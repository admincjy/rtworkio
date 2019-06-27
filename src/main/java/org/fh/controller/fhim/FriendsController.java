package org.fh.controller.fhim;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.fhim.FriendsService;
import org.fh.util.Jurisdiction;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：好友管理
 * 作者：FH 
 * 官网：
 */
@Controller
@RequestMapping("/friends")
public class FriendsController extends BaseController {
	
	@Autowired
	private FriendsService friendsService;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("friends:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");						//关键词检索条件
		if(Tools.notEmpty(keywords))pd.put("keywords", keywords.trim());
		pd.put("USERNAME", Jurisdiction.getUsername());
		page.setPd(pd);
		List<PageData>	varList = friendsService.datalistPage(page);	//列出Friends列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhim/friends/friends_list";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/deletefromlist")
	@ResponseBody
	@RequiresPermissions("friends:del")
	public Object deletefromlist(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try {
			friendsService.delete(pd);
		} catch (Exception e) {
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**拉黑
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/pullblackfromlist")
	@ResponseBody
	@RequiresPermissions("friends:del")
	public Object pullblackfromlist(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try {
			friendsService.delete(pd);						//删除自己好友栏
			pd.put("USERNAME", Jurisdiction.getUsername());	//用户名
			friendsService.pullblack(pd);					//删除对方好友栏
		} catch (Exception e) {
			errInfo = "error";
		}
		map.put("result", errInfo);							//返回结果
		return map;
	}
	
	/**删除 从右下角好友列表里面右键拉黑好友
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("friends:del")
	public Object delete(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		String FRIENDS_ID = pd.getString("FRIENDS_ID");
		try {
			if("null".equals(FRIENDS_ID)){						
				pd.put("USERNAME", Jurisdiction.getUsername());	//用户名
				pd = friendsService.findMyFriend(pd);
			}						
			friendsService.delete(pd);
		} catch (Exception e) {
			errInfo = "error";
		}
		map.put("result", errInfo);								//返回结果
		return map;
	}
	
	/**拉黑 从右下角好友列表里面右键拉黑好友
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/pullblack")
	@ResponseBody
	@RequiresPermissions("friends:del")
	public Object pullblack(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		String FRIENDS_ID = pd.getString("FRIENDS_ID");
		try {
			if("null".equals(FRIENDS_ID)){						
				pd.put("USERNAME", Jurisdiction.getUsername());	//用户名
				pd = friendsService.findMyFriend(pd);
			}
			friendsService.delete(pd);						//删除自己好友栏
			pd.put("USERNAME", Jurisdiction.getUsername());	//用户名
			friendsService.pullblack(pd);					//删除对方好友栏
		} catch (Exception e) {
			errInfo = "error";
		}
		map.put("result", errInfo);								//返回结果
		return map;
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@RequiresPermissions("friends:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		friendsService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String FRIENDS_ID = pd.getString("FRIENDS_ID");
		if("null".equals(FRIENDS_ID)){						//从右下角好友列表里面右键删除好友
			pd.put("USERNAME", Jurisdiction.getUsername());	//用户名
			pd = friendsService.findMyFriend(pd);
		}else{	
			pd = friendsService.findById(pd);				//根据ID读取
		}
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhim/friends/friends_edit";
	}
	
	/**去添加好友页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd()throws Exception{
		return "fhim/friends/friends_add";
	}
	
	/**添加好友检索
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/search")
	public String search(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");						//关键词检索条件
		if(Tools.notEmpty(keywords))pd.put("keywords", keywords.trim());
		pd.put("USERNAME", Jurisdiction.getUsername());					//不检索自己
		List<PageData>	varList = friendsService.listAllToSearch(pd);
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhim/friends/friends_add";
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("friends:del")
	public Object deleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		if(Tools.notEmpty(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			try {
				friendsService.deleteAll(ArrayDATA_IDS);
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
