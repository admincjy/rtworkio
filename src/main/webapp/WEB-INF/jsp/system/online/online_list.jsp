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
                                        <div style="padding-left: 15px;padding-top: 15px;">
											<table style="margin-top:10px;">
												<tr style="height:26px;">
													<td style="padding-left: 15px;">在线人数：</td>
													<td>
														<div style="width:39px;" id="onlineCount">0</div>
													</td>
												</tr>
											</table>
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
															<th style="width: 50px;">NO</th>
															<th>用户名</th>
															<th style="width: 86px;text-align: center;">操作</th>
														</tr>
													</thead>
									                <tbody id="userlist"></tbody>
                                                </table>
                                                
                                                <table style="width:100%;margin-top:15px;">
													<tr>
														<td style="vertical-align:top;">
															<a class="btn btn-light btn-sm" onclick="makeAll('确定要把这些用户强制下线吗?');" title="批量强制下线" >强制下线</a>
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
	//初始化
	$(function(){
		online();
		//复选框控制全选,全不选 
		$('#zcheckbox').click(function(){
		 if($(this).is(':checked')){
			 $("input[name='ids']").click();
		 }else{
			 $("input[name='ids']").attr("checked", false);
		 }
		});
	});
	
	var websocketonline;//websocke对象
	var userCount = 0;	//在线总数
	function online(){
		if (window.WebSocket) {
			websocketonline = new WebSocket(encodeURI('ws://'+top.onlineAdress)); //oladress在main.jsp页面定义
			websocketonline.onopen = function() {
				websocketonline.send('[ ]fhadmin');//连接成功
			};
			websocketonline.onerror = function() {
				//连接失败
			};
			websocketonline.onclose = function() {
				//连接断开
			};
			//消息接收
			websocketonline.onmessage = function(message) {
				var message = JSON.parse(message.data);
				if (message.type == 'count') {
					userCount = message.msg;
				}else if(message.type == 'userlist'){
					$("#userlist").html('');
					 $.each(message.list, function(i, user){
						 $("#userlist").append(
							'<tr>'+	 
								 '<td>'+
									'<div class="checkbox d-inline">'+
                                		'<input type="checkbox" id="zcheckbox'+i+'" name="ids" value="'+user+'">'+
                                		'<label  style="max-height: 12px;" for="zcheckbox'+i+'" class="cr"></label>'+
                            		'</div>'+
								'</td>'+
								'<td>'+(i+1)+'</td>'+
								'<td><a onclick="editUser(\''+user+'\')" style="cursor:pointer;">'+user+'</a></td>'+
								'<td>'+
									'<a style="height:23px;" class="btn btn-light btn-sm" onclick="goOutTUser(\''+user+'\')"><div style="margin-top:-5px;margin-left: -5px;">&nbsp;强制下线</div></a>'+
								'</td>'+
							'</tr>'
						 );
						 userCount = i+1;
					 });
					 $("#onlineCount").html(userCount);
				}else if(message.type == 'addUser'){
					 $("#userlist").append(
						'<tr>'+	 
							 '<td>'+
								'<div class="checkbox d-inline">'+
                        			'<input type="checkbox" id="zcheckbox'+message.user+'" name="ids" value="'+message.user+'">'+
                        			'<label  style="max-height: 12px;" for="zcheckbox'+message.user+'" class="cr"></label>'+
                    			'</div>'+
							'</td>'+
							'<td>'+(userCount+1)+'</td>'+
							'<td><a onclick="editUser(\''+message.user+'\')" style="cursor:pointer;">'+message.user+'</a></td>'+
							'<td>'+
								'<a style="height:23px;"  class="btn btn-light btn-sm" onclick="goOutTUser(\''+message.user+'\')"><div style="margin-top:-5px;margin-left: -5px;">&nbsp;强制下线</div></a>'+
							'</td>'+
						'</tr>'
					);
					 userCount = userCount+1;
					 $("#onlineCount").html(userCount);
				}
			};
		}
	}
	
	//强制某用户下线
	function goOutUser(theuser){
		websocketonline.send('[goOut]'+theuser);
	}
	
	//强制某用户下线
	function goOutTUser(theuser){
		theuser = theuser.replace("mobile-","");
		if('admin' == theuser){
			swal("操作失败!", "不能强制下线admin用户!", "warning");
			return;
		}
		swal({
			title: '',
            text: "确定要强制["+theuser+"]下线吗?",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        })
        .then((willDelete) => {
            if (willDelete) {
            	goOutUser(theuser);
            }
        });
	}
	
	//查看修改用户
	function editUser(USERNAME){
		USERNAME = USERNAME.replace("mobile-","");
		if('admin' == USERNAME){
			swal("禁止查看!", "不能查看修改admin用户!", "warning");
			return;
		}
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="资料";
		 diag.URL = '<%=basePath%>user/goEditUfromOnline?USERNAME='+USERNAME;
		 diag.Width = 600;
		 diag.Height = 496;
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
				for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if('admin' != document.getElementsByName('ids')[i].value){
							  if(str=='') str += document.getElementsByName('ids')[i].value;
							  else str += ',' + document.getElementsByName('ids')[i].value;
						  }else{
							  document.getElementsByName('ids')[i].checked  = false;
							  $("#cts").tips({
									side:3,
						            msg:'admin用户不能强制下线',
						            bg:'#AE81FF',
						            time:5
						        });
						  }
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
					var arField = str.split(',');
					for(var i=0;i<arField.length;i++){
						websocketonline.send('[goOut]'+arField[i]);
					}
				}
            }
        });
	}
		
</script>
</body>
</html>