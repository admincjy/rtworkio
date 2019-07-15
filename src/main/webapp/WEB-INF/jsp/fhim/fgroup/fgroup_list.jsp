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
    <meta name="author" content=" " />

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
         
										<form action="fgroup/list" method="post" name="Form" id="Form">
										<div class="card-block table-border-style" style="margin-top: -5px">
                                            <div class="table-responsive">
                                                <table class="table table-hover">	
													<thead>
														<tr>
															<th style="width: 50px;">NO</th>
															<th>组名</th>
															<th style="width: 100px;">操作</th>
														</tr>
													</thead>
																			
													<tbody>
													<!-- 开始循环 -->	
													<c:choose>
														<c:when test="${not empty varList}">
															<c:forEach items="${varList}" var="var" varStatus="vs">
																<tr>
																	<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
																	<td>${var.NAME}</td>
																	<td>
																		<shiro:hasPermission name="fgroup:edit"><a title="修改" onclick="edit('${var.FGROUP_ID}');" style="cursor:pointer;"><i class="feather icon-edit-2"></i></a></shiro:hasPermission>
									                    				<shiro:hasPermission name="fgroup:del"><a title="删除" onclick="del('${var.FGROUP_ID }');" style="cursor:pointer;"><i class="feather icon-x"></i></a></shiro:hasPermission>
																	</td>
																</tr>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<tr class="main_info">
																<td colspan="100" class="center" >没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
													</tbody>
												</table>
												<table style="width:100%;margin-top:15px;">
													<tr>
														<td style="vertical-align:top;">
															<shiro:hasPermission name="fgroup:add"><a class="btn btn-light btn-sm" onclick="add();">新增</a></shiro:hasPermission>
														</td>
														<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
													</tr>
												</table>
											</div>
                                        </div>
										</form>
			
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
		//检索
		function searchs(){
			$("#Form").submit();
		}
		
		//新增
		function add(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>fgroup/goAdd';
			 diag.Width = 600;
			 diag.Height = 141;
			 diag.Modal = true;				//有无遮罩窗口
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			swal({
				title: '',
	            text: "确定要删除 吗?",
	            icon: "warning",
	            buttons: true,
	            dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
	            	$.ajax({
	        			type: "POST",
	        			url: '<%=basePath%>fgroup/delete',
	        	    	data: {FGROUP_ID:Id,tm:new Date().getTime()},
	        			dataType:'json',
	        			cache: false,
	        			success: function(data){
	        				 if("success" == data.result){
	        					 swal("删除成功", "已经从列表中删除!", "success");
	        				 }
	        				 setTimeout(searchs, 1500);
	        			}
	        		});
                }
            });
		}
		
		//修改
		function edit(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>fgroup/goEdit?FGROUP_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 141;
			 diag.Modal = true;				//有无遮罩窗口
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
</script>

</body>
</html>