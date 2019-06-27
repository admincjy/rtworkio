	package org.fh.controller.act.rutask;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.event.impl.ActivitiActivityEventImpl;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.fh.controller.act.AcBusinessController;
import org.fh.controller.fhoa.StudyController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.act.HiprocdefService;
import org.fh.service.act.RuprocdefService;
import org.fh.service.fhoa.ConclusionService;
import org.fh.service.fhoa.StudyService;
import org.fh.service.fhoa.StudyplanMxService;
import org.fh.service.fhoa.WorkplanMxService;
import org.fh.service.system.FhsmsService;
import org.fh.util.Const;
import org.fh.util.DateUtil;
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
 * 说明：待办任务
 * 作者：FH Admin 
 * 官网：
 */
@Controller
@RequestMapping(value="/rutask")
public class RuTaskController extends AcBusinessController {
	
	@Autowired
	private RuprocdefService ruprocdefService;
	
	@Autowired
	private FhsmsService fhsmsService;
	
	@Autowired
	private HiprocdefService hiprocdefService;
	@Autowired
	private StudyService studyService;
	@Autowired
	private ConclusionService conclusionService;
	@Autowired
	private StudyplanMxService studyplanMxService;
	@Autowired
	private WorkplanMxService workplanMxService;;
	@Autowired
	private HistoryService historyService;
	
	/**待办任务列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("rutask:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("keywords", KEYWORDS.trim());
		String STRARTTIME = pd.getString("STRARTTIME");					//开始时间
		String ENDTIME = pd.getString("ENDTIME");						//结束时间
		if(Tools.notEmpty(STRARTTIME))pd.put("lastStart", STRARTTIME+" 00:00:00");
		if(Tools.notEmpty(ENDTIME))pd.put("lastEnd", ENDTIME+" 00:00:00");
		pd.put("USERNAME", Jurisdiction.getUsername()); 		//查询当前用户的任务(用户名查询)
		pd.put("RNUMBERS", Jurisdiction.getRnumbers()); 		//查询当前用户的任务(角色编码查询)
		page.setPd(pd);
		List<PageData>	varList = ruprocdefService.list(page);	//列出Rutask列表
		for(int i=0;i<varList.size();i++){
			varList.get(i).put("INITATOR", getInitiator(varList.get(i).getString("PROC_INST_ID_")));//流程申请人
		}
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "act/rutask/rutask_list";
	}
	
	/**待办任务列表(只显示5条,用于后台顶部小铃铛左边显示)
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getList")
	@ResponseBody
	public Object getList(Page page) throws Exception{
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		pd.put("USERNAME", Jurisdiction.getUsername()); 		//查询当前用户的任务(用户名查询)
		pd.put("RNUMBERS", Jurisdiction.getRnumbers()); 		//查询当前用户的任务(角色编码查询)
		page.setPd(pd);
		page.setShowCount(5);
		List<PageData>	varList = ruprocdefService.list(page);	//列出Rutask列表
		List<PageData> pdList = new ArrayList<PageData>();
		for(int i=0;i<varList.size();i++){
			PageData tpd = new PageData();
			tpd.put("NAME_", varList.get(i).getString("NAME_"));	//任务名称
			tpd.put("PNAME_", varList.get(i).getString("PNAME_"));	//流程名称
			pdList.add(tpd);
		}
		map.put("list", pdList);
		map.put("taskCount", page.getTotalResult());
		return map;
	}
	
	/**去办理任务页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goHandle")
	public String goHandle(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	varList = ruprocdefService.varList(pd);			//列出流程变量列表
		PageData tonamePd=hiprocdefService.selectToName(pd.getString("PROC_INST_ID_"));
		if(tonamePd!=null) {
			varList.add(tonamePd);
		}
		List<PageData>	hitaskList = ruprocdefService.hiTaskList(pd);	//历史任务节点列表
		for(int i=0;i<hitaskList.size();i++){							//根据耗时的毫秒数计算天时分秒
			if(null != hitaskList.get(i).get("DURATION_")){
				Long ztime = Long.parseLong(hitaskList.get(i).get("DURATION_").toString());
				Long tian = ztime / (1000*60*60*24);
				Long shi = (ztime % (1000*60*60*24))/(1000*60*60);
				Long fen = (ztime % (1000*60*60*24))%(1000*60*60)/(1000*60);
				Long miao = (ztime % (1000*60*60*24))%(1000*60*60)%(1000*60)/1000;
				hitaskList.get(i).put("ZTIME", tian+"天"+shi+"时"+fen+"分"+miao+"秒");
			}
		}String FILENAME = URLDecoder.decode(pd.getString("FILENAME"), "UTF-8");
		createXmlAndPngAtNowTask(pd.getString("PROC_INST_ID_"),FILENAME);//生成当前任务节点的流程图片
		pd.put("FILENAME", FILENAME);
		String imgSrcPath = PathUtil.getProjectpath()+Const.FILEACTIVITI+FILENAME;
		pd.put("imgSrc", "data:image/jpeg;base64,"+ImageAnd64Binary.getImageStr(imgSrcPath)); //解决图片src中文乱码，把图片转成base64格式显示(这样就不用修改tomcat的配置了)
		model.addAttribute("varList", varList);
		model.addAttribute("hitaskList", hitaskList);
		model.addAttribute("pd", pd);

//		if(hitaskList.get(hitaskList.size()).get("TASK_DEF_KEY_").equals("QJ1")) {
//			model.addAttribute("takeUser", "QJ1");
//		}
        String key=hitaskList.get(hitaskList.size()-1).get("PROC_DEF_ID_").toString();
        String qj=hitaskList.get(hitaskList.size()-1).get("ACT_ID_").toString();
		if(key.indexOf("key_synergy")!=-1) {
			if(qj.equals("QJ3")||qj.equals("QJ5")) {
				model.addAttribute("isgateway", "yes");
			  }
            if(qj.equals("QJ5")) {
					model.addAttribute("isToName", "yes");
			  }
		}else if (key.indexOf("key_distributed")!=-1) {
			if(qj.equals("QJ3")) {
					model.addAttribute("isgateway", "yes");
					model.addAttribute("isToName", "yes");
			  }
		}else if (key.indexOf("key_study")!=-1&&key.indexOf("key_study_plan")==-1) {
              if(qj.equals("QJ2")) {
					model.addAttribute("isToName", "yes");
			  }
	    }else if (key.indexOf("key_work_conclusion")!=-1) {
            if(qj.equals("QJ2")) {
					model.addAttribute("isToName", "yes");
			  }
		}else if (key.indexOf("key_study_plan")!=-1) {
            if(qj.equals("QJ2")) {
					model.addAttribute("isToName", "yes");
			  }
		}else if (key.indexOf("key_work_plan")!=-1) {
            if(qj.equals("QJ2")) {
					model.addAttribute("isToName", "yes");
			  }
		}
		return "act/rutask/rutask_handle";
	}
	
	/**办理任务
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/handle")
	@RequiresPermissions("rutask:edit")
	public String handle(Model model) throws Exception{
		Session session = Jurisdiction.getSession();
		PageData pd = new PageData();
		pd = this.getPageData();
		String taskId = pd.getString("ID_");	//任务ID
		String sfrom = "";
		Object ofrom = getVariablesByTaskIdAsMap(taskId,"审批结果");
		if(null != ofrom){
			sfrom = ofrom.toString();
		}
		Map<String,Object> map = new LinkedHashMap<String, Object>();
		String OPINION = sfrom + Jurisdiction.getName() + ",fh,"+pd.getString("OPINION");//审批人的姓名+审批意见
		String msg = pd.getString("msg");
		if("yes".equals(msg)){								//批准
			map.put("审批结果", "【批准】" + OPINION);		//审批结果
			setVariablesByTaskIdAsMap(taskId,map);			//设置流程变量
			setVariablesByTaskId(taskId,"RESULT","批准");
			completeMyPersonalTask(taskId);
		}else{												//驳回
			map.put("审批结果", "【驳回】" + OPINION);		//审批结果
			setVariablesByTaskIdAsMap(taskId,map);			//设置流程变量
			setVariablesByTaskId(taskId,"RESULT","驳回");
			completeMyPersonalTask(taskId);
		}
		try{
			removeVariablesByPROC_INST_ID_(pd.getString("PROC_INST_ID_"),"RESULT");			//移除流程变量(从正在运行中)
		}catch(Exception e){
			/*此流程变量在历史中**/
		}
		try{
			String ASSIGNEE_ = pd.getString("ASSIGNEE_");							//下一待办对象
			if(Tools.notEmpty(ASSIGNEE_)){
				setAssignee(session.getAttribute("TASKID").toString(),ASSIGNEE_);	//指定下一任务待办对象
			}else{
				Object os = session.getAttribute("YAssignee");
				if(null != os && !"".equals(os.toString())){
					ASSIGNEE_ = os.toString();										//没有指定就是默认流程的待办人
				}else{
					trySendSms(model,pd); //没有任务监听时，默认流程结束，发送站内信给任务发起人
				}
			}
			model.addAttribute("ASSIGNEE_",ASSIGNEE_);	//用于给待办人发送新任务消息
		}catch(Exception e){
			/*手动指定下一待办人，才会触发此异常。
			 * 任务结束不需要指定下一步办理人了,发送站内信通知任务发起人**/
			trySendSms(model,pd);
		}
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	/**发送站内信
	 * @param mv
	 * @param pd
	 * @throws Exception
	 */
	public void trySendSms(Model model,PageData pd)throws Exception{
		List<PageData>	hivarList = hiprocdefService.hivarList(pd);			//列出历史流程变量列表
		for(int i=0;i<hivarList.size();i++){
			if("USERNAME".equals(hivarList.get(i).getString("NAME_"))){
				sendSms(hivarList.get(i).getString("TEXT_"));
				model.addAttribute("FHSMS",hivarList.get(i).getString("TEXT_"));
				break;
			}
		}
	}
	
	/**发站内信通知审批结束
	 * @param USERNAME
	 * @throws Exception
	 */
	public void sendSms(String USERNAME) throws Exception{
		PageData pd = new PageData();
		pd.put("SANME_ID", this.get32UUID());			//ID
		pd.put("SEND_TIME", DateUtil.getTime());		//发送时间
		pd.put("FHSMS_ID", this.get32UUID());			//主键
		pd.put("TYPE", "1");							//类型1：收信
		pd.put("FROM_USERNAME", USERNAME);				//收信人
		pd.put("TO_USERNAME", "系统消息");
		pd.put("CONTENT", "您申请的任务已经审批完毕,请到已办任务列表查看");
		pd.put("STATUS", "2");
		fhsmsService.save(pd);
	}
	
	/**去审批详情页面
	 * @param 
	 * @return
	 */
	@RequestMapping(value="/details")
	public String details(Model model){
		PageData pd = new PageData();
		pd = this.getPageData();
		model.addAttribute("pd", pd);
		return "act/rutask/handle_details";
	}
	
	@RequestMapping(value="/contentDetails")
	public String selectByPIId(Model model)throws Exception{
        PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	hitaskList = ruprocdefService.hiTaskList(pd);
		String key=hitaskList.get(hitaskList.size()-1).get("PROC_DEF_ID_").toString();
        String qj=hitaskList.get(hitaskList.size()-1).get("ACT_ID_").toString();
        if(key.indexOf("key_synergy")!=-1) {
			pd.put("key", "synergy");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			model.addAttribute("contents", pageDatas);
		}else if(key.indexOf("key_distributed")!=-1){
			pd.put("key", "distributed");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			model.addAttribute("contents", pageDatas);
		}else if(key.indexOf("key_study")!=-1&&key.indexOf("key_study_plan")==-1){
			pd.put("key", "study");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			if(qj.equals("QJ2")) {
				model.addAttribute("isScore", "yes");
		    }
			if(pd.getString("isRun").equals("1")) {
				model.addAttribute("isShowScore", "yes");
				model.addAttribute("isScore", "no");
		    }
			if(pd.getString("isRun").equals("3")) {
				model.addAttribute("isShowScore", "other");
				model.addAttribute("isScore", "other");
		    }
			model.addAttribute("contents", pageDatas.get(0).getString("CONTENT"));
			model.addAttribute("SCORE", pageDatas.get(0).getString("SCORE"));
		}else if(key.indexOf("key_study_plan")!=-1){
			pd.put("key", "studyplan");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			if(qj.equals("QJ2")) {
				model.addAttribute("isScore", "yes");
		    }
			if(pd.getString("isRun").equals("1")) {
				model.addAttribute("isShowScore", "yes");
				model.addAttribute("isScore", "no");
		    }
			model.addAttribute("contents", pageDatas);
		}else if(key.indexOf("key_work_conclusion")!=-1){
			pd.put("key", "conclusion");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			if(qj.equals("QJ2")) {
				model.addAttribute("isScore", "yes");
		    }
			if(pd.getString("isRun").equals("1")) {
				model.addAttribute("isShowScore", "yes");
				model.addAttribute("isScore", "no");
		    }
			model.addAttribute("contents", pageDatas.get(0).getString("CONTENT"));
			model.addAttribute("SCORE", pageDatas.get(0).getString("SCORE"));
			model.addAttribute("TYPE", pageDatas.get(0).getString("TYPE"));
		}else if(key.indexOf("key_work_plan")!=-1){
			pd.put("key", "workplan");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			if(qj.equals("QJ2")) {
				model.addAttribute("isScore", "yes");
		    }
			if(pd.getString("isRun").equals("1")) {
				model.addAttribute("isShowScore", "yes");
				model.addAttribute("isScore", "no");
		    }
			model.addAttribute("contents", pageDatas);
		}
        return "act/rutask/handle_content_details";
	}
	
	
	@RequestMapping(value="/contentViewDetails")
	public String selectByPIIdView(Model model)throws Exception{
        PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	hitaskList = ruprocdefService.hiTaskList(pd);
		String key=hitaskList.get(hitaskList.size()-1).get("PROC_DEF_ID_").toString();
        String qj=hitaskList.get(hitaskList.size()-1).get("ACT_ID_").toString();
        if(key.indexOf("key_synergy")!=-1) {
			pd.put("key", "synergy");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			model.addAttribute("contents", pageDatas);
		}else if(key.indexOf("key_distributed")!=-1){
			pd.put("key", "distributed");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			model.addAttribute("contents", pageDatas);
		}else if(key.indexOf("key_study")!=-1&&key.indexOf("key_study_plan")==-1){
			pd.put("key", "study");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			if(qj.equals("QJ2")) {
				model.addAttribute("isScore", "yes");
		    }
			if(pd.getString("isRun").equals("1")) {
				model.addAttribute("isShowScore", "yes");
				model.addAttribute("isScore", "no");
		    }
			if(pd.getString("isRun").equals("3")) {
				model.addAttribute("isShowScore", "other");
				model.addAttribute("isScore", "other");
		    }
			model.addAttribute("contents", pageDatas.get(0).getString("CONTENT"));
			model.addAttribute("SCORE", pageDatas.get(0).getString("SCORE"));
		}else if(key.indexOf("key_study_plan")!=-1){
			pd.put("key", "studyplan");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			if(qj.equals("QJ2")) {
				model.addAttribute("isScore", "yes");
		    }
			if(pd.getString("isRun").equals("1")) {
				model.addAttribute("isShowScore", "yes");
				model.addAttribute("isScore", "no");
		    }
			model.addAttribute("contents", pageDatas);
		}else if(key.indexOf("key_work_conclusion")!=-1){
			pd.put("key", "conclusion");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			if(qj.equals("QJ2")) {
				model.addAttribute("isScore", "yes");
		    }
			if(pd.getString("isRun").equals("1")) {
				model.addAttribute("isShowScore", "yes");
				model.addAttribute("isScore", "no");
		    }
			model.addAttribute("contents", pageDatas.get(0).getString("CONTENT"));
			model.addAttribute("SCORE", pageDatas.get(0).getString("SCORE"));
			model.addAttribute("TYPE", pageDatas.get(0).getString("TYPE"));
		}else if(key.indexOf("key_work_plan")!=-1){
			pd.put("key", "workplan");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			model.addAttribute("pd", pd);
			if(qj.equals("QJ2")) {
				model.addAttribute("isScore", "yes");
		    }
			if(pd.getString("isRun").equals("1")) {
				model.addAttribute("isShowScore", "yes");
				model.addAttribute("isScore", "no");
		    }
			model.addAttribute("contents", pageDatas);
		}
        return "act/rutask/handle_content_view_details";
	}
	
	
	@RequestMapping(value="/putScore")
	@ResponseBody
	public String putScore(Model model)throws Exception{
		Map<String, String> map=new HashMap<>();
        PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	hitaskList = ruprocdefService.hiTaskList(pd);
		String key=hitaskList.get(hitaskList.size()-1).get("PROC_DEF_ID_").toString();
        if(key.indexOf("key_synergy")!=-1) {
			map.put("result","success");
		}else if(key.indexOf("key_distributed")!=-1){
			map.put("result","success");
		}else if(key.indexOf("key_study")!=-1&&key.indexOf("key_study_plan")==-1){
			studyService.editbyPIID(pd);
			map.put("result","success");
		}else if(key.indexOf("key_study_plan")!=-1){
			String[] strArray = null;   
	        strArray = pd.getString("scores").split(",");
			pd.put("key", "studyplan");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			for(int i=0;i<pageDatas.size();i++) {
				pageDatas.get(i).put("SCORE", strArray[i]);
			}
            studyplanMxService.batchUpdate(pageDatas);
			map.put("result","success");
		}else if(key.indexOf("key_work_conclusion")!=-1){
			conclusionService.editbyPIID(pd);
			map.put("result","success");
		}else if(key.indexOf("key_work_plan")!=-1){
			String[] strArray = null;   
	        strArray = pd.getString("scores").split(",");
			pd.put("key", "workplan");
			List<PageData> pageDatas=ruprocdefService.selectByPIId(pd);
			for(int i=0;i<pageDatas.size();i++) {
				pageDatas.get(i).put("SCORE", strArray[i]);
			}
			workplanMxService.batchUpdate(pageDatas);
			map.put("result","success");
		}
        return "transferPage";
	}
	
	
	/**提交人提交任务
	 * @param
	 * @throws Exception
	 */
	public void submit(String PROC_INST_ID_ ,String ASSIGNEE_) throws Exception{
		PageData pdx=new PageData();
		pdx.put("PROC_INST_ID_", PROC_INST_ID_);
		pdx.put("USERNAME", Jurisdiction.getUsername()); 		//查询当前用户的任务(用户名查询)
		pdx.put("RNUMBERS", Jurisdiction.getRnumbers()); 		//查询当前用户的任务(角色编码查询)
		PageData pdTask=ruprocdefService.selectTaskID(pdx);
		Session session = Jurisdiction.getSession();
		String taskId = pdTask.getString("ID_");
		String sfrom = "";
		Object ofrom = getVariablesByTaskIdAsMap(taskId,"审批结果");
		if(null != ofrom){
			sfrom = ofrom.toString();
		}
		Map<String,Object> map = new LinkedHashMap<String, Object>();
		String OPINION = sfrom + Jurisdiction.getName() + ",fh,"+"";//审批人的姓名+审批意见
		map.put("审批结果", "【批准】" + OPINION);		//审批结果
		setVariablesByTaskIdAsMap(taskId,map);			//设置流程变量
		setVariablesByTaskId(taskId,"RESULT","批准");
		completeMyPersonalTask(taskId);
		try{
			removeVariablesByPROC_INST_ID_(PROC_INST_ID_,"RESULT");			//移除流程变量(从正在运行中)
		}catch(Exception e){
			/*此流程变量在历史中**/
		}
		try{
            //下一待办对象
			if(Tools.notEmpty(ASSIGNEE_)){
				setAssignee(session.getAttribute("TASKID").toString(),ASSIGNEE_);	//指定下一任务待办对象
			}
		}catch(Exception e){
			/*手动指定下一待办人，才会触发此异常。
			 * 任务结束不需要指定下一步办理人了,发送站内信通知任务发起人**/
		}
	}

}
