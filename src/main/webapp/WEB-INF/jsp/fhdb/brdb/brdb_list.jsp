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
    <meta name="author" content="" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/fonts/material/css/materialdesignicons.min.css">
    
    <!-- 日期插件 -->
    <link rel="stylesheet" href="assets/plugins/material-datetimepicker/css/bootstrap-material-datetimepicker.css">

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
									<form action="brdb/list" method="post" name="Form" id="Form">
									<div style="padding-left: 15px;padding-top: 10px;">
									<table style="margin-top:5px;">
										<tr>
											<td>
						                        <div class="input-group input-group-sm mb-3">
                                                   	<input class="form-control" id="keywords" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
                                                </div>
											</td>
											<td style="padding-left:2px;">
						                        <div class="input-group input-group-sm mb-3">
						                        	<input type="text" class="form-control date" name="lastStart" id="lastStart"  value="${pd.lastStart}" readonly="readonly" placeholder="开始日期" title="开始日期" style="width:93px;">
						                        </div>
											</td>
											<td style="padding-left:2px;">
						                        <div class="input-group input-group-sm mb-3">
						                        	<input type="text" class="form-control date" name="lastEnd" id="lastEnd"  value="${pd.lastEnd}" readonly="readonly" placeholder="结束日期" title="结束日期" style="width:93px;">
						                        </div>
											</td>
											<td style="vertical-align:top;padding-left:5px;">
												<select name="TYPE" id="id" style="height: 30px;width:43px;padding-left:6px;border: 1px solid #CED4DA;transparent;appearance:none;-moz-appearance:none;-webkit-appearance:none;">
													<option value="">全部</option>
													<option value="1" <c:if test="${pd.TYPE==1}">selected</c:if>>整库</option>
													<option value="2" <c:if test="${pd.TYPE==2}">selected</c:if>>单表</option>
												</select>
											</td>
											<td style="vertical-align:top;padding-left:5px;">
												<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索">
													<i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i>
												</a>
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
														<th style="width:50px;">NO</th>
														<th>表名</th>
														<th>备份时间</th>
														<th>操作用户</th>
														<th>存储位置</th>
														<c:if test="${remoteDB == 'no' }"><th>数据大小</th></c:if>
														<th>备注</th>
														<th id="tsmsg">操作</th>
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
		                                                            	<input type="checkbox" id="zcheckbox${vs.index }" name='ids' value="${var.FHDB_ID}">
		                                                            	<label  style="max-height: 12px;" for="zcheckbox${vs.index }" class="cr"></label>
		                                                        	</div>
																 </td>
																<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
																<td>${var.TABLENAME}</td>
																<td>${var.BACKUP_TIME}</td>
																<td>${var.USERNAME}</td>
																<td>${var.SQLPATH}</td>
																<c:if test="${remoteDB == 'no' }"><td>${var.DBSIZE}&nbsp;KB</td></c:if>
																<td>${var.BZ}</td>
																<td>
																	<shiro:hasPermission name="brdb:edit"><a title="还原" onclick="dbRecover('${var.TABLENAME}','${var.SQLPATH}');" style="cursor:pointer;"><i class="feather icon-rotate-cw"></i></a></shiro:hasPermission>
																	<shiro:hasPermission name="brdb:edit"><a title="修改" onclick="edit('${var.FHDB_ID}');" style="cursor:pointer;"><i class="feather icon-edit-2"></i></a></shiro:hasPermission>
								                   					<shiro:hasPermission name="brdb:del"><a title="删除" onclick="del('${var.FHDB_ID }');" style="cursor:pointer;"><i class="feather icon-x"></i></a></shiro:hasPermission>
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
														<shiro:hasPermission name="brdb:del"><a class="btn btn-light btn-sm" onclick="makeAll();" title="批量删除">删除</a></shiro:hasPermission>
													</td>
													<td>
														<!-- [加载状态 ] start -->
													    <div id="backuping1" style="display:none;">
													    	<div class="d-flex justify-content-center">
						                                        <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
					                                                <span class="sr-only"></span>
					                                            </div>
					                                        </div>
					                                    </div>
													    <!-- [ 加载状态  ] End -->
													</td>
													<td>
													<div id="backuping2" style="padding-top: 8px; display:none;float:left;">&nbsp;正在还原……</div>
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

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
  	
	<c:if test="${dbtype == 'oracle' }">
	<script type="text/javascript">
	$(function() {
		oracleMsg = "当数据库为Oracle时进行还原, 请先手动删除要还原的表或整库, 否则还原提示成功也无效！";
	});
	</script>
	</c:if>
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
		
		//还原操作
		var oracleMsg="";// 数据库为oracle时，提示消息(本页js上面处理)
		function dbRecover(TABLENAME,SQLPATH){
			swal({
            	title: "确定要进行还原["+TABLENAME+"]吗?",
                text: oracleMsg,
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
					$("#backuping1").show();
					$("#backuping2").show();
					 $.ajax({
							type: "POST",
							url: '<%=basePath%>brdb/dbRecover?tm='+new Date().getTime(),
					    	data: {TABLENAME:TABLENAME,SQLPATH:SQLPATH},
							dataType:'json',
							cache: false,
							success: function(data){
								if("success" == data.result){
									 $("#tsmsg").tips({
											side:3,
								            msg:'还原成功',
								            bg:'#83CB4F',
								            time:15
								        });
								 }else{
									 $("#tsmsg").tips({
											side:3,
								            msg:'还原失败,检查配置文件及是否远程数据库',
								            bg:'#cc0033',
								            time:15
								        });
								 }
								$("#backuping1").hide();
								$("#backuping2").hide();
							}
						});
                }
            });
		}
		
		//删除
		function del(Id){
			swal({
            	title: "确定要删除此记录吗？",
                text: '确保数据安全性,只删除记录,不删除物理硬盘数据',
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
	            	$.ajax({
	        			type: "POST",
	        			url: '<%=basePath%>brdb/delete',
	        	    	data: {FHDB_ID:Id,tm:new Date().getTime()},
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
			 diag.URL = '<%=basePath%>brdb/goEdit?FHDB_ID='+Id;
			 diag.Width = 600;
			 diag.Height = 158;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//批量操作
		function makeAll(){
			swal({
            	title: "确定要删除选中的记录吗?",
                text: '确保数据安全性,只删除记录,不删除物理硬盘数据',
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
	   					$.ajax({
	   						type: "POST",
	   						url: '<%=basePath%>brdb/deleteAll?tm='+new Date().getTime(),
	   				    	data: {DATA_IDS:str},
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
                }
            });
		}
		
	</script>


</body>
</html>