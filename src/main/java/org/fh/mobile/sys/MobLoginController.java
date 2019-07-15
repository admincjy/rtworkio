package org.fh.mobile.sys;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.fh.controller.base.BaseController;
import org.fh.entity.system.User;
import org.fh.service.system.FHlogService;
import org.fh.service.system.UsersService;
import org.fh.util.Const;
import org.fh.util.IniFileUtil;
import org.fh.util.Jurisdiction;
import org.fh.util.PathUtil;
import org.fh.entity.PageData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：登录处理类(手机端)
 * 作者：FH Admin 
 */
@Controller
@RequestMapping("/mobile")
public class MobLoginController extends BaseController {
	
	@Autowired
    private UsersService usersService;
	@Autowired
    private FHlogService FHLOG;
	
	/**访问登录页
	 * @param model
	 * @return
	 */
	@RequestMapping("/login")
	public String loginPage(Model model)throws Exception{
		Session session = Jurisdiction.getSession();
		if(null == session.getAttribute(Const.SYSNAME)){
			String infFilePath = PathUtil.getClasspath()+Const.SYSSET;										//配置文件路径
			String sysName = IniFileUtil.readCfgValue(infFilePath, "SysSet1", Const.SYSNAME, "FH Admin");	//系统名称
			session.setAttribute(Const.SYSNAME, sysName);
		}
		return "mobile/login";
	}

	/**请求登录，验证用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/check" ,produces="application/json;charset=UTF-8")
	@ResponseBody
	public Object check()throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		String KEYDATA[] = pd.getString("KEYDATA").replaceAll("qq313596790fh", "").split(",fh,");
		if(null != KEYDATA && KEYDATA.length == 2){
			String USERNAME = KEYDATA[0];							//登录过来的用户名
			String PASSWORD  = KEYDATA[1];							//登录过来的密码
			UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, new SimpleHash("SHA-1", USERNAME, PASSWORD).toString());
			Subject subject = SecurityUtils.getSubject();
			try {
				subject.login(token);								//这一步在调用login(token)方法时,它会走到MyRealm.doGetAuthenticationInfo()方法中
	        }catch(UnknownAccountException uae){
	            errInfo = "usererror";
	        }catch(IncorrectCredentialsException ice){
	        	errInfo = "usererror";
	        }catch(LockedAccountException lae){
	        	errInfo = "usererror";
	        }catch(ExcessiveAttemptsException eae){
	        	errInfo = "usererror4";
	        }catch (DisabledAccountException sae){
	        	errInfo = "usererror";
	        }catch(AuthenticationException ae){
	        	errInfo = "usererror";
	        }
	        if(subject.isAuthenticated()){							//验证是否登录成功
	        	Session session = Jurisdiction.getSession();
	        	pd.put("USERNAME", USERNAME);
	            pd = usersService.findByUsername(pd);
	            User user = new User();
	            user.setUSER_ID(pd.getString("USER_ID"));
				user.setUSERNAME(pd.getString("USERNAME"));
				user.setPASSWORD(pd.getString("PASSWORD"));
				user.setNAME(pd.getString("NAME"));
				user.setROLE_ID(pd.getString("ROLE_ID"));
				user.setLAST_LOGIN(pd.getString("LAST_LOGIN"));
				user.setIP(pd.getString("IP"));
				user.setSTATUS(pd.getString("STATUS"));
				session.setAttribute(Const.SESSION_USER, user);		//把当前用户放入session
				FHLOG.save(USERNAME, "手机端成功登录系统");				//记录日志
	        }else{
	            token.clear();
	            errInfo = "usererror";
	        }
	        if(!"success".equals(errInfo))FHLOG.save(USERNAME, "手机端尝试登录系统失败,用户名密码错误,无权限");
		}else{
			errInfo = "error";										//缺少参数
		}
		map.put("result", errInfo);
		return map;
	}

}
