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
    <link rel="stylesheet" href="assets/css/style.css">
    
    <style type="text/css">

	.viewreson{
		z-index: 9999999999999999;
		position:absolute;
		border:1px solid #EAEAEA;
		background-color:white;
		display: none;
	}
	
	</style>

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
                            
                            	<div class="col-sm-12">
								    <ul class="nav nav-tabs" id="myTab" role="tablist">
								        <li class="nav-item">
								            <a class="nav-link active text-uppercase" id="home-tab" data-toggle="tab" role="tab" href="#home" aria-controls="home" aria-selected="true" style="cursor:pointer;">申请事项</a>
								        </li>
								        <li class="nav-item">
								            <a class="nav-link text-uppercase" id="profile-tab" data-toggle="tab"  role="tab" href="#profile" aria-controls="profile" aria-selected="false" style="cursor:pointer;">审批过程</a>
								        </li>
								        <li class="nav-item">
								            <a class="nav-link text-uppercase" id="contact-tab" data-toggle="tab" role="tab" href="#contact" aria-controls="contact" aria-selected="false" style="cursor:pointer;">流程图</a>
								        </li>
								    </ul>
								    <div class="tab-content" id="myTabContent">
								        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
								            <p class="mb-0">
								            	<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 10px;">
												<c:forEach items="${varList}" var="var" varStatus="vs">
													<tr>
														<c:if test="${var.NAME_ != 'RESULT'}">
															<td style="width:75px;text-align: right;padding-top: 10px;">${var.NAME_ == 'USERNAME'?'提交户名':var.NAME_}</td>
															<td style="padding-top: 10px;">${var.TEXT_}</td>
														</c:if>
													</tr>
												</c:forEach>
												<tr>
													<td style="width:75px;text-align: right;padding-top: 10px;">提交内容</td>
													<td style="padding-top: 10px;">
														<a onclick="contentmx('${pd.PROC_INST_ID_}')" style="cursor:pointer;" title="详情">&nbsp;<i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i></a>
													</td>
												</tr>
												</table>
								            </p>
								        </div>
								        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
								            <p class="mb-0">
								            	<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 10px;">
													<tr>
														<th style="width:50px;">步骤</th>
														<th style="width:150px;">任务节点</th>
														<th style="width:150px;">办理人</th>
														<th style="width:150px;"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>审批开始时间</th>
														<th style="width:150px;"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>审批结束时间</th>
														<th style="width:120px;">用时</th>
														<th>审批意见</th>
													</tr>
													<c:forEach items="${hitaskList}" var="var" varStatus="vs">
														<tr>
															<td style="width: 30px;text-align: center;">${vs.index+1}</td>
															<td style="padding-top: 10px;">${var.ACT_NAME_}</td>
															<td style="padding-top: 10px;">
																<c:if test="${var.ASSIGNEE_ != NULL}"><a onclick="viewUser('${var.ASSIGNEE_}')" style="cursor:pointer;"><i style="margin-top:0px;margin-left: -6px;"  class="feather icon-search"></i>${var.ASSIGNEE_}</a></c:if>
															</td>
															<td style="padding-top: 10px;">${fn:substring(var.START_TIME_ ,0,19)}</td>
															<td style="padding-top: 10px;">
																<c:if test="${var.END_TIME_ == NULL}">正在审批……</c:if>
																<c:if test="${var.END_TIME_ != NULL}">${fn:substring(var.END_TIME_ ,0,19)}</c:if>
															</td>
															<td>${var.ZTIME}<c:if test="${vs.index > 0 && var.TEXT_ == null}"><div class="viewreson" id="viewreson${vs.index+1}">&nbsp;${var.DELETE_REASON_}&nbsp;</div></c:if></td>
															<td style="padding-top: 10px;">
																<c:if test="${vs.index > 0 && var.TEXT_ == null}">
																	<c:if test="${var.DELETE_REASON_ != null && var.DELETE_REASON_ != '' && var.DELETE_REASON_ != ' '}">
											                    	<sapn onmouseover="showRe('viewreson${vs.index+1}');" style="cursor:pointer;" onmouseout="hideRe('viewreson${vs.index+1}');">作废缘由<i style="margin-top:0px;margin-left: 3px;"  class="feather icon-message-circle"></i></sapn>
											                    	</c:if>
											                    </c:if>
																<c:forEach items="${fn:split(var.TEXT_,',fh,')}"   var="val" varStatus="dvs"  >
											                            <c:if test="${dvs.index == 0 }">${val}</c:if>
											                            <c:if test="${dvs.index == 1 }">
											                            	<a onclick="details('d${vs.index+1}')" style="cursor:pointer;" title="详情">&nbsp;<i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i></a>
											                            </c:if>
											                    </c:forEach>
											                    <textarea id="d${vs.index+1}" style="display: none;">${var.TEXT_}</textarea>
															</td>
														</tr>
													</c:forEach>
												</table>
								            </p>
								        </div>
								        <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
								            <p class="mb-0">
								            	<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 10px;">
													<tr>
														<td style="text-align: center;"><img alt="${pd.FILENAME }" src="${pd.imgSrc }"></td>
													</tr>
													<tr>
														<td style="text-align: center;"><p class="text-warning bigger-110 orange" style="padding-top: 5px;">如果图片显示不全,点击最大化按钮</p></td>
													</tr>
												</table>
								            </p>
								        </div>
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
<script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
		<script type="text/javascript">
		
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
		function contentmx(id){
			 var diag = new top.Dialog();
			 diag.Modal = false;			//有无遮罩窗口
			 diag.Drag=true;
			 diag.Title ="提交详情";
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.URL = '<%=basePath%>rutask/contentDetails?PROC_INST_ID_='+id+'&isRun=1';
			 diag.Width = 760;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//审批意见详情页
		function details(htmlId){
			 var content = $("#"+htmlId).val().split(',fh,');
			 top.handleDetails(content[1]);
			 var diag = new top.Dialog();
			 diag.Modal = false;			//有无遮罩窗口
			 diag.Drag=true;
			 diag.Title ="审批意见";
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.URL = '<%=basePath%>rutask/details';
			 diag.Width = 760;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//显示作废缘由
		function showRe(ID){
			 $("#"+ID).show();
		}
		
		//隐藏作废缘由
		function hideRe(ID){
			 $("#"+ID).hide();
		}
		
		</script>
</body>
</html>