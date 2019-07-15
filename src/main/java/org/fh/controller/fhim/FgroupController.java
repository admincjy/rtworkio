package org.fh.controller.fhim;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.fhim.FgroupService;
import org.fh.util.Jurisdiction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：好友分组
 * 作者：FH
 *  ：
 */
@Controller
@RequestMapping("/fgroup")
public class FgroupController extends BaseController {
	
	@Autowired
	private FgroupService fgroupService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("fgroup:add")
	public String save(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FGROUP_ID", this.get32UUID());			//主键
		pd.put("USERNAME", Jurisdiction.getUsername());	//用户名
		fgroupService.save(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("fgroup:del")
	public Object delete(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try {
			fgroupService.delete(pd);
		} catch (Exception e) {
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
	@RequiresPermissions("fgroup:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		fgroupService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("fgroup:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERNAME", Jurisdiction.getUsername());
		page.setPd(pd);
		List<PageData> varList = fgroupService.datalistPage(page);	//列出Fgroup列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhim/fgroup/fgroup_list";
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
		return "fhim/fgroup/fgroup_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = fgroupService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhim/fgroup/fgroup_edit";
	}	
	
	/**获取分组列表
	 * @return
	 */
	@RequestMapping(value="/getFgroup")
	@ResponseBody
	public Object getLevels(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		String errInfo = "success";
		try{
			pd = this.getPageData();
			pd.put("USERNAME", Jurisdiction.getUsername());	//用户名
			List<PageData> varList = fgroupService.listAll(pd);
			map.put("list", varList);	
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}

}
