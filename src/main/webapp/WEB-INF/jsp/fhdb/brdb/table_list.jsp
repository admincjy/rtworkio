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
							
										<table style="margin-top: 15px;margin-left: 15px;">
											<tr>
												<td>
												<button type="button" class="btn btn-light btn-sm"><i class="mdi mdi-database"></i>${dbtype}</button>
												<button type="button" class="btn btn-light btn-sm" id="backupts"><i class="mdi mdi-arrow-right-bold"></i>${databaseName}</button>
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
												<div id="backuping2" style="padding-top: 8px; display:none">&nbsp;正在备份……</div>
												</td>
											</tr>
										</table>
										<div class="card-block table-border-style" style="margin-top: -15px">
                                     		<div class="table-responsive">
												<table class="table table-hover">	
													<thead>
														<tr>
															<c:if test="${dbtype != 'sqlserver' }">
															<th style="width: 50px;" id="cts">
									                            <div class="checkbox d-inline">
		                                                            <input type="checkbox" name="fhcheckbox" id="zcheckbox">
		                                                            <label  style="max-height: 12px;" for="zcheckbox" class="cr"></label>
		                                                        </div>
															</th>
															</c:if>
															<th style="width:50px;">NO</th>
															<th>表名</th>
															<c:if test="${dbtype != 'sqlserver' }">
															<th>&nbsp;&nbsp;&nbsp;&nbsp;操作</th>
															</c:if>
															<c:if test="${dbtype != 'sqlserver' }"><th style="width:50px;"></th></c:if>
															<th style="width:50px;">NO</th>
															<th>表名</th>
															<c:if test="${dbtype != 'sqlserver' }">
															<th>&nbsp;&nbsp;&nbsp;&nbsp;操作</th>
															</c:if>
														</tr>
													</thead>
																			
													<tbody>
													<!-- 开始循环 -->	
													<c:choose>
														<c:when test="${not empty varList}">
															<tr>
															<c:forEach items="${varList}" var="var" varStatus="vs">
																	<c:if test="${dbtype != 'sqlserver' }">
																	<td id='ffhid${vs.index}'>
																	  	<div class="checkbox d-inline">
		                                                            		<input type="checkbox"  name='ids' value="${var}" id='fhid${vs.index}'>
		                                                            		<label  style="max-height: 12px;" for="fhid${vs.index}" class="cr"></label>
		                                                        		</div>
																	</td>
																	</c:if>
																	<td scope="row" style="width: 50px;">${vs.index+1}</td>
																	<td class='left' style="width: 220px;">${var}</td>
																	<c:if test="${dbtype != 'sqlserver' }">
																	<td>
																		<shiro:hasPermission name="brdb:add">
																			<a style="height:20px;" class="btn btn-light btn-sm" onclick="backupTable('${var}','fhid${vs.index}');"><div style="margin-top:-6px;margin-left: -1px;">备份</div></a>
																		</shiro:hasPermission>
																	</td>
																	</c:if>
																	${(vs.index+1)%2 == 0?'</tr><tr>':''}
															</c:forEach>
															</tr>
														</c:when>
														<c:otherwise>
															<tr>
																<td colspan="100">没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
													</tbody>
												</table>
												<table style="width:100%;">
													<tr>
														<td style="vertical-align:top;">
															<c:if test="${dbtype != 'sqlserver' }">
																<shiro:hasPermission name="brdb:add"><a class="btn btn-light btn-sm" onclick="makeAll('确定要批量备份这些表吗？');">备份表</a></shiro:hasPermission>
															</c:if>
															<shiro:hasPermission name="brdb:add"><a class="btn btn-light btn-sm" onclick="backupall();" id="alldata">备份整个库</a></shiro:hasPermission>
														</td>
														<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;"></div></td>
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
	
	//备份全库
	function backupall(){
		swal({
        	   title: '',
               text: "确定要备份整个数据库吗?",
               icon: "warning",
               buttons: true,
               dangerMode: true,
           }).then((willDelete) => {
               if (willDelete) {
	           	 $("#backuping1").show();
				 $("#backuping2").show();
				 $.ajax({
						type: "POST",
						url: '<%=basePath%>brdb/backupAll',
				    	data: {tm:new Date().getTime()},
						dataType:'json',
						cache: false,
						success: function(data){
							 if("success" == data.result){
								 $("#backupts").tips({
										side:3,
							            msg:'备份成功,在数据还原里面查看记录',
							            bg:'#83CB4F',
							            time:15
							        });alldata
							        $("#alldata").tips({
										side:3,
							            msg:'备份成功,在数据还原里面查看记录',
							            bg:'#83CB4F',
							            time:15
							        });alldata
							 }else{
								 $("#backupts").tips({
										side:3,
							            msg:'备份失败,检查配置文件及备份保存路径',
							            bg:'#cc0033',
							            time:15
							        });
								 $("#alldata").tips({
										side:3,
							            msg:'备份失败,检查配置文件及备份保存路径',
							            bg:'#83CB4F',
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
	
	//备份单表
	function backupTable(fhtable,id){
		swal({
        	   title: '',
               text: "确定要备份这表[ "+fhtable+" ]吗?",
               icon: "warning",
               buttons: true,
               dangerMode: true,
           }).then((willDelete) => {
               if (willDelete) {
           		backupAjax(fhtable,id);
               }
           });
	}
	
	/**请求备份
	* fhtable：表名
	* id ：提示对象的ID
	*/
	function backupAjax(fhtable,id){
		 $("#backuping1").show();
		 $("#backuping2").show();
		 $.ajax({
			type: "POST",
			url: '<%=basePath%>brdb/backupTable?tm='+new Date().getTime(),
	    	data: {fhtable:fhtable},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					 $("#f"+id).tips({
							side:2,
				            msg:'备份成功',
				            bg:'#83CB4F',
				            time:5
				        });
				 }else{
					 $("#"+id).tips({
							side:3,
				            msg:'备份失败,检查配置文件及备份保存路径',
				            bg:'#cc0033',
				            time:15
				        });
				 }
				$("#backuping1").hide();
				$("#backuping2").hide();
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
					var fid = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',fh,' + document.getElementsByName('ids')[i].value;
					  	
					  	if(fid=='') fid += document.getElementsByName('ids')[i].id;
					  	else fid += ',fh,' + document.getElementsByName('ids')[i].id;
					  }
					}
					if(str==''){
						$("#cts").tips({
	    					side:2,
	    		            msg:'点这里全选',
	    		            bg:'#AE81FF',
	    		            time:3
	    		        });
	                    swal("", "您没有选择任何内容", "warning");
	    				return;
					}else{
						if(msg == '确定要批量备份这些表吗？'){
							var arrTable = str.split(',fh,');
							var arrFid = fid.split(',fh,');
							for(var fhi=0;fhi<arrTable.length;fhi++){
								backupAjax(arrTable[fhi],arrFid[fhi]);
							}
						}
					}
               }
			});
	};
		
</script>


</body>
</html>