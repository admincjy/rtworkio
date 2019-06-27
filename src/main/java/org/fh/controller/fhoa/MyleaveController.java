package org.fh.controller.fhoa;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.act.AcStartController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.fhoa.MyleaveService;
import org.fh.util.Jurisdiction;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：请假申请
 * 作者：FH 
 * 官网：
 */
@Controller
@RequestMapping("/myleave")
public class MyleaveController extends AcStartController {
	
	@Autowired
	private MyleaveService myleaveService;
	
	/**保存请假单
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("myleave:add")
	public String save(Model model){
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MYLEAVE_ID", this.get32UUID());					//主键
		pd.put("USERNAME", Jurisdiction.getUsername());			//用户名
		try {
			/** 工作流的操作 **/
			Map<String,Object> map = new LinkedHashMap<String, Object>();
			map.put("请假人员", Jurisdiction.getName());			//当前用户的姓名
			map.put("开始时间", pd.getString("STARTTIME"));
			map.put("结束时间", pd.getString("ENDTIME"));
			map.put("请假时长", pd.getString("WHENLONG"));
			map.put("请假类型", pd.getString("TYPE"));
			map.put("请假事由", pd.getString("REASON"));
			map.put("USERNAME", Jurisdiction.getUsername());			//指派代理人为当前用户
			startProcessInstanceByKeyHasVariables("KEY_leave",map);		//启动流程实例(请假单流程)通过KEY
			myleaveService.save(pd);									//记录存入数据库
			model.addAttribute("ASSIGNEE_",Jurisdiction.getUsername());	//用于给待办人发送新任务消息
			model.addAttribute("msg","success");
		} catch (Exception e) {
			model.addAttribute("errer","errer");
			model.addAttribute("msgContent","请联系管理员部署相应业务流程!");
		}								
		return "transferPage";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("myleave:del")
	public Object delete() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		myleaveService.delete(pd);
		map.put("result", "success");
		return map;
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@RequiresPermissions("myleave:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		myleaveService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("myleave:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");				//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("keywords", KEYWORDS.trim());
		pd.put("USERNAME", "admin".equals(Jurisdiction.getUsername())?"":Jurisdiction.getUsername()); //除admin用户外，只能查看自己的数据
		page.setPd(pd);
		List<PageData>	varList = myleaveService.list(page);	//列出Myleave列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhoa/myleave/myleave_list";
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "fhoa/myleave/myleave_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = myleaveService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhoa/myleave/myleave_edit";
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("myleave:del")
	public Object deleteAll() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		if(Tools.notEmpty(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			myleaveService.deleteAll(ArrayDATA_IDS);
		}else{
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
}

