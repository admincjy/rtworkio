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
    <meta name="author" content="FH Admin QQ313596790" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/fonts/material/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
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
                                    
                                    	<form action="procdef/list" method="post" name="Form" id="Form">	
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
								                        	<input type="text" class="form-control date" name="STRARTTIME" id="STRARTTIME"  value="${pd.STRARTTIME}" readonly="readonly" placeholder="开始日期" title="开始时间" style="width:93px;">
								                        </div>
													</td>
													<td style="padding-left:2px;">
								                        <div class="input-group input-group-sm mb-3">
								                        	<input type="text" class="form-control date" name="ENDTIME" id="ENDTIME"  value="${pd.ENDTIME}" readonly="readonly" placeholder="结束日期" title="截止时间" style="width:93px;">
								                        </div>
													</td>
													<td style="vertical-align:top;padding-left:5px;">
														<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索">
															<i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i>
														</a>
														<shiro:hasPermission name="procdef:add">
															<a class="btn btn-light btn-sm" onclick="uploadPro();" style="width: 23px;height:30px;margin-top:1px;margin-left: -9px;" title="导入流程">
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
															<th>名称</th>
															<th>流程定义KEY</th>
															<th>版本</th>
															<th>部署时间</th>
															<th>流程bpmn文件名称</th>
															<th>流程图片名称</th>
															<th>状态</th>
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
		                                                            	<input type="checkbox" id="zcheckbox${vs.index }" name='ids' value="${var.DEPLOYMENT_ID_}">
		                                                            	<label  style="max-height: 12px;" for="zcheckbox${vs.index }" class="cr"></label>
		                                                        	</div>
																 </td>
											                     <td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											                     <td>${var.NAME_}</td>
											                     <td>${var.KEY_}</td>
											                     <td>v.${var.VERSION_}</td>
											                     <td>${fn:substring(var.DEPLOY_TIME_ ,0,19)}</td>
											                     <td><a href="javascript:goViewXml('${var.DEPLOYMENT_ID_}','${var.RESOURCE_NAME_}')" style="cursor:pointer;" title="预览XML">${var.RESOURCE_NAME_}</a></td>
											                     <td><a href="javascript:goViewPng('${var.DEPLOYMENT_ID_}','${var.DGRM_RESOURCE_NAME_}')" style="cursor:pointer;">${var.DGRM_RESOURCE_NAME_}</a></td>
											                     <td id="STATUS${vs.index+1}">
											                     	${var.SUSPENSION_STATE_ == '1' ? '<font color="#87B87F">已激活</font><div class="spinner-grow spinner-grow-sm" role="status"><span class="sr-only">Loading...</span></div>' : '<font color="red">已挂起</font>'}	
											                     </td>
											                     <td id="cz${vs.index+1}">
										                     		<shiro:hasPermission name="fhmodel:add">
										                     		<a style="height:20px;margin-left: -10px;" class="btn btn-light btn-sm" title="映射模型" onclick="addModel('${var.ID_}','cz${vs.index+1}');"><div style="margin-top:-6px;margin-left: -1px;">映射模型</div></a>
										                     		</shiro:hasPermission>
										                     		<shiro:hasPermission name="procdef:cha">
										                     		<a title="打包下载" onclick="window.location.href='<%=basePath%>/procdef/download?DEPLOYMENT_ID_=${var.DEPLOYMENT_ID_}'" style="cursor:pointer;"><i class="mdi mdi-cloud-download"></i></a>
										                     		</shiro:hasPermission>
										                     		<shiro:hasPermission name="procdef:edit">
										                     		<a id="offing1${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == 1}">style="display: none;"</c:if> title="激活" onclick="onoff('${var.ID_}','1',this.id,'${vs.index+1}');" style="cursor:pointer;">
																		<i class="feather icon-play"></i>
																	</a>
																	<a id="oning1${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == 2}">style="display: none;"</c:if> title="挂起" onclick="onoff('${var.ID_}','2',this.id,'${vs.index+1}');" style="cursor:pointer;">
																		<i class="feather icon-pause"></i>
																	</a>
										                     		</shiro:hasPermission>
											                     	<shiro:hasPermission name="procdef:del">
											                     		<a title="删除" onclick="del('${var.DEPLOYMENT_ID_}');" style="cursor:pointer;"><i class="feather icon-x"></i></a>
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
										                 		<shiro:hasPermission name="procdef:del"><a class="btn btn-light btn-sm" onclick="makeAll('确定要删除选中的数据吗?');">删除</a></shiro:hasPermission>
															</td>
															<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
														</tr>
													</table>
												</div>
											</div>
                                    	</form>
                                    
                                    </div>
								</div>
								<!-- [ Hover-table ] start -->
								
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
		
	//预览Xml
	function goViewXml(DEPLOYMENT_ID_,FILENAME){
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="预览XML";
		diag.URL = '<%=basePath%>procdef/goViewXml?DEPLOYMENT_ID_='+DEPLOYMENT_ID_+'&FILENAME='+encodeURI(encodeURI(FILENAME));
		diag.Width = 1000;
		diag.Height = 608;
		diag.Modal = true;				//有无遮罩窗口
		diag.ShowMinButton = true;		//最小化按钮
		diag. ShowMaxButton = true;		//最大化按钮
		diag.CancelEvent = function(){ 	//关闭事件
		diag.close();
		};
		diag.show();
	}
	
	//预览Png
	function goViewPng(DEPLOYMENT_ID_,FILENAME){
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="预览流程图";
		diag.URL = '<%=basePath%>procdef/goViewPng?DEPLOYMENT_ID_='+DEPLOYMENT_ID_+'&FILENAME='+encodeURI(encodeURI(FILENAME));
		diag.Width = 800;
		diag.Height = 460;
		diag.Modal = true;				//有无遮罩窗口
		diag.ShowMinButton = true;		//最小化按钮
		diag. ShowMaxButton = true;		//最大化按钮
		diag.CancelEvent = function(){ 	//关闭事件
		diag.close();
		};
		diag.show();
	}
	
	//激活 or 挂起
	function onoff(ID_,STATUS,ofid,VSID){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>procdef/onoffPro?tm='+new Date().getTime(),
	    	data: {ID_:ID_,STATUS:STATUS},
			dataType:'json',
			//beforeSend: validateData,
			cache: false,
			success: function(data){
				 if("ok" == data.msg){
					 if(STATUS == '1'){
						 $("#"+ofid).tips({
								side:3,
					            msg:'激活成功',
					            bg:'#AE81FF',
					            time:2
					        });
						 $("#offing1"+VSID).hide();
						 $("#offing2"+VSID).hide();
						 $("#oning1"+VSID).show();
						 $("#oning2"+VSID).show();
						 $("#STATUS"+VSID).html('<font color="#87B87F">已激活</font><div class="spinner-grow spinner-grow-sm" role="status"><span class="sr-only">Loading...</span></div>');
					 }else{
						 $("#"+ofid).tips({
								side:3,
					            msg:'已经挂起',
					            bg:'#AE81FF',
					            time:2
					        });
						 $("#offing1"+VSID).show();
						 $("#offing2"+VSID).show();
						 $("#oning1"+VSID).hide();
						 $("#oning2"+VSID).hide();
						 $("#STATUS"+VSID).html('<font color="red">已挂起</font>');
					 }
				 }
			}
		});
	}
	
	//映射模型
	function addModel(processDefinitionId,czid){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>fhmodel/saveModelFromPro?tm='+new Date().getTime(),
	    	data: {processDefinitionId:processDefinitionId},
			dataType:'json',
			//beforeSend: validateData,
			cache: false,
			success: function(data){
				 if("ok" == data.msg){
					 $("#"+czid).tips({
							side:3,
				            msg:'映射成功,可以去模型列表查看',
				            bg:'#AE81FF',
				            time:2
				        });
				 }else{
					 $("#"+czid).tips({
							side:3,
				            msg:'映射失败!',
				            bg:'#AE81FF',
				            time:2
				        });
				 }
			}
		});
	}
	
	//删除
	function del(Id){
		swal({
			title: '确定要删除吗?',
            text: "它所关联的所有数据,包括任务和历史流程全部会被删除",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
            	$.ajax({
        			type: "POST",
        			url: '<%=basePath%>procdef/delete',
        	    	data: {DEPLOYMENT_ID_:Id,tm:new Date().getTime()},
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
					if(msg == '确定要删除选中的数据吗?'){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>procdef/deleteAll?tm='+new Date().getTime(),
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
            }
        });
	}
	
	//导入流程
	function uploadPro(){
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="导入流程";
		 diag.URL = '<%=basePath%>procdef/goUploadPro';
		 diag.Width = 600;
		 diag.Height = 168;
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