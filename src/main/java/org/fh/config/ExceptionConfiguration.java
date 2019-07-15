package org.fh.config;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

/**
 * 说明：错误异常拦截处理
 * 作者：FH Admin 
 *  ：
 */
@Configuration
public class ExceptionConfiguration implements HandlerExceptionResolver {

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		ModelAndView mv = new ModelAndView();
		
		String exInfo = ex.toString().replaceAll("\n", "<br/>");
		
		boolean status = exInfo.contains("Subject does not have permission");
		
		if(status){
			exInfo = "<div id='nos'>[没有此页面的访问权限]</div>" + exInfo;
        }else {
        	System.out.println("==============异常开始=============");
    		ex.printStackTrace();
    		System.out.println("==============异常结束=============");
        }
		
		mv.addObject("exception", exInfo);
		mv.setViewName("error");
		return mv;
	}
	
}
