package org.fh.mobile.fhim;

import java.util.List;

import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.service.fhim.HismsgService;
import org.fh.util.Jurisdiction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 说明：聊天记录(手机端)
 * 作者：FH Admin Q 31359-6790
 * 官网：www.fhadmin.org
 */
@Controller
@RequestMapping(value="/mobhismsg")
public class MobHismsgController extends BaseController {
	
	@Autowired
	private HismsgService hismsgService;
	
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
		pd.put("TITLE", pd.getString("title"));							//和谁聊天
		pd.put("USERNAME", Jurisdiction.getUsername());					//当前用户(发送者)
		page.setPd(pd);
		List<PageData>	varList = hismsgService.datalistPage(page);		//列出Hismsg列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "mobile/im/hismsg_list";
	}
	
}
