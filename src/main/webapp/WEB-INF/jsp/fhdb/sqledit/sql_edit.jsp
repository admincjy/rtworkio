<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <meta name="author" content="" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/fonts/material/css/materialdesignicons.min.css">

</head>

<body style="background-color: white">
    
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
								<div class="col-xl-12">
                                    <div class="card">
                                    
                                    	<div style="padding-left: 15px;padding-top: 15px;width: 100%">
                                    	<table style="width: 100%">
	                                    	<tr>
												<td>
												<div class="input-group input-group-sm mb-3">
				                                    <div class="input-group-prepend">
				                                        <span class="input-group-text" style="width: 130px;"><span style="width: 100%;">SQL脚本编辑语句</span></span>
				                                    </div>
				                                    <textarea class="form-control" rows="2" cols="10" id="updateSQL" style="width:68%;"  title="INSERT、UPDATE 或 DELETE 语句" placeholder="这里输入： INSERT、UPDATE 或 DELETE 语句"></textarea>
				                                    <div style="float: right;margin-right: 12px;margin-top: 3px;margin-left: 5px;" style="width:19%">
														<shiro:hasPermission name="sqledit:edit">
															<button type="button" class="btn btn-icon btn-dark" onclick="executeUpdate();" title="执行SQL"><i class="feather icon-play"></i></button>
														</shiro:hasPermission>
													</div>
				                                 </div>
				                                 <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
				                                    <div class="input-group-prepend">
				                                        <span class="input-group-text" style="width: 130px;"><span style="width: 100%;">SQL脚本查询语句</span></span>
				                                    </div>
				                                    <textarea class="form-control" rows="2" cols="10" id="querySQL" style="width:68%;" title="SELECT语句" placeholder="这里输入： SELECT 语句"></textarea>
				                                    <div style="float: right;margin-right: 12px;margin-top: 3px;margin-left: 5px;" style="width:19%">
														<shiro:hasPermission name="sqledit:cha">
															<button type="button" class="btn btn-icon btn-dark" onclick="executeQuery();" title="执行SQL"><i class="feather icon-play"></i></button>
														</shiro:hasPermission>
													</div>
				                                 </div>
				                                 </td>
			                                 </tr>
		                                 </table>
		                                 </div>
		                                 
										<div class="card-block table-border-style" style="margin-top: -15px">
                                            <div class="table-responsive">
                                                <table class="table table-hover">
													<thead id="theadid">
														<tr id="columnList">
															<th>字段</th>
														</tr>
													</thead>
											
													<tbody id="valuelist">
														<tr class='center'>
															<td>数据显示区</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>	
										<div class="card-block table-border-style" style="margin-top: -15px">
                                            <div class="table-responsive">
                                                <table class="table table-hover">
													<tr>
														<td style="width:120px;">
															<div id="theadid2">查询时间 &nbsp;s</div>
														</td>
														<td style="width:66px;">
															<div id="fhcount">共 &nbsp;条</div>
														</td>
														<td style="padding-top:16px;">
															<div id="exceldiv">
																<shiro:hasPermission name="toExcel">
																	<i class="mdi mdi-cloud-download" style="cursor:pointer;" onclick="toExcel();" title="导出到EXCEL"></i>
																</shiro:hasPermission>
															</div>
														</td>
														<td></td>
													</tr>
												</table>
											</div>
										</div>
										<textarea rows="" cols="" id="sqlstrforExcel" style="display: none;"></textarea>
									</div>
								</div>
                            </div>
                            <!-- [ Main Content ] end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <!-- [ 主内容区 ] end -->
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>

	<script type="text/javascript">
		//执行编辑语句
		function executeUpdate(){
			var sql = $("#updateSQL").val();
			if("" == sql){
				$("#updateSQL").tips({
					side:3,
		            msg:'什么也没输入！',
		            bg:'#AE81FF',
		            time:3
		        });
				return;
			}
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>sqledit/executeUpdate?tm='+new Date().getTime(),
			    	data: {sql:sql},
					dataType:'json',
					cache: false,
					success: function(data){
						 if("success" == data.result){
							 $("#updateSQL").tips({
									side:3,
						            msg:'执行成功, 用时：'+data.rTime+' s',
						            bg:'#AE81FF',
						            time:10
						        });
						 }else{
							 $("#updateSQL").tips({
									side:3,
						            msg:'执行失败,sql语句错误 或 非编辑语句or查询数据库连接错误',
						            bg:'#cc0033',
						            time:15
						        });
						 }
					}
				});
		}
	</script>

	<script type="text/javascript">
		//执行查询语句
		function executeQuery(){
			var sql = $("#querySQL").val();
			if("" == sql){
				$("#querySQL").tips({
					side:3,
		            msg:'什么也没输入！',
		            bg:'#AE81FF',
		            time:3
		        });
				return;
			}
			 $.ajax({
					type: "POST",
					url: '<%=basePath%>sqledit/executeQuery?tm='+new Date().getTime(),
			    	data: {sql:sql},
					dataType:'json',
					cache: false,
					success: function(data){
						 if("success" == data.result){
							 $("#theadid").tips({
									side:3,
						            msg:'执行成功, 查询时间：'+data.rTime+' s',
						            bg:'#AE81FF',
						            time:15
						        });
							 $("#theadid2").html('查询时间：'+data.rTime+' s');
							 $("#columnList").html('');	//初始清空字段名称
							 $("#valuelist").html('');	//初始清空值列表
							 $.each(data.columnList, function(m, column){ 	//列出字段名
								 $("#columnList").append(
									'<th>'+column+'</th>'	 
								 );
							 });
							 var fhcount = 0;
							 $.each(data.dataList, function(n, fhdata){ 	//列出每条记录
								 var str1 = '<tr>';
								 var str2 = '';
								 $.each(fhdata, function(f, fhvalue){ 		//列出字段名
									 str2 += '<td>'+fhvalue+'</d>'; 
								 });
								 var str3 = '</tr>';
								 $("#valuelist").append(str1+str2+str3);
								 fhcount ++;
							 });
							 $("#fhcount").html('共  '+fhcount+' 条');
							 $("#sqlstrforExcel").val(sql);
						 }else{
							 $("#querySQL").tips({
									side:3,
						            msg:'查询失败,sql语句错误或非查询语句or查询数据库连接错误',
						            bg:'#cc0033',
						            time:15
						        });
						 }
					}
				});
		}
		
		//导出excel
		function toExcel(){
			var sqlstrforExcel = $("#sqlstrforExcel").val();
			if("" == sqlstrforExcel){
                swal("", "什么数据都没有，你导出什么?", "warning");
				return
			}else{
				window.location.href='<%=basePath%>sqledit/excel?sql='+sqlstrforExcel;
			}
		}
	</script>

</body>
</html>