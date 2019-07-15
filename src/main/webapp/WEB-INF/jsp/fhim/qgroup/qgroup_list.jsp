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
    <link rel="stylesheet" href="assets/css/style.css">
    
    <style type="text/css">
		img{width:39px; height:39px; border-radius:50%;-webkit-border-radius:50%;-moz-border-radius:50%;}
	</style>

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
							
									<!-- 检索  -->
									<form action="qgroup/list" method="post" name="Form" id="Form">
									<div style="padding-left: 15px;padding-top: 15px;">
									<!-- 检索条件  -->
									<table>
										<tr>
											<td>
						                        <div class="input-group input-group-sm mb-3">
                                                      	<input class="form-control" type="text" id="keywords" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
                                                  	</div>
											</td>
											<td style="vertical-align:top;padding-left:5px;">
												<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索"><i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i></a>
											</td>
										</tr>
									</table>
									<!-- 检索  -->
                                    </div>
									<div class="card-block table-border-style" style="margin-top: -15px">
                                    	<div class="table-responsive">
											<table class="table table-hover mb-0">	
												<thead>
													<tr>
														<th style="width:50px;">NO</th>
														<th>群</th>
														<th>群主</th>
														<th>创建时间</th>
														<th style="width:379px;text-align: center;">操作</th>
													</tr>
												</thead>
																		
												<tbody>
												<!-- 开始循环 -->	
												<c:choose>
													<c:when test="${not empty varList}">
														<c:forEach items="${varList}" var="var" varStatus="vs">
															<tr>
																<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
																<td>
																	<img src="${var.PHOTO}" width="39" />&nbsp;
																	${var.NAME}
																</td>
																<td>${var.USERNAME==pd.USERNAME?"(我创建的)":var.USERNAME}</td>
																<td>${var.CTIME}</td>
																<td>
																	<shiro:hasPermission name="qgroup:edit">
																		<c:if test="${var.USERNAME==pd.USERNAME }">
																		<a style="height:23px;" class="btn btn-light btn-sm" onclick="groupMembers('${var.QGROUP_ID}');"><div style="margin-top:-5px;margin-left: -5px;">管理群成员</div></a>
																		<a style="height:23px;" class="btn btn-light btn-sm" onclick="hismsg('${var.QGROUP_ID}');"><div style="margin-top:-5px;margin-left: -5px;">管理聊天记录</div></a>
																		</c:if>
																	</shiro:hasPermission>
																	<shiro:hasPermission name="qgroup:edit">
																		<c:if test="${var.USERNAME==pd.USERNAME }">
																		<a style="height:23px;" class="btn btn-light btn-sm" title="编辑" onclick="edit('${var.QGROUP_ID}');"><div style="margin-top:-5px;margin-left: -5px;">编辑</div></a>
																		</c:if>
																	</shiro:hasPermission>
																	<shiro:hasPermission name="qgroup:del">
																	<c:if test="${var.USERNAME==pd.USERNAME }">
																	<a style="height:23px;" class="btn btn-light btn-sm" onclick="del('${var.QGROUP_ID}','${var.PHOTO}','del');"><div style="margin-top:-5px;margin-left: -5px;">解散群</div></a>
																	</c:if>
																	<c:if test="${var.USERNAME!=pd.USERNAME }">
																	<a style="height:23px;" class="btn btn-light btn-sm" onclick="del('${var.QGROUP_ID}','${var.PHOTO}','out');"><div style="margin-top:-5px;margin-left: -5px;">退出群</div></a>
																	</c:if>
																	</shiro:hasPermission>
																</td>
															</tr>
														
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr>
															<td colspan="100" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
											
											<table style="width:100%;margin-top:15px;">
												<tr>
													<td style="vertical-align:top;">
														<shiro:hasPermission name="qgroup:add"><a class="btn btn-light btn-sm" onclick="add();">新增</a></shiro:hasPermission>
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
		
		//群成员
		function groupMembers(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="群成员管理";
			 diag.URL = '<%=basePath%>qgroup/groupMembers?QGROUP_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//聊天记录
		function hismsg(Id){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="群聊天记录管理";
			 diag.URL = '<%=basePath%>hismsg/list?id='+Id+'&type=group';
			 diag.Width = 1000;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//新增
		function add(){
			var QID = "${QID }";
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>qgroup/goAddFromlist?QID='+QID;
			 diag.Width = 596;
			 diag.Height = 175;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 $.ajax({
							type: "POST",
							url: 'qgroup/getThisQgroup',	 //获取此群的信息
						   	data: {QGROUP_ID:QID,tm:new Date().getTime()},
							dataType:'json',
							cache: false,
							success: function(data){
								top.addQgroup(QID,data.avatar,data.groupname);	//把群添加到群组栏里面	此方法在im.jsp页面中
								searchs();
							}
						});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//解散or退出群
		function del(Id,PATH,TYPE){
			var msg = "";
			if('del'==TYPE){
				msg = "确定要解散此群吗?";
			}else{
				msg = "确定要退出此群吗?";
			}
			swal({
            	title: '',
                text: msg,
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
	            	top.removeQgroup(Id,TYPE); 	//从自己群组栏移除  此方法在im.jsp页面中
	            	$.ajax({
	        			type: "POST",
	        			url: '<%=basePath%>qgroup/delete',
	        	    	data: {QGROUP_ID:Id,PATH:PATH,TYPE:TYPE,tm:new Date().getTime()},
	        			dataType:'json',
	        			cache: false,
	        			success: function(data){
	        				 if("success" == data.result){
	        					 swal("", "操作成功", "success");
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
			 diag.URL = '<%=basePath%>qgroup/goEdit?QGROUP_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 300;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
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