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
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/fonts/material/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
    <script type="text/javascript">
		//刷新ztree
		function parentReload(){
			var MSG = ${MSG};
			if('change' == MSG){
				parent.location.href="<%=basePath%>menu/listAllMenu?MENU_ID="+${MENU_ID};
			}
		}
		parentReload();
	</script>
    
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
										<div class="card-block table-border-style" style="margin-top: 5px">
                                        	<div class="table-responsive">
									             <table class="table table-hover">
									                 <thead>
										                 <tr>
										                    <th>NO</th>
															<th>名称</th>
															<th>资源路径</th>
															<th>权限标识</th>
															<th>状态</th>
															<th>操作</th>
										                 </tr>
									                 </thead>
									                 <tbody>
									                 <!-- 开始循环 -->	
													 <c:choose>
														<c:when test="${not empty menuList}">
									                 	 <c:forEach items="${menuList}" var="menu" varStatus="vs">
											                 <tr>
											                     <td scope="row">${menu.MENU_ORDER }</td>
											                     <td>${menu.MENU_ICON } <a href="javascript:goSonmenu('${menu.MENU_ID }')">${menu.MENU_NAME }  <i class="feather icon-chevron-down"></i></a> </td>
											                     <td>${menu.MENU_URL == '#'? '&nbsp;&nbsp;&nbsp;&nbsp;(无)': menu.MENU_URL}</td>
											                     <td>${'' == menu.SHIRO_KEY || null == menu.SHIRO_KEY ?'(无)': menu.SHIRO_KEY}</td>
											                     <td>&nbsp;<i class="feather ${menu.MENU_STATE == 1? 'icon-eye': 'icon-eye-off'}"></i></td>
											                     <td>
											                     	<c:if test="${!(null != pd.MENU_ID && pd.MENU_ID != '0')}">
											                     		<shiro:hasPermission name="menu:edit"><a title="编辑图标" onclick="setIcon('${menu.MENU_ID }');" style="cursor:pointer;"><i class="feather icon-image"></i></a></shiro:hasPermission>
											                     	</c:if>
											                     	<shiro:hasPermission name="menu:edit"><a title="修改" onclick="editMenu('${menu.MENU_ID}');" style="cursor:pointer;"><i class="feather icon-edit-2"></i></a></shiro:hasPermission>
											                     	<shiro:hasPermission name="menu:del"><a title="删除" onclick="delMenu('${menu.MENU_NAME }','${menu.MENU_ID }');" style="cursor:pointer;"><i class="feather icon-x"></i></a></shiro:hasPermission>
											                     </td>
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
														<td style="vertical-align:top;">
															<shiro:hasPermission name="menu:add"><a class="btn btn-light btn-sm" onclick="addMenu('${MENU_ID}');">新增</a></shiro:hasPermission>
															<c:if test="${null != pd.MENU_ID && pd.MENU_ID != '0'}">
															<a class="btn btn-light btn-sm" onclick="goSonmenu('${pd.PARENT_ID}');">返回</a>
															</c:if>
														</td>
														<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
	<script type="text/javascript">
		
		//去此ID下子菜单列表
		function goSonmenu(MENU_ID){
			window.location.href="<%=basePath%>menu/list?MENU_ID="+MENU_ID;
		};
		
		//新增菜单
		function addMenu(MENU_ID){
			window.location.href="<%=basePath%>menu/toAdd?MENU_ID="+MENU_ID;
		};
		
		//编辑菜单
		function editMenu(MENU_ID){
			window.location.href="<%=basePath%>menu/toEdit?id="+MENU_ID;
		};
		
		//编辑菜单图标
		function setIcon(MENU_ID){
		   	 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑图标";
			 diag.URL = '<%=basePath%>menu/toEditicon?MENU_ID='+MENU_ID;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					setTimeout("location.reload()",100);
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function delMenu(MENU_NAME,MENU_ID){
			swal({
            	title: '',
                text: '确定要删除 '+MENU_NAME+' 吗?',
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
	            	$.ajax({
	        			type: "POST",
	        			url: '<%=basePath%>menu/delete',
	        	    	data: {MENU_ID:MENU_ID,tm:new Date().getTime()},
	        			dataType:'json',
	        			cache: false,
	        			success: function(data){
	        				 if("success" == data.result){
	        					 swal("删除成功", MENU_NAME+" 已经从列表中删除", "success");
	        					 parent.location.href="<%=basePath%>menu/listAllMenu?MENU_ID="+${MENU_ID};
	        				 }else{
	        					 swal("删除失败!", "请先删除子菜单!", "success");
	        					 swal({
	     		                    title: '删除失败!',
	     		                    text: '请先删除子菜单!',
	     		                    type: 'warning',
	     		                    buttonsStyling: false,
	     		                    showConfirmButton: false,
	     		                    confirmButtonClass: 'btn btn-light',
	     		                    background: 'rgba(0, 0, 0, 0.96)'
	     		                });
	        				 }
	        				 
	        			}
	        		});
                }
            });
		}
		
	</script>
</body>
</html>
