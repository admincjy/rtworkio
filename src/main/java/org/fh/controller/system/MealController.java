package org.fh.controller.system;

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
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;

import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.util.DateUtil;
import org.fh.util.ObjectExcelView;
import org.fh.util.Tools;
import org.fh.entity.PageData;
import org.fh.service.system.MealService;
import org.fh.service.system.UsersService;

/** 
 * 说明：订餐表
 * 作者：FH Admin 
 * 时间：2019-04-09
 * 官网：
 */
@Controller
@RequestMapping("/meal")
public class MealController extends BaseController {
	
	@Autowired
	private MealService mealService;
	@Autowired
	private UsersService usersService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("meal:add")
	public String save(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MEAL_ID", this.get32UUID());	//主键
		mealService.save(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("meal:del")
	public Object delete(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			mealService.delete(pd);
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
	@RequiresPermissions("meal:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		mealService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("meal:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData>	varList = mealService.list(page);	//列出Meal列表
        Page pages=new Page();
		List<PageData> userList=usersService.listUsersBystaff(pages);
        model.addAttribute("userList", userList);
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "system/meal/meal_list";
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	@RequiresPermissions("meal:add")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData page = new PageData();
		List<PageData> userList=usersService.listAllUser(page);
        model.addAttribute("userList", userList);
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "system/meal/meal_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	@RequiresPermissions("meal:edit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = mealService.findById(pd);	//根据ID读取
        Page page=new Page();
		List<PageData> userList=usersService.listUsersBystaff(page);
        model.addAttribute("userList", userList);
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "system/meal/meal_edit";
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("meal:del")
	public Object deleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		try{
			if(Tools.notEmpty(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				mealService.deleteAll(ArrayDATA_IDS);
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
		titles.add("订餐人");	//1
		titles.add("创建时间");	//2
//		titles.add("更新时间");	//3
//		titles.add("菜单");	//4
//		titles.add("是否订餐(0否1是)");	//5
//		titles.add("是否停止订餐(0否1是)");	//6
//		titles.add("就餐时间");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = mealService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			PageData pd1=new PageData();
			pd1.put("USER_ID", varOList.get(i).getString("USER_ID"));
			PageData pd2=usersService.findById(pd1);
			if (pd2!=null) {
				vpd.put("var1", pd2.getString("NAME"));	    //1
			}else {
                vpd.put("var1", "");	    //1
			}
			vpd.put("var2", varOList.get(i).get("CREATETIME").toString());	    //2
//			vpd.put("var3", varOList.get(i).get("UPDATETIME").toString());	    //3
//			vpd.put("var4", varOList.get(i).getString("MENU"));	    //4
//			vpd.put("var5", varOList.get(i).get("ISORDER").toString());	//5
//			vpd.put("var6", varOList.get(i).get("ISSTOPORDER").toString());	//6
//			vpd.put("var7", varOList.get(i).getString("DINNERTIME"));	    //7
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/callMeal")
	@ResponseBody
	public Object callMeal(Model model) throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
        Object USERNAME=(Object) SecurityUtils.getSubject().getPrincipal(); 
		PageData pageData=new PageData();
		pageData.put("USERNAME", USERNAME.toString());
		PageData pageData2=usersService.findByUsername(pageData);
		if (USERNAME.toString()=="admin"||USERNAME.toString().equals("admin")) {
			map.put("result","admin");
			return map;
		}
		if(mealService.findByUserId(pageData)==null) {
	    	PageData pd =new PageData();
			pd = this.getPageData();
			pd.put("MEAL_ID", this.get32UUID());	//主键
			pd.put("USER_ID", pageData2.get("USER_ID"));
			mealService.save(pd);
			map.put("result","success");
	    }else {
	    	map.put("result","failure");
	    }
		return map;
	}
	
}
