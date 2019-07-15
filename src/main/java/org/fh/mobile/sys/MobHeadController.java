package org.fh.mobile.sys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.session.Session;
import org.fh.controller.base.BaseController;
import org.fh.entity.PageData;
import org.fh.entity.system.Role;
import org.fh.entity.system.User;
import org.fh.service.system.FhsmsService;
import org.fh.service.system.PhotoService;
import org.fh.service.system.RoleService;
import org.fh.service.system.UsersService;
import org.fh.util.Const;
import org.fh.util.IniFileUtil;
import org.fh.util.Jurisdiction;
import org.fh.util.PathUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：手机获取基础信息
 * 作者：FH Admin Q313596790
 *  ：www. fhadmin.org
 */
@Controller
@RequestMapping("/mobilehead")
public class MobHeadController extends BaseController {
	
	@Autowired
    private UsersService usersService;
	@Autowired
    private RoleService roleService;
	@Autowired
    private PhotoService photoService;
	@Autowired
	private FhsmsService fhsmsService;
	
	/**获取基本信息
	 * @return
	 */
	@RequestMapping(value="/getNowUser")
	@ResponseBody
	public Object getList() {
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		String errInfo = "success";
		Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USERROL);
		if(null != user){
			pd.put(Const.SESSION_USERNAME, user.getUSERNAME());
			PageData pdPhoto;
			try {
				pdPhoto = photoService.findById(pd);
				map.put("userPhoto", null == pdPhoto?"assets/images/user/avatar-2.jpg":pdPhoto.getString("PHOTO2"));//用户头像
				map.put("NAME", user.getNAME());
				map.put("USERNAME", user.getUSERNAME());
				map.put("ROLE_NAME", user.getRole().getROLE_NAME());
				
				String infFilePath = PathUtil.getClasspath()+Const.SYSSET;								//配置文件路径
				if(null == session.getAttribute(Const.SHOWCOUNT)){
					session.setAttribute(Const.SHOWCOUNT, IniFileUtil.readCfgValue(infFilePath, "SysSet1", Const.SHOWCOUNT, "10"));//初始系统带分页的列表每页显示条数
				}
				
				String onlineIp = IniFileUtil.readCfgValue(infFilePath, "SysSet1", "onlineIp", "127.0.0.1");		//在线管理IP
				String onlinePort = IniFileUtil.readCfgValue(infFilePath, "SysSet1", "onlinePort", "8869");			//在线管理端口
				map.put("onlineAdress", onlineIp+":"+onlinePort);	//在线管理websocket地址
				
				String imIp = IniFileUtil.readCfgValue(infFilePath, "SysSet1", "imIp", "127.0.0.1");				//即时聊天IP
				String imPort = IniFileUtil.readCfgValue(infFilePath, "SysSet1", "imPort", "8869");					//即时聊天端口
				map.put("wimadress", imIp+":"+imPort);				//即时聊天websocket地址
				
				map.put("fhsmsCount", fhsmsService.findFhsmsCount(Jurisdiction.getUsername()).get("fhsmsCount").toString());//站内信未读总数
				map.put("fhsmsSound", IniFileUtil.readCfgValue(infFilePath, "SysSet1", "fhsmsSound", "1"));			//信息提示音
				
				Object RNUMBERS = session.getAttribute(Const.SESSION_RNUMBERS);
				if(null == RNUMBERS){
					session.setAttribute(Const.SESSION_RNUMBERS, getRnumbers()); //把当前用户的角色编码放入session
				}
				
				errInfo = "success";
			} catch (Exception e) {
				errInfo = "error";
			}
		}else {
			errInfo = "error";
		}
		map.put("result", errInfo);
		return map;
	}
	
	/**通过角色ID数组获取角色列表拼接角色编码
	 * @return
	 * @throws Exception
	 */
	public String getRnumbers() throws Exception{
		PageData userpd = new PageData();
		userpd.put(Const.SESSION_USERNAME, Jurisdiction.getUsername());
		userpd = usersService.findByUsername(userpd);		//通过用户名获取用户信息
		String ZROLE_ID = userpd.get("ROLE_ID").toString()+",fh,"+userpd.getString("ROLE_IDS");
		String arryROLE_ID[] = ZROLE_ID.split(",fh,");
		List<Role> rlist = roleService.getRoleByArryROLE_ID(arryROLE_ID);
		StringBuffer RNUMBERS = new StringBuffer();
		RNUMBERS.append("(");
		for(Role role:rlist){
			RNUMBERS.append("'"+role.getRNUMBER()+"'");
		}
		RNUMBERS.append(")");
		return RNUMBERS.toString();
	}
	
	/**判断当前用户角色编码符合过滤条件(用于新任务消息通知)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/isNowRole")
	@ResponseBody
	public Object isNowRole() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(Jurisdiction.getRnumbers().indexOf(pd.getString("RNUMBER"))!=-1){
			map.put("msg", "yes");
		}else{
			map.put("msg", "no");
		}
		return map;
	}

}





//F-H Q  3-135-9679-0 
