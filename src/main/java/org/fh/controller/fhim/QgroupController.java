package org.fh.controller.fhim;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.fhim.IQgroupService;
import org.fh.service.fhim.QgroupService;
import org.fh.service.fhim.SysmsgService;
import org.fh.util.Const;
import org.fh.util.DateUtil;
import org.fh.util.DelFileUtil;
import org.fh.util.FileUpload;
import org.fh.util.Jurisdiction;
import org.fh.util.PathUtil;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * 说明：群组
 * 作者：FH 
 *  ：
 */
@Controller
@RequestMapping("/qgroup")
public class QgroupController extends BaseController {
	
	@Autowired
	private QgroupService qgroupService;
	@Autowired
	private IQgroupService iQgroupService;
	@Autowired
	private SysmsgService sysmsgService;

	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("qgroup:add")
	public String save(
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="NAME",required=false) String NAME,
			@RequestParam(value="QID",required=false) String QGROUP_ID,
			Model model
			) throws Exception{
		PageData pd = new PageData();
		String  ffile = DateUtil.getDays(), fileName = "";
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getProjectpath() + Const.FILEPATHIMG + ffile;	//文件上传路径
			fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
			pd.put("PHOTO", Const.FILEPATHIMG + ffile + "/" + fileName);				//群名
			pd.put("NAME", NAME);							//群名
			pd.put("CTIME", DateUtil.date2Str(new Date()));	//创建时间
			pd.put("USERNAME", Jurisdiction.getUsername());	//群主
			pd.put("QGROUP_ID", QGROUP_ID);					//主键
			qgroupService.save(pd);							//存入群组数据库表
			PageData ipd = new PageData();
			ipd = iQgroupService.findById(pd);
			if(null == ipd){								//当我没有任何群时添加数据，否则修改
				pd.put("QGROUPS", "('"+pd.getString("QGROUP_ID")+"',");
				pd.put("IQGROUP_ID", this.get32UUID());		//主键
				iQgroupService.save(pd);
			}else{
				pd.put("QGROUPS", ipd.getString("QGROUPS")+"'"+pd.getString("QGROUP_ID")+"',");
				iQgroupService.edit(pd);
			}
		}else{
			model.addAttribute("msg","error");
		}
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**退群或者解散群
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("qgroup:del")
	public Object delete() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERNAME", Jurisdiction.getUsername());								 	//当前用户
		String TYPE = pd.getString("TYPE");
		if("del".equals(TYPE)){														 	//解散群（删除群的操作在ChatServer中处理）
			if(Tools.notEmpty(pd.getString("PATH").trim())){
				DelFileUtil.delFolder(PathUtil.getProjectpath()+ pd.getString("PATH")); //删除群头像
			}
		}else{												//退出群
			PageData qggpd = new PageData();
			qggpd = qgroupService.findById(pd);
			
			PageData msgpd = new PageData();
			/*存入IM系统消息表中IM_SYSMSG*/
			msgpd.put("SYSMSG_ID", this.get32UUID());						//主键
			msgpd.put("USERNAME", qggpd.getString("USERNAME"));				//接收者用户名(即群主)
			msgpd.put("FROMUSERNAME", "系统");								//发送者
			msgpd.put("CTIME", DateUtil.date2Str(new Date()));				//操作时间
			msgpd.put("REMARK", "");										//留言
			msgpd.put("TYPE", "group");										//类型
			msgpd.put("CONTENT", Jurisdiction.getName()+" 从群："+qggpd.getString("NAME")+" 退出了");	//事件内容
			msgpd.put("ISDONE", "yes");										//是否完成
			msgpd.put("DTIME", DateUtil.date2Str(new Date()));				//完成时间
			msgpd.put("QGROUP_ID", pd.getString("QGROUP_ID"));				//群ID
			msgpd.put("DREAD", "0");										//阅读状态 0 未读
			sysmsgService.save(msgpd);
			
			PageData ipd = new PageData();
			ipd = iQgroupService.findById(pd);
			pd.put("QGROUPS", ipd.getString("QGROUPS").replaceAll("'"+pd.getString("QGROUP_ID")+"',", ""));
			iQgroupService.edit(pd);
		}
		map.put("result", "success");				//返回结果
		return map;
	}
	
	/**踢出群
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/kickout")
	@ResponseBody
	public Object kickout() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData qggpd = new PageData();
		qggpd = qgroupService.findById(pd);
		if(!Jurisdiction.getUsername().equals(qggpd.getString("USERNAME"))){return null;}//如果当前用户不是群主，禁止后续操作
		PageData msgpd = new PageData();
		/*存入IM系统消息表中IM_SYSMSG*/
		msgpd.put("SYSMSG_ID", this.get32UUID());						//主键
		msgpd.put("USERNAME", pd.getString("USERNAME"));				//被踢出的成员用户名
		msgpd.put("FROMUSERNAME", "系统");								//发送者
		msgpd.put("CTIME", DateUtil.date2Str(new Date()));				//操作时间
		msgpd.put("REMARK", "");										//留言
		msgpd.put("TYPE", "group");										//类型
		msgpd.put("CONTENT", Jurisdiction.getName()+" 从群："+qggpd.getString("NAME")+" 踢出了您");	//事件内容
		msgpd.put("ISDONE", "yes");										//是否完成
		msgpd.put("DTIME", DateUtil.date2Str(new Date()));				//完成时间
		msgpd.put("QGROUP_ID", pd.getString("QGROUP_ID"));				//群ID
		msgpd.put("DREAD", "0");										//阅读状态 0 未读
		sysmsgService.save(msgpd);
		PageData ipd = new PageData();
		ipd = iQgroupService.findById(pd);
		pd.put("QGROUPS", ipd.getString("QGROUPS").replaceAll("'"+pd.getString("QGROUP_ID")+"',", ""));
		iQgroupService.edit(pd);
		map.put("result", "success");				//返回结果
		return map;
	}
	
	/**删除图片
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deltp")
	@ResponseBody
	public Object deltp() throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String PATH = pd.getString("PATH");	
		if(Tools.notEmpty(pd.getString("PATH").trim())){								//图片路径
			DelFileUtil.delFolder(PathUtil.getProjectpath() + pd.getString("PATH")); 	//删除硬盘中的图片
		}
		if(PATH != null){
			qgroupService.delTp(pd);													//删除数据库中图片数据
		}	
		map.put("result", "success");				//返回结果
		return map;
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	@RequiresPermissions("qgroup:edit")
	public String edit(
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="tpz",required=false) String tpz,
			@RequestParam(value="QGROUP_ID",required=false) String QGROUP_ID,
			@RequestParam(value="NAME",required=false) String NAME,
			Model model
		)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("NAME", NAME);							//群名
		pd.put("QGROUP_ID", QGROUP_ID);					//主键
		if (null != file && !file.isEmpty()) {
			String  ffile = DateUtil.getDays(), fileName = "";
			String filePath = PathUtil.getProjectpath() + Const.FILEPATHIMG + ffile;	//文件上传路径
			fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
			pd.put("PHOTO", Const.FILEPATHIMG + ffile + "/" + fileName);				//路径
		}else{
			pd.put("PHOTO", tpz);
		}
		qgroupService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("qgroup:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");					//关键词检索条件
		if(Tools.notEmpty(keywords))pd.put("keywords", keywords.trim());
		pd.put("USERNAME", Jurisdiction.getUsername());				//当前用户
		PageData ipd = new PageData();
		ipd = iQgroupService.findById(pd);
		if(null == ipd){									
			pd.put("item", "('null')");
		}else{
			pd.put("item", ipd.getString("QGROUPS")+"'fh')");
		}
		page.setPd(pd);
		List<PageData>	varList = qgroupService.datalistPage(page);	//列出Qgroup列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		model.addAttribute("QID", this.get32UUID());
		return "fhim/qgroup/qgroup_list";
	}
	
	/**去添加群页面(好友面板中检索页)
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public String goAdd()throws Exception{
		return "fhim/qgroup/qgroup_add";
	}
	
	/**去新增页面(我的群组列表页面)
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddFromlist")
	public String goAddFromlist(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "fhim/qgroup/qgroup_edit";
	}	
	
	/**群检索
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/search")
	public String search(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(Tools.notEmpty(keywords)) pd.put("keywords", keywords.trim());
		List<PageData>	varList = qgroupService.searchListAll(pd);
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhim/qgroup/qgroup_add";
	}
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = qgroupService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhim/qgroup/qgroup_edit";
	}
	
	/**获取此群的信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getThisQgroup")
	@ResponseBody
	public Object getThisQgroup() throws Exception{
		Map<String,Object> map = new LinkedHashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = qgroupService.findById(pd);
		map.put("avatar", pd.getString("PHOTO"));	//群头像
		map.put("groupname", pd.getString("NAME"));	//群名称
		return map;
	}
	
	/**群成员
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/groupMembers")
	public String groupMembers(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");							//关键词检索条件
		if(Tools.notEmpty(keywords))pd.put("keywords", keywords.trim());
		pd.put("USERNAME", Jurisdiction.getUsername());						//排除本人(即群主)
		page.setPd(pd);
		List<PageData>	varList = iQgroupService.memberslistPage(page);		//列出群成员列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhim/qgroup/qgroup_members";
	}
	
	
}
