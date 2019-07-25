package org.fh.controller.financial;

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
	
}
