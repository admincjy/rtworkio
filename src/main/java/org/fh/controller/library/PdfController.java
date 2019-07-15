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
 * 时间：2019-05-21
 *  ：www.fhadmin.org
 */
@Controller
@RequestMapping("/pdf")
public class PdfController extends BaseController {
	
	@Autowired
	private ManagementSystemService managementsystemService;
	
	
	
	
	
	/**批量删除
	 * @param
	 * @throws Exception
	*/
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("m_talent:del")
	public Object deleteAll(){
		Map<String,Object> map = new HashMap<String,Object>();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String errInfo = "success";
		String DATA_IDS = pd.getString("DATA_IDS");
		try{
			if(Tools.notEmpty(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				for(int i=0;i<ArrayDATA_IDS.length;i++) {
					PageData pd1 = new PageData();
					pd1.put("MANAGEMENTSYSTEM_ID", ArrayDATA_IDS[i]);
					PageData data= managementsystemService.findById(pd1);
					String flieName=PathUtil.getFilePath()+Const.LOCFILEPATHFILE+data.getString("PATH");
				    FileUtil.delFile(flieName); 
				}
				managementsystemService.deleteAll(ArrayDATA_IDS);
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
	
	
	
	
	/**从pfd导入到数据库
	 * @param file
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/savepdf")
	@RequiresPermissions("frompdf")
	public String savePdf(@RequestParam(value="pdf",required=false) MultipartFile file, Model model) throws Exception{
		String date=DateUtil.getDay();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getFilePath()+Const.LOCFILEPATHFILE+date+"\\";								//文件上传路径			
			String fileName =  FileUpload.fileUp(file, filePath, file.getOriginalFilename().substring(0, file.getOriginalFilename().indexOf(".")));//执行上传
			PageData pdName = new PageData();
			pdName.put("NAME", fileName);
			List<PageData> listAll=managementsystemService.listAll(pdName);
			if (listAll.size()>0) {
				//已存在此文件,更新
				PageData pd1 = new PageData();
				pd1.put("MANAGEMENTSYSTEM_ID", listAll.get(0).get("MANAGEMENTSYSTEM_ID"));
				pd1.put("UPDATETIME",  new Date());
				managementsystemService.edit(pd1);
			}else {
                //不存在此文件,新增
				pd.put("MANAGEMENTSYSTEM_ID", this.get32UUID());	//主键
				pd.put("NAME", fileName);
				pd.put("PATH", date+"\\"+fileName);
				pd.put("SUFFIX", "pdf");
				pd.put("ISDOWM", 1);
				pd.put("CREATETIME", new Date());
				managementsystemService.save(pd);					
			}
		}
		model.addAttribute("msg","success");
		return "transferPage";
	}
	
	@RequestMapping(value="/{MANAGEMENTSYSTEM_ID}/displayPDF.do")
	public void displayPDF(HttpServletRequest request,HttpServletResponse response,@PathVariable("MANAGEMENTSYSTEM_ID")String MANAGEMENTSYSTEM_ID) {
		try {
			PageData pd = new PageData();
			pd.put("MANAGEMENTSYSTEM_ID", MANAGEMENTSYSTEM_ID);
			PageData data= managementsystemService.findById(pd);
			String fileRealPath=PathUtil.getFilePath()+Const.LOCFILEPATHFILE+data.getString("PATH");
			File file = new File(fileRealPath);
			FileInputStream fileInputStream = new FileInputStream(file);
			response.setHeader("Content-Disposition", "attachment;fileName="+"SHR人才中心"+".pdf");
			response.setContentType("multipart/form-data");
			OutputStream outputStream = response.getOutputStream();
			IOUtils.write(IOUtils.toByteArray(fileInputStream), outputStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
