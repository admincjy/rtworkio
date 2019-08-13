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
		<meta name="author" content="FH Admin" />

		<link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="assets/fonts/material/css/materialdesignicons.min.css">
		<link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
		<link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
		<link rel="stylesheet" href="assets/css/style.css">

		<!-- 日期插件 -->
		<link rel="stylesheet" href="assets/date/css/bootstrap-datetimepicker.min.css">
		<style type="text/css">
			th {
				background: #455661;
				color: white;
			}
			
			th,
			td {
				text-align: center;
				word-break: break-all;
				word-wrap: normal;
				border: 1px solid #EAEDF4;
			}
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

										<form action="studyplan/year" method="post" name="Form" id="Form">
											<!-- 检索  -->
											<div style="padding-left: 20px;padding-top: 15px;">
												<table>
													<tr>
														<td style="border: none;">
														    <input type="text"  readonly class="form_datetime" name="YEAR" id="YEAR" value=""  maxlength="32" placeholder="这里输入查询年份" title="">

		                                                    
		                                                    <span style="margin-top:8.5px ;margin-left:10px;">搜索：</span>
															<input type="text" name="ASSIGNEE_2" id="ASSIGNEE_2" value="" style="width:150px;" readonly="readonly" />
															<a class="btn btn-light btn-sm" onclick="clean();" title="清空" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;">
																<div style="margin-top:0px;margin-left: -6px;">清</div>
															</a>
															<a class="btn btn-light btn-sm" title="选择办理人(单人)" onclick="getUser();" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;">
																<i class="feather icon-user" style="margin-top:-6px;margin-left: -6px;"></i>
															</a>
															<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索"><i style="margin-top:-3px;margin-left: -6px;" class="feather icon-search"></i></a>
															
															<!--<a class="btn btn-light btn-sm" title="选择办理角色(此角色下所有人都可以办理)" onclick="getRole();" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;margin-left:-8px;">
																<i class="feather icon-users" style="margin-top:-6px;margin-left: -6px;"></i>
															</a>-->
														</td>
														<td style="vertical-align:top;padding-left:5px;border: none;">
															<!--<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索"><i style="margin-top:-3px;margin-left: -6px;" class="feather icon-search"></i></a>-->
															<shiro:hasPermission name="toExcel">
																<a class="btn btn-light btn-sm" onclick="toExcel();" style="width: 23px;height:30px;margin-top:1px;margin-left: -9px;" title="导出到excel表格">
																	<i style="margin-top:-3px;margin-left: -6px;" class="mdi mdi-cloud-download"></i>
																</a>
															</shiro:hasPermission>
														</td>
													</tr>
												</table>
											</div>
											<!-- 主内容  -->
											
													<div class="card-block table-border-style" style="margin-top: -15px" id="exclTable">
														<div class="table-responsive">
															<table class="table table-hover" style="border: 1px solid #EAEDF4;">
																<thead>
																	<tr style="border: 1px solid #EAEDF4;">
																		<th>提交人</th>
																		<th>月份</th>
																		<th>书目</th>
																		<th>作者</th>
																		<th>书本信息</th>
																		<th>评分</th>
																		<th>页码</th>
																		<th>页数</th>
																		<th>合计页码</th>
																	</tr>
																</thead>
																<tbody>
																	<!-- 开始循环 -->
																	<c:choose>
																		<c:when test="${not empty varList}">
																			<c:forEach items="${varList}" var="var" varStatus="vs">
																				<tr ondblclick="contentmx('${var.PROC_INST_ID_}')">
																					<td class="name" style="vertical-align: middle;text-align: center;">${var.NAME}</td>
																					<td class="month" style="vertical-align: middle;text-align: center;">${var.MONTH}</td>
																					<td>${var.BOOKNAME}</td>
																					<td>${var.AUTHOR}</td>
																					<td>${var.BOOKCONTET}</td>
																					<td>${var.SCORE}</td>
																					<td>${var.COUNT}</td>
																					<td>${var.TOTAL_PAGE}</td>
																					<td class="sum"  style="vertical-align: middle;text-align: center;">${var.TOTAL_MONTH_PAGE}</td>
																					<!--<td>${var.PROC_INST_ID_}</td>-->
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
		<script src="assets/date/js/bootstrap-datetimepicker.min.js"></script>
		<script src="assets/date/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

		<!-- 表单验证提示 -->
		<script src="assets/js/jquery.tips.js"></script>

		<script type="text/javascript">
			//合并月份单元格
			$(function() {
				$('.name').each(function(index, element) {
					if(!$(this).hasClass('hide')) {
						var next = $(this).parent('tr').next('tr').children('.name'); //下一个合并的对象
						$(this).attr('rowspan', 1);
						while($(this).text() == next.text()) {
							$(this).attr('rowspan', parseInt($(this).attr('rowspan')) + 1);
							next.hide();
							next.addClass('hide');
							next = next.parent('tr').next('tr').children('.name'); //下一个合并的对象
						}
					}
				});
			});
			$(function() {
				$('.month').each(function(index, element) {
					if(!$(this).hasClass('hide')) {
						var next = $(this).parent('tr').next('tr').children('.month'); //下一个合并的对象
						$(this).attr('rowspan', 1);
						while($(this).text() == next.text()) {
							$(this).attr('rowspan', parseInt($(this).attr('rowspan')) + 1);
							next.hide();
							next.addClass('hide');
							next = next.parent('tr').next('tr').children('.month'); //下一个合并的对象
						}
					}
				});
			});
			$(function() {
				$('.sum').each(function(index, element) {
					if(!$(this).hasClass('hide')) {
						var next = $(this).parent('tr').next('tr').children('.sum'); //下一个合并的对象
						$(this).attr('rowspan', 1);
						while($(this).text() == next.text()) {
							$(this).attr('rowspan', parseInt($(this).attr('rowspan')) + 1);
							next.hide();
							next.addClass('hide');
							next = next.parent('tr').next('tr').children('.sum'); //下一个合并的对象
						}
					}
				});
			});

			$(function() {
				var year = new Date().getFullYear();
				$("select").append($("<option value=" + year + ">" + year + "</option><option value=" + (year - 1) + ">" + (year - 1) + "</option><option value=" + (year - 2) + ">" + (year - 2) + "</option>"));
			});
			//检索
		function searchs(){
            console.log($("#ASSIGNEE_2").val())
			$("#Form").submit();
		}

			function save() {
				if($("#ASSIGNEE_2").val() == "") {
					$("#ASSIGNEE_2").tips({
						side: 3,
						msg: '请选择下一办理对象',
						bg: '#AE81FF',
						time: 2
					});
					$("#ASSIGNEE_2").focus();
					return false;
				}
				$("#Form").submit();
				$("#showform").hide();
				$("#jiazai").show();
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

//			function getRole() {
//				var diag = new top.Dialog();
//				diag.Drag = true;
//				diag.Title = "选择角色";
//				diag.URL = '<%=basePath%>role/roleListWindow?ROLE_ID=1';
//				diag.Width = 700;
//				diag.Height = 545;
//				diag.Modal = true; //有无遮罩窗口
//				diag.ShowMaxButton = true; //最大化按钮
//				diag.ShowMinButton = true; //最小化按钮
//				diag.CancelEvent = function() { //关闭事件
//					var RNUMBER = diag.innerFrame.contentWindow.document.getElementById('RNUMBER').value;
//					if("" != RNUMBER) {
//						$("#ASSIGNEE_").val(RNUMBER);
//						$("#ASSIGNEE_2").val(RNUMBER);
//					}
//					diag.close();
//				};
//				diag.show();
//			}

			//清空下一任务对象
			function clean() {
				$("#ASSIGNEE_").val("");
				$("#ASSIGNEE_2").val("");
			}

			$(function() {});
						$(function() {
					        $(".form_datetime").datetimepicker({
    		 format: 'yyyy',
			 weekStart: 1,
	         autoclose: true,
	         startView: 4,
	         minView: 4,
	         forceParse: false,
	         language: 'zh-CN'
        	});
						});
			//导出excel
			function toExcel() {
				var filename = "工作计划执行情况表"
				var html = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40'><head><meta charset='utf-8' /><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>工作计划执行情况表</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body>" + document.getElementById("exclTable").outerHTML + "</body></html>";
				var blob = new Blob([html], {
					type: "application/vnd.ms-excel"
				});
				var aurl = URL.createObjectURL(blob);
				var link = document.createElement('a')
				link.setAttribute('href', aurl)
				link.setAttribute('download', filename)
				document.body.appendChild(link)
				link.click()
				document.body.removeChild(link)
			}

			//			function contentmx(id) {
			//				if(id == "") {
			//					swal("查询失败", "该员工未提交!", "error");
			//					return false;
			//				}
			//				var diag = new top.Dialog();
			//				diag.Modal = false; //有无遮罩窗口
			//				diag.Drag = true;
			//				diag.Title = "提交详情";
			//				diag.ShowMaxButton = true; //最大化按钮
			//				diag.ShowMinButton = true; //最小化按钮
			//				diag.URL = '<%=basePath%>rutask/contentViewDetails?PROC_INST_ID_=' + id + '&isRun=1';
			//				diag.Width = 760;
			//				diag.Height = 500;
			//				diag.CancelEvent = function() { //关闭事件
			//					diag.close();
			//				};
			//				diag.show();
			//			}
		</script>
		
	</body>

</html>