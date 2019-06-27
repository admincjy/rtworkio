<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
    <title>${sessionScope.sysName}</title>
    <!-- HTML5 Shim and Respond.js IE10 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 10]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="author" content="FH Admin QQ313596790" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

</head>

<body style="background-color: white">
    
    <!-- [加载状态 ] start -->
    <div class="loader-bg">
        <div class="loader-track">
            <div class="loader-fill"></div>
        </div>
    </div>
    <!-- [ 加载状态  ] End -->

    <!-- [ 主内容区 ] start -->
        <div class="pcoded-wrapper">
            <div class="pcoded-content">
                <div class="pcoded-inner-content">
                    <div class="main-body">
                        <div class="page-wrapper">
                            <!-- [ Main Content ] start -->
                            <div class="row">
                            
								<form action="head/saveSysSet1" name="Form" id="Form" method="post" style="width: 100%;">
	    							<input type="hidden" value="${fhsmsSound }" id="fhsmsSound" name="fhsmsSound" />
									<div id="showform" style="padding-top: 1px;">
	                            
		                                <div class="input-group input-group-sm mb-3">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">系统名称</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="sysName" id="sysName" value="${sysName }" placeholder="这里输入系统名称" maxlength="10"  title="系统名称">
		                                 </div>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">每页条数</span></span>
		                                     </div>
		                                     <input type="number" class="form-control" name="showCount" id="showCount"  value="${showCount }"  maxlength="2" placeholder="这里输入每页条数" title="带分页的列表页面,每页显示条数" >
		                                 </div>
		                                 
		                                 <h6>邮箱服务器配置</h6>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top:5px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">SMTP</span></span>
		                                     </div>
		                                     <input type="text" class="form-control" name="SMTP" id="SMTP" value="${SMTP }" placeholder="这里输入SMTP" maxlength="32"  title="SMTP">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">端口</span></span>
		                                     </div>
		                                     <input type="number" class="form-control" name="PORT" id="PORT"  value="${PORT }"  maxlength="5" placeholder="这里输入端口" title="端口" >
		                                 </div>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top:-10px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">邮箱</span></span>
		                                     </div>
		                                     <input type="text" class="form-control" name="EMAIL" id="EMAIL" value="${EMAIL }" placeholder="这里输入邮箱服务器邮箱" maxlength="32"  title="邮箱服务器邮箱">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">密码</span></span>
		                                     </div>
		                                     <input type="password" class="form-control" name="PAW" id="PAW"  value="${PAW }"  maxlength="100" placeholder="这里输入密码:" title="密码" >
		                                 </div>
		                                 
		                                 <h6>在线管理(站内信)服务器IP和端口配置</h6>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top:5px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">IP地址</span></span>
		                                     </div>
		                                     <input type="text" class="form-control" name="onlineIp" id="onlineIp" value="${onlineIp }" placeholder="这里输入IP地址" maxlength="32"  title="IP地址">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">端口</span></span>
		                                     </div>
		                                     <input type="number" class="form-control" name="onlinePort" id="onlinePort"  value="${onlinePort }"  maxlength="5" placeholder="这里输入端口" title="端口" >
		                                 </div>
		                                 
		                                 <h6>即时聊天服务器IP和端口配置</h6>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top:5px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">IP地址</span></span>
		                                     </div>
		                                     <input type="text" class="form-control" name="imIp" id="imIp" value="${imIp }" placeholder="这里输入IP地址" maxlength="32"  title="IP地址">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">端口</span></span>
		                                     </div>
		                                     <input type="number" class="form-control" name="imPort" id="imPort"  value="${imPort }"  maxlength="5" placeholder="这里输入端口" title="端口" >
		                                 </div>
		                                 
			                             <div style="max-height: 55px;">
			                             <h6>新消息提示音</h6>
			                             <div class="form-group d-inline">
	                                         <div class="radio radio-primary d-inline">
	                                             <input type="radio" name="radio-p-fill-5" id="fhradio0" <c:if test="${fhsmsSound == 'm0' }">checked=""</c:if> onclick="setFhsmsSoundType('m0');">
	                                             <label for="fhradio0" class="cr">静音</label>
	                                         </div>
                                         </div>
                                         <div class="form-group d-inline">
	                                         <div class="radio radio-primary d-inline">
	                                             <input type="radio" name="radio-p-fill-5" id="fhradio1" <c:if test="${fhsmsSound == 'm1' }">checked=""</c:if> onclick="setFhsmsSoundType('m1');">
	                                             <label for="fhradio1" class="cr">歪歪音效</label>
	                                         </div>
                                         </div>
                                         <div class="form-group d-inline">
	                                         <div class="radio radio-primary d-inline">
	                                             <input type="radio" name="radio-p-fill-5" id="fhradio2" <c:if test="${fhsmsSound == 'm2' }">checked=""</c:if> onclick="setFhsmsSoundType('m2');">
	                                             <label for="fhradio2" class="cr">美女音效</label>
	                                         </div>
                                         </div>
                                         <div class="form-group d-inline">
	                                         <div class="radio radio-primary d-inline">
	                                             <input type="radio" name="radio-p-fill-5" id="fhradio3" <c:if test="${fhsmsSound == 'm3' }">checked=""</c:if> onclick="setFhsmsSoundType('m3');">
	                                             <label for="fhradio3" class="cr">飞信音效</label>
	                                         </div>
                                         </div>
                                         <div class="form-group d-inline">
	                                         <div class="radio radio-primary d-inline">
	                                             <input type="radio" name="radio-p-fill-5" id="fhradio4" <c:if test="${fhsmsSound == 'm4' }">checked=""</c:if> onclick="setFhsmsSoundType('m4');">
	                                             <label for="fhradio4" class="cr">IOS短信音效</label>
	                                         </div>
                                         </div>
                                         <div class="form-group d-inline">
	                                         <div class="radio radio-primary d-inline">
	                                             <input type="radio" name="radio-p-fill-5" id="fhradio5" <c:if test="${fhsmsSound == 'm5' }">checked=""</c:if> onclick="setFhsmsSoundType('m5');">
	                                             <label for="fhradio5" class="cr">iPhoneQQ音效</label>
	                                         </div>
                                         </div>
			                             </div>
		                                 
		                                 <div class="input-group" style="margin-top:10px;background-color: white" >
							            	<span style="width: 100%;text-align: center;">
							            		<a class="btn btn-light btn-sm" onclick="save1();">保存</a>
							            		<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">取消</a>
							            	</span>
							             </div>
	                            
									</div>
									
									<!-- [加载状态 ] start -->
								    <div id="jiazai" style="display:none;margin-top:50px;">
								    	<div class="d-flex justify-content-center">
	                                        <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
                                                <span class="sr-only">Loading...</span>
                                            </div>
                                        </div>
                                    </div>
								    <!-- [ 加载状态  ] End -->
									
								</form>
							<div style="display: none;" id="fhsmsobjsys"></div>
                            </div>
                            <!-- [ Main Content ] end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <!-- [ 主内容区 ] end -->
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<!-- 本页面依赖 --> 
<script src="assets/js/sys.js"></script>
</body>
</html>