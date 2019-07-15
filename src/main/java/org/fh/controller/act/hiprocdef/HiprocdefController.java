package org.fh.controller.act.hiprocdef;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.act.AcBusinessController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.act.HiprocdefService;
import org.fh.service.act.RuprocdefService;
import org.fh.util.Const;
import org.fh.util.ImageAnd64Binary;
import org.fh.util.PathUtil;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：历史流程任务
 * 作者：FH Admin 
 *  ：
 */
@Controller
@RequestMapping("/hiprocdef")
public class HiprocdefController extends AcBusinessController {
	
	@Autowired
	private RuprocdefService ruprocdefService;
	@Autowired
	private HiprocdefService hiprocdefService;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("hiprocdef:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("keywords", KEYWORDS.trim());
		String STRARTTIME = pd.getString("STRARTTIME");					//开始时间
		String ENDTIME = pd.getString("ENDTIME");						//结束时间
		if(Tools.notEmpty(STRARTTIME))pd.put("lastStart", STRARTTIME+" 00:00:00");
		if(Tools.notEmpty(ENDTIME))pd.put("lastEnd", ENDTIME+" 00:00:00");
		page.setPd(pd);
		List<PageData> varList = hiprocdefService.list(page);			//列出Hiprocdef列表
		for(int i=0;i<varList.size();i++){
			Long ztime = Long.parseLong(varList.get(i).get("DURATION_").toString());
			Long tian = ztime / (1000*60*60*24);
			Long shi = (ztime % (1000*60*60*24))/(1000*60*60);
			Long fen = (ztime % (1000*60*60*24))%(1000*60*60)/(1000*60);
			varList.get(i).put("ZTIME", tian+"天"+shi+"时"+fen+"分");
			varList.get(i).put("INITATOR", getInitiator(varList.get(i).getString("PROC_INST_ID_")));//流程申请人
        }
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "act/hiprocdef/hiprocdef_list";
	}
	
	/**查看流程信息页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/view")
	public String view(Model model)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	varList = hiprocdefService.hivarList(pd);			//列出历史流程变量列表
		PageData tonamePd=hiprocdefService.selectToName(pd.getString("PROC_INST_ID_"));
		if(tonamePd!=null) {
			varList.add(tonamePd);
		}
		List<PageData>	hitaskList = ruprocdefService.hiTaskList(pd);		//历史任务节点列表
		for(int i=0;i<hitaskList.size();i++){								//根据耗时的毫秒数计算天时分秒
			if(null != hitaskList.get(i).get("DURATION_")){
				Long ztime = Long.parseLong(hitaskList.get(i).get("DURATION_").toString());
				Long tian = ztime / (1000*60*60*24);
				Long shi = (ztime % (1000*60*60*24))/(1000*60*60);
				Long fen = (ztime % (1000*60*60*24))%(1000*60*60)/(1000*60);
				Long miao = (ztime % (1000*60*60*24))%(1000*60*60)%(1000*60)/1000;
				hitaskList.get(i).put("ZTIME", tian+"天"+shi+"时"+fen+"分"+miao+"秒");
			}
		}
		String FILENAME = URLDecoder.decode(pd.getString("FILENAME"), "UTF-8");
		createXmlAndPngAtNowTask(pd.getString("PROC_INST_ID_"),FILENAME);	//生成当前任务节点的流程图片
		pd.put("FILENAME", FILENAME);
		String imgSrcPath = PathUtil.getProjectpath()+Const.FILEACTIVITI+FILENAME;
		pd.put("imgSrc", "data:image/jpeg;base64,"+ImageAnd64Binary.getImageStr(imgSrcPath)); //解决图片src中文乱码，把图片转成base64格式显示(这样就不用修改tomcat的配置了)
		model.addAttribute("varList", varList);
		model.addAttribute("hitaskList", hitaskList);
		model.addAttribute("pd", pd);
		return "act/hiprocdef/hiprocdef_view";
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("hiprocdef:del")
	public Object delete() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		deleteHiProcessInstance(pd.getString("PROC_INST_ID_"));
		map.put("result", "success");
		return map;
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("hiprocdef:del")
	public Object deleteAll() throws Exception{
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		if(Tools.notEmpty(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for(int i=0;i<ArrayDATA_IDS.length;i++){
				deleteHiProcessInstance(ArrayDATA_IDS[i]);
			}
		}else{
			errInfo = "error";
		}
		map.put("result", errInfo);
		return map;
	}

}
