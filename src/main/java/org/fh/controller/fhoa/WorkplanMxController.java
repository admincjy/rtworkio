package org.fh.controller.fhoa;

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
import org.fh.service.act.RuprocdefService;
import org.fh.service.fhoa.WorkplanMxService;
import org.fh.service.fhoa.WorkplanService;

/** 
 * 说明：工作计划流程(明细)
 * 作者：FH Admin 
 * 时间：2019-05-05
 * 官网：
 */
@Controller
@RequestMapping("/workplanmx")
public class WorkplanMxController extends BaseController {
	
	@Autowired
	private WorkplanMxService workplanmxService;
	
	@Autowired
	private WorkplanService workplanService;
	
	@Autowired
	private RuprocdefService ruprocdefService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public String save(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("WORKPLANMX_ID", this.get32UUID());	//主键
		String PROGRESS=pd.getString("PROGRESS")+"%";
		pd.put("PROGRESS", PROGRESS);
		workplanmxService.save(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			workplanmxService.delete(pd);
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
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
//		pd.put("WORKPLANMX_ID", this.get32UUID());	//主键
		String PROGRESS=pd.getString("PROGRESS")+"%";
		pd.put("PROGRESS", PROGRESS);
		workplanmxService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData>	varList = workplanmxService.list(page);	//列出WorkplanMx列表
		//判断流程是否已经结束
		pd = workplanService.findById(pd);	//根据ID读取
		PageData pdPageData=ruprocdefService.selectInformation(pd);
		if (pdPageData.get("ENDTIME")!=null) {
			model.addAttribute("isEnd", "yes");
		}else {
			model.addAttribute("isEnd", "no");
		}
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhoa/workplanmx/workplanmx_list";
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData pageData=workplanmxService.findTitleById(pd);
		if(pageData!=null) {
			pd.put("TITLE", pageData.get("TITLE"));
		}
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "fhoa/workplanmx/workplanmx_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = workplanmxService.findById(pd);	//根据ID读取
		if(pd.getString("PROGRESS")!=null&&pd.getString("PROGRESS")!="") {
			String PROGRESS=pd.getString("PROGRESS").substring(0,pd.getString("PROGRESS").length()-1);
			pd.put("PROGRESS", PROGRESS);
	    }
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhoa/workplanmx/workplanmx_edit";
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll(){
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		try{
			if(Tools.notEmpty(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				workplanmxService.deleteAll(ArrayDATA_IDS);
				errInfo = "success";
			}else{
				errInfo = "error";
			}
		}catch(Exception e){
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
		titles.add("工作计划明细");	//1
		titles.add("计划完成时间");	//2
		titles.add("完成进度百分比");	//3
		titles.add("考核评分");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = workplanmxService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("CONTENTDETAIL"));	    //1
			vpd.put("var2", varOList.get(i).getString("PLANTIME"));	    //2
			vpd.put("var3", varOList.get(i).getString("PROGRESS"));	    //3
			vpd.put("var4", varOList.get(i).getString("SCORE"));	    //4
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}

	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listNoEnd")
	public String listNoEnd(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData>	varList = workplanmxService.listNoEnd(page);	//列出未完成完成WorkplanMx列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhoa/workplanmx/workplanmx_list";
	}
}
