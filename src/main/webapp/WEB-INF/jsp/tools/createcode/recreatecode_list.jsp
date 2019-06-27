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
			                           
										<div style="padding-left: 25px;padding-top: 15px;">
											<div>
												<h6 class="card-title" style="padding-left: 5px;">连接数据库</h6>
												<table>
													<tr id="fhdb">
														<td>
															<div class="input-group input-group-sm mb-3">
							                                    <div class="input-group-prepend">
							                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">数据库</span></span>
							                                    </div>
							                                    <select name="dbtype" id="dbtype" data-placeholder="请选择数据库" onchange="selectDb(this.value)"  style="padding-left:5px;vertical-align:top;width: 200px;border: 1px solid #CED4DA;transparent;appearance:none;-moz-appearance:none;-webkit-appearance:none;">
																	<option value="mysql">Mysql</option>
																	<option value="oracle">Oracle</option>
																	<option value="sqlserver">Sqlserver</option>
																</select>
							                                 </div>
							                                 <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
							                                    <div class="input-group-prepend">
							                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">用户名</span></span>
							                                    </div>
							                                    <input class="form-control"  type="text" name="username" id="username" value="root"  maxlength="32" placeholder="输入用户名" title="用户名"/>
							                                </div>
														</td>
														<td>
															 <div class="input-group input-group-sm mb-3">
							                                    <div class="input-group-prepend">
							                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">地址</span></span>
							                                    </div>
							                                    <input type="text" class="form-control" name="dbAddress" id="dbAddress" value="localhost" maxlength="200" placeholder="数据库连接地址" title="数据库连接地址"/>
							                                 </div>
							                                 <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
							                                    <div class="input-group-prepend">
							                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">密码</span></span>
							                                    </div>
							                                    <input class="form-control" type="password" name="password" id="password"  maxlength="32" placeholder="输入密码" title="密码"/>
							                                </div>
														</td>
														<td>
															<div class="input-group input-group-sm mb-3">
							                                    <div class="input-group-prepend">
							                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">端口</span></span>
							                                    </div>
							                                    <input class="form-control"  type="number" name="dbport" id="dbport" value="3306"  maxlength="10" placeholder="输入端口" title="端口"/>
							                                </div>
							                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
							                                    <div class="input-group-prepend">
							                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">库名</span></span>
							                                    </div>
							                                    <input class="form-control" type="text" name="databaseName" id="databaseName"  maxlength="32" placeholder="输入数据库名" title="数据库名"/>
							                                </div>
														</td>
														<td style="padding-left: 10px;">
															<button type="button" class="btn btn-dark btn-sm" onclick="connDb();" data-toggle="tooltip" data-original-title="btn btn-dark">连接</button>
														</td>
													</tr>
												</table>
											</div>
										</div>
										<div class="card-block table-border-style" style="margin-top: -15px">
                                            <div class="table-responsive">
                                                <table class="table table-hover">
												<thead>
													<tr>
														<th class="center" style="width:50px;">NO</th>
														<th style="width:220px;">表名</th>
														<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;操作</th>
														<th style="width:50px;">NO</th>
														<th style="width:220px;">表名</th>
														<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;操作</th>
													</tr>
												</thead>
																	
												<tbody id="valuelist">
													<tr class='center'>
														<td colspan="10">数据显示区</td>
													</tr>
												</tbody>
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
		
		//选择数据库
		function selectDb(value){
			$("#dbAddress").val('localhost');	//连接地址
			if("mysql" == value){
				$("#dbport").val(3306);				//端口
				$("#username").val('root');			//用户名
				$("#databaseName").val('');			//库名
			}else if("oracle" == value){
				$("#dbport").val(1521);				//端口
				$("#databaseName").val('orcl');		//库名
				$("#username").val('');
			}else{
				$("#dbport").val(1433);				//端口
				$("#username").val('sa');			//用户名
				$("#databaseName").val('');			//库名
			}
		}
		
		//连接数据库,读取数据库中的表
		function connDb(){
			var dbtype = $("#dbtype").val();				//数据库类型
			var dbAddress = $("#dbAddress").val();			//连接地址
			var dbport = $("#dbport").val();				//端口
			var username = $("#username").val();			//用户名
			var password = $("#password").val();			//密码
			var databaseName = $("#databaseName").val();	//数据库名
			
			if("" == dbAddress){
				$("#dbAddress").tips({
					side:1,
		            msg:'请输入连接地址！',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#dbAddress").focus();
				return;
			}
			if("" == dbport){
				$("#dbport").tips({
					side:1,
		            msg:'请输入端口！',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#dbport").focus();
				return;
			}
			if("" == username){
				$("#username").tips({
					side:1,
		            msg:'请输入用户名！',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#username").focus();
				return;
			}
			if("" == password){
				$("#password").tips({
					side:1,
		            msg:'请输入密码！',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#password").focus();
				return;
			}
			if("" == databaseName){
				$("#databaseName").tips({
					side:1,
		            msg:'请输入数据库名！',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#databaseName").focus();
				return;
			}
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>recreateCode/listAllTable?tm='+new Date().getTime(),
			    	data: {dbtype:dbtype,dbAddress:dbAddress,dbport:dbport,username:username,password:password,databaseName:databaseName},
					dataType:'json',
					cache: false,
					success: function(data){
						 $.each(data.list, function(i, list){
							 if("ok" == list.msg){
								 $("#fhdb").tips({
										side:1,
							            msg:'连接成功',
							            bg:'#83CB4F',
							            time:10
							        });
								 $("#valuelist").html('');					//初始清空值列表
								 $("#valuelist").append('<tr>');
								 $.each(data.tblist, function(n, tblist){ 	//列出每条记录
									 $("#valuelist").append('<td>'+(n+1)+'</td><td>'+tblist+'</td><td float: left;><a onclick="productCode(\''+tblist+'\')" style="cursor:pointer;height:20px;" class="btn btn-light btn-sm"><div style="margin-top:-6px;margin-left: -1px;">反射<i class="feather icon-corner-right-up"></i></div></a></td>');
									 if((n+1)%2==0)$("#valuelist").append('</tr><tr>');
								 }); 
								 $("#valuelist").append('</tr>');
							 }else{
								 $("#fhdb").tips({
										side:3,
							            msg:'连接失败,检查连接参数是否正确！',
							            bg:'#cc0033',
							            time:15
							        });
							 }
						 });
					}
				});
		}
		
		//启动代码生成器
		function productCode(table){
			var dbtype = $("#dbtype").val();				//数据库类型
			var dbAddress = $("#dbAddress").val();			//连接地址
			var dbport = $("#dbport").val();				//端口
			var username = $("#username").val();			//用户名
			var password = $("#password").val();			//密码
			var databaseName = $("#databaseName").val();	//数据库名
			username = username.replace("#","%23");
			username = username.replace("#","%23");
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="代码生成器";
			 diag.URL = '<%=basePath%>recreateCode/goProductCode?table='+table+'&dbtype='+dbtype+'&dbAddress='+dbAddress+'&dbport='+dbport+'&username='+username+'&password='+password+'&databaseName='+databaseName;
			 diag.Width = 919;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
	</script>


</body>
</html>