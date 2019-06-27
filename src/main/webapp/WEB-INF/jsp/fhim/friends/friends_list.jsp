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
    
    <!-- select插件 -->
    <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="assets/plugins/multi-select/css/multi-select.css">
    
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
										<form action="friends/list" method="post" name="Form" id="Form">
											<div style="padding-left: 15px;padding-top: 15px;">
											<table>
												<tr>
													<td>
								                        <div class="input-group input-group-sm mb-3">
                                                        	<input class="form-control" id="keywords" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
                                                    	</div>
													</td>
													
													<td style="padding-left:2px;">
								                        <div class="input-group input-group-sm mb-3">
								                        	<input type="text" class="form-control date" name="lastStart" id="lastStart"  value="${pd.lastStart}" readonly="readonly" placeholder="开始日期" title="开始时间" style="width:93px;">
								                        </div>
													</td>
													<td style="padding-left:2px;">
								                        <div class="input-group input-group-sm mb-3">
								                        	<input type="text" class="form-control date" name="lastEnd" id="lastEnd"  value="${pd.lastEnd}" readonly="readonly" placeholder="结束日期" title="结束时间" style="width:93px;">
								                        </div>
													</td>
													<td style="vertical-align:top;padding-left:2px;width: 100px;">
								                        <select class="js-example-placeholder-multiple col-sm-12" name="FGROUP_ID" id="FGROUP_ID" data-placeholder="请选择分组"></select>
													</td>
													<td style="vertical-align:top;padding-left:5px;">
														<shiro:hasPermission name="friends:cha">
															<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索">
																<i style="margin-top:-3px;margin-left: -6px;" class="feather icon-search"></i>
															</a>
														</shiro:hasPermission>
													</td>
												</tr>
											</table>
											</div>
											<!-- 检索  -->
											
											<div class="card-block table-border-style" style="margin-top: -15px">
	                                            <div class="table-responsive">
	                                            	<table class="table table-hover mb-0">
														<thead>
															<tr>
																<th style="width: 50px;" id="cts">
										                            <div class="checkbox d-inline">
			                                                            <input type="checkbox" name="fhcheckbox" id="zcheckbox">
			                                                            <label  style="max-height: 12px;" for="zcheckbox" class="cr"></label>
			                                                        </div>
																</th>
																<th style="width: 50px;">NO</th>
																<th>好友</th>
																<th>分组</th>
																<th>申请时间</th>
																<th>是否同意</th>
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
				                                                            	<input type="checkbox" id="zcheckbox${vs.index }" name='ids' value="${var.FRIENDS_ID}" title="${var.FUSERNAME}">
				                                                            	<label  style="max-height: 12px;" for="zcheckbox${vs.index }" class="cr"></label>
				                                                        	</div>
																		</td>
																		<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
																		<td>
																			<img src="${(null == var.PHOTO2 || '' == var.PHOTO2)?'assets/images/user/avatar-2.jpg':var.PHOTO2}" width="39" />&nbsp;
																			${var.NAME}(${var.FUSERNAME})
																		</td>
																		<td>${var.GNAME==null?'未分组':var.GNAME}</td>
																		<td>${var.CTIME}</td>
																		<td>
																			${var.ALLOW == 'will'?'等待同意':''}
																			${var.ALLOW == 'no'?'被拒绝':''}
																			${var.ALLOW == 'yes'?'已同意':''}
																		</td>
																		<td>
																			<shiro:hasPermission name="friends:edit"><a title="修改" onclick="edit('${var.FRIENDS_ID}');" style="cursor:pointer;"><i class="feather icon-edit-2"></i></a></shiro:hasPermission>
										                    				<shiro:hasPermission name="friends:del"><a title="删除" onclick="del('${var.FRIENDS_ID}','${var.FUSERNAME}');" style="cursor:pointer;"><i class="feather icon-x"></i></a></shiro:hasPermission>
																			<shiro:hasPermission name="friends:del"><a title="拉黑" onclick="pullblack('${var.FRIENDS_ID}','${var.FUSERNAME}');" title="拉黑后也会在对方好友栏删除您" style="cursor:pointer;"><i class="feather icon-slash"></i></a></shiro:hasPermission>
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
																<shiro:hasPermission name="friends:del"><a class="btn btn-light btn-sm" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除">删除</a></shiro:hasPermission>
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
//检索
function searchs(){
	$("#Form").submit();
}
$(function() {
	var FGROUP_ID = "${pd.FGROUP_ID}";
	$.ajax({
		type: "POST",
		url: '<%=basePath%>fgroup/getFgroup?tm='+new Date().getTime(),
    	data: {},
		dataType:'json',
		cache: false,
		success: function(data){
			 $("#FGROUP_ID").append("<option value=''>请选择分组</option>");
			 $.each(data.list, function(i, dvar){
				 if(FGROUP_ID == dvar.FGROUP_ID){
					 $("#FGROUP_ID").append("<option value="+dvar.FGROUP_ID+" selected='selected'>"+dvar.NAME+"</option>");
				 }else{
					 $("#FGROUP_ID").append("<option value="+dvar.FGROUP_ID+">"+dvar.NAME+"</option>");
				 }
			 });
		}
	});
	
	//复选框控制全选,全不选 
	$('#zcheckbox').click(function(){
	 if($(this).is(':checked')){
		 $("input[name='ids']").click();
	 }else{
		 $("input[name='ids']").attr("checked", false);
	 }
	});
});

//删除
function del(Id,FUSERNAME){
	swal({
		title: '',
        text: "确定要删除吗?",
        icon: "warning",
        buttons: true,
        dangerMode: true,
    }).then((willDelete) => {
        if (willDelete) {
	    	$.ajax({
				type: "POST",
				url: '<%=basePath%>friends/deletefromlist',
		    	data: {FRIENDS_ID:Id,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					 if("success" == data.result){
						 top.removeFriendByI(FUSERNAME); 		//从自己好友栏移除  此方法在im.jsp页面中
						 top.removeFriendFromMobile(FUSERNAME);	//从自己手机好友栏里面删除对方
						 swal("删除成功", "已经从列表中删除!", "success");
					 }
					 setTimeout(searchs, 1500);
				}
			});
        }
    });
}

//拉黑
function pullblack(Id,FUSERNAME){
	swal({
    	title: '确定要拉黑吗?',
        text: "拉黑后也会在对方好友栏删除您",
        icon: "warning",
        buttons: true,
        dangerMode: true,
    }).then((willDelete) => {
        if (willDelete) {
	    	$.ajax({
				type: "POST",
				url: '<%=basePath%>friends/pullblackfromlist',
		    	data: {FRIENDS_ID:Id,FUSERNAME:FUSERNAME,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					 if("success" == data.result){
						 top.removeFriendByI(FUSERNAME); 		//从自己好友栏移除  此方法在im.jsp页面中
						 top.removeIFromFriend(FUSERNAME);		//从对方好友栏里面删除自己
						 top.removeFriendFromMobile(FUSERNAME);	//从自己手机好友栏里面删除对方
						 swal("拉黑成功", "已经从列表中删除!", "success");
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
	 diag.URL = '<%=basePath%>friends/goEdit?FRIENDS_ID='+Id;
	 diag.Width = 399;
	 diag.Height = 155;
	 diag.Modal = true;				//有无遮罩窗口
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
			 searchs();
		}
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
			var nstr = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
				if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  	if(nstr=='') nstr += document.getElementsByName('ids')[i].title;
				  	else nstr += ',' + document.getElementsByName('ids')[i].title;
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
					var arrid = nstr.split(',');
					for(var n=0;n<arrid.length;n++){
						top.removeFriendByI(arrid[n]); //从自己好友栏移除  此方法在im.jsp页面中
					}
					$.ajax({
						type: "POST",
						url: '<%=basePath%>friends/deleteAll?tm='+new Date().getTime(),
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
</script>

</body>
</html>