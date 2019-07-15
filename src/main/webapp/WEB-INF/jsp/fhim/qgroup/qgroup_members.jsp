<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
         
										<form action="qgroup/groupMembers" method="post" name="Form" id="Form">
										<input name="QGROUP_ID" id="QGROUP_ID" type="hidden" value="${pd.QGROUP_ID }" />
										<div style="padding-left:20px;padding-top: 15px;">
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
                                             			<table class="table table-hover">	
													<thead>
														<tr>
															<th style="width: 50px;" id="cts">
									                            <div class="checkbox d-inline">
		                                                            <input type="checkbox" name="fhcheckbox" id="zcheckbox">
		                                                            <label  style="max-height: 12px;" for="zcheckbox" class="cr"></label>
		                                                        </div>
															</th>
															<th style="width:50px;">NO</th>
															<th>成员</th>
															<th style="width:105px;text-align: center;">操作</th>
														</tr>
													</thead>
																			
													<tbody>
													<!-- 开始循环 -->	
													<c:choose>
														<c:when test="${not empty varList}">
															<c:forEach items="${varList}" var="var" varStatus="vs">
																<tr>
																	<td>
																	  	<div class="checkbox d-inline">
			                                                            	<input type="checkbox" id="zcheckbox${vs.index }" name='ids' value="${var.USERNAME}">
			                                                            	<label  style="max-height: 12px;" for="zcheckbox${vs.index }" class="cr"></label>
			                                                        	</div>
																	 </td>
																	<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
																	<td>
																		<img src="${(null == var.PHOTO2 || '' == var.PHOTO2)?'assets/images/user/avatar-2.jpg':var.PHOTO2}" width="30" />&nbsp;
																		${var.NAME} (${var.USERNAME})
																	</td>
																	<td>
																		<a style="height:23px;" class="btn btn-light btn-sm" onclick="del('${pd.QGROUP_ID}','${var.USERNAME}');"><div style="margin-top:-5px;margin-left: -5px;">&nbsp;踢出群</div></a>
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
													</tbody>
												</table>
												<table style="width:100%;margin-top:15px;">
													<tr>
														<td style="vertical-align:top;">
															<a class="btn btn-light btn-sm" onclick="makeAll('确定要把选中的成员踢出群吗?');" >踢出群</a>
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
		
		$(function() {
			//复选框控制全选,全不选 
			$('#zcheckbox').click(function(){
			 if($(this).is(':checked')){
				 $("input[name='ids']").click();
			 }else{
				 $("input[name='ids']").attr("checked", false);
			 }
			});
		})
		
		//踢出群
		function del(QGROUP_ID,USERNAME){
			swal({
            	title: '',
                text: "确定要踢出群吗?",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
	            	$.ajax({
	        			type: "POST",
	        			url: '<%=basePath%>qgroup/kickout',
	        	    	data: {QGROUP_ID:QGROUP_ID,USERNAME:USERNAME,tm:new Date().getTime()},
	        			dataType:'json',
	        			cache: false,
	        			success: function(data){
	        				 if("success" == data.result){
	        					 top.kickoutQgroup(USERNAME,QGROUP_ID); 	//通知被踢出的成员，发送个提醒消息，此函数在  im.jsp 页面
	        					 swal("删除成功", "已经从列表中删除!", "success");
	        				 }
	        				 setTimeout(searchs, 1500);
	        			}
	        		});
                }
            });
		}
		
		//批量操作
		function makeAll(msg){
			swal({
            	title: '',
                text: msg,
                icon: "warning",
                buttons: true,
                dangerMode: true,
                
            }).then((willDelete) => {
                if (willDelete) {
	            	var str = '';
	    			for(var i=0;i < document.getElementsByName('ids').length;i++){
	    				  if(document.getElementsByName('ids')[i].checked){
	    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
	    				  	else str += ',' + document.getElementsByName('ids')[i].value;
	    				  }
	    			}
	    			if(str==''){
	    				$("#cts").tips({
	    					side:2,
	    		            msg:'点这里全选',
	    		            bg:'#AE81FF',
	    		            time:3
	    		        });
	                    swal("", "您没有选择任何内容!", "warning");
	    				return;
	    			}else{
	    				if(msg == '确定要把选中的成员踢出群吗?'){
	    					var QGROUP_ID = "${pd.QGROUP_ID}";
							var arrid = str.split(',');
	    					
							for(var n=0;n<arrid.length;n++){
								var USERNAME = arrid[n];
								top.kickoutQgroup(USERNAME,QGROUP_ID); 	//通知被踢出的成员，发送个提醒消息，此函数在  im.jsp 页面
							
		    					$.ajax({
		    						type: "POST",
		    						url: '<%=basePath%>qgroup/kickout?tm='+new Date().getTime(),
		    				    	data: {QGROUP_ID:QGROUP_ID,USERNAME:USERNAME},
		    						dataType:'json',
		    						cache: false,
		    						success: function(data){
		    							if("success" == data.result){
		    	        					 swal("删除成功", "已经从列表中删除!", "success");
		    	        				 }
		    							if(n == arrid.length)setTimeout(searchs, 1500);
		    						}
		    					});
							}
	    				}
	    			}
                }
            });
		}
		
</script>

</body>
</html>