package org.fh.controller.fhim;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.fhim.HismsgService;
import org.fh.util.Jurisdiction;
import org.fh.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：聊天记录
 * 作者：FH 
 *  ：
 */
@Controller
@RequestMapping("/hismsg")
public class HismsgController extends BaseController {
	
	@Autowired
	private HismsgService hismsgService;
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete(){
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "success";
		try {
			hismsgService.delete(pd);
		} catch (Exception e) {
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}
	
	/**打开聊天记录窗口
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/himsglist")
	public String himsgList(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("TOID", pd.getString("id"));								//目标(好友或者群)
		pd.put("TYPE", pd.getString("type"));							//类型
		pd.put("USERNAME", Jurisdiction.getUsername());					//当前用户(发送者)
		page.setPd(pd);
		List<PageData>	varList = hismsgService.datalistPage(page);		//列出Hismsg列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhim/hismsg/hismsg_list";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("TOID", pd.getString("id"));								//目标(好友或者群)
		pd.put("TYPE", pd.getString("type"));							//类型
		pd.put("USERNAME", Jurisdiction.getUsername());					//当前用户(发送者)
		page.setPd(pd);
		List<PageData>	varList = hismsgService.datalistPage(page);		//列出Hismsg列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "fhim/hismsg/hismsg_list_del";
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll(){
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		if(Tools.notEmpty(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			try {
				hismsgService.deleteAll(ArrayDATA_IDS);
			} catch (Exception e) {
				errInfo = "error";
			}
		}else{
			errInfo = "error";
		}
		map.put("result", errInfo);				//返回结果
		return map;
	}

}
