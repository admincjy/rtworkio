package org.fh.controller.financial;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.fh.controller.base.BaseController;
import org.fh.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.apache.shiro.authz.annotation.RequiresPermissions;


import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.financial.FinancialModelService;

import javax.servlet.http.HttpServletResponse;

/** 
 * 说明：金融模型 
 * 时间：2019-07-24
 */
@Controller
@RequestMapping("/financialmodel")
public class FinancialModelController extends BaseController {
	
	@Autowired
	private FinancialModelService financialmodelService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("financialmodel:add")
	public String save(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FINANCIALMODEL_ID", this.get32UUID());	//主键
		financialmodelService.save(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("financialmodel:del")
	public Object delete(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			financialmodelService.delete(pd);
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
	@RequiresPermissions("financialmodel:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		financialmodelService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("financialmodel:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData>	varList = financialmodelService.list(page);	//列出FinancialModel列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "financial/financialmodel/financialmodel_list";
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	@RequiresPermissions("financialmodel:add")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "financial/financialmodel/financialmodel_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	@RequiresPermissions("financialmodel:edit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = financialmodelService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "financial/financialmodel/financialmodel_edit";
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("financialmodel:del")
	public Object deleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		try{
			if(Tools.notEmpty(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				financialmodelService.deleteAll(ArrayDATA_IDS);
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
		titles.add("模型名称");	//1
		titles.add("创建时间");	//2
		titles.add("备注");	//3
		dataMap.put("titles", titles);
		List<PageData> varOList = financialmodelService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("CREATETIME"));	    //2
			vpd.put("var3", varOList.get(i).getString("REMARK"));	    //3
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}

	/**打开上传EXCEL页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goUploadExcel")
	public String goUploadExcel()throws Exception{
		return"financial/financialmodel/uploadexcel";
	}

	/**下载模版
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downExcel")
	public void downExcel(HttpServletResponse response)throws Exception{
		FileDownload.fileDownload(response, PathUtil.getProjectpath() + Const.FILEPATHFILE + "Users.xls", "Users.xls");
	}

	/**从EXCEL导入到数据库
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/readExcel")
	@RequiresPermissions("fromExcel")
	@SuppressWarnings("unchecked")
	public String readExcel(@RequestParam(value="excel",required=false) MultipartFile file, Model model) throws Exception{
		PageData pd = new PageData();
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getProjectpath() + Const.FILEPATHFILE;								//文件上传路径
			String fileName =  FileUpload.fileUp(file, filePath, "datafexcel");								//执行上传
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);			//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
			/**
			 *
			 */
			for(int i=0;i<listPd.size();i++){
				pd.put("MODELDATA_ID", this.get32UUID());
				pd.put("DATE", listPd.get(i).getString("var0"));
				pd.put("DATE_NUMBER", listPd.get(i).getString("var1"));
				pd.put("EP", listPd.get(i).getString("var2"));
				pd.put("EPCUT", listPd.get(i).getString("var3"));
				pd.put("BP", listPd.get(i).getString("var4"));
				pd.put("SP", listPd.get(i).getString("var5"));
				pd.put("NCFP", listPd.get(i).getString("var6"));
				pd.put("OCFP", listPd.get(i).getString("var7"));
				pd.put("DP", listPd.get(i).getString("var8"));
				pd.put("FCFP", listPd.get(i).getString("var9"));
				pd.put("MACD", listPd.get(i).getString("var10"));
				pd.put("BIAS", listPd.get(i).getString("var11"));
				pd.put("MARKET_VALUE", listPd.get(i).getString("var12"));
				pd.put("MONTH_UP_DOWM", listPd.get(i).getString("var13"));
				financialmodelService.savedataf(pd);
			}
		}
		model.addAttribute("msg","success");
		return "transferPage";
	}



	@RequestMapping(value="/findDatabyDay")
	public String findDatabyDay(Page page, Model model) throws Exception{
		List<String> result = DateUtil.getMonthBetween("2017-01","2018-12");
		List<PageData>  PageDatas=new ArrayList<>();
		PageData pDate = new PageData();
		BigDecimal EP = new BigDecimal("1");
		BigDecimal EPCUT = new BigDecimal("1");
		BigDecimal BP = new BigDecimal("1");
		BigDecimal SP = new BigDecimal("1");
		BigDecimal NCFP = new BigDecimal("1");
		BigDecimal OCFP = new BigDecimal("1");
		BigDecimal DP = new BigDecimal("1");
		BigDecimal FCFP = new BigDecimal("1");
		BigDecimal MACD = new BigDecimal("1");
		BigDecimal BIAS = new BigDecimal("1");
		BigDecimal ROE_DATA = new BigDecimal("1");
		BigDecimal ROE = new BigDecimal("1");
		BigDecimal ROA = new BigDecimal("1");
		BigDecimal AOR = new BigDecimal("1");
		BigDecimal GROSS = new BigDecimal("1");
		BigDecimal GROSS_TTM = new BigDecimal("1");
		BigDecimal YIE = new BigDecimal("1");
		BigDecimal ROE_DEL = new BigDecimal("1");
		BigDecimal TTM = new BigDecimal("1");
		BigDecimal TOTAL_VALUE = new BigDecimal("1");
		for (int i=0;i<result.size();i++){
			PageData pd = new PageData();
			pd.put("DATE",result.get(i));
			PageData pageData = financialmodelService.findDatabyDay(pd);
			pd.put("EP",(BigDecimal) pageData.get("EP"));
			pd.put("EPCUT",(BigDecimal) pageData.get("EPCUT"));
			pd.put("BP",(BigDecimal) pageData.get("BP"));
			pd.put("SP",(BigDecimal) pageData.get("SP"));
			pd.put("NCFP",(BigDecimal) pageData.get("NCFP"));
			pd.put("OCFP",(BigDecimal) pageData.get("OCFP"));
			pd.put("DP",(BigDecimal) pageData.get("DP"));
			pd.put("FCFP",(BigDecimal) pageData.get("FCFP"));
			pd.put("MACD",(BigDecimal) pageData.get("MACD"));
			pd.put("BIAS",(BigDecimal) pageData.get("BIAS"));
			pd.put("ROE_DATA",(BigDecimal) pageData.get("ROE_DATA"));
			pd.put("ROE",(BigDecimal) pageData.get("ROE"));
			pd.put("ROA",(BigDecimal) pageData.get("ROA"));
			pd.put("AOR",(BigDecimal) pageData.get("AOR"));
			pd.put("GROSS",(BigDecimal) pageData.get("GROSS"));
			pd.put("GROSS_TTM",(BigDecimal) pageData.get("GROSS_TTM"));
			pd.put("YIE",(BigDecimal) pageData.get("YIE"));
			pd.put("ROE_DEL",(BigDecimal) pageData.get("ROE_DEL"));
			pd.put("TTM",(BigDecimal) pageData.get("TTM"));
			pd.put("TOTAL_VALUE",(BigDecimal) pageData.get("TOTAL_VALUE"));
			EP=EP.multiply((BigDecimal) pageData.get("EP"));
			EPCUT=EPCUT.multiply((BigDecimal) pageData.get("EPCUT"));
			BP=BP.multiply((BigDecimal) pageData.get("BP"));
			SP=SP.multiply((BigDecimal) pageData.get("SP"));
			NCFP=NCFP.multiply((BigDecimal) pageData.get("NCFP"));
			OCFP=OCFP.multiply((BigDecimal) pageData.get("OCFP"));
			DP=DP.multiply((BigDecimal) pageData.get("DP"));
			FCFP=FCFP.multiply((BigDecimal) pageData.get("FCFP"));
			MACD=MACD.multiply((BigDecimal) pageData.get("MACD"));
			BIAS=BIAS.multiply((BigDecimal) pageData.get("BIAS"));
			ROE_DATA=ROE_DATA.multiply((BigDecimal) pageData.get("ROE_DATA"));
			ROE=ROE.multiply((BigDecimal) pageData.get("ROE"));
			ROA=ROA.multiply((BigDecimal) pageData.get("ROA"));
			AOR=AOR.multiply((BigDecimal) pageData.get("AOR"));
			GROSS=GROSS.multiply((BigDecimal) pageData.get("GROSS"));
			GROSS_TTM=GROSS_TTM.multiply((BigDecimal) pageData.get("GROSS_TTM"));
			YIE=YIE.multiply((BigDecimal) pageData.get("YIE"));
			ROE_DEL=ROE_DEL.multiply((BigDecimal) pageData.get("ROE_DEL"));
			TTM=TTM.multiply((BigDecimal) pageData.get("TTM"));
			TOTAL_VALUE=TOTAL_VALUE.multiply((BigDecimal) pageData.get("TOTAL_VALUE"));
			PageDatas.add(pd);
		}
		pDate.put("DATE","累乘合计");
		pDate.put("EP",EP.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("EPCUT",EPCUT.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("BP",BP.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("SP",SP.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("NCFP",NCFP.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("OCFP",OCFP.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("DP",DP.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("FCFP",FCFP.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("MACD",MACD.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("BIAS",BIAS.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("ROE_DATA",ROE_DATA.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("ROE",ROE.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("ROA",ROA.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("AOR",AOR.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("GROSS",GROSS.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("GROSS_TTM",GROSS_TTM.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("YIE",YIE.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("ROE_DEL",ROE_DEL.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("TTM",TTM.setScale(30,   BigDecimal.ROUND_HALF_UP));
		pDate.put("TOTAL_VALUE",TOTAL_VALUE.setScale(30,   BigDecimal.ROUND_HALF_UP));
		PageDatas.add(pDate);
        model.addAttribute("PageDatas", PageDatas);
		return "financial/financialmodel/model_list";
	}


}
