package org.fh.controller.fhoa;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.act.AcStartController;
import org.fh.controller.act.rutask.RuTaskController;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.util.DateUtil;
import org.fh.util.Jurisdiction;
import org.fh.util.ObjectExcelView;
import org.fh.util.Tools;
import org.fh.entity.PageData;
import org.fh.service.act.RuprocdefService;
import org.fh.service.fhoa.StudyService;
import org.fh.service.system.UsersService;

/** 
 * 说明：学习心得流程
 * 作者：FH 
 * 时间：2019-04-30
 *  ：
 */
@Controller
@RequestMapping("/study")
public class StudyController extends AcStartController {
	
	@Autowired
	private RuprocdefService ruprocdefService;
	
	@Autowired
	private StudyService studyService;
	
	@Autowired
	private UsersService usersService;
	
	@Autowired
	private RuTaskController ruTaskController;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@RequiresPermissions("study:add")
	public String save(Model model) throws Exception{
		Date date = new Date();
		PageData pd = new PageData();
		pd = this.getPageData();
        String ASSIGNEE = pd.getString("ASSIGNEE_2");
        String ASSIGNEE_3="";
        if(Tools.notEmpty(pd.getString("ASSIGNEE_3"))) {
              ASSIGNEE_3=pd.getString("ASSIGNEE_3");
		}
        String pdName=usersService.selectNames(ASSIGNEE);
		pd.put("TONAME", pdName);	
		pd.put("STUDY_ID", this.get32UUID());	//主键
		pd.put("NAME", Jurisdiction.getName());
		pd.put("STARTTIME", date);	
		pd.put("CCNAME",ASSIGNEE_3);
		studyService.save(pd);
		
		pd = studyService.findById(pd);	//根据ID读取
		PageData pdu = new PageData();
		pdu.put("USER_ID", pd.getString("TONAME"));
		PageData dataUser=usersService.findById(pdu);
		
        //设置要获取到什么样的时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //获取String类型的时间
        String createdate = sdf.format(date);
		try {
			/** 工作流的操作 **/
			Map<String,Object> map = new LinkedHashMap<String, Object>();
			map.put("汇报人员", Jurisdiction.getName());			//当前用户的姓名
//			map.put("接收人员", dataUser.get("NAME"));
//			map.put("学习心得", pd.getString("CONTENT"));
			map.put("开始时间", createdate);
			if(ASSIGNEE_3!="") {
				map.put("抄送人",ASSIGNEE_3);
			}
			map.put("USERNAME", Jurisdiction.getUsername());			//指派代理人为当前用户
			String procInstId=startProcessInstanceByKeyHasVariables("key_study",map);	//启动流程实例(协同单流程)通过KEY
			pd.put("PROC_INST_ID_", procInstId);
			studyService.edit(pd);									//记录存入数据库
			ruTaskController.submit(procInstId, ASSIGNEE);
			model.addAttribute("ASSIGNEE_",ASSIGNEE);	//用于给待办人发送新任务消息
			model.addAttribute("msg","success");
//			model.addAttribute("msg", "edit");
			model.addAttribute("pd", pd);
		} catch (Exception e) {
			model.addAttribute("errer","errer");
			model.addAttribute("msgContent","请联系管理员部署相应业务流程!");
		}
		return "transferPage";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("study:del")
	public Object delete(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try{
			studyService.delete(pd);
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
	@RequiresPermissions("study:edit")
	public String edit(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		studyService.edit(pd);
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("study:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!Jurisdiction.getName().equals("系统管理员")) {
			pd.put("NAME", Jurisdiction.getName());
		}
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData>	varList = studyService.list(page);	//列出Study列表
		for(PageData pData:varList) {
			if (Tools.notEmpty(pData.getString("CCNAME"))) {
				if(pData.getString("CCNAME").indexOf(Jurisdiction.getName()+"Y")>-1) {
					pData.put("ISCC", "0");
				}
			}
		}
		for(int i=0;i<varList.size();i++) {
			PageData pdx = new PageData();
			pdx.put("PROC_INST_ID_", varList.get(i).get("PROC_INST_ID_"));
			PageData pdPageData=ruprocdefService.selectInformation(pdx);
			if (pdPageData.get("ENDTIME")!=null) {
				varList.get(i).put("isEnd", "yes");
			}else {
				varList.get(i).put("isEnd", "no");
			}
		}
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhoa/study/study_list";
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	@RequiresPermissions("study:add")
	public String goAdd(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("msg", "save");
		model.addAttribute("pd", pd);
		return "fhoa/study/study_edit";
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	@RequiresPermissions("study:edit")
	public String goEdit(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = studyService.findById(pd);	//根据ID读取
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "fhoa/study/study_edit";
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("study:del")
	public Object deleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		try{
			if(Tools.notEmpty(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				studyService.deleteAll(ArrayDATA_IDS);
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
		titles.add("汇报时间");	//1
		titles.add("汇报人");	//2
		titles.add("接收人");	//3
		titles.add("抄送人");	//4
		titles.add("内容");	//5
		titles.add("接收人评分");	//6
		titles.add("结束时间");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = studyService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("STARTTIME"));	    //1
			vpd.put("var2", varOList.get(i).getString("NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("TONAME"));	    //3
			vpd.put("var4", varOList.get(i).getString("COPE_NAME"));	    //4
			vpd.put("var5", varOList.get(i).getString("CONTENT"));	    //5
			vpd.put("var6", varOList.get(i).getString("SCORE"));	    //6
			vpd.put("var7", varOList.get(i).getString("ENDTIME"));	    //7
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@RequestMapping(value="/contentDetails")
	public String selectByPIId(Model model)throws Exception{
        PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("key", "study");
		List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
		model.addAttribute("pd", pd);
		model.addAttribute("contents", pageDatas.get(0).getString("CONTENT"));
		model.addAttribute("SCORE", pageDatas.get(0).getString("SCORE"));
        return "act/rutask/handle_content_details";
	}
	
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/report")
	@RequiresPermissions("study:report")
	public String report(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if (Tools.isEmpty(pd.getString("STARTCOMMITTIME"))) {
			String STARTCOMMITTIME=DateUtil.getBeforeDayDate("6");
			String ENDTCOMMITIME=DateUtil.getDay();
			pd.put("STARTCOMMITTIME", STARTCOMMITTIME);
			pd.put("ENDTCOMMITIME", ENDTCOMMITIME);
		}
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData> varList = studyService.listReportPage(page);	//列出Workplan列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhoa/study/study_report";
	}
}
