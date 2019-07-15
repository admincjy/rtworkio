package org.fh.mobile.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.entity.system.Role;
import org.fh.service.system.FHlogService;
import org.fh.service.system.PhotoService;
import org.fh.service.system.RoleService;
import org.fh.service.system.UsersService;
import org.fh.util.DelFileUtil;
import org.fh.util.ImageAnd64Binary;
import org.fh.util.Jurisdiction;
import org.fh.util.PathUtil;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：用户(手机端)
 * 作者：FH Admin Q313596790
 *  ：www.fhadmin. org
 */
@Controller
@RequestMapping("/mobileuser")
public class MobUserController extends BaseController {
	
	@Autowired
    private UsersService usersService;
	@Autowired
    private RoleService roleService;
	@Autowired
	private PhotoService photoService;
	@Autowired
    private FHlogService FHLOG;
	
	/**显示用户列表(弹窗选择用)
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listUsersForWindow")
	public String listUsersForWindow(Page page, Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData>	userList = usersService.listUsersBystaff(page);	//列出用户列表(弹窗选择用)
		model.addAttribute("userList", userList);
		model.addAttribute("pd", pd);
		return "mobile/user/window_user_list";
	}
	
	/** 选择角色(弹窗选择用)
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/roleListWindow")
	public String roleListWindow(Page page, Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData> roleList = roleService.roleListWindow(page);//列出所有角色
		model.addAttribute("pd", pd);
		model.addAttribute("roleList", roleList);
		return "mobile/user/window_role_list";
	}
	
	/**进入修改头像页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditPhoto")
	public String goEditPhoto()throws Exception{
		return "mobile/user/user_photo";
	}
	
	/**保存用户头像
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/saveUserPhoto")
	@ResponseBody
	public Object saveUserPhoto() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		pd = this.getPageData();
		String USERNAME = Jurisdiction.getUsername();//用户名
		String userphoto = "uploadFiles/photo/"+USERNAME+"_photo.jpg";
		String imgData = pd.getString("PHOTODATA").replace("data:image/jpeg;base64,", "");
		String pathimg = PathUtil.getProjectpath()+userphoto;
		ImageAnd64Binary.generateImage(imgData, pathimg);
		pd.put("USERNAME", USERNAME);	
		pd.put("PHOTO0", "");			//原图
		pd.put("PHOTO1", userphoto);	//头像1
		pd.put("PHOTO2", userphoto);	//头像2
		pd.put("PHOTO3", userphoto);	//头像3
		map.put("userPhoto",pd.getString("PHOTO2"));
		PageData ypd = photoService.findById(pd);
		if(null == ypd){				//没有数据就新增，否则就修改
			pd.put("USERPHOTO_ID", this.get32UUID());		//主键
			photoService.save(pd);
		}else{
			photoService.edit(pd);
			String PHOTO0 = ypd.getString("PHOTO0");
			String PHOTO1 = ypd.getString("PHOTO1");
			String PHOTO2 = ypd.getString("PHOTO2");
			String PHOTO3 = ypd.getString("PHOTO3");
			if(!userphoto.equals(PHOTO1)){
				if(Tools.notEmpty(PHOTO0)){
					DelFileUtil.delFolder(PathUtil.getProjectpath()+ PHOTO0); //删除原图
				}
				DelFileUtil.delFolder(PathUtil.getProjectpath()+ PHOTO1); //删除图1
				DelFileUtil.delFolder(PathUtil.getProjectpath()+ PHOTO2); //删除图2
				DelFileUtil.delFolder(PathUtil.getProjectpath()+ PHOTO3); //删除图3
			}
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**进入修改资料页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditUser")
	public String index(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd.put("USERNAME", Jurisdiction.getUsername());
		pd = usersService.findByUsername(pd);						//根据用户名读取
		model.addAttribute("msg", "editU");
		model.addAttribute("pd", pd);
		model.addAttribute("roleList", roleList);
		return "mobile/user/user_info";
	}
	
	/**
	 * 修改用户
	 */
	@RequestMapping(value="/editU")
	public String editU(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!Jurisdiction.getUsername().equals(pd.getString("USERNAME"))){		//如果当前登录用户修改用户资料提交的用户名非本人
			FHLOG.save(Jurisdiction.getUsername(), "恶意修改用户资料："+pd.getString("USERNAME"));
			return null;
		}else{	//如果当前登录用户修改用户资料提交的用户名是本人，则不能修改本人的角色ID
			PageData upd = new PageData();
			upd = usersService.findByUsername(pd);
			pd.put("USER_ID", upd.getString("USER_ID")); //对ID还原本人ID，防止串改
			pd.put("ROLE_ID", upd.getString("ROLE_ID")); //对角色ID还原本人角色ID
			pd.put("ROLE_IDS", Tools.notEmpty(upd.getString("ROLE_IDS"))?upd.get("ROLE_IDS"):""); //对角色ID还原本人副职角色ID
		}
		if(pd.getString("PASSWORD") != null && !"".equals(pd.getString("PASSWORD"))){
			pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());
		}
		usersService.editUser(pd);	//执行修改
		FHLOG.save(Jurisdiction.getUsername(), "修改个人资料："+pd.getString("USERNAME"));
		model.addAttribute("msg","editUsuccess");
		return "mobile/user/user_center";
	}
	
	/**判断邮箱是否存在
	 * @return
	 */
	@RequestMapping(value="/hasE")
	@ResponseBody
	public Object hasE(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(usersService.findByEmail(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}

}
