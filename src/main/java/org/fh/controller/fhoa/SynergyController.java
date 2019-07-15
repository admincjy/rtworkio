package org.fh.controller.fhoa;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.task.Task;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.act.AcStartController;
import org.fh.controller.act.rutask.RuTaskController;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.util.DateUtil;
import org.fh.util.Jurisdiction;
import org.fh.util.ObjectExcelView;
import org.fh.util.Tools;
import org.fh.entity.PageData;
import org.fh.service.fhoa.SynergyService;
import org.fh.service.system.UsersService;
import org.fh.service.act.RuprocdefService;
import org.fh.service.fhoa.SynergyMxService;

/** 
 * 说明：synergy
 * 作者：FH Admin 
 * 时间：2019-04-27
 *  ：
 */
@Controller
@RequestMapping("/synergy")
public class SynergyController extends AcStartController {
	
	@Autowired
	private SynergyService synergyService;
	
	@Autowired
	private SynergyMxService synergymxService;
	
	@Autowired
	private RuprocdefService ruprocdefService;
	
	@Autowired
	private UsersService usersService;
	
	@Autowired
	private RuTaskController ruTaskController;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("synergy:add")
	public String save(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
        String ASSIGNEE = pd.getString("ASSIGNEE_2");
        String ASSIGNEE_3="";
        if(Tools.notEmpty(pd.getString("ASSIGNEE_3"))) {
              ASSIGNEE_3=pd.getString("ASSIGNEE_3");
		}
		Date date = new Date();
        //设置要获取到什么样的时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //获取String类型的时间
        String createdate = sdf.format(date);
        String sDEADLINE=pd.getString("DEADLINE");
        Date DEADLINE=sdf.parse(sDEADLINE);
		pd.put("SYNERGY_ID", this.get32UUID());	//主键
		pd.put("NAME", Jurisdiction.getName());
		pd.put("STARTTIME",date);
		pd.put("DEADLINE",DEADLINE);
		pd.put("CCNAME",ASSIGNEE_3);
		synergyService.save(pd);
		pd = synergyService.findById(pd);	//根据ID读取
//		PageData pdu = new PageData();
//		pdu.put("USER_ID", pd.getString("TONAME"));
//		PageData dataUser=usersService.findById(pdu);
		try {
			/** 工作流的操作 **/
			Map<String,Object> map = new LinkedHashMap<String, Object>();
			map.put("被协同人", Jurisdiction.getName());			//当前用户的姓名
			map.put("协同标题", pd.getString("TITLE"));			
//			map.put("协同人员", dataUser.get("NAME"));
			map.put("开始时间", createdate);
//			map.put("结束时间", pd.getString("ENDTIME"));
			map.put("截止时间", sDEADLINE);
//			map.put("协同进度", pd.getString("STATE"));
//			map.put("执行人意见", pd.getString("OPINIONS"));
			if(ASSIGNEE_3!="") {
				map.put("抄送人员",ASSIGNEE_3);
			}
			map.put("USERNAME", Jurisdiction.getUsername());			//指派代理人为当前用户
			String procInstId=startProcessInstanceByKeyHasVariables("key_synergy",map);	//启动流程实例(协同单流程)通过KEY
			pd.put("PROC_INST_ID_", procInstId);
			synergyService.edit(pd);									//记录存入数据库
			ruTaskController.submit(procInstId, ASSIGNEE);
			model.addAttribute("ASSIGNEE_",ASSIGNEE);	//用于给待办人发送新任务消息
//			model.addAttribute("msg","success");
			model.addAttribute("msg", "edit");
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			model.addAttribute("errer","errer");
			model.addAttribute("msgContent","请联系管理员部署相应业务流程!");
		}
		return "fhoa/synergy/synergy_edit";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("synergy:del")
	public Object delete() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			if(Integer.parseInt(synergymxService.findCount(pd).get("zs").toString()) > 0){
				errInfo = "error";
			}else{
				synergyService.delete(pd);
			}
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@RequiresPermissions("synergy:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		synergyService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("synergy:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!Jurisdiction.getName().equals("系统管理员")) {
			pd.put("NAME", Jurisdiction.getName());
		}
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData> varList = synergyService.list(page);	//列出Synergy列表
		for(PageData pData:varList) {
			if (Tools.notEmpty(pData.getString("CCNAME"))) {
				if(pData.getString("CCNAME").indexOf(Jurisdiction.getName()+"Y")>-1) {
					pData.put("ISCC", "0");
				}
			}
		}
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhoa/synergy/synergy_list";
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	@RequiresPermissions("synergy:add")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
        Page page=new Page();
		List<PageData> userList=usersService.listUsersBystaff(page);
        model.addAttribute("userList", userList);
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "fhoa/synergy/synergy_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	@RequiresPermissions("synergy:edit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = synergyService.findById(pd);	//根据ID读取
        Page page=new Page();
		List<PageData> userList=usersService.listUsersBystaff(page);
        model.addAttribute("userList", userList);
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhoa/synergy/synergy_edit";
	}	
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	@RequiresPermissions("toExcel")
	public ModelAndView exportExcel() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("被协同人");	//1
		titles.add("协同人");	//2
		titles.add("协同开始时间");	//3
		titles.add("协同结束时间");	//4
		titles.add("约定截止时间");	//5
		titles.add("协同进度");	//6
		titles.add("执行人意见");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = synergyService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("TONAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("STARTTIME"));	    //3
			vpd.put("var4", varOList.get(i).getString("ENDTIME"));	    //4
			vpd.put("var5", varOList.get(i).getString("DEADLINE"));	    //5
			vpd.put("var6", varOList.get(i).getString("STATE"));	    //6
			vpd.put("var7", varOList.get(i).getString("OPINIONS"));	    //7
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	
	
	
}
