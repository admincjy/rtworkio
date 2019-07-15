package org.fh.controller.library;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.apache.shiro.authz.annotation.RequiresPermissions;

import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.util.DateUtil;
import org.fh.util.ObjectExcelView;
import org.fh.util.Tools;
import org.fh.entity.PageData;
import org.fh.service.library.ManagementSystemService;

/** 
 * 说明：朗威图书馆
 * 
 */
@Controller
@RequestMapping("/managementsystem")
public class ManagementSystemController extends BaseController {
	
	@Autowired
	private ManagementSystemService managementsystemService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("managementsystem:add")
	public String save(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MANAGEMENTSYSTEM_ID", this.get32UUID());	//主键
		managementsystemService.save(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("managementsystem:del")
	public Object delete(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			managementsystemService.delete(pd);
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
	@RequiresPermissions("managementsystem:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		managementsystemService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("managementsystem:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData>	varList = managementsystemService.list(page);	//列出ManagementSystem列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "library/managementsystem/managementsystem_list";
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	@RequiresPermissions("managementsystem:add")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "library/managementsystem/managementsystem_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	@RequiresPermissions("managementsystem:edit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = managementsystemService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "library/managementsystem/managementsystem_edit";
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("managementsystem:del")
	public Object deleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		try{
			if(Tools.notEmpty(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				managementsystemService.deleteAll(ArrayDATA_IDS);
				errInfo = "success";
			}else{
				errInfo = "error";
			}
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
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
		titles.add("文件名");	//1
		titles.add("文件路径");	//2
		titles.add("类型");	//3
		titles.add("文件后缀");	//4
		titles.add("是否可下载");	//5
		dataMap.put("titles", titles);
		List<PageData> varOList = managementsystemService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("PATH"));	    //2
			vpd.put("var3", varOList.get(i).getString("CLASSIFICATION"));	    //3
			vpd.put("var4", varOList.get(i).getString("SUFFIX"));	    //4
			vpd.put("var5", varOList.get(i).get("ISDOWM").toString());	//5
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
}
