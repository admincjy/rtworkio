package org.fh.util;


import com.baidu.ueditor.ConfigManager;
import com.baidu.ueditor.define.ActionMap;
import com.baidu.ueditor.define.AppInfo;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.State;
import com.baidu.ueditor.hunter.FileManager;
import com.baidu.ueditor.hunter.ImageHunter;
import com.baidu.ueditor.upload.Base64Uploader;
import com.baidu.ueditor.upload.BinaryUploader;
import com.baidu.ueditor.upload.IStorageManager;
import com.baidu.ueditor.upload.StorageManager;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Map;

public class UetidorActionEnter{


    private HttpServletRequest request = null;

    private String rootPath = null;
    private String contextPath = null;

    private String actionType = null;

    private ConfigManager configManager = null;

    private IStorageManager storage;

    public UetidorActionEnter(HttpServletRequest request, String rootPath) {
        this(new StorageManager(), request, rootPath, null);
    }

    public UetidorActionEnter(HttpServletRequest request, String rootPath, String configPath) {
        this(new StorageManager(), request, rootPath, configPath);
    }

    public UetidorActionEnter(IStorageManager storage, HttpServletRequest request, String rootPath) {
        this(storage, request, rootPath, null);
    }

    public UetidorActionEnter(IStorageManager storage, HttpServletRequest request, String rootPath, String configPath) {
        this.storage = storage;

        this.request = request;
        this.rootPath = rootPath;
        this.actionType = request.getParameter("action");
        this.contextPath = request.getContextPath();
        if (configPath == null) {
            configPath = request.getParameter("configPath");
            if (configPath == null) {
                configPath = request.getRequestURI();
            }
        }
        this.configManager = ConfigManager.getInstance(this.rootPath, this.contextPath, configPath);

    }

    public String exec() {

        String callbackName = this.request.getParameter("callback");

        if (callbackName != null) {

            if (!validCallbackName(callbackName)) {
                return new BaseState(false, AppInfo.ILLEGAL).toJSONString();
            }

            return callbackName + "(" + this.invoke() + ");";

        } else {
            return this.invoke();
        }

    }

    public String invoke() {

        if (actionType == null || !ActionMap.mapping.containsKey(actionType)) {
            return new BaseState(false, AppInfo.INVALID_ACTION).toJSONString();
        }

        if (this.configManager == null || !this.configManager.valid()) {
            return new BaseState(false, AppInfo.CONFIG_ERROR).toJSONString();
        }

        State state = null;

        int actionCode = ActionMap.getType(this.actionType);

        Map<String, Object> conf = null;

        switch (actionCode) {

            case ActionMap.CONFIG:
                return this.configManager.getAllConfig().toString();

            case ActionMap.UPLOAD_IMAGE:
            case ActionMap.UPLOAD_SCRAWL:
            case ActionMap.UPLOAD_VIDEO:
            case ActionMap.UPLOAD_FILE: {
                conf = this.configManager.getConfig(actionCode);
                File file=new File("E:\\lwmfile\\");
                if(file.exists()){
                    if (file.isDirectory()){

                    }else {
                        System.out.println("存在与文件夹相同名字的文件");
                    }
                }else {
                    file.mkdir();
                }
                conf.put("rootPath","E:/lwmfile/");
                String filedName = (String) conf.get("fieldName");
                if ("true".equals(conf.get("isBase64"))) {
                    state = new Base64Uploader(storage).save(this.request.getParameter(filedName), conf);
                } else {
                    state = new BinaryUploader(storage).save(this.request, conf);
                }
                break;
            }
            case ActionMap.CATCH_IMAGE:
                conf = configManager.getConfig(actionCode);
                conf.put("rootPath","E:/lwmfile/");
                String[] list = this.request.getParameterValues((String) conf.get("fieldName"));
                state = new ImageHunter(storage, conf).capture(list);
                break;

            case ActionMap.LIST_IMAGE:
            case ActionMap.LIST_FILE:
                conf = configManager.getConfig(actionCode);
                int start = this.getStartIndex();
                state = new FileManager(conf).listFile(start);
                break;

        }

        return state.toJSONString();

    }

    public int getStartIndex() {

        String start = this.request.getParameter("start");

        try {
            return Integer.parseInt(start);
        } catch (Exception e) {
            return 0;
        }

    }

    /**
     * callback参数验证
     */
    public boolean validCallbackName(String name) {

        if (name.matches("^[a-zA-Z_]+[\\w0-9_]*$")) {
            return true;
        }

        return false;

    }
}
