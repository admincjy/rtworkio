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
    <meta name="author" content="FH Admin  " />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
    <!-- 日期插件 -->
    <link rel="stylesheet" href="assets/plugins/material-datetimepicker/css/bootstrap-material-datetimepicker.css">
    
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
					
								<form action="myleave/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
									<input type="hidden" name="MYLEAVE_ID" id="MYLEAVE_ID" value="${pd.MYLEAVE_ID}"/>
									<div id="showform" style="padding-top: -10px;">
										 <div class="input-group input-group-sm mb-3" style="margin-top:5px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">开始时间</span></span>
		                                     </div>
		                                     <input type="text" class="form-control date-format" name="STARTTIME" id="STARTTIME"  value="${pd.STARTTIME}" readonly="readonly" placeholder="这里输入开始时间" title="开始时间">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">结束时间</span></span>
		                                     </div>
		                                     <input type="text" class="form-control date-format" name="ENDTIME" id="ENDTIME"  value="${pd.ENDTIME}" readonly="readonly" placeholder="这里输入结束时间" title="结束时间">
		                                 </div>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top:-10px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">请假类型</span></span>
		                                     </div>
		                                     <div style="width:206px;margin-left: 1px;">
		                                     <select class="js-example-placeholder-multiple col-sm-12" name="TYPE" id="TYPE" data-placeholder="请假类型"></select>
		                                     </div>
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">请假时长</span></span>
		                                     </div>
		                                     <input type="text" class="form-control" name="WHENLONG" id="WHENLONG" value="${pd.WHENLONG }" maxlength="32" placeholder="这里输入时长" title="时长" style="height: 33px;">
		                                 </div>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top:-10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">请假事由</span></span>
		                                    </div>
		                                    <textarea class="form-control" name="REASON" id="REASON" maxlength="1000" placeholder="这里输入事由" title="事由" style="height: 339px;">${pd.REASON}</textarea>
		                                 </div>
										 <div class="input-group" style="margin-top:10px;background-color: white" >
							            	<span style="width: 100%;text-align: center;">
							            		<a class="btn btn-light btn-sm" onclick="save();">保存请假单</a>
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
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
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
		
	//初始分类,调用数据字典
	$(function() {
		var TYPE = "${pd.TYPE}";
		$.ajax({
			type: "POST",
			url: '<%=basePath%>dictionaries/getLevels?tm='+new Date().getTime(),
	    	data: {DICTIONARIES_ID:'6d30b170d4e348e585f113d14a4dd96d'},//6d30b170d4e348e585f113d14a4dd96d 为请假类型ID
			dataType:'json',
			cache: false,
			success: function(data){
				 $.each(data.list, function(i, dvar){
					 if(TYPE == dvar.BIANMA){
						 $("#TYPE").append("<option value="+dvar.NAME+" selected='selected'>"+dvar.NAME+"</option>");
					 }else{
						 $("#TYPE").append("<option value="+dvar.NAME+">"+dvar.NAME+"</option>");
					 }
				 });
			}
		});
	});
		
	//保存
	function save(){
		if($("#STARTTIME").val()==""){
			$("#STARTTIME").tips({
				side:3,
	            msg:'请输入开始时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#STARTTIME").focus();
		return false;
		}
		if($("#ENDTIME").val()==""){
			$("#ENDTIME").tips({
				side:3,
	            msg:'请输入结束时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ENDTIME").focus();
		return false;
		}
		if($("#TYPE").val()==""){
			$("#TYPE").tips({
				side:3,
	            msg:'请选择请假类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TYPE").focus();
		return false;
		}
		if($("#WHENLONG").val()==""){
			$("#WHENLONG").tips({
				side:3,
	            msg:'请输入时长',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#WHENLONG").focus();
		return false;
		}
		if($("#REASON").val()==""){
			$("#REASON").tips({
				side:3,
	            msg:'请输入事由',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#REASON").focus();
		return false;
		}
		$("#Form").submit();
		$("#showform").hide();
		$("#jiazai").show();
	}
		
</script>

</body>
</html>