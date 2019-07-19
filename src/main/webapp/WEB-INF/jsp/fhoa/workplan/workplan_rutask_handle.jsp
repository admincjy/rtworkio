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
		<meta name="author" content="FH Admin " />

		<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
		<link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
		<link rel="stylesheet" href="assets/css/style.css">
		<style type="text/css">
			.title {
				border: 1px solid #ebeef5;
				valign=middle；
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
											<a class="nav-link active text-uppercase" id="home-tab" data-toggle="tab" role="tab" href="#home" aria-controls="home" aria-selected="true" style="cursor:pointer;">提交事项</a>
										</li>
										<li class="nav-item">
											<a class="nav-link text-uppercase" id="profile-tab" data-toggle="tab" role="tab" href="#profile" aria-controls="profile" aria-selected="false" style="cursor:pointer;">审批过程</a>
										</li>
										<li class="nav-item">
											<a class="nav-link text-uppercase" id="contact-tab" data-toggle="tab" role="tab" href="#contact" aria-controls="contact" aria-selected="false" style="cursor:pointer;">流程图</a>
										</li>
									</ul>
									<div class="tab-content" id="myTabContent">
										<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
											<p class="mb-0">
												<table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 10px;">
													<!--<tr>
													<td style="width:25%;text-align: left;padding-top: 10px;">提交人员:&nbsp;&nbsp;${pageDatas[0].NAME}</td>
													<td style="width:25%;text-align: left;padding-top: 10px;">抄送人员:&nbsp;&nbsp;${pageDatas[0].COPYNAME}</td>
													<td style="width:50%;text-align: left;padding-top: 10px;"">提交时间:&nbsp;&nbsp;${pageDatas[0].STARTTIME}</td>
												</tr>-->
													<tr>
														<td style="width:75px;text-align: right;padding-top: 10px;text-align: center;">提交人员</td>
														<td style="width:75px;text-align: right;padding-top: 10px;text-align: center;">接收人员</td>
														<td style="width:75px;text-align: right;padding-top: 10px;text-align: center;">抄送人员</td>
														<td style="width:75px;text-align: right;padding-top: 10px;text-align: center;">提交时间</td>
			</tr>
													<tr>
														<td style="padding-top: 10px;text-align: center;">${pageDatas[0].NAME}</td>
														<td style="padding-top: 10px;text-align: center;">${pageDatas[0].TONAME}</td>
														<td style="padding-top: 10px;text-align: center;">${pageDatas[0].COPE_NAME}</td>
														<td style="padding-top: 10px;text-align: center;">${pageDatas[0].STARTTIME}</td>
														
													</tr>
												</table>
												<c:if test="${null == pd.msg or pd.msg != 'admin' }">
													<form action="rutask/handle" name="Form" id="Form" method="post">
														<input type="hidden" name="ID_" id="ID_" value="${pd.ID_}" />
														<input type="hidden" name="ASSIGNEE_" id="ASSIGNEE_" value="" />
														<input type="hidden" name="PROC_INST_ID_" id="PROC_INST_ID_" value="${pd.PROC_INST_ID_}" />
														<input type="hidden" name="msg" id="msg" value="yes" />
														<div id="showform" style="padding-top: 0px;">
															<table class="table table-hover">
																<thead>
																	<tr>
																		<th style="width:50px;">NO</th>
																		<th style="border: 1px solid #ebeef5;">标题</th>
																		<th style="border: 1px solid #ebeef5;">计划明细</th>
																		<th style="border: 1px solid #ebeef5;">完成时间</th>
																		<th style="border: 1px solid #ebeef5;">完成进度</th>
																		<th style="border: 1px solid #ebeef5;">评分</th>
																	</tr>
																</thead>
																<tbody id="tablboy">
																	<!-- 开始循环 -->
																	<c:choose>
																		<c:when test="${not empty pageDatas}">
																			<c:forEach items="${pageDatas}" var="var" varStatus="vs">
																				<tr>
																					<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
																					<td class="title" style="border: 1px solid #ebeef5;vertical-align: middle;text-align: center;">${var.TITLE}</td>
																					<td style="word-break: break-all; word-wrap: normal;white-space:pre-wrap;border: 1px solid #ebeef5; ">${var.CONTENTDETAIL}</td>
																					<td style="border: 1px solid #ebeef5;">${var.PLANTIME}</td>
																					<td style="border: 1px solid #ebeef5;">${var.PROGRESS}</td>
																					<td style="border: 1px solid #ebeef5;">
																						<input id="SCORE" style="width: 50px;" type="text" onKeyUp="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
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
															<table id="table_report" class="table table-striped table-bordered table-hover">
																<tr>
																	<td style="text-align: center;" colspan="10">
																		<a class="btn btn-light btn-sm" onclick="handle('yes');"><i class="feather icon-check"></i>通过</a>
																		<a class="btn btn-light btn-sm" onclick="isDel('${pd.PROC_INST_ID_}');" style="margin-left: -8px;" data-toggle="modal" data-target="#exampleModal"><i class="feather icon-trash-2"></i>终止</a>
																		<a class="btn btn-light btn-sm" onclick="top.Dialog.close();" style="margin-left: -8px;"><i class="feather icon-corner-right-down"></i>取消</a>
																	</td>
																</tr>
															</table>
														</div>

														<!-- [加载状态 ] start -->
														<div id="jiazai" style="display:none;margin-top:50px;">
															<div class="d-flex justify-content-center">
																<div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
																	<span class="sr-only">Loading...</span>
																</div>
															</div>
														</div>
														<!-- [ 加载状态  ] End -->

													</form>

													<!-- 终止弹窗  -->
													<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
														<div class="modal-dialog" role="document">
															<div class="modal-content">
																<div class="modal-header">
																	<h5 class="modal-title" id="exampleModalLabel">要终止此流程吗?</h5>
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
																	<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="wclose();">取消</button>
																	<button type="button" class="btn btn-primary" onclick="del();">终止</button>
																</div>
															</div>
														</div>
													</div>
													<!-- 终止弹窗  -->

												</c:if>
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
																<c:if test="${var.ASSIGNEE_ != NULL}">
																	<a onclick="viewUser('${var.ASSIGNEE_}')" style="cursor:pointer;"><i style="margin-top:-3px;margin-left: -6px;" class="feather icon-search"></i>${var.ASSIGNEE_}</a>
																</c:if>
															</td>
															<td style="padding-top: 10px;">${fn:substring(var.START_TIME_ ,0,19)}</td>
															<td style="padding-top: 10px;">
																<c:if test="${var.END_TIME_ == NULL}">正在审批……</c:if>
																<c:if test="${var.END_TIME_ != NULL}">${fn:substring(var.END_TIME_ ,0,19)}</c:if>
															</td>
															<td class='center'>${var.ZTIME}</td>
															<td style="padding-top: 10px;">
																<c:forEach items="${fn:split(var.TEXT_,',fh,')}" var="val" varStatus="dvs">
																	<c:if test="${dvs.index == 0 }">${val}</c:if>
																	<c:if test="${dvs.index == 1 }">
																		<a onclick="details('d${vs.index+1}')" style="cursor:pointer;" title="详情">&nbsp;<i style="margin-top:-3px;margin-left: -6px;" class="feather icon-search"></i></a>
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
														<td style="text-align: center;">
															<p class="text-warning bigger-110 orange" style="padding-top: 5px;">如果图片显示不全,点击最大化按钮</p>
														</td>
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
		<script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>

		<!-- 表单验证提示 -->
		<script src="assets/js/jquery.tips.js"></script>

		<!-- 百度富文本编辑框-->
		<!--<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>-->
		<!-- 百度富文本编辑框-->

		<script type="text/javascript">
			//查看用户
			function viewUser(USERNAME) {
				if('admin' == USERNAME) {
					swal("禁止查看!", "不能查看admin用户!", "warning");
					return;
				}
				var diag = new top.Dialog();
				diag.Drag = true;
				diag.Title = "资料";
				diag.URL = '<%=basePath%>user/view?USERNAME=' + USERNAME;
				diag.Width = 600;
				diag.Height = 319;
				diag.CancelEvent = function() { //关闭事件
					diag.close();
				};
				diag.show();
			}
			//合并标题单元格
			$(function() {
				$('.title').each(function(index, element) {
					if(!$(this).hasClass('hide')) {
						var next = $(this).parent('tr').next('tr').children('.title'); //下一个合并的对象
						$(this).attr('rowspan', 1);
						while($(this).text() == next.text()) {
							$(this).attr('rowspan', parseInt($(this).attr('rowspan')) + 1);
							next.hide();
							next.addClass('hide');
							next = next.parent('tr').next('tr').children('.title'); //下一个合并的对象
						}
					}
				});
			});
			//审批意见详情页
			function details(htmlId) {
				var content = $("#" + htmlId).val().split(',fh,');
				top.handleDetails(content[1]);
				var diag = new top.Dialog();
				diag.Modal = false; //有无遮罩窗口
				diag.Drag = true;
				diag.Title = "审批意见";
				diag.ShowMaxButton = true; //最大化按钮
				diag.ShowMinButton = true; //最小化按钮
				diag.URL = '<%=basePath%>rutask/details';
				diag.Width = 760;
				diag.Height = 500;
				diag.CancelEvent = function() { //关闭事件
					diag.close();
				};
				diag.show();
			}

			function contentmx(id) {
				var diag = new top.Dialog();
				diag.Modal = false; //有无遮罩窗口
				diag.Drag = true;
				diag.Title = "提交详情";
				diag.ShowMaxButton = true; //最大化按钮
				diag.ShowMinButton = true; //最小化按钮
				diag.URL = '<%=basePath%>rutask/contentDetails?PROC_INST_ID_=' + id + '&isRun=0';
				diag.Width = 900;
				diag.Height = 700;
				diag.CancelEvent = function() { //关闭事件
					diag.close();
				};
				diag.show();
			}

			//选择办理人
			function getUser() {
				var diag = new top.Dialog();
				diag.Drag = true;
				diag.Title = "选择办理人";
				diag.URL = '<%=basePath%>user/listUsersForWindow';
				diag.Width = 700;
				diag.Height = 545;
				diag.Modal = true; //有无遮罩窗口
				diag.ShowMaxButton = true; //最大化按钮
				diag.ShowMinButton = true; //最小化按钮
				diag.CancelEvent = function() { //关闭事件
					var USERNAME = diag.innerFrame.contentWindow.document.getElementById('USERNAME').value;
					if("" != USERNAME) {
						$("#ASSIGNEE_").val(USERNAME);
						$("#ASSIGNEE_2").val(USERNAME);
					}
					diag.close();
				};
				diag.show();
			}

			//选择角色
			function getRole() {
				var diag = new top.Dialog();
				diag.Drag = true;
				diag.Title = "选择1111角色";
				diag.URL = '<%=basePath%>role/roleListWindow?ROLE_ID=1';
				diag.Width = 700;
				diag.Height = 545;
				diag.Modal = true; //有无遮罩窗口
				diag.ShowMaxButton = true; //最大化按钮
				diag.ShowMinButton = true; //最小化按钮
				diag.CancelEvent = function() { //关闭事件
					var RNUMBER = diag.innerFrame.contentWindow.document.getElementById('RNUMBER').value;
					if("" != RNUMBER) {
						$("#ASSIGNEE_").val(RNUMBER);
						$("#ASSIGNEE_2").val(RNUMBER);
					}
					diag.close();
				};
				diag.show();
			}

			//清空下一任务对象
			function clean() {
				$("#ASSIGNEE_").val("");
				$("#ASSIGNEE_2").val("");
			}

			//办理任务
			function handle(msg) {
				$("#msg").val(msg);
				var scores = [];
				var isNUll = false;
				$("#tablboy").find("tr").each(function() {
					var tdArr = $(this).children();
					var score = tdArr.eq(5).find("input").val();
					if(score == "" || Number(score) < 0 || Number(score) > 100) {
						isNUll = true;
					}
					scores.push(score)
				});
				if(isNUll == true) {
					$("#SCORE").tips({
						side: 3,
						msg: '请对所有工作计划进行评分且分数在0-100之间',
						bg: '#AE81FF',
						time: 2
					});
					$("#SCORE").focus();
					return false;
				}
				$("#PROC_INST_ID_").val()
				$.ajax({
					type: "POST",
					url: '<%=basePath%>rutask/putScore?PROC_INST_ID_=' + $("#PROC_INST_ID_").val() + '&scores=' + scores,
					data: {},
					dataType: 'json',
					cache: false,
					success: function(data) {}
				});

				$("#Form").submit();
				$("#showform").hide();
				$("#jiazai").show();
			}

			//是否终止
			function isDel(Id) {
				$("#recipient-id").val(Id);
				$("#showform").hide();
			}

			//提交终止
			function del() {
				var Id = $("#recipient-id").val();
				var reason = $("#message-text").val();
				if('' == reason) {
					swal("", "还未写终止缘由!", "warning");
					return false;
				}
				var url = "<%=basePath%>ruprocdef/delete?PROC_INST_ID_=" + Id + "&reason=" + encodeURI(encodeURI(reason)) + "&tm=" + new Date().getTime();
				$.get(url, function(data) {
					if("ok" == data.msg) {
						swal("", "已经终止!", "success");
						setTimeout('twclose()', 1500);
					}
				});
			}

			//取消终止
			function wclose() {
				$("#showform").show();
			}

			//关闭弹窗
			function twclose() {
				top.Dialog.close();
			}
		</script>
		<c:if test="${null == pd.msg or pd.msg != 'admin' }">
			<script type="text/javascript">
				//百度富文本
				//setTimeout("ueditor()",500);
				//function ueditor(){
				//	var ue = UE.getEditor('editor');
				//}
				//ueditor有标签文本
				function getContent() {
					var arr = [];
					arr.push(UE.getEditor('editor').getContent());
					return arr.join("");
				}
			</script>
		</c:if>
	</body>

</html>