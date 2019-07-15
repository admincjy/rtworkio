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
    <meta name="author" content="FH Admin  " />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/fonts/simple-line-icons/css/simple-line-icons.css">
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
											<td style="width:86px;"><shiro:hasPermission name="role:add"><a href="javascript:addRole(0);" class="btn btn-light btn-sm">新增组</a></shiro:hasPermission></td>
												<c:choose>
												<c:when test="${not empty roleList}">
												<c:forEach items="${roleList}" var="role" varStatus="vs">
													<td>
														<a class="btn btn-${pd.ROLE_ID == role.ROLE_ID?"secondary":"light"} btn-sm"	 href="role/list?ROLE_ID=${role.ROLE_ID }" ><i class="feather icon-users"></i>${role.ROLE_NAME }</a>
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
									
									<table style="margin-top: 5px;margin-left: 20px;">
										<tr>
										<td>本组：</td>
										<td>
										<shiro:hasPermission name="role:edit"><a class="btn btn-light btn-sm" onclick="editRole('${pd.ROLE_ID }');">修改组名称</a></shiro:hasPermission>
											<c:choose>
												<c:when test="${pd.ROLE_ID == 'f99'}">
												</c:when>
												<c:otherwise>
												<a class="btn btn-light btn-sm" onclick="editRights('${pd.ROLE_ID }');">
													<c:if test="${pd.ROLE_ID == '1'}">Admin 菜单权限</c:if>
													<c:if test="${pd.ROLE_ID != '1'}">组菜单权限</c:if>
												</a>
												</c:otherwise>
											</c:choose>
											<c:choose> 
												<c:when test="${pd.ROLE_ID == '1'}">
												</c:when>
												<c:otherwise>
												<shiro:hasPermission name="role:del">
													<a class="btn btn-light btn-sm" style="width: 20px;height:30px;" title="删除" onclick="delRole('${pd.ROLE_ID }','z','${pd.ROLE_NAME }');">
														<i style="margin-left:-7px;" class="feather icon-x"></i>
													</a>
												</shiro:hasPermission>
												</c:otherwise>
											</c:choose>
										</td>
										</tr>
									</table>
									<div class="card-block table-border-style" style="margin-top: -15px">
                                    	<div class="table-responsive">
											<table class="table table-hover">
												<thead>
												<tr>
													<th>NO</th>
													<th>角色</th>
													<th>编码</th>
													<th>上级角色</th>
													<th>部门</th>
													<shiro:hasPermission name="role:edit">
													<th>增</th>
													<th>删</th>
													<th>改</th>
													<th>查</th>
													</shiro:hasPermission>
													<th>操作</th>
												</tr>
												</thead>
												<c:choose>
													<c:when test="${not empty roleList_z}">
														<c:forEach items="${roleList_z}" var="var" varStatus="vs">
														<tr>
														<td scope="row" style="width:30px;">${vs.index+1}</td>
														<td style="width:200px;" id="ROLE_NAMETd${var.ROLE_ID }">${var.ROLE_NAME }</td>
														<td>${var.RNUMBER }</td>
														<td>${var.FATHER_ROLE_NAME}</td>
														<td>${var.DICTIONARIES_ID }.${var.DEPARTMENT }</td>
														<shiro:hasPermission name="role:edit">
														<td style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','add_qx');" title="分配新增权限" style="cursor:pointer;"><i class="icon-wrench"></i></a></td>
														<td style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','del_qx');" title="分配删除权限" style="cursor:pointer;"><i class="icon-wrench"></i></a></td>
														<td style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','edit_qx');" title="分配修改权限" style="cursor:pointer;"><i class="icon-wrench"></i></a></td>
														<td style="width:30px;"><a onclick="roleButton('${var.ROLE_ID }','cha_qx');" title="分配查看权限" style="cursor:pointer;"><i class="icon-wrench"></i></a></td>
														</shiro:hasPermission>
														<td style="width:155px;">
														<a onclick="editRights('${var.ROLE_ID }');" title="菜单权限" style="cursor:pointer;"><i class="feather icon-tag"></i></a>
															<c:if test="${var.ROLE_ID != 'fhadminzhuche' }"><!-- 注册用户角色不能修改 -->
																<shiro:hasPermission name="role:edit"><a title="编辑" onclick="editRole('${var.ROLE_ID }');" style="cursor:pointer;"><i class="feather icon-edit-2"></i></a></shiro:hasPermission>
															</c:if>
														<c:choose> 
															<c:when test="${var.ROLE_ID == '1'}">
															</c:when>
															<c:otherwise>
															 	<c:if test="${var.ROLE_ID != 'fhadminzhuche' }"><!-- 注册用户角色不能删除 -->
															 		<shiro:hasPermission name="role:del"><a title="删除" onclick="delRole('${var.ROLE_ID }','c','${var.ROLE_NAME }');" style="cursor:pointer;"><i class="feather icon-x"></i></a></shiro:hasPermission>
															 	</c:if>
															</c:otherwise>
														</c:choose>
														</td>
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
														<shiro:hasPermission name="role:add"><a class="btn btn-light btn-sm" onclick="addRole('${pd.ROLE_ID }');">新增</a></shiro:hasPermission>
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

	//新增
	function addRole(pid){
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增";
		 diag.URL = '<%=basePath%>role/toAdd?parent_id='+pid;
		 diag.Width = 600;
		 diag.Height = 500;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
				setTimeout("self.location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//修改
	function editRole(ROLE_ID){
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑";
		 diag.URL = '<%=basePath%>role/toEdit?ROLE_ID='+ROLE_ID;
		 diag.Width = 600;
		 diag.Height = 500;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
				setTimeout("self.location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//删除
	function delRole(ROLE_ID,msg,ROLE_NAME){
		swal({
               title: '',
               text: "确定要删除["+ROLE_NAME+"]吗?",
               icon: "warning",
               buttons: true,
               dangerMode: true,
           }).then((willDelete) => {
               if (willDelete) {
		           	$.ajax({
		       			type: "POST",
		       			url: '<%=basePath%>role/delete',
		       	    	data: {ROLE_ID:ROLE_ID,tm:new Date().getTime()},
		       			dataType:'json',
		       			cache: false,
		       			success: function(data){
		       				 if("success" == data.result){
		       					 swal("删除成功", "["+ROLE_NAME+"] 已经从列表中删除", "success");
		       					 if(msg == 'c'){
		       							setTimeout("document.location.reload()", 1500);
									}else{
										window.location.href="<%=basePath%>role/list";
									}
		       				 }else if("false" == data.result){
		       					swal("删除失败!", "请先删除下级角色!", "warning");
		       				 }else if("false2" == data.result){
		       					swal("删除失败!", "此角色已被使用!", "warning");
		       				 }
		       			}
		       		});
               }
           });
	}
	
	//菜单权限
	function editRights(ROLE_ID){
		 var diag = new top.Dialog();
		 diag.Drag = true;
		 diag.Title = "菜单权限";
		 diag.URL = '<%=basePath%>role/menuqx?ROLE_ID='+ROLE_ID;
		 diag.Width = 320;
		 diag.Height = 466;
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
	
	//按钮权限(增删改查)
	function roleButton(ROLE_ID,msg){
		if(msg == 'add_qx'){
			var Title = "授权新增权限(此角色下打勾的菜单拥有新增权限)";
		}else if(msg == 'del_qx'){
			Title = "授权删除权限(此角色下打勾的菜单拥有删除权限)";
		}else if(msg == 'edit_qx'){
			Title = "授权修改权限(此角色下打勾的菜单拥有修改权限)";
		}else if(msg == 'cha_qx'){
			Title = "授权查看权限(此角色下打勾的菜单拥有查看权限)";
		}
		 var diag = new top.Dialog();
		 diag.Drag = true;
		 diag.Title = Title;
		 diag.URL = '<%=basePath%>role/b4Button?ROLE_ID='+ROLE_ID+'&msg='+msg;
		 diag.Width = 320;
		 diag.Height = 466;
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
		
</script>
</body>
</html>
