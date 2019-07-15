package org.fh.controller.act.fhmodel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.act.AcBaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.act.FHModelService;
import org.fh.util.Jurisdiction;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：工作流模型管理
 * 作者：FH Admin 
 *  ：
 */
@Controller
@RequestMapping("/fhmodel")
public class FHModelController extends AcBaseController{
	
	@Autowired
	private FHModelService fHModelService;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("fhmodel:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("keywords", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData> varList = fHModelService.list(page);
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "act/fhmodel/fhmodel_list";
	}
	
	 /**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("process_author", Jurisdiction.getName());	//流程作者
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "act/fhmodel/fhmodel_edit";
	}
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("fhmodel:add")
	public String save(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String process_author = pd.getString("process_author");	//流程作者
		String name  = pd.getString("name");					//流程名称
		String process_id  = pd.getString("process_id");		//流程标识
		String modelname  = pd.getString("modelname");			//模型名称
		String description  = pd.getString("description");		//模型描述
		String category  = pd.getString("category");			//模型分类
		String modelId = createModel(process_id,process_author,name,modelname,description,category);
		model.addAttribute("msg","success");
		model.addAttribute("sunval",modelId);
		return "transferPage";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("fhmodel:del")
	public Object delete() throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		deleteModel(pd.getString("ID_"));
		map.put("result", "success");				//返回结果
		return map;
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("fhmodel:del")
	public Object deleteAll() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		if(Tools.notEmpty(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				deleteModel(ArrayDATA_IDS[i]);
			}
		}else{
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**部署流程定义
	 * @return 
	 */
	@RequestMapping(value="/deployment")
	@ResponseBody
	@RequiresPermissions("fhmodel:edit")
	public Object deployment(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "success";
		try{
			deploymentProcessDefinitionFromModelId(pd.getString("modelId"));//部署流程定义
		}catch (Exception e){
			result = "error";
		}finally{
			map.put("result", result);
		}
		return map;
	}
	
	/**判断能否正常根据模型ID导出xml文件
	 * @return 
	 */
	@RequestMapping(value="/isCanexportXml")
	@ResponseBody
	@RequiresPermissions("fhmodel:cha")
	public Object isCanexportXml(HttpServletResponse response){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String result = "success";
		try{
			isCanexportXmlFromModelId(response,pd.getString("modelId"));
		}catch (Exception e){
			result = "error";
		}finally{
			map.put("result", result);
		}
		return map;
	}
	
	/**去预览XML页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goView")
	@RequiresPermissions("fhmodel:cha")
	public String goView(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String code = viewXmlFromModelId(pd.getString("modelId"));
		pd.put("code", code);
		model.addAttribute("pd", pd);
		return "act/fhmodel/xml_view";
	}
	
	/**正式根据模型ID导出xml文件
	 * @return 
	 * @throws Exception 
	 */
	@RequestMapping(value="/exportXml")
	@RequiresPermissions("fhmodel:cha")
	public void exportXml(HttpServletResponse response) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		exportXmlFromModelId(response,pd.getString("modelId"));	//导出xml文件
	}
	
	/**打开流程编辑器页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/editor")
	@RequiresPermissions("fhmodel:edit")
	public String editor(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("pd", pd);
		return "act/fhmodel/editor";
	}
	
	 /**去修改类型页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = fHModelService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "act/fhmodel/fhmodel_type";
	}
	
	/**修改类型
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@RequiresPermissions("fhmodel:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		fHModelService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}

	 /**从流程定义映射模型
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/saveModelFromPro")
	@ResponseBody
	@RequiresPermissions("fhmodel:add")
	public Object saveModelFromPro(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		String msg = "ok";
		pd = this.getPageData();
		String processDefinitionId = pd.getString("processDefinitionId"); 		//流程定义ID
		try {
			saveModelFromPro(processDefinitionId);
		} catch (Exception e) {
			msg = "errer";
		}
		map.put("msg", msg);
		return map;
	}
	
}
