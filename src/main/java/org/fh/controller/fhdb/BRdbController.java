package org.fh.controller.fhdb;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;


import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.fhdb.BRdbService;
import org.fh.util.DateUtil;
import org.fh.util.DbFH;
import org.fh.util.FileUtil;
import org.fh.util.Jurisdiction;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：数据库管理(备份和还原)
 * 作者：FH 
 *  ：
 */
@Controller
@RequestMapping("/brdb")
public class BRdbController extends BaseController {
	
	@Autowired
	private BRdbService bRdbService;
	
	/**列出所有表
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/listAllTable")
	@RequiresPermissions("brdb:listAllTable")
	public String listAllTable(Model model) throws Exception{
		Object[] arrOb = DbFH.getTables();
		List<String> tblist = (List<String>)arrOb[1];
		model.addAttribute("varList", tblist);				//所有表
		model.addAttribute("dbtype", arrOb[2]);				//数据库类型
		model.addAttribute("databaseName", arrOb[0]);		//数据库名
		return "fhdb/brdb/table_list";
	}
	
	 /**备份全库
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/backupAll")
	@ResponseBody
	@RequiresPermissions("brdb:add")
	public Object backupAll(){
		String username = Jurisdiction.getUsername();
		String errInfo = "success";
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String kackupPath;
		try {
			kackupPath = DbFH.getDbFH().backup("").toString();			//调用数据库备份
			if(Tools.notEmpty(kackupPath) && !"errer".equals(kackupPath)){
				pd.put("FHDB_ID", this.get32UUID());					//主键
				pd.put("USERNAME", username);							//操作用户
				pd.put("BACKUP_TIME", DateUtil.date2Str(new Date()));	//备份时间
				pd.put("TABLENAME", "整库");								//表名
				pd.put("SQLPATH", kackupPath);							//存储位置
				pd.put("DBSIZE", FileUtil.getFilesize(kackupPath));		//文件大小
				pd.put("TYPE", 1);										//1: 备份整库，2：备份某表
				pd.put("BZ", username+"备份全库操作");					//备注
				try {
					bRdbService.save(pd);
				} catch (Exception e) {
					errInfo = "error";
				}
			}else{
				errInfo = "error";
			}
		} catch (InterruptedException e) {
			errInfo = "error";
			e.printStackTrace();
		} catch (ExecutionException e) {
			errInfo = "error";
			e.printStackTrace();
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	 /**备份单表
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/backupTable")
	@ResponseBody
	@RequiresPermissions("brdb:add")
	public Object backupTable(){
		String username = Jurisdiction.getUsername();
		String errInfo = "success";
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String TABLENAME = pd.getString("fhtable");					//页面ajax传过来的表名
		String kackupPath;
		try {
			kackupPath = DbFH.getDbFH().backup(TABLENAME).toString();	//调用数据库备份
			if(Tools.notEmpty(kackupPath) && !"errer".equals(kackupPath)){
				pd.put("FHDB_ID", this.get32UUID());				//主键
				pd.put("USERNAME", username);						//操作用户
				pd.put("BACKUP_TIME", DateUtil.date2Str(new Date()));	//备份时间
				pd.put("TABLENAME", TABLENAME);						//表名
				pd.put("SQLPATH", kackupPath);						//存储位置
				pd.put("DBSIZE", FileUtil.getFilesize(kackupPath));	//文件大小
				pd.put("TYPE", 2);									//1: 备份整库，2：备份某表
				pd.put("BZ", username+"备份单表");					//备注
				try {
					bRdbService.save(pd);
				} catch (Exception e) {
					errInfo = "error";
				}
			}else{
				errInfo = "error";
			}
		} catch (InterruptedException e) {
			errInfo = "error";
			e.printStackTrace();
		} catch (ExecutionException e) {
			errInfo = "error";
			e.printStackTrace();
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	 /**数据还原操作
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/dbRecover")
	@ResponseBody
	@RequiresPermissions("brdb:edit")
	public Object dbRecover(){
		String errInfo = "success";
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String TABLENAME = pd.getString("TABLENAME");			//页面ajax传过来的表名或数据库名
		String SQLPATH = pd.getString("SQLPATH");				//页面ajax传过来的备份文件完整路径
		try {
			String returnStr = DbFH.getDbFH().recover(TABLENAME, SQLPATH).toString();
			if("ok".equals(returnStr)){
				errInfo = "success";
			}else{
				errInfo = "error";
			}
		} catch (InterruptedException e) {
			errInfo = "error";
			e.printStackTrace();
		} catch (ExecutionException e) {
			errInfo = "error";
			e.printStackTrace();
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("brdb:del")
	public Object delete(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try {
			bRdbService.delete(pd);
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
	@RequiresPermissions("brdb:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		bRdbService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("brdb:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");						//关键词检索条件
		if(Tools.notEmpty(keywords))pd.put("keywords", keywords.trim());
		String lastStart = pd.getString("lastStart");					//开始时间
		String lastEnd = pd.getString("lastEnd");						//结束时间
		if(Tools.notEmpty(lastStart))pd.put("lastLoginStart", lastStart+" 00:00:00");
		if(Tools.notEmpty(lastEnd)) pd.put("lastLoginEnd", lastEnd+" 00:00:00");
		page.setPd(pd);
		List<PageData>	varList = bRdbService.list(page);			//列出Fhdb列表
		Map<String,String> DBmap = DbFH.getDBParameter();
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		model.addAttribute("dbtype", DBmap.get("dbtype").toString());		//数据库类型
		model.addAttribute("remoteDB", DBmap.get("remoteDB").toString());	//是否远程备份数据库 yes or no
		return "fhdb/brdb/brdb_list";
	}
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	@RequiresPermissions("brdb:edit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = bRdbService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhdb/brdb/brdb_edit";
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("brdb:del")
	public Object deleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		if(Tools.notEmpty(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			try {
				bRdbService.deleteAll(ArrayDATA_IDS);
			} catch (Exception e) {
				errInfo = "error";
			}
		}else{
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
}
