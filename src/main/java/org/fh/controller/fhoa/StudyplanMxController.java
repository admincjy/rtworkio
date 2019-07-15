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
import org.fh.service.fhoa.StudyplanMxService;
import org.fh.service.fhoa.StudyplanService;

/** 
 * 说明：学习计划流程(明细)
 * 作者：FH 
 * 时间：2019-05-05
 *  ：
 */
@Controller
@RequestMapping("/studyplanmx")
public class StudyplanMxController extends BaseController {
	
	@Autowired
	private StudyplanService studyplanService;
	
	@Autowired
	private StudyplanMxService studyplanmxService;
	
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
		pd.put("STUDYPLANMX_ID", this.get32UUID());	//主键
		studyplanmxService.save(pd);
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
			studyplanmxService.delete(pd);
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
		studyplanmxService.edit(pd);
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
		List<PageData>	varList = studyplanmxService.list(page);	//列出StudyplanMx列表
		//判断流程是否已经结束
		pd = studyplanService.findById(pd);	//根据ID读取
		PageData pdPageData=ruprocdefService.selectInformation(pd);
		if (pdPageData.get("ENDTIME")!=null) {
			model.addAttribute("isEnd", "yes");
		}else {
			model.addAttribute("isEnd", "no");
		}
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhoa/studyplanmx/studyplanmx_list";
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
		return "fhoa/studyplanmx/studyplanmx_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = studyplanmxService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhoa/studyplanmx/studyplanmx_edit";
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
				studyplanmxService.deleteAll(ArrayDATA_IDS);
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
		titles.add("学习书目");	//1
		titles.add("书本信息");	//2
		titles.add("学习情况");	//3
		titles.add("开始学习时间");	//4
		titles.add("完成学习时间");	//5
		titles.add("上级评分");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = studyplanmxService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("BOOKNAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("BOOKCONTET"));	    //2
			vpd.put("var3", varOList.get(i).getString("COUNT"));	    //3
			vpd.put("var4", varOList.get(i).getString("STUDYSTARTTIME"));	    //4
			vpd.put("var5", varOList.get(i).getString("STUDYENDTIME"));	    //5
			vpd.put("var6", varOList.get(i).getString("SCORE"));	    //6
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}

}
