package org.fh.mobile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.fh.controller.base.BaseController;
import org.fh.entity.PageData;
import org.fh.entity.system.Dictionaries;
import org.fh.service.system.DictionariesService;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：手机端
 * 作者：FH Admin Q313596790
 *  ：www.fhadmin.org
 */
@Controller
@RequestMapping("/mobileindex")
public class MobIndexController extends BaseController {
	
	@Autowired
	private DictionariesService dictionariesService;
	
	/**进入首页
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/index")
	public String index()throws Exception{
		return "mobile/index";
	}
	
	/**去聊天首页
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goIm")
	public String goIm()throws Exception{
		return "mobile/im/index";
	}
	
	/**进入站内信页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/fhsms")
	public String fhsms()throws Exception{
		return "mobile/fhsms/fs_list";
	}
	
	/**进入我的通讯页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/myim")
	public String myim()throws Exception{
		return "mobile/im/im_list";
	}
	
	/**进入个人中心
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/usercenter")
	public String userCenter()throws Exception{
		return "mobile/user/user_center";
	}

	/**进入任务管理
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/tasklist")
	public String taskList()throws Exception{
		return "mobile/task/task_list";
	}
	
	/**进入审批管理
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/oalist")
	public String oaList()throws Exception{
		return "mobile/oa/oa_list";
	}

	/**获取数据字典中的数据
	 * @return
	 */
	@RequestMapping(value="/getLevels")
	@ResponseBody
	public Object getLevels(){
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String DICTIONARIES_ID = pd.getString("DICTIONARIES_ID");
			DICTIONARIES_ID = Tools.isEmpty(DICTIONARIES_ID)?"0":DICTIONARIES_ID;
			List<Dictionaries>	varList = dictionariesService.listSubDictByParentId(DICTIONARIES_ID); //用传过来的ID获取此ID下的子列表数据
			List<PageData> pdList = new ArrayList<PageData>();
			for(Dictionaries d :varList){
				PageData pdf = new PageData();
				pdf.put("DICTIONARIES_ID", d.getDICTIONARIES_ID());
				pdf.put("BIANMA", d.getBIANMA());
				pdf.put("NAME", d.getNAME());
				pdList.add(pdf);
			}
			map.put("list", pdList);	
		} catch(Exception e){
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}

}
