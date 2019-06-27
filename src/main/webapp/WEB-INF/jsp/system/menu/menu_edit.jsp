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
	    
							    <h6 style="margin-left: 5px;">上级菜单：${null == pds.MENU_NAME ?'(无) 此项为顶级菜单':pds.MENU_NAME}</h6>
							    
							    <form action="menu/${MSG }" name="Form" id="Form" method="post" style="width: 100%;">
							    <input type="hidden" name="MENU_ID" id="menuId" value="${pd.MENU_ID }"/>
								<input type="hidden" name="MENU_TYPE" id="MENU_TYPE" value="1"/>
								<input type="hidden" name="MENU_STATE" id="MENU_STATE" value="${pd.MENU_STATE }"/>
								<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? MENU_ID:pd.PARENT_ID}"/>
							    <div id="showform">
							    
						            <div class="input-group input-group-sm mb-3">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">菜单名称</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="MENU_NAME" id="MENU_NAME"  value="${pd.MENU_NAME }"  maxlength="32" placeholder="这里输入菜单名称" title="菜单名称" >
	                                </div>
							   		<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">菜单链接</span></span>
	                                    </div>
	                                    <c:if test="${null != pds.MENU_NAME}">
											<input type="text" name="MENU_URL" id="MENU_URL" value="${pd.MENU_URL }" placeholder="这里输入菜单链接" class="form-control" maxlength="250" title="菜单链接" />
										</c:if>
										<c:if test="${null == pds.MENU_NAME}">
											<input type="text" name="MENU_URL" id="MENU_URL" value="" readonly="readonly" placeholder="顶级菜单禁止输入" class="form-control" />
										</c:if>
	                                </div>
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">权限标识</span></span>
	                                    </div>
	                                    <c:if test="${null != pds.MENU_NAME}">
					                    	<input type="text" class="form-control" name="SHIRO_KEY" id="SHIRO_KEY"  value="${pd.SHIRO_KEY }"  maxlength="32" placeholder="这里输入菜单权限标识(选填)" title="权限标识" >
					                    </c:if>
					                    <c:if test="${null == pds.MENU_NAME}">
											<input type="text" name="SHIRO_KEY" id="SHIRO_KEY" value="(无)" readonly="readonly" placeholder="顶级菜单禁止输入" class="form-control" />
										</c:if>
	                                </div>
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">菜单序号</span></span>
	                                    </div>
	                                    <input type="number" class="form-control" name="MENU_ORDER" id="MENU_ORDER"  value="${pd.MENU_ORDER }"  maxlength="2" placeholder="这里输入菜单序号" title="菜单序号" >
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="margin-top: 0px;background-color: white">
						                <div class="input-group-prepend">
	                                        <span style="width: 79px;"><span style="width: 100%;">菜单状态：</span></span>
	                                    </div>
                                        <div class="radio radio-primary d-inline" style="margin-top: -10px;">
                                             <input type="radio" name="radio-p-fill-5" id="fhradio0" <c:if test="${pd.MENU_STATE == 1 }">checked=""</c:if> onclick="setType(1);"/>
                                             <label for="fhradio0" class="cr">显示</label>
                                         </div>
                                         <div class="radio radio-primary d-inline" style="margin-top: -10px;">
                                             <input type="radio" name="radio-p-fill-5" id="fhradio1" <c:if test="${pd.MENU_STATE == 0 }">checked=""</c:if> onclick="setType(0);"/>
                                             <label for="fhradio1" class="cr">隐藏</label>
                                         </div>
						            </div>
						            <div class="input-group" style="margin-top:0px;background-color: white" >
						            	<span style="width: 100%;padding-left: 15px;">
						            		<a class="btn btn-light btn-sm" onclick="save();">保存</a>
						            		<a class="btn btn-light btn-sm" onclick="goback('${MENU_ID}');">取消</a>
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
  
  <script type="text/javascript">
  
	//取消
	function goback(MENU_ID){
		window.location.href="<%=basePath%>menu/list?MENU_ID="+MENU_ID;
	}
	
	//保存
	function save(){
		if($("#MENU_NAME").val()==""){
			$("#MENU_NAME").tips({
				side:3,
	            msg:'请输入菜单名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MENU_NAME").focus();
			return false;
		}
		if($("#MENU_URL").val()==""){
			$("#MENU_URL").val('#');
		}
		//状态值为空默认为显示
		if($("#MENU_STATE").val()==""){
			$("#MENU_STATE").val(1);
		}
		if($("#SHIRO_KEY").val()==""){
			$("#SHIRO_KEY").val('(无)');
		}
		if($("#MENU_ORDER").val()==""){
			$("#MENU_ORDER").tips({
				side:1,
	            msg:'请输入菜单序号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MENU_ORDER").focus();
			return false;
		}
		if(isNaN(Number($("#MENU_ORDER").val()))){
			$("#MENU_ORDER").tips({
				side:1,
	            msg:'请输入菜单序号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MENU_ORDER").focus();
			$("#MENU_ORDER").val(1);
			return false;
		}
		$("#showform").hide();
		$("#jiazai").show();
		$("#Form").submit();
	}
	
	//设置菜单类型or状态
	function setType(value){
		$("#MENU_STATE").val(value);
	}
	
  </script>
</body>
</html>
