package org.fh.controller.library;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.Page;
import org.fh.util.Const;
import org.fh.util.DateUtil;
import org.fh.util.FileUpload;
import org.fh.util.FileUtil;
import org.fh.util.PathUtil;
import org.fh.util.Tools;
import org.fh.entity.PageData;
import org.fh.service.library.ManagementSystemService;

/** 
 * 说明：朗威图书馆
 * 作者：FH Admin 
 * 时间：
 *  ：www.fhadmin.org
 */
@Controller
@RequestMapping("/r_enterprise")
public class REnterpriseController extends BaseController {
	
	@Autowired
	private ManagementSystemService managementsystemService;
	
	
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("r_enterprise:list")
	public String list(Page page, Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CLASSIFICATION", "904");
		String KEYWORDS = pd.getString("KEYWORDS");						//关键词检索条件
		if(Tools.notEmpty(KEYWORDS))pd.put("KEYWORDS", KEYWORDS.trim());
		page.setPd(pd);
		List<PageData>	varList = managementsystemService.list(page);	//列出ManagementSystem列表
		model.addAttribute("varList", varList);
		model.addAttribute("pd", pd);
		return "library/research/r_enterprise_list";
	}
	
	/**打开上传pdf页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goUploadpdf")
	public String goUploadPdf(Model model)throws Exception{
		PageData pd = new PageData();
		pd.put("CLASSIFICATION", "904");
		model.addAttribute("pd", pd);
		return"library/uploadpdf";
	}
	
	
	
	
	
}
