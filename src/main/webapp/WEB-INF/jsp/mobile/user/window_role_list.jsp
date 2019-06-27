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
                            	<!-- [ Hover-table ] start -->
                                <div class="col-xl-12">
                                    <div class="card">
										<form action="mobileuser/roleListWindow" method="post" name="Form" id="Form" style="width: 100%;">
										<input type="hidden" name="ROLE_ID" id="ROLE_ID" value="${pd.ROLE_ID }"/>
										<!-- 检索条件  -->
										<div style="padding-left: 15px;padding-top: 15px;">
										<table>
											<tr>
												<td>
							                        <div class="input-group input-group-sm mb-3">
                                                     	<input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${pd.KEYWORDS }" placeholder="这里输入关键词" />
                                                 	</div>
												</td>
												<td style="vertical-align:top;padding-left:5px;">
													<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索">
														<i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i>
													</a>
												</td>
											</tr>
										</table>
										</div>
										<!-- 检索  -->
										<div class="card-block table-border-style" style="margin-top: -15px">
		                                	<div class="table-responsive">
												<table class="table table-hover">
													<thead>
														<tr>
															<th>角色</th>
															<th>编号</th>
														</tr>
													</thead>
													<tbody>
													<!-- 开始循环 -->	
													<c:choose>
														<c:when test="${not empty roleList}">
															<c:forEach items="${roleList}" var="var" varStatus="vs">
																<tr onclick="setRole('${var.RNUMBER }')" style="cursor:pointer;">
																	<td>${var.ROLE_NAME }</td>
																	<td>${var.RNUMBER }</td>
																</tr>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<tr>
																<td colspan="10">没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
													</tbody>
												</table>
												<table style="width:100%;margin-top:15px;">
													<tr>
														<td style="text-align: center;">${page.pageStrSimplify}</td>
													</tr>
												</table>
												
											</div>
										</div>
										</form>
									</div>
								</div>
                            </div>
                            <!-- [ Main Content ] end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <!-- [ 主内容区 ] end -->
    
    <input type="hidden" name="RNUMBER" id="RNUMBER" />
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">

	//检索
	function searchs(){
		$("#Form").submit();
	}
	
	//选定角色
	function setRole(RNUMBER){
		$("#RNUMBER").val(RNUMBER);
		roleBinding();
	}
	
	//选择角色
	function roleBinding(){
		var RNUMBER = $("#RNUMBER").val();
		if("" == RNUMBER){
			$("#fhadminth").tips({
				side:3,
	            msg:'没有选择任何角色',
	            bg:'#AE81FF',
	            time:2
	        });
		}else{
			top.Dialog.close();
		}
	}
		
</script>
</html>
