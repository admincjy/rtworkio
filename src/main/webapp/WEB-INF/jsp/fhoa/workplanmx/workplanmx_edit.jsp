<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    
    <!-- 日期插件 -->
    <link rel="stylesheet" href="assets/date/css/bootstrap-datetimepicker.min.css">    
    
    	
    <!-- select插件 -->
    <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="assets/plugins/multi-select/css/multi-select.css">

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
                            
								<form action="workplanmx/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
									<input type="hidden" name="WORKPLANMX_ID" id="WORKPLANMX_ID" value="${pd.WORKPLANMX_ID}"/>
									<input type="hidden" name="WORKPLAN_ID" id="WORKPLAN_ID" value="${pd.WORKPLAN_ID}"/>
									<div id="showform">
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">计划标题</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="TITLE" id="TITLE" value="${pd.TITLE}" maxlength="255" placeholder="这里输入工作计划标题" title="工作计划标题">
	                                </div>
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">计划明细</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="CONTENTDETAIL" id="CONTENTDETAIL" value="${pd.CONTENTDETAIL}" maxlength="255" placeholder="这里输入工作计划明细" title="工作计划明细">
	                                </div>
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">进度百分比</span></span>
	                                    </div>
	                                    <input type="number" class="form-control" name="PROGRESS" id="PROGRESS" value="${pd.PROGRESS}" maxlength="255" placeholder="这里输入完成进度百分比" title="进度百分比">
	                                </div>
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">完成时间</span></span>
	                                    </div>
	                                   <!-- <input type="text" class="form-control date" name="PLANTIME" id="PLANTIME" value="${pd.PLANTIME}" maxlength="32" placeholder="这里输入计划完成时间" title="计划完成时间">	-->	
                                        <input size="90" type="text"  readonly class="form_datetime" name="PLANTIME" id="PLANTIME" value="${pd.PLANTIME}"  maxlength="32" placeholder="这里输入计划完成时间" title="计划完成时间">
	                                </div>
						            <!--<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">考核评分</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="SCORE" id="SCORE" value="${pd.SCORE}" maxlength="255" placeholder="这里输入考核评分" title="考核评分">
	                                </div>-->
								 	<div class="input-group" style="margin-top:10px;background-color: white" >
						            	<span style="width: 100%;text-align: center;">
						            		<a class="btn btn-light btn-sm" onclick="save();">保存</a>
						            		<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">取消</a>
						            	</span>
						            </div>
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

<!-- 日期插件 -->
<script src="assets/date/js/bootstrap-datetimepicker.min.js"></script>
<script src="assets/date/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

<!-- select插件 -->
<script src="assets/plugins/select2/js/select2.full.min.js"></script>
<script src="assets/plugins/multi-select/js/jquery.quicksearch.js"></script>
<script src="assets/plugins/multi-select/js/jquery.multi-select.js"></script>
<script src="assets/js/pages/form-select-custom.js"></script>

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">
        $(".form_datetime").datetimepicker({
		    minView: "month", //选择日期后，不会再跳转去选择时分秒 
		    language:  'zh-CN',
        	format: 'yyyy-mm-dd',
		    todayBtn:  1,
		    autoclose: 1
        	});
        //保存
		function save(){
			if($("#TITLE").val()==""){
				$("#TITLE").tips({
					side:3,
		            msg:'请输入工作计划标题',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TITLE").focus();
			return false;
			}
			if($("#CONTENTDETAIL").val()==""){
				$("#CONTENTDETAIL").tips({
					side:3,
		            msg:'请输入工作计划明细',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTENTDETAIL").focus();
			return false;
			}
			if($("#PLANTIME").val()==""){
				$("#PLANTIME").tips({
					side:3,
		            msg:'请输入计划完成时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PLANTIME").focus();
			return false;
			}
			if($("#PROGRESS").val()==""){
				$("#PROGRESS").tips({
					side:3,
		            msg:'请输入完成进度百分比',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROGRESS").focus();
			return false;
			}else if($("#PROGRESS").val()<0||$("#PROGRESS").val()>100){
				$("#PROGRESS").tips({
					side:3,
		            msg:'请输入0到100进度百分比',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROGRESS").focus();
			return false;
			}
//			if($("#SCORE").val()==""){
//				$("#SCORE").tips({
//					side:3,
//		            msg:'请输入考核评分',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#SCORE").focus();
//			return false;
//			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
		
		$(function() {


		});
</script>

</body>
</html>