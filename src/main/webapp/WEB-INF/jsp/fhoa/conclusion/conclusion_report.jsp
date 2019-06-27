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
							
										<form action="conclusion/report" method="post" name="Form" id="Form">
											<!-- 检索  -->
											<div style="padding-left: 20px;padding-top: 15px;">
											<table>
												<tr>
													<td>
														<div class="input-group input-group-sm mb-3">
		                                                	<input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${pd.KEYWORDS }" placeholder="这里输入关键词" />
		                                                	<input type="text"  readonly class="form_datetime" name="STARTCOMMITTIME" id="STARTCOMMITTIME" value="${pd.STARTCOMMITTIME }"  maxlength="32" placeholder="这里输入开始查询时间" title="">
											           		<input type="text"  readonly class="form_datetime" name="ENDTCOMMITIME" id="ENDTCOMMITIME" value="${pd.ENDTCOMMITIME }"  maxlength="32" placeholder="这里输入结束查询时间" title="">
		                                                </div>
													</td>
													<td style="vertical-align:top;padding-left:5px;">
														<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索"><i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i></a>
														<shiro:hasPermission name="toExcel">
														<a class="btn btn-light btn-sm" onclick="toExcel();" style="width: 23px;height:30px;margin-top:1px;margin-left: -9px;" title="导出到excel表格">
															<i style="margin-top:-3px;margin-left: -6px;" class="mdi mdi-cloud-download"></i>
														</a>
														</shiro:hasPermission>
													</td>
												</tr>
											</table>
											</div>
											<!-- 检索  -->
											<div class="card-block table-border-style" style="margin-top: -15px" id="exclTable">
                                    			<div class="table-responsive">
                                        			<table class="table table-hover" >	
														<thead>
															<tr>
																<th>部门</th>
																<th>提交人</th>
																<th>接收人</th>
																<th>抄送人</th>
																<!--<th>抄送人</th>-->
																<!--<th>工作内容</th>-->
																<th>提交时间</th>
																<th>总结类型</th>
																<th>是否提交</th>
																<th>分数</th>
															</tr>
														</thead>
														<tbody>
														<!-- 开始循环 -->	
														<c:choose>
															<c:when test="${not empty varList}">
																<c:forEach items="${varList}" var="var" varStatus="vs">
																	<tr ondblclick="contentmx('${var.PROC_INST_ID_}')" >
																		<td>${var.DEPARTMENT}</td>
																		<td>${var.zname}</td>
																		<td>${var.TONAME}</td>
																		<td>${var.CCNAME}</td>
																		<td>${var.STARTTIME}</td>
																		<td>${var.TYPE}</td>
																		<td>${var.submit==0?'否':'是'}</td>
																		<td>${var.SCORE==null?'未评分':var.SCORE}</td>
																		<!--<td>${var.ENDTIME}</td>-->
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
        function dateFormat(Date,fmt) {
		  var o = {
		      "M+": Date.getMonth() + 1, //月份 
		      "d+": Date.getDate(), //日 
//		      "H+": Date.getHours(), //小时 
//		      "m+": Date.getMinutes(), //分 
//		      "s+": Date.getSeconds(), //秒 
//		      "q+": Math.floor((Date.getMonth() + 3) / 3), //季度 
//		      "S": Date.getMilliseconds() //毫秒 
		  };
		  if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (Date.getFullYear() + "").substr(4 - RegExp.$1.length));
		  for (var k in o)
		  if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		  return fmt;
		};
	    $(function () {
		    let startDate = new Date();
			startDate.setTime(new Date().getTime() - 3600 * 1000 * 24 * 6); //获取一周前的Date对象
			let startTime = dateFormat(startDate,'yyyy-MM-dd'); //获取一周前的格式化后日期
			let endTime = dateFormat(new Date(),'yyyy-MM-dd');  //获取当前格式化后日期 
			if($('#STARTCOMMITTIME').val()==""){
			   $('#STARTCOMMITTIME').val(startTime);
			}
			if($('#ENDTCOMMITIME').val()==""){
			   $('#ENDTCOMMITIME').val(endTime);
			}
		    $('#STARTCOMMITTIME').datetimepicker({
			    minView: "month", //选择日期后，不会再跳转去选择时分秒 
			    language:  'zh-CN',
	        	format: 'yyyy-mm-dd',
			    todayBtn:  1,
			    autoclose: 1
		    });
		    $('#ENDTCOMMITIME').datetimepicker({
			    minView: "month", //选择日期后，不会再跳转去选择时分秒 
			    language:  'zh-CN',
	        	format: 'yyyy-mm-dd',
			    todayBtn:  1,
			    autoclose: 1,
		    });
		});
		//检索
		function searchs(){
			$("#Form").submit();
		}
		//导出excel
		function toExcel(){
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
        function contentmx(id){
			 if(id==""){
				swal("查询失败", "该员工未提交!", "error");
			 return false;
			 }
			 var diag = new top.Dialog();
			 diag.Modal = false;			//有无遮罩窗口
			 diag.Drag=true;
			 diag.Title ="提交详情";
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.URL = '<%=basePath%>rutask/contentViewDetails?PROC_INST_ID_='+id+'&isRun=1';
			 diag.Width = 760;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
</script>

</body>
</html>