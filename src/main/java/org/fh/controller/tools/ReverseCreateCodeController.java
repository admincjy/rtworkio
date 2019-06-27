package org.fh.controller.tools;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.fh.controller.base.BaseController;
import org.fh.entity.PageData;
import org.fh.util.DbFH;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 说明：代码生成器(反向生成)
 * 作者：FH 
 * 官网：
 */
@Controller
@RequestMapping("/recreateCode")
public class ReverseCreateCodeController extends BaseController {
	
	
	/**列表
	 * @return
	 */
	@RequestMapping(value="/list")
	@RequiresPermissions("recreateCode:list")
	public String list() throws Exception{
		return "tools/createcode/recreatecode_list";
	}
	
	 /**列出所有表
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/listAllTable")
	@SuppressWarnings("unchecked")
	@RequiresPermissions("recreateCode:list")
	@ResponseBody
	public Object listAllTable(){
		PageData pd = new PageData();		
		pd = this.getPageData();
		Map<String,Object> map = new HashMap<String,Object>();
		List<PageData> pdList = new ArrayList<PageData>();
		List<String> tblist = new ArrayList<String>();
		try {
			Object[] arrOb = DbFH.getTables(pd);
			tblist = (List<String>)arrOb[1];
			pd.put("msg", "ok");
		} catch (ClassNotFoundException e) {
			pd.put("msg", "no");
			e.printStackTrace();
		} catch (SQLException e) {
			pd.put("msg", "no");
			e.printStackTrace();
		}
		pdList.add(pd);
		map.put("tblist", tblist);
		map.put("list", pdList);
		return map;
	}
	
	/**去代码生成器页面(进入弹窗)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goProductCode")
	public String goProductCode(Model model) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String fieldType = "";
		StringBuffer sb = new StringBuffer("");
		List<Map<String,String>> columnList = DbFH.getFieldParameterLsit(DbFH.getFHCon(pd),pd.getString("table"),pd.getString("dbtype")); //读取字段信息
		for(int i=0;i<columnList.size();i++){
			Map<String,String> fmap = columnList.get(i);
			sb.append(fmap.get("fieldNanme").toString().toUpperCase());					//字段名称
			sb.append(",fh,");
			fieldType = fmap.get("fieldType").toString().toLowerCase();					//字段类型
			if(fieldType.contains("int")){
				sb.append("Integer");
			}else if(fieldType.contains("NUMBER")){
				if(Integer.parseInt(fmap.get("fieldSccle")) > 0){
					sb.append("Double");
				}else{
					sb.append("Integer");
				}
			}else if(fieldType.contains("double") || fieldType.contains("numeric")){
				sb.append("Double");
			}else if(fieldType.contains("date")){
				sb.append("Date");
			}else{
				sb.append("String");
			}
			sb.append(",fh,");
			if("".equals(fmap.get("fieldComment").toString())){
				sb.append("备注"+(i+1));													//当字段没有注释的时候用'备注'代替
			}else{
				sb.append(fmap.get("fieldComment").toString());							//字段注释
			}
			sb.append(",fh,");
			sb.append("是");																//是否前台录入
			sb.append(",fh,");
			sb.append("无");																//默认值
			sb.append(",fh,");
			sb.append(fmap.get("fieldLength").toString());								//长度
			sb.append(",fh,");
			sb.append(fmap.get("fieldSccle").toString());								//小数点右边的位数
			sb.append(",fh,");
			sb.append("null");		
			sb.append("Q313596790");
		}
		pd.put("FIELDLIST", sb.toString());
		model.addAttribute("msg", "edit");
		model.addAttribute("pd", pd);
		return "tools/createcode/productCode";
	}
	
}
//FHQ 3 1 3 5 9 6 7 9 0
