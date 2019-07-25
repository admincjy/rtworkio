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
    <link rel="stylesheet" href="assets/fonts/material/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
    <!-- 日期插件 -->
    <link rel="stylesheet" href="assets/plugins/material-datetimepicker/css/bootstrap-material-datetimepicker.css">
<style type="text/css">
			th{
				background:#455661;
				color: white;
				
			}
		th,td {
				text-align: center;
				word-break: break-all;
				word-wrap: normal;
				
		}
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
										<form action="fhsms/list" method="post" name="Form" id="Form">
										<input type="hidden" name="TYPE" value="${pd.TYPE}" />
										<div style="padding-left: 8px;padding-top: 8px;">
											<table >
												<tr>
													<td>
								                        <div class="input-group input-group-sm mb-3">
                                                        	<input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${pd.KEYWORDS }" placeholder="这里输入关键词" />
                                                    	</div>
													</td>
													<td style="padding-left:2px;">
								                        <div class="input-group input-group-sm mb-3">
								                        	<input type="text" class="form-control date" name="STRARTTIME" id="STRARTTIME"  value="${pd.STRARTTIME}" readonly="readonly" placeholder="开始日期" title="开始日期" style="width:93px;">
								                        </div>
													</td>
													<td style="padding-left:2px;">
								                        <div class="input-group input-group-sm mb-3">
								                        	<input type="text" class="form-control date" name="ENDTIME" id="ENDTIME"  value="${pd.ENDTIME}" readonly="readonly" placeholder="结束日期" title="结束日期" style="width:93px;">
								                        </div>
													</td>
													<td style="vertical-align:top;padding-left:2px;margin-top: 5px;">
														<select name="STATUS" id="STATUS" style="height: 30px;width:43px;padding-left:6px;border: 1px solid #CED4DA;transparent;appearance:none;-moz-appearance:none;-webkit-appearance:none;" title="状态">
															<option value="">全部</option>
															<option value="1" <c:if test="${pd.STATUS == '1' }">selected</c:if>>已读</option>
															<option value="2" <c:if test="${pd.STATUS == '2' }">selected</c:if>>未读</option>
														</select>
													</td>
													<td style="vertical-align:top;padding-left:5px;">
														<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索"><i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i></a>
													</td>							
													<td style="padding-left:20px;vertical-align:top;"><a href="fhsms/list?TYPE=1" class="btn btn-${pd.TYPE != '2'?'secondary':'light'} btn-sm">收信箱</a></td>
													<td style="padding-left:0px;vertical-align:top;"><a href="fhsms/list?TYPE=2" class="btn btn-${pd.TYPE == '2'?'secondary':'light'} btn-sm">发信箱</a></td>
												</tr>
											</table>
										</div>
										<!-- 检索  -->
									
										<div class="card-block table-border-style" style="margin-top: -15px">
                                       					<div class="table-responsive">
												<table class="table table-hover" >
													<thead>
														<tr>
															<th style="width: 50px;" id="cts">
									                            <div class="checkbox d-inline">
		                                                            <input type="checkbox" name="fhcheckbox" id="zcheckbox">
		                                                            <label  style="max-height: 12px;" for="zcheckbox" class="cr"></label>
		                                                        </div>
															</th>
															<th style="width:50px;">NO</th>
															<th>发信人</th>
															<th>发信时间</th>
															<th>内容</th>
															<!--<th>状态</th>-->
															<th>操作</th>
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
		                                                            		<input type="checkbox" id="zcheckbox${vs.index }" name='ids' title="${var.TO_USERNAME=='系统消息'?'admin':var.TO_USERNAME}" value="${var.FHSMS_ID}" >
		                                                            		<label  style="max-height: 12px;" for="zcheckbox${vs.index }" class="cr"></label>
		                                                        		</div>
																	 </td>
																	<td style="width: 30px;" scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
																	<c:if test="${pd.TYPE != '2' }">
																	<td ><a onclick="viewUser('${var.TO_USERNAME}')" style="cursor:pointer;">${var.TO_USERNAME}</a></td>
																	<!--<td><a onclick="viewUser('${var.FROM_USERNAME}')" style="cursor:pointer;">${var.FROM_USERNAME}</a></td>-->
																	</c:if>
																	<c:if test="${pd.TYPE == '2' }">
																	<td > <a onclick="viewUser('${var.FROM_USERNAME}')" style="cursor:pointer;">${var.FROM_USERNAME}</a></td>
																	<!--<td><a onclick="viewUser('${var.TO_USERNAME}')" style="cursor:pointer;">${var.TO_USERNAME}</a></td>-->
																	</c:if>
																	<td >${var.SEND_TIME}</td>
																	<!--<td id="STATUS${vs.index+1}"><c:if test="${var.STATUS == '2' }"><span class="badge badge-warning">未读</span></c:if><c:if test="${var.STATUS == '1' }"><span class="badge badge-success">已读</span></c:if></td>-->
																	<td style="width: 300px;"> 
																	<div id="STATUS${vs.index+1}" style="cursor:pointer;height:20px;overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width:300px" onclick="viewx('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');" >
																	<c:if test="${var.STATUS == '2' }">
																	
																	<span style="color: #888888;"> ${var.CONTENT}</span></c:if>
																	<c:if test="${var.STATUS == '1' }">
																		<span style="color: #B5B7B7;">${var.CONTENT}</span>
																	</c:if>
																	
																	</div>
																	</td>
										                                <td>
																		<!--<a title="查看" onclick="viewx('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');" style="cursor:pointer;">
																			<i class="feather icon-search"></i>
																		</a>-->
																		<shiro:hasPermission name="fhSms">
																		<a title='发送站内信' onclick="sendFhsms('${var.TO_USERNAME=='系统消息'?'admin':var.TO_USERNAME}');" style="cursor:pointer;">
																			<i class="mdi mdi-email-plus-outline"></i>
																		</a>
																		</shiro:hasPermission>
																		<a title="删除" onclick="del('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');" style="cursor:pointer;">
																			<i class="feather icon-x"></i>
																		</a>
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
												
												<!--<table style="width:100%;margin-top:15px;">
													<tr>
														<td style="vertical-align:top;">-->
															<shiro:hasPermission name="fhSms"><a title="批量发送站内信" class="btn btn-light btn-sm" onclick="makeAll('确定要发站内信吗?');">发信</a></shiro:hasPermission>
															<a class="btn btn-light btn-sm" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" >删除</a>
														<!--</td>-->
														<!--<td style="vertical-align:top;">--><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div><!--</td>-->
													<!--</tr>
												</table>-->
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

<!-- 日期插件-->
<script src="assets/js/pages/moment-with-locales.min.js"></script>
<script src="assets/plugins/material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>
<script src="assets/js/pages/form-picker-custom.js"></script>

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
		
		//发站内信
		function sendFhsms(USERNAME){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="站内信";
			 diag.URL = '<%=basePath%>fhsms/goAdd?USERNAME='+USERNAME;
			 diag.Width = 700;
			 diag.Height = 530;
			 diag.Modal = false;			//有无遮罩窗口
			 diag.CancelEvent = function(){ //关闭事件
				 setTimeout("self.location=self.location",100);
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(ztid,STATUS,type,Id,SANME_ID){
			swal({
            	title: '',
                text: "确定要删除 吗?",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
	            	if(type == "1" && STATUS == '2' && $("#"+ztid).html() == '<span class="badge badge-warning">未读</span>'){
						top.readFhsms();//读取站内信时减少未读总数  <!-- readFhsms()函数在 WebRoot\assets\js\index.js中 -->
					}
	            	$.ajax({
	        			type: "POST",
	        			url: '<%=basePath%>fhsms/delete',
	        	    	data: {FHSMS_ID:Id,tm:new Date().getTime()},
	        			dataType:'json',
	        			cache: false,
	        			success: function(data){
	        				 if("success" == data.result){
	        					 swal("删除成功", "已经从列表中删除", "success");
	        				 }
	        				 setTimeout(searchs, 1500);
	        			}
	        		});
                }
            });
		}
		
		//查看信件：
//		viewx('STATUS${vs.index+1}','${var.STATUS}','${pd.TYPE == '2'?'2':'1' }','${var.FHSMS_ID}','${var.SANME_ID}');" 
		function viewx(ztid,STATUS,type,Id,SANME_ID){
			if(type == "1" && STATUS == '2' && $("#"+ztid).html() == '<span class="badge badge-warning">未读</span>'){
				$("#"+ztid).html('<span class="badge badge-success">已读</span>');
				top.readFhsms();//读取站内信时减少未读总数  <!-- readFhsms()函数在 WebRoot\assets\js\index.js中 -->
			}
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="站内信";
			 diag.URL = '<%=basePath%>fhsms/goView?FHSMS_ID='+Id+'&TYPE='+type+'&SANME_ID='+SANME_ID+'&STATUS='+STATUS;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
		     diag.Modal = false;			//有无遮罩窗口
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
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
	            	var username = '';
	    			for(var i=0;i < document.getElementsByName('ids').length;i++){
	    				  if(document.getElementsByName('ids')[i].checked){
	    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
	    				  	else str += ',' + document.getElementsByName('ids')[i].value;
	    				  	if(username=='') username += document.getElementsByName('ids')[i].title;
						  	else username += ';' + document.getElementsByName('ids')[i].title;
	    				  }
	    			}
	    			if(str=='' && msg != '确定要发站内信吗?'){
	    				$("#cts").tips({
	    					side:2,
	    		            msg:'点这里全选',
	    		            bg:'#AE81FF',
	    		            time:3
	    		        });
	                    swal("", "您没有选择任何内容!", "warning");
	    				return;
	    			}else{
						if(msg == '确定要删除选中的数据吗?'){
							$.ajax({
								type: "POST",
								url: '<%=basePath%>fhsms/deleteAll?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								cache: false,
								success: function(data){
									 if("success" == data.result){
										 top.getFhsmsCount();//更新未读站内信
	    	        					 swal("删除成功", "已经从列表中删除", "success");
	    	        				 }
	    	        				 setTimeout(searchs, 1500);
								}
							});
						}else if(msg == '确定要发站内信吗?'){
							sendFhsms(username);
						}
	    			}
                }
            });
		}
		
		//查看用户
		function viewUser(USERNAME){
			if('admin' == USERNAME){
				swal("禁止查看!", "不能查看admin用户!", "warning");
				return;
			}
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>user/view?USERNAME='+USERNAME;
			 diag.Width = 600;
			 diag.Height = 319;
			 diag.Modal = false;			//有无遮罩窗口
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
</script>

</body>
</html>