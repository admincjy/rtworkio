package org.fh.controller.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.entity.system.Dictionaries;
import org.fh.service.system.DictionariesService;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONArray;

/**
 * 说明：数据字典处理类
 * 作者：FH Admin 
 *  ：
 */
@Controller
@RequestMapping("/dictionaries")
public class DictionariesController extends BaseController {
	
	@Autowired
	private DictionariesService dictionariesService;
	
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllDict")
	@RequiresPermissions("dictionaries:list")
	public String listAllDict(Model model,String DICTIONARIES_ID)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDict("0"));
		String json = arr.toString();
		json = json.replaceAll("DICTIONARIES_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDict", "nodes").replaceAll("hasDict", "checked").replaceAll("treeurl", "url");
		model.addAttribute("zTreeNodes", json);
		model.addAttribute("DICTIONARIES_ID",DICTIONARIES_ID);
		model.addAttribute("pd", pd);	
		return "system/dictionaries/dictionaries_ztree";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("dictionaries:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		String DICTIONARIES_ID = null == pd.get("DICTIONARIES_ID")?"":pd.get("DICTIONARIES_ID").toString();
		if(null != pd.get("id") && !"".equals(pd.get("id").toString())){
			DICTIONARIES_ID = pd.get("id").toString();
		}
		pd.put("DICTIONARIES_ID", DICTIONARIES_ID);						//上级ID
		page.setPd(pd);
		List<PageData>	varList = dictionariesService.list(page);		//列出Dictionaries列表
		model.addAttribute("pd", dictionariesService.findById(pd));		//传入上级所有信息
		model.addAttribute("DICTIONARIES_ID", DICTIONARIES_ID);			//上级ID
		model.addAttribute("varList", varList);
		return "system/dictionaries/dictionaries_list";
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String DICTIONARIES_ID = null == pd.get("DICTIONARIES_ID")?"":pd.get("DICTIONARIES_ID").toString();
		pd.put("DICTIONARIES_ID", DICTIONARIES_ID);						//上级ID
		model.addAttribute("pds",dictionariesService.findById(pd));		//传入上级所有信息
		model.addAttribute("DICTIONARIES_ID", DICTIONARIES_ID);			//传入ID，作为子级ID用
		model.addAttribute("msg", "save");
		return "system/dictionaries/dictionaries_edit";
	}
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public String save(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("DICTIONARIES_ID", this.get32UUID());	//主键
		dictionariesService.save(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**判断编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasBianma")
	@ResponseBody
	public Object hasBianma(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(dictionariesService.findByBianma(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String DICTIONARIES_ID = pd.getString("DICTIONARIES_ID");
		pd = dictionariesService.findById(pd);									//根据ID读取
		model.addAttribute("pd", pd);											//放入视图容器
		pd.put("DICTIONARIES_ID",pd.get("PARENT_ID").toString());				//用作上级信息
		model.addAttribute("pds",dictionariesService.findById(pd));				//传入上级所有信息
		model.addAttribute("DICTIONARIES_ID", pd.get("PARENT_ID").toString());	//传入上级ID，作为子ID用
		pd.put("DICTIONARIES_ID",DICTIONARIES_ID);								//复原本ID
		model.addAttribute("msg", "edit");
		return "system/dictionaries/dictionaries_edit";
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		dictionariesService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**
	 * 删除
	 * @param DICTIONARIES_ID
	 * @param
	 * @throws Exception 
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete(@RequestParam String DICTIONARIES_ID) throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd.put("DICTIONARIES_ID", DICTIONARIES_ID);
		String errInfo = "success";
		if(dictionariesService.listSubDictByParentId(DICTIONARIES_ID).size() > 0){//判断是否有子级，是：不允许删除
			errInfo = "error";
		}else{
			pd = dictionariesService.findById(pd);					//根据ID读取
			if("yes".equals(pd.getString("YNDEL")))return null;		//当禁止删除字段值为yes, 则禁止删除，只能从手动从数据库删除
			if(null != pd.get("TBSNAME") && !"".equals(pd.getString("TBSNAME"))){
				String TBFIELD = pd.getString("TBFIELD");
				if(Tools.isEmpty(TBFIELD))TBFIELD = "BIANMA"; 		//如果关联字段没有设置，就默认字段为 BIANMA
				pd.put("TBFIELD", TBFIELD);
				String[] table = pd.getString("TBSNAME").split(",");
				for(int i=0;i<table.length;i++){
					pd.put("thisTable", table[i]);
					try {
						if(Integer.parseInt(dictionariesService.findFromTbs(pd).get("zs").toString())>0){//判断是否被占用，是：不允许删除(去排查表检查字典表中的编码字段)
							errInfo = "error";
							break;
						}
					} catch (Exception e) {
							errInfo = "error2";
							break;
					}
				}
			}
		}
		if("success".equals(errInfo)){
			dictionariesService.delete(pd);	//执行删除
		}
		map.put("result", errInfo);
		return map;
	}
	
	/**获取连级数据
	 * @return
	 */
	@RequestMapping(value="/getLevels")
	@ResponseBody
	public Object getLevels(){
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String DICTIONARIES_ID = pd.getString("DICTIONARIES_ID");
			DICTIONARIES_ID = Tools.isEmpty(DICTIONARIES_ID)?"0":DICTIONARIES_ID;
			List<Dictionaries>	varList = dictionariesService.listSubDictByParentId(DICTIONARIES_ID); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdList = new ArrayList<PageData>();
			for(Dictionaries d :varList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("BIANMA", d.getBIANMA());
				pdf.put("NAME", d.getNAME());
				pdList.add(pdf);
			}
			map.put("list", pdList);	
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**
	 * 显示列表ztree (用于代码生成器引用数据字典)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllDictToCreateCode")
	public String listAllDictToCreateCode(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictToCreateCode("0"));
			String json = arr.toString();
			json = json.replaceAll("DICTIONARIES_ID", "id").replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDict", "nodes").replaceAll("hasDict", "checked").replaceAll("treeurl", "click");
			model.addAttribute("zTreeNodes", json);
			model.addAttribute("pd", pd);	
		} catch(Exception e){
		}
		return "system/dictionaries/dictionaries_ztree_windows";
	}
	
}
