package org.fh.controller.system;

import org.fh.controller.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 说明：在线管理处理类
 * 作者：FH 
 * 官网：
 */
@Controller
@RequestMapping("/online")
public class OnlineController extends BaseController {
	
	/**列表
	 * @return
	 */
	@RequestMapping(value="/list")
	public String list(){
		return "system/online/online_list";
	}

}
