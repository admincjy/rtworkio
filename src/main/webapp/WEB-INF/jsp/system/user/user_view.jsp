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
    <meta name="author" content="FH Admin  " />

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
	
								<c:if test="${null != rpd}">
					            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">职位</span></span>
                                    </div>
                                    <input type="text" class="form-control" value="${rpd.ROLE_NAME }" disabled="disabled"  title="职位">
                                </div>
								</c:if>
								<c:if test="${null == rpd}">
								<c:if test="${fx != 'head'}">
					            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">职位</span></span>
                                    </div>
                                    <div  style="max-width:469px;margin-left: 2px;">
										<select class="js-example-placeholder-multiple col-sm-12" name="ROLE_ID" id="ROLE_ID" style="height: 30px;border: 0; background: transparent;appearance:none;-moz-appearance:none;-webkit-appearance:none; ">
											<c:forEach items="${roleList}" var="role">
											<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
											</c:forEach>
										</select>
					            	</div>
                                </div>
								</c:if>
					            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">用户名</span></span>
                                    </div>
                                    <input type="text" class="form-control" value="${null==pd?'无此用户名':pd.USERNAME }" disabled="disabled"  title="用户名">
                                </div>
					            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">编号</span></span>
                                    </div>
                                    <input type="text" class="form-control" value="${pd.NUMBER }" disabled="disabled"  title="编号">
                                </div>
					            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">姓名</span></span>
                                    </div>
                                    <input type="text" class="form-control" value="${pd.NAME }" disabled="disabled"  title="姓名">
                                </div>
								<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">手机号</span></span>
                                    </div>
                                    <input type="text" class="form-control" value="${pd.PHONE }" disabled="disabled"  title="手机号">
                                </div>
                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">邮箱</span></span>
                                    </div>
                                    <input type="text" class="form-control" value="${pd.EMAIL }" disabled="disabled"  title="邮箱">
                                </div>
					            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">备注</span></span>
                                    </div>
                                    <input type="text" class="form-control" value="${pd.BZ }" disabled="disabled"  title="备注">
                                </div>
								</c:if>
	    
                            </div>
                            <!-- [ Main Content ] end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <!-- [ 主内容区 ] end -->

<script type="text/javascript" src="assets/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>

</html>