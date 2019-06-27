package org.fh.config;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 说明：处理404页面
 * 作者：FH 
 * 官网：
 */
@Controller
public class ErrorPageController implements ErrorController {
 
     private static final String ERROR_PATH = "/error";
      
        @RequestMapping(ERROR_PATH)
        public String error(){
            return "404";
        }
        @Override
        public String getErrorPath() {
            return ERROR_PATH;
        }
}
