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
    <link rel="stylesheet" href="assets/fonts/material/css/materialdesignicons.min.css">
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
							
									<form action="financialmodel/findDatabyDay" method="post" name="Form" id="Form">
									<!-- 检索  -->
									<div style="padding-left: 20px;padding-top: 15px;">
									<table style="margin-top:5px;">
										<tr>
											<td style="vertical-align:top;padding-left:5px;">
												<a class="btn btn-light btn-sm" onclick="toExcel();" style="width: 23px;height:30px;margin-top:1px;margin-left: -9px;" title="导出到excel表格">
													<i style="margin-top:-3px;margin-left: -6px;" class="mdi mdi-cloud-download"></i>
												</a>
											</td>
										</tr>
									</table>
									</div>
									<!-- 检索  -->
									<div class="card-block table-border-style" style="margin-top: -15px"  id="exclTable">
                                    	<div class="table-responsive">
                                        	<table class="table table-hover">
												<thead>
													<tr>
														<th>日期</th>
														<th>EP</th>
														<th>EPCUT</th>
														<th>BP</th>
														<th>SP</th>
														<th>NCFP</th>
														<th>OCFP</th>
														<th>DP</th>
														<th>FCFP</th>
														<th>MACD指数平滑移动平均</th>
														<th>BIAS乖离率</th>
														<th>单季度净资产收益率ROE</th>
														<th>净资产收益率ROE</th>
														<th>单季度总资产净利率ROA</th>
														<th>总资产净利率ROA</th>
														<th>单季度销售毛利率</th>
														<th>销售毛利率(TTM)</th>
														<th>单季度净资产收益率(扣除非经常损益)</th>
														<th>净资产收益率ROE(扣除/摊薄)</th>
														<th>总资产周转率(TTM)</th>
														<th>总市值</th>
													</tr>
												</thead>
																		
												<tbody>
												<!-- 开始循环 -->	
												<c:choose>
													<c:when test="${not empty PageDatas}">
														<c:forEach items="${PageDatas}" var="var" varStatus="vs">
															<tr>
																<td>${var.DATE}</td>
																<td>${var.EP}</td>
																<td>${var.EPCUT}</td>
																<td>${var.BP}</td>
																<td>${var.SP}</td>
																<td>${var.NCFP}</td>
																<td>${var.OCFP}</td>
																<td>${var.DP}</td>
																<td>${var.FCFP}</td>
																<td>${var.MACD}</td>
																<td>${var.BIAS}</td>
																<td>${var.ROE_DATA}</td>
																<td>${var.ROE}</td>
																<td>${var.ROA}</td>
																<td>${var.AOR}</td>
																<td>${var.GROSS}</td>
																<td>${var.GROSS_TTM}</td>
																<td>${var.YIE}</td>
																<td>${var.ROE_DEL}</td>
																<td>${var.TTM}</td>
																<td>${var.TOTAL_VALUE}</td>
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
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">

		
		
		
		
		//打开上传excel页面
		function fromExcel(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="从EXCEL导入到系统";
			 diag.URL = '<%=basePath%>financialmodel/goUploadExcel';
			 diag.Width = 600;
			 diag.Height = 150;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
					 searchs();
				}
				diag.close();
			 };
			 diag.show();
		}	
		
		
		//导出excel
		function toExcel(){
				var filename = "金融模型"
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
</script>

</body>
</html>