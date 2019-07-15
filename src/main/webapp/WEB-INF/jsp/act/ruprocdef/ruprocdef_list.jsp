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
										<form action="ruprocdef/list" method="post" name="Form" id="Form">
										<!-- 检索条件  -->									
										<div style="padding-left: 15px;padding-top: 15px;">
											<table style="margin-top:5px;">
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
															<th style="width: 30px;">NO</th>
															<th>流程名称</th>
															<th>申请人</th>
															<th>当前节点(审批人)</th>
															<th>当前任务</th>
															<th>创建时间</th>
															<th>状态</th>
															<th style="width: 200px;">操作</th>
														</tr>
													</thead>
													<tbody>
													<!-- 开始循环 -->	
													<c:choose>
														<c:when test="${not empty varList}">
															<c:forEach items="${varList}" var="var" varStatus="vs">
																<tr>
																	<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
																	<td>${var.PNAME_}</td>
																	<td>${var.INITATOR}</td>
																	<td><a onclick="viewUser('${var.ASSIGNEE_}')" style="cursor:pointer;">${var.ASSIGNEE_}</a></td>
																	<td>${var.NAME_}</td>
																	<td>${fn:substring(var.CREATE_TIME_ ,0,19)}</td>
																	<td id="STATUS${vs.index+1}">${var.SUSPENSION_STATE_ == 1 ? '<font color="#87B87F">正在运行</font><div class="spinner-grow spinner-grow-sm" role="status"><span class="sr-only">Loading...</span></div>' : '<font color="red">已挂起</font>'}</td>
																	<td>
																		<a style="height:20px;margin-left: -10px;" class="btn btn-light btn-sm" title="流程信息" onclick="view('${var.PROC_INST_ID_}','${var.ID_}','${var.DGRM_RESOURCE_NAME_}');"><div style="margin-top:-6px;margin-left: -1px;">流程信息</div></a>
																		<shiro:hasPermission name="Delegate">
																		<a style="height:20px;margin-left: -10px;" class="btn btn-light btn-sm" title="委派" onclick="delegate('${var.ID_}');"><div style="margin-top:-6px;margin-left: -1px;">委派</div></a>
																		</shiro:hasPermission>
																		<shiro:hasPermission name="ruprocdef:edit">
																		<a id="offing1${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == 1}">style="display: none;"</c:if> style="cursor:pointer;" title="激活" onclick="onoff('${var.ID_}','1',this.id,'${vs.index+1}');">
																			<i class="feather icon-play"></i>
																		</a>
																		<a id="oning1${vs.index+1}" <c:if test="${var.SUSPENSION_STATE_ == 2}">style="display: none;"</c:if> style="cursor:pointer;" title="挂起" onclick="onoff('${var.ID_}','2',this.id,'${vs.index+1}');">
																			<i class="feather icon-pause"></i>
																		</a>
																		</shiro:hasPermission>
					                     								<shiro:hasPermission name="Abolish">
																			<a title="作废" onclick="isDel('${var.PROC_INST_ID_}');" data-toggle="modal" data-target="#exampleModal" style="cursor:pointer;"><i class="feather icon-x"></i></a>
																		</shiro:hasPermission>
																	</td>
																</tr>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<tr>
																<td colspan="100">没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
													</tbody>
												</table>
												<table style="width:100%;margin-top:15px;">
													<tr>
														<td style="vertical-align:top;"></td>
														<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
													</tr>
												</table>
											</div>
										</div>
										</form>
										
										<!-- 作废弹窗  -->
									    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                               <div class="modal-dialog" role="document">
                                                   <div class="modal-content">
                                                       <div class="modal-header">
                                                           <h5 class="modal-title" id="exampleModalLabel">要作废此流程吗?</h5>
                                                           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                       </div>
                                                       <div class="modal-body">
                                                               <input type="hidden" class="form-control" id="recipient-id">
                                                               <div class="form-group">
                                                                   <label for="message-text" class="col-form-label">缘由:</label>
                                                                   <textarea class="form-control" id="message-text"></textarea>
                                                               </div>
                                                       </div>
                                                       <div class="modal-footer">
                                                           <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                                                           <button type="button" class="btn btn-primary" onclick="del();">作废</button>
                                                       </div>
                                                   </div>
                                               </div>
                                        </div>
										<!-- 作废弹窗  -->
										
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

<script src="assets/js/vendor-all.min.js"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>

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
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
	
	//激活 or 挂起
	function onoff(ID_,STATUS,ofid,VSID){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>ruprocdef/onoffTask?tm='+new Date().getTime(),
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
						 $("#STATUS"+VSID).html('<font color="#87B87F">正在运行</font><div class="spinner-grow spinner-grow-sm" role="status"><span class="sr-only">Loading...</span></div>');
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
	
	//是否作废
	function isDel(Id){
		$("#recipient-id").val(Id);
	}
	
	//提交作废
	function del(){
		var Id = $("#recipient-id").val();
		var reason = $("#message-text").val();
		if('' == reason){
			swal("", "还未写作废缘由!", "warning");
			return false;
		}
		var url = "<%=basePath%>ruprocdef/delete?PROC_INST_ID_="+Id+"&reason="+encodeURI(encodeURI(reason))+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if("ok" == data.msg){
				 swal("", "已经作废!", "success");
			 }
			 setTimeout(searchs, 1500);
		});
	}
	
	//委派
	function delegate(ID_){
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="委派对象";
		 diag.URL = '<%=basePath%>ruprocdef/goDelegate?ID_='+ID_;
		 diag.Width = 439;
		 diag.Height = 146;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
				 searchs();
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//流程信息
	function view(PROC_INST_ID_,ID_,FILENAME){
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="流程信息";
		 diag.URL = '<%=basePath%>rutask/goHandle?PROC_INST_ID_='+PROC_INST_ID_+'&ID_='+ID_+'&msg=admin'+'&FILENAME='+encodeURI(encodeURI(FILENAME));
		 diag.Width = 1200;
		 diag.Height = 599;
		 diag.Modal = true;				//有无遮罩窗口
		 diag. ShowMaxButton = true;	//最大化按钮
	     diag.ShowMinButton = true;		//最小化按钮 
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
	
</script>

</body>
</html>