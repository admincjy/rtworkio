package org.fh.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.PageData;
import org.fh.entity.system.Role;
import org.fh.service.system.ButtonrightsService;
import org.fh.service.system.FHlogService;
import org.fh.service.system.FhButtonService;
import org.fh.service.system.RoleService;
import org.fh.util.Jurisdiction;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：按钮权限处理类
 * 作者：FH Admin 
 *  ：
 */
@Controller
@RequestMapping(value="/buttonrights")
public class ButtonrightsController extends BaseController {
	
	@Autowired
	private ButtonrightsService buttonrightsService;
	@Autowired
    private RoleService roleService;
	@Autowired
	private FhButtonService fhButtonService;
	@Autowired
    private FHlogService FHLOG;
	
	/**列表
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("buttonrights:list")
	public String list(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String type = pd.getString("type");
		type = Tools.isEmpty(type)?"0":type;
		if(Tools.isEmpty(pd.getString("ROLE_ID"))){
			pd.put("ROLE_ID", "1");											//默认列出第一组角色(初始设计系统用户组不能删除)
		}
		PageData fpd = new PageData();
		fpd.put("ROLE_ID", "0");
		List<Role> roleList = roleService.listAllRolesByPId(fpd);			//列出组(页面横向排列的一级组)
		List<Role> roleList_z = roleService.listAllRolesByPId(pd);			//列出此组下架角色
		List<PageData> buttonlist = fhButtonService.listAll(pd);			//列出所有按钮
		List<PageData> roleFhbuttonlist = buttonrightsService.listAll(pd);	//列出所有角色按钮关联数据
		pd = roleService.findById(pd);										//取得点击的角色组(横排的)
		model.addAttribute("pd", pd);
		model.addAttribute("roleList", roleList);
		model.addAttribute("roleList_z", roleList_z);
		model.addAttribute("buttonlist", buttonlist);
		model.addAttribute("roleFhbuttonlist", roleFhbuttonlist);
		if("2".equals(type)){
			return "system/buttonrights/buttonrights_list_r";
		}else{
			return "system/buttonrights/buttonrights_list";
		}
	}
	
	/**点击按钮处理关联表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/upRb")
	@ResponseBody
	@RequiresPermissions("buttonrights:edit")
	public Object updateRolebuttonrightd()throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		if(null != buttonrightsService.findById(pd)){	//判断关联表是否有数据 是:删除/否:新增
			buttonrightsService.delete(pd);				//删除
		}else{
			pd.put("RB_ID", this.get32UUID());			//主键
			buttonrightsService.save(pd);				//新增
		}
		FHLOG.save(Jurisdiction.getUsername(), "操作了按钮权限的开关:角色ID："+pd.getString("ROLE_ID")+", 按钮ID："+pd.getString("BUTTON_ID"));				//记录日志
		map.put("result", errInfo);
		return map;
	}
	
}
