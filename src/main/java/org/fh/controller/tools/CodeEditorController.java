package org.fh.controller.tools;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.system.CodeEditorService;
import org.fh.util.DateUtil;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：代码生成器模版编辑
 * 作者：FH 
 *  ：
 */
@Controller
@RequestMapping(value="/codeeditor")
public class CodeEditorController extends BaseController {
	
	@Autowired
	private CodeEditorService codeEditorService;
	
	/**去编辑页面1
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	@RequiresPermissions("codeeditor:edit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("pd", pd);
		return "tools/codeeditor/codeeditor_edit_1";
	}
	
	 /**去编辑页面2
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit2")
	@RequiresPermissions("codeeditor:edit")
	public String goEdit2(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("pd", pd);
		return "tools/codeeditor/codeeditor_edit_2";
	}
	
	/**获取code
	 * @return 
	 */
	@RequestMapping(value="/getCode")
	@ResponseBody
	@RequiresPermissions("codeeditor:list")
	public Object getCode(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			String type = pd.getString("type");
			String ftlNmame = pd.getString("ftlNmame");
			String code = Tools.readFileAllContent("/admin/template/ftl/"+type+"/"+ftlNmame+".ftl");	//从原始模版获取
			map.put("code", code);
		}catch (Exception e){
			errInfo = "error";
		}finally{
			map.put("result", errInfo);
		}
		return map;
	}
	
	/**保存
	 * @return 
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	@RequiresPermissions("codeeditor:add")
	public Object save(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			String codeTxt =  pd.getString("codeTxt");
			String type = pd.getString("type");
			String ftlNmame = pd.getString("ftlNmame");
			Tools.writeFileCR("/admin/template/ftl/"+type+"/"+ftlNmame+".ftl",codeTxt);	//写入到文件
			pd.put("TYPE", type);
			pd.put("FTLNMAME", ftlNmame);
			pd.put("CODECONTENT", codeTxt);
			pd.put("CODEEDITOR_ID", this.get32UUID());		//主键
			pd.put("CTIME", DateUtil.date2Str(new Date()));	//创建时间
			codeEditorService.save(pd);						//记录存储到数据库
		}catch (Exception e){
			errInfo = "error";
		}finally{
			map.put("result", errInfo);
		}
		return map;
	}
	
	/**还原
	 * @return 
	 */
	@RequestMapping(value="/reduction")
	@ResponseBody
	@RequiresPermissions("codeeditor:edit")
	public Object reduction(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			String type = pd.getString("type");
			String ftlNmame = pd.getString("ftlNmame");
			String msg = pd.getString("msg");
			String code = "";
			if("fromHistory".equals(msg)){
				code = codeEditorService.findById(pd).getString("CODECONTENT");				//从历史编辑获取
			}else{
				code = Tools.readFileAllContent("/admin/template/ftl_backups/"+type+"/"+ftlNmame+".ftl");	//从原始模版获取
			}
			Tools.writeFileCR("/admin/template/ftl/"+type+"/"+ftlNmame+".ftl",code);						//写入到现在模版
			map.put("code", code);
		}catch (Exception e){
			errInfo = "error";
		}finally{
			map.put("result", errInfo);
		}
		return map;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("codeeditor:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData>	varList = codeEditorService.list(page);	//列出CodeEditor列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "tools/codeeditor/codeeditor_list";
	}
	
	 /**查看代码
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/view")
	@RequiresPermissions("codeeditor:list")
	public String view(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("pd", pd);
		String msg = pd.getString("msg");
		if("2".equals(msg)){
			return "tools/codeeditor/codeeditor_view2";
		}else{
			return "tools/codeeditor/codeeditor_view1";
		}
	}
	
	/**获取code
	 * @return 
	 */
	@RequestMapping(value="/getCodeFromView")
	@ResponseBody
	@RequiresPermissions("codeeditor:list")
	public Object getCodeFromView(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			pd = codeEditorService.findById(pd);	//根据ID读取
			map.put("code", pd.getString("CODECONTENT"));
		}catch (Exception e){
			errInfo = "error";
		}finally{
			map.put("result", errInfo);
		}
		return map;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@RequiresPermissions("codeeditor:del")
	@ResponseBody
	public Object delete(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try {
			codeEditorService.delete(pd);
		} catch (Exception e) {
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("codeeditor:del")
	public Object deleteAll() throws Exception{
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		if(Tools.notEmpty(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			codeEditorService.deleteAll(ArrayDATA_IDS);
		}else{
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}

}
