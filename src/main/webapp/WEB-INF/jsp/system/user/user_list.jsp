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
    
    <!-- 日期插件 -->
    <link rel="stylesheet" href="assets/plugins/material-datetimepicker/css/bootstrap-material-datetimepicker.css">
    
    <!-- select插件 -->
    <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="assets/plugins/multi-select/css/multi-select.css">

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
         
								          <form action="user/listUsers" method="post" name="Form" id="Form">
											<!-- 检索条件  -->
											<div style="padding-left: 15px;padding-top: 15px;">
											<table>
												<tr>
													<td>
								                        <div class="input-group input-group-sm mb-3">
                                                        	<input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${pd.KEYWORDS }" placeholder="这里输入关键词" />
                                                    	</div>
													</td>
													<td style="padding-left:2px;">
								                        <div class="input-group input-group-sm mb-3">
								                        	<input type="text" class="form-control date" name="STRARTTIME" id="STRARTTIME"  value="${pd.STRARTTIME}" readonly="readonly" placeholder="开始日期" title="最近登录开始时间" style="width:93px;">
								                        </div>
													</td>
													<td style="padding-left:2px;">
								                        <div class="input-group input-group-sm mb-3">
								                        	<input type="text" class="form-control date" name="ENDTIME" id="ENDTIME"  value="${pd.ENDTIME}" readonly="readonly" placeholder="结束日期" title="最近登录截止时间" style="width:93px;">
								                        </div>
													</td>
													<td style="vertical-align:top;padding-left:2px;width: 100px;">
								                        <select class="js-example-placeholder-multiple col-sm-12" name="ROLE_ID" id="ROLE_ID" data-placeholder="请选择角色" >
								                        	<option value=""></option>
	                                                        <c:forEach items="${roleList}" var="role">
															<option value="${role.ROLE_ID }" <c:if test="${ROLE_ID==role.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
															</c:forEach>
	                                                    </select>
													</td>
													<td style="vertical-align:top;padding-left:2px;width: 100px;">
					                                    <select class="js-example-placeholder-multiple col-sm-12" name="STATE" id="STATE" data-placeholder="请选择角色" >
								                        </select>
													</td>
													<td style="vertical-align:top;padding-left:5px;">
															<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索">
																<i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i>
															</a>
														<shiro:hasPermission name="toExcel">
															<a class="btn btn-light btn-sm" onclick="toExcel();" style="width: 23px;height:30px;margin-top:1px;margin-left: -9px;" title="导出到excel表格">
																<i style="margin-top:-3px;margin-left: -6px;" class="mdi mdi-cloud-download"></i>
															</a>
														</shiro:hasPermission>
														<shiro:hasPermission name="fromExcel">
															<a class="btn btn-light btn-sm" onclick="fromExcel();" style="width: 23px;height:30px;margin-top:1px;margin-left: -9px;" title="从EXCEL导入到系统">
																<i style="margin-top:-3px;margin-left: -6px;" class="mdi mdi-cloud-upload"></i>
															</a>
														</shiro:hasPermission>
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
															<th style="width: 50px;" id="cts">
									                            <div class="checkbox d-inline">
		                                                            <input type="checkbox" name="fhcheckbox" id="zcheckbox">
		                                                            <label  style="max-height: 12px;" for="zcheckbox" class="cr"></label>
		                                                        </div>
															</th>
										                    <th>NO</th>
															<th>编号</th>
															<th>用户名</th>
															<th>姓名</th>
															<th>角色</th>
															<th>邮箱</th>
															<th>最近登录</th>
															<th>电话号码</th>
															<th>员工状态</th>
															<th>操作</th>
										                 </tr>
									                 </thead>
									                 <tbody>
									                 <!-- 开始循环 -->	
													 <c:choose>
														<c:when test="${not empty userList}">
									                 	 <c:forEach items="${userList}" var="user" varStatus="vs">
											                 <tr>
																 <td>
																  	<div class="checkbox d-inline">
		                                                            	<input type="checkbox" id="zcheckbox${vs.index }" name='ids' value="${user.USER_ID }" alt="${user.EMAIL }" title="${user.USERNAME }">
		                                                            	<label  style="max-height: 12px;" for="zcheckbox${vs.index }" class="cr"></label>
		                                                        	</div>
																 </td>
											                     <td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											                     <td>${user.NUMBER }</td>
											                     <td>${user.USERNAME }</td>
											                     <td>${user.NAME }</td>
											                     <td>${user.ROLE_NAME }</td>
											                     <td>
											                    	<a title="发送电子邮件" style="text-decoration:none;cursor:pointer;" <shiro:hasPermission name="email">onclick="sendEmail('${user.EMAIL }');"</shiro:hasPermission>>${user.EMAIL }&nbsp;<i class="mdi mdi-email-plus"></i></a>
											                     </td>
											                     <td>${user.LAST_LOGIN }</td>
											                     <td>${user.PHONE }</td>
											                     <td>${user.STATE }</td>
											                     <td>
									                     			<shiro:hasPermission name="fhSms">
																		<a title='发送站内信' onclick="sendFhsms('${user.USERNAME}');" style="cursor:pointer;"><i class="mdi mdi-email-plus-outline"></i></a>
																	</shiro:hasPermission>
											                     	<shiro:hasPermission name="user:edit">
											                     		<a title="修改" onclick="editUser('${user.USER_ID}');" style="cursor:pointer;"><i class="feather icon-edit-2"></i></a>
											                     	</shiro:hasPermission>
											                     	<shiro:hasPermission name="user:del">
											                     		<a title="删除" onclick="delUser('${user.USER_ID }','${user.NAME }');" style="cursor:pointer;"><i class="feather icon-x"></i></a>
											                     	</shiro:hasPermission>
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
																<shiro:hasPermission name="user:add"><a class="btn btn-light btn-sm" onclick="add();">新增</a></shiro:hasPermission>
										                 		<shiro:hasPermission name="user:del"><a class="btn btn-light btn-sm" onclick="makeAll('确定要删除选中的用户吗?');" style="margin-left:-9px;">删除</a></shiro:hasPermission>
										                 		<shiro:hasPermission name="email"><a class="btn btn-light btn-sm" title="批量发送站内信" onclick="makeAll('确定要给选中的用户发送邮件?');" style="margin-left:-9px;">发邮件</a></shiro:hasPermission>
										                 		<shiro:hasPermission name="fhSms"><a class="btn btn-light btn-sm" title="批量发送站内信" onclick="makeAll('确定要给选中的用户发送站内信吗?');" style="margin-left:-9px;">发站内信</a></shiro:hasPermission>
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

<!-- 日期插件 -->
<script src="assets/js/pages/moment-with-locales.min.js"></script>
<script src="assets/plugins/material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>
<script src="assets/js/pages/form-picker-custom.js"></script>

<!-- select插件 -->
<script src="assets/plugins/select2/js/select2.full.min.js"></script>
<script src="assets/plugins/multi-select/js/jquery.quicksearch.js"></script>
<script src="assets/plugins/multi-select/js/jquery.multi-select.js"></script>
<script src="assets/js/pages/form-select-custom.js"></script>

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
	<script type="text/javascript">
		//初始选择项,调用数据字典
		$(function() {
			//流程分类
			$.ajax({
				type: "POST",
				url: '<%=basePath%>dictionaries/getLevels?tm='+new Date().getTime(),
		    	data: {DICTIONARIES_ID:'1a8c426bc62e4bcea47916aa3d82afac'},//act001 为工作流分类
				dataType:'json',
				cache: false,
				success: function(data){
					$("#STATE").html('<option value="" >请选择员工状态</option>');
					 $.each(data.list, function(i, dvar){
							$("#STATE").append("<option value="+dvar.BIANMA+">"+dvar.NAME+"</option>");
					 });
				}
			});
		});
		
		//检索
		function searchs(){
			console.log(666,$("#STATE").val())
			$("#Form").submit();
		}
		
		//新增
		function add(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>user/goAddUser';
			 diag.Width = 600;
			 diag.Height = 496;
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
		
		//删除
		function delUser(USER_ID,NAME){
			swal({
               	title: '',
                text: '确定要删除 '+NAME+' 吗?',
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
	            	$.ajax({
	        			type: "POST",
	        			url: '<%=basePath%>user/deleteUser',
	        	    	data: {USER_ID:USER_ID,tm:new Date().getTime()},
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
	            	var emstr = '';
	            	var username = '';
	    			for(var i=0;i < document.getElementsByName('ids').length;i++){
	    				  if(document.getElementsByName('ids')[i].checked){
	    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
	    				  	else str += ',' + document.getElementsByName('ids')[i].value;
	    				  	
	    				  	if(emstr=='') emstr += document.getElementsByName('ids')[i].alt;
	    				  	else emstr += ';' + document.getElementsByName('ids')[i].alt;
	    				  	
	    				  	if(username=='') username += document.getElementsByName('ids')[i].title;
	    				  	else username += ';' + document.getElementsByName('ids')[i].title;
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
	    				if(msg == '确定要删除选中的用户吗?'){
	    					$.ajax({
	    						type: "POST",
	    						url: '<%=basePath%>user/deleteAllUser?tm='+new Date().getTime(),
	    				    	data: {USER_IDS:str},
	    						dataType:'json',
	    						cache: false,
	    						success: function(data){
	    							if("success" == data.result){
	    								if("success" == data.result){
	    		        					 swal("删除成功", "已经从列表中删除!", "success");
	    		        				 }
	    		        				 setTimeout(searchs, 1500);
	    							}
	    						}
	    					});
	    				}else if(msg == '确定要给选中的用户发送站内信吗?'){
	    					sendFhsms(username);
	    				}else if(msg == '确定要给选中的用户发送邮件?'){
	    					sendEmail(emstr);
	    				}
	    			}
                }
            });
		}
		
		//修改
		function editUser(USER_ID){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>user/goEditUser?USER_ID='+USER_ID;
			 diag.Width = 600;
			 diag.Height = 496;
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
		
		//导出excel
		function toExcel(){
			var KEYWORDS = $("#KEYWORDS").val();
			var STRARTTIME = $("#STRARTTIME").val();
			var ENDTIME = $("#ENDTIME").val();
			var ROLE_ID = $("#ROLE_ID").val();
			window.location.href='<%=basePath%>user/excel?KEYWORDS='+KEYWORDS+'&STRARTTIME='+STRARTTIME+'&ENDTIME='+ENDTIME+'&ROLE_ID='+ROLE_ID;
		}

		//打开上传excel页面
		function fromExcel(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="从EXCEL导入到系统";
			 diag.URL = '<%=basePath%>user/goUploadExcel';
			 diag.Width = 600;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}	
		
		//发站内信
		function sendFhsms(USERNAME){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="站内信";
			 diag.URL = '<%=basePath%>fhsms/goAdd?USERNAME='+USERNAME;
			 diag.Width = 700;
			 diag.Height = 530;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送电子邮件";
			 diag.URL = '<%=basePath%>head/goSendEmail?EMAIL='+EMAIL;
			 diag.Width = 1000;
			 diag.Height = 700;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
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
		
	</script>
</body>
</html>
