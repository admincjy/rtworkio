package org.fh.mobile.fhim;

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
 * 说明：好友管理(手机端)
 * 作者：FH Admin Q313596790
 * 官网：www.fhadmin.org
 */
@Controller
@RequestMapping(value="/mobfriends")
public class MobFriendsController extends BaseController {
	
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
		return "mobile/im/friends_list";
	}
	
	/**去添加好友页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd()throws Exception{
		return "mobile/im/friends_add";
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
		return "mobile/im/friends_add";
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
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = friendsService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "mobile/im/friends_edit";
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@ResponseBody
	@RequiresPermissions("friends:edit")
	public Object edit() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		friendsService.edit(pd);
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
}
