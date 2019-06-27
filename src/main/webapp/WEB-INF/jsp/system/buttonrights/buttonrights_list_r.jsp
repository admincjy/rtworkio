<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"  %>
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

<body>
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
								<table style="margin-top: 8px;margin-left: 20px;">
									<tr height="35">
										<td style="width:50px;">角色组:</td>
											<c:choose>
											<c:when test="${not empty roleList}">
											<!-- 角色组循环 -->
											<c:forEach items="${roleList}" var="role" varStatus="vs">
												<td>
													<a class="btn btn-${pd.ROLE_ID == role.ROLE_ID?"secondary":"light"} btn-sm"	 href="buttonrights/list?type=2&ROLE_ID=${role.ROLE_ID }" ><i class="feather icon-users"></i>${role.ROLE_NAME }</a>
												</td>
												<td style="width:1px;"></td>
											</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
												<td colspan="100">没有相关数据</td>
												</tr>
											</c:otherwise>
											</c:choose>
										<td></td>
									</tr>
								</table>
								<div class="card-block table-border-style" style="margin-top: -15px">
		                        	<div class="table-responsive">
		                            	<table class="table table-hover">
											<thead>
												<tr>
													<th style="width: 50px;">NO</th>
													<th>按钮名称</th>
													<shiro:hasPermission name="buttonrights:edit">
														<!-- 按钮循环 -->
														<c:forEach items="${roleList_z}" var="var" varStatus="vs">
															<th class='center'>${var.ROLE_NAME }</th>
														</c:forEach>
													</shiro:hasPermission>
												</tr>
											</thead>
											<c:choose>
												<c:when test="${not empty buttonlist}">
													<!-- 按钮循环 -->
													<c:forEach items="${buttonlist}" var="fhbutton" varStatus="vsb">
													<tr>
													<td style="width:30px;">${vsb.index+1}</td>
													<td class='center' >${fhbutton.NAME }</td>
													<shiro:hasPermission name="buttonrights:edit">
														<!-- 角色循环 -->
														<c:forEach items="${roleList_z}" var="var" varStatus="vs">
															<!-- 关联表循环 -->
															<c:forEach items="${roleFhbuttonlist}" var="varRb" varStatus="vsRb">
																<c:if test="${var.ROLE_ID == varRb.ROLE_ID && fhbutton.FHBUTTON_ID == varRb.BUTTON_ID }">
																	<c:set value="1" var="rbvalue"></c:set>
																</c:if>
															</c:forEach>
															<td style="height: 20px;">
							                                    <div class="switch switch-info d-inline m-r-10">
		                                                            <input type="checkbox" id="switch-i-${vs.index}${vsb.index}" onclick="upRb('${var.ROLE_ID}','${fhbutton.FHBUTTON_ID}')" <c:if test="${rbvalue == 1 }">checked=""</c:if>>
		                                                            <label for="switch-i-${vs.index}${vsb.index}" class="cr"></label>
		                                                        </div>
															</td>
															<c:set value="0" var="rbvalue"></c:set>
														</c:forEach>
													</shiro:hasPermission>
													</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
													<td colspan="100" class="center" >没有相关数据</td>
													</tr>
												</c:otherwise>
											</c:choose>
											</table>
											<table style="width:100%;margin-top:15px;">
													<tr>
														<td style="vertical-align:top;">
															<a class="btn btn-light btn-sm" onclick="window.location.href='<%=basePath%>buttonrights/list?ROLE_ID=${pd.ROLE_ID }';">切换视图</a>
														</td>
													</tr>
											</table>
										</div>
									</div>
                             </div>
                         </div>
                         <!-- [ Hover-table ] end -->

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
<script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>
    
<script type="text/javascript">
	//处理按钮点击
	function upRb(ROLE_ID,FHBUTTON_ID){
		$.ajax({
			type: "POST",
			url: "<%=basePath%>buttonrights/upRb?ROLE_ID="+ROLE_ID+"&BUTTON_ID="+FHBUTTON_ID+"&guid="+new Date().getTime(),
	    	data: encodeURI(""),
			dataType:'json',
			//beforeSend: validateData,
			cache: false,
			success: function(data){
			}
		});
	}
</script>

</body>
</html>