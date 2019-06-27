package org.fh.controller.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.fh.controller.base.BaseController;
import org.fh.entity.system.Role;
import org.fh.service.system.DictionariesService;
import org.fh.service.system.FHlogService;
import org.fh.service.system.RoleService;
import org.fh.service.system.UsersService;
import org.fh.util.Const;
import org.fh.util.FileDownload;
import org.fh.util.FileUpload;
import org.fh.util.GetPinyin;
import org.fh.util.Jurisdiction;
import org.fh.util.ObjectExcelRead;
import org.fh.util.ObjectExcelView;
import org.fh.util.PathUtil;
import org.fh.util.Tools;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 * 说明：系统用户处理类
 * 作者：FH Admin
 * 官网：
 */
@Controller
@RequestMapping("/user")
public class UsersController extends BaseController {
	
	@Autowired
    private UsersService usersService;
	@Autowired
    private RoleService roleService;
	@Autowired
    private FHlogService FHLOG;
	@Autowired
    private DictionariesService dictionariesService;
	
	
	/**用户列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listUsers")
	@RequiresPermissions("user:list")
	public String listUsers(Page page, Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		
		/*检索条件*/
		String ROLE_ID = pd.getString("ROLE_ID");						//角色ID
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		String STRARTTIME = pd.getString("STRARTTIME");					//开始时间
		String ENDTIME = pd.getString("ENDTIME");						//结束时间
		if(Tools.notEmpty(STRARTTIME))pd.put("STRARTTIME", STRARTTIME+" 00:00:00");
		if(Tools.notEmpty(ENDTIME))pd.put("ENDTIME", ENDTIME+" 00:00:00");
		
		page.setPd(pd);
		List<PageData>	userList = usersService.userlistPage(page);		//列出用户列表
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);		//列出所有系统用户角色
		model.addAttribute("userList", userList);
		model.addAttribute("roleList", roleList);
		model.addAttribute("ROLE_ID", ROLE_ID);
		model.addAttribute("pd", pd);

		return "system/user/user_list";
	}
	
	/**去新增用户页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddUser")
	@RequiresPermissions("user:add")
	public String goAddUser(Model model)throws Exception{
		PageData pd = new PageData();
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);		//列出所有系统用户角色
		model.addAttribute("msg", "saveUser");
		model.addAttribute("roleList", roleList);
		model.addAttribute("pd", pd);
		return "system/user/user_edit";
	}
	
	/**去修改用户页面(系统用户列表修改)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditUser")
	@RequiresPermissions("user:edit")
	public String goEditUser(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		if("1".equals(pd.getString("USER_ID"))){return null;}		//不能修改admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		model.addAttribute("fx", "user");
		pd = usersService.findById(pd);								//根据ID读取
		String ROLE_IDS = pd.getString("ROLE_IDS");					//副职角色ID
		if(Tools.notEmpty(ROLE_IDS)){
			String arryROLE_ID[] = ROLE_IDS.split(",");
			for(int i=0;i<roleList.size();i++){
				Role role = roleList.get(i);
				String roleId = role.getROLE_ID();
				for(int n=0;n<arryROLE_ID.length;n++){
					if(arryROLE_ID[n].equals(roleId)){
						role.setRIGHTS("1");	//此时的目的是为了修改用户信息上，能看到副职角色都有哪些
						break;
					}
				}
			}
		}
		model.addAttribute("pd", pd);
		model.addAttribute("msg", "editUser");
		model.addAttribute("roleList", roleList);
		return "system/user/user_edit";
	}
	
	/**去修改用户页面(个人资料修改)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditMyInfo")
	public String goEditMyInfo(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd.put("USERNAME", Jurisdiction.getUsername());
		pd = usersService.findByUsername(pd);						//根据用户名读取
		model.addAttribute("pd", pd);
		model.addAttribute("fx", "head");
		model.addAttribute("msg", "editUserOwn");
		model.addAttribute("roleList", roleList);
		return "system/user/user_edit";
	}
	
	/**
	 * 修改用户(系统用户列表修改)
	 */
	@RequestMapping(value="/editUser")
	@RequiresPermissions("user:edit")
	public String editUser(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		FHLOG.save(Jurisdiction.getUsername(), "从系统用户中修改"+pd.getString("USERNAME")+"的资料");				//记录日志
		if(!Jurisdiction.getUsername().equals(pd.getString("USERNAME"))){ //如果当前登录用户修改用户资料提交的用户名非本人
			if("admin".equals(pd.getString("USERNAME")) && !"admin".equals(Jurisdiction.getUsername())){return null;}	//非admin用户不能修改admin
		}else{	//如果当前登录用户修改用户资料提交的用户名是本人，则不能修改本人的角色ID
			PageData upd = new PageData();
			upd = usersService.findByUsername(pd);
			pd.put("ROLE_ID", upd.getString("ROLE_ID")); //对角色ID还原本人角色ID
			pd.put("ROLE_IDS", Tools.notEmpty(upd.getString("ROLE_IDS"))?upd.get("ROLE_IDS"):""); //对角色ID还原本人副职角色ID
		}
		if(pd.getString("PASSWORD") != null && !"".equals(pd.getString("PASSWORD"))){
			pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());
		}
		usersService.editUser(pd);	//执行修改
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**
	 * 修改用户(个人资料修改)
	 */
	@RequestMapping(value="/editUserOwn")
	public String editUserOwn(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		FHLOG.save(Jurisdiction.getUsername(), "从个人资料中修改"+pd.getString("USERNAME")+"的资料");				//记录日志
		if(!Jurisdiction.getUsername().equals(pd.getString("USERNAME"))){ //如果当前登录用户修改用户资料提交的用户名非本人
			return null;//不能修改非本人的资料
		}else{			//如果当前登录用户修改用户资料提交的用户名是本人，则不能修改本人的角色ID
			PageData upd = new PageData();
			upd = usersService.findByUsername(pd);
			pd.put("ROLE_ID", upd.getString("ROLE_ID")); //对角色ID还原本人角色ID
			pd.put("ROLE_IDS", Tools.notEmpty(upd.getString("ROLE_IDS"))?upd.get("ROLE_IDS"):""); //对角色ID还原本人副职角色ID
		}
		if(pd.getString("PASSWORD") != null && !"".equals(pd.getString("PASSWORD"))){
			pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());
		}
		usersService.editUser(pd);	//执行修改
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**判断用户名是否存在
	 * @return
	 */
	@RequestMapping(value="/hasUser")
	@ResponseBody
	public Object hasUser(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(usersService.findByUsername(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**判断邮箱是否存在
	 * @return
	 */
	@RequestMapping(value="/hasEmail")
	@ResponseBody
	public Object hasEmail(){
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
	
	/**判断编码是否存在
	 * @return
	 */
	@RequestMapping(value="/hasNumber")
	@ResponseBody
	public Object hasNumber(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(usersService.findByNumbe(pd) != null){
				errInfo = "error";
			}
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**保存用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveUser")
	@RequiresPermissions("user:add")
	public String saveUser(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USER_ID", this.get32UUID());			//ID 主键
		pd.put("LAST_LOGIN", "");						//最后登录时间
		pd.put("IP", "");								//IP
		pd.put("STATUS", "0");							//状态
		pd.put("SKIN", "pcoded-navbar navbar-image-3,navbar pcoded-header navbar-expand-lg navbar-light header-dark,");		//用户默认皮肤
		pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());			//密码加密
		if(null == usersService.findByUsername(pd)){	//判断用户名是否存在
			usersService.saveUser(pd); 					//执行保存
			model.addAttribute("msg","success");
		}else{
			model.addAttribute("msg","failed");
		}
		FHLOG.save(Jurisdiction.getUsername(), "新增用户："+pd.getString("USERNAME"));				//记录日志
		return "transferPage";
	}
	
	/**删除用户
	 * @return
	 */
	@RequestMapping(value="/deleteUser")
	@ResponseBody
	@RequiresPermissions("user:del")
	public Object deleteUser(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		String errInfo = "success";
		try{
			pd = this.getPageData();
			FHLOG.save(Jurisdiction.getUsername(), "删除用户ID："+pd.getString("USER_ID"));				//记录日志
			usersService.deleteUser(pd);
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**
	 * 批量删除
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteAllUser")
	@ResponseBody
	@RequiresPermissions("user:del")
	public Object deleteAllUser(){
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String USER_IDS = pd.getString("USER_IDS");
		String errInfo = "success";
		if(Tools.notEmpty(USER_IDS)){
			try{
				String ArrayUSER_IDS[] = USER_IDS.split(",");
				FHLOG.save(Jurisdiction.getUsername(), "批量删除用户");				//记录日志
				usersService.deleteAllUser(ArrayUSER_IDS);
				errInfo = "success";
			} catch(Exception e){
				errInfo = "error";
			}
		}else{
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**导出用户信息到EXCEL
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/excel")
	@RequiresPermissions("toExcel")
	public ModelAndView exportExcel() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			
			/*检索条件*/
			String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
			if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
			String STRARTTIME = pd.getString("STRARTTIME");					//开始时间
			String ENDTIME = pd.getString("ENDTIME");						//结束时间
			if(Tools.notEmpty(STRARTTIME))pd.put("STRARTTIME", STRARTTIME+" 00:00:00");
			if(Tools.notEmpty(ENDTIME))pd.put("ENDTIME", ENDTIME+" 00:00:00");
			
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("用户名"); 		//1
			titles.add("编号");  		//2
			titles.add("姓名");			//3
			titles.add("职位");			//4
			titles.add("手机");			//5
			titles.add("邮箱");			//6
			titles.add("最近登录");		//7
			titles.add("上次登录IP");	//8
			dataMap.put("titles", titles);
			List<PageData> userList = usersService.listAllUser(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<userList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", userList.get(i).getString("USERNAME"));		//1
				vpd.put("var2", userList.get(i).getString("NUMBER"));		//2
				vpd.put("var3", userList.get(i).getString("NAME"));			//3
				vpd.put("var4", userList.get(i).getString("ROLE_NAME"));	//4
				vpd.put("var5", userList.get(i).getString("PHONE"));		//5
				vpd.put("var6", userList.get(i).getString("EMAIL"));		//6
				vpd.put("var7", userList.get(i).getString("LAST_LOGIN"));	//7
				vpd.put("var8", userList.get(i).getString("IP"));			//8
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();					//执行excel操作
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
		}
		return mv;
	}
	
	/**打开上传EXCEL页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goUploadExcel")
	public String goUploadExcel()throws Exception{
		return"system/user/uploadexcel";
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
			String fileName =  FileUpload.fileUp(file, filePath, "userexcel");								//执行上传
			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0);			//执行读EXCEL操作,读出的数据导入List 2:从第3行开始；0:从第A列开始；0:第0个sheet
			pd.put("LAST_LOGIN", "");				//最后登录时间
			pd.put("IP", "");						//IP
			pd.put("STATUS", "0");					//状态
			pd.put("SKIN", "pcoded-navbar navbar-image-3,navbar pcoded-header navbar-expand-lg navbar-light header-dark,");					//默认皮肤
			pd.put("ROLE_ID", "fhadminzhuche");		//默认角色注册用户
			pd.put("ROLE_IDS", "");					//副职角色
			/**
			 * var0 :编号
			 * var1 :姓名
			 * var2 :手机
			 * var3 :邮箱
			 * var4 :备注
			 */
			for(int i=0;i<listPd.size();i++){		
				pd.put("USER_ID", this.get32UUID());										//ID
				pd.put("NAME", listPd.get(i).getString("var1"));							//姓名
				String USERNAME = GetPinyin.getPingYin(listPd.get(i).getString("var1"));	//根据姓名汉字生成全拼
				pd.put("USERNAME", USERNAME);	
				if(usersService.findByUsername(pd) != null){								//判断用户名是否重复
					USERNAME = GetPinyin.getPingYin(listPd.get(i).getString("var1"))+Tools.getRandomNum();
					pd.put("USERNAME", USERNAME);
				}
				pd.put("BZ", listPd.get(i).getString("var4"));								//备注
				if(Tools.checkEmail(listPd.get(i).getString("var3"))){						//邮箱格式不对就跳过
					pd.put("EMAIL", listPd.get(i).getString("var3"));						
					if(usersService.findByEmail(pd) != null){								//邮箱已存在就跳过
						continue;
					}
				}else{
					continue;
				}
				pd.put("NUMBER", listPd.get(i).getString("var0"));							//编号已存在就跳过
				pd.put("PHONE", listPd.get(i).getString("var2"));							//手机号
				
				pd.put("PASSWORD", new SimpleHash("SHA-1", USERNAME, "123").toString());	//默认密码123
				if(usersService.findByNumbe(pd) != null){
					continue;
				}
				usersService.saveUser(pd);
			}
		}
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**去修改用户页面(在线管理页面打开)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goEditUfromOnline")
	public String goEditUfromOnline(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		if("admin".equals(pd.getString("USERNAME"))){return null;}	//不能查看admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd = usersService.findByUsername(pd);						//根据ID读取
		List<Role> froleList = new  ArrayList<Role>();				//存放副职角色
		String ROLE_IDS = pd.getString("ROLE_IDS");					//副职角色ID
		if(Tools.notEmpty(ROLE_IDS)){
			String arryROLE_ID[] = ROLE_IDS.split(",");
			for(int i=0;i<roleList.size();i++){
				Role role = roleList.get(i);
				String roleId = role.getROLE_ID();
				for(int n=0;n<arryROLE_ID.length;n++){
					if(arryROLE_ID[n].equals(roleId)){
						role.setRIGHTS("1");	//此时的目的是为了修改用户信息上，能看到副职角色都有哪些
						break;
					}
				}
				froleList.add(role);
			}
		}else{
			froleList = roleList;
		}
		model.addAttribute("msg", "editUser");
		model.addAttribute("pd", pd);
		model.addAttribute("roleList", roleList);
		model.addAttribute("froleList", froleList);
		return "system/user/user_edit";
	}
	
	/**查看用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/view")
	public String view(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String USERNAME = pd.getString("USERNAME");
		if("admin".equals(USERNAME)){return null;}					//不能查看admin用户
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);	//列出所有系统用户角色
		pd = usersService.findByUsername(pd);						//根据ID读取
		if(null == pd){
			PageData rpd = new PageData();
			rpd.put("RNUMBER", USERNAME);							//用户名查不到数据时就把数据当作角色的编码去查询角色表
			rpd = roleService.getRoleByRnumber(rpd);
			model.addAttribute("rpd", rpd);
		}
		model.addAttribute("pd", pd);
		model.addAttribute("roleList", roleList);
		return "system/user/user_view";
	}
	
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
		String STRARTTIME = pd.getString("STRARTTIME");					//开始时间
		String ENDTIME = pd.getString("ENDTIME");						//结束时间
		if(Tools.notEmpty(STRARTTIME))pd.put("STRARTTIME", STRARTTIME+" 00:00:00");
		if(Tools.notEmpty(ENDTIME))pd.put("ENDTIME", ENDTIME+" 00:00:00");
		page.setPd(pd);
		List<PageData>	userList = usersService.listUsersBystaff(page);	//列出用户列表(弹窗选择用)
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);		//列出所有系统用户角色
		model.addAttribute("userList", userList);
		model.addAttribute("roleList", roleList);
		model.addAttribute("pd", pd);
		return "system/user/window_user_list";
	}
	
	
	/**显示抄送人用户列表(弹窗选择用)
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/listCCUsersForWindow")
	public String listCCUsersForWindow(Page page, Model model)throws Exception{
//		page.setShowCount(1000);
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		String STRARTTIME = pd.getString("STRARTTIME");					//开始时间
		String ENDTIME = pd.getString("ENDTIME");						//结束时间
		if(Tools.notEmpty(STRARTTIME))pd.put("STRARTTIME", STRARTTIME+" 00:00:00");
		if(Tools.notEmpty(ENDTIME))pd.put("ENDTIME", ENDTIME+" 00:00:00");
		page.setPd(pd);
		List<PageData>	userList = usersService.listUsersBystaff(page);	//列出用户列表(弹窗选择用)
		pd.put("ROLE_ID", "1");
		List<Role> roleList = roleService.listAllRolesByPId(pd);		//列出所有系统用户角色
		model.addAttribute("userList", userList);
		model.addAttribute("roleList", roleList);
		model.addAttribute("pd", pd);
		return "system/user/window_ccuser_list";
	}
}
