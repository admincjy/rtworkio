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
        <div>
            <div class="pcoded-content">
                <div class="pcoded-inner-content">
                    <div class="main-body">
                        <div class="page-wrapper">
                            <!-- [ Main Content ] start -->
                            <div class="row">
	
								<form action="fhmodel/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
									<div id="showform">
							            <div class="input-group input-group-sm mb-3" style="max-width: 553px;margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">模型名称</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="modelname" id="modelname" maxlength="32" placeholder="这里输入模型名称" title="模型名称">
		                                </div>
		                                <div class="input-group input-group-sm mb-3" style="max-width: 553px;margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">模型分类</span></span>
		                                    </div>
		                                    <select name="category" id="category"  title="模型分类" style="width:475px;padding-left:10px;border: 1px solid #CED4DA;transparent;appearance:none;-moz-appearance:none;-webkit-appearance:none;"></select>
		                                </div>
		                                <div class="input-group input-group-sm mb-3" style="max-width: 553px;margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">模型描述</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="description" id="description" maxlength="100" placeholder="这里输入模型描述" title="模型描述">
		                                </div>
		                                <div class="input-group input-group-sm mb-3" style="max-width: 553px;margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">流程名称</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="name" id="name" maxlength="32" placeholder="这里输入流程名称" title="流程名称">
		                                </div>
		                                <div class="input-group input-group-sm mb-3" style="max-width: 553px;margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">流程标识</span></span>
		                                    </div>
		                                    <select name="process_id" id="process_id"  title="流程标识" style="width:475px;padding-left:10px;border: 1px solid #CED4DA;transparent;appearance:none;-moz-appearance:none;-webkit-appearance:none;"></select>
		                                </div>
		                                <div class="input-group input-group-sm mb-3" style="max-width: 553px;margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">流程名称</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="process_author" id="process_author" value="${pd.process_author }" maxlength="32" placeholder="这里输入流程作者" title="流程作者">
		                                </div>
							            <div class="input-group" style="margin-top:15px;background-color: white" >
							            	<span style="width: 100%;text-align: center;">
							            		<a class="btn btn-light btn-sm" onclick="save();">保存</a>
							            		<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">取消</a>
							            	</span>
							             </div>
						           </div>
									<!-- [加载状态 ] start -->
								    <div id="jiazai" style="display:none;margin-top:5px;">
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
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
  	
<script type="text/javascript">
//初始选择项,调用数据字典
$(function() {
	//流程分类
	$.ajax({
		type: "POST",
		url: '<%=basePath%>dictionaries/getLevels?tm='+new Date().getTime(),
    	data: {DICTIONARIES_ID:'act001'},//act001 为工作流分类
		dataType:'json',
		cache: false,
		success: function(data){
			$("#category").html('<option value="" >请选择分类</option>');
			 $.each(data.list, function(i, dvar){
					$("#category").append("<option value="+dvar.BIANMA+">"+dvar.NAME+"</option>");
			 });
		}
	});
	//为流程标识
	$.ajax({
		type: "POST",
		url: '<%=basePath%>dictionaries/getLevels?tm='+new Date().getTime(),
    	data: {DICTIONARIES_ID:'act002'},//act002为流程标识
		dataType:'json',
		cache: false,
		success: function(data){
			$("#process_id").html('<option value="" >请选择流程标识</option>');
			 $.each(data.list, function(i, dvar){
					$("#process_id").append("<option value="+dvar.BIANMA+">"+dvar.NAME+"("+dvar.BIANMA+")"+"</option>");
			 });
		}
	});
});

//保存
function save(){
	if($("#modelname").val()==""){
		$("#modelname").tips({
			side:3,
            msg:'请输入模型名称',
            bg:'#AE81FF',
            time:2
        });
		$("#modelname").focus();
	return false;
	}
	if($("#category").val()==""){
		$("#category").tips({
			side:3,
            msg:'请输入模型分类',
            bg:'#AE81FF',
            time:2
        });
		$("#category").focus();
	return false;
	}
	if($("#description").val()==""){
		$("#description").tips({
			side:3,
            msg:'请输入模型描述',
            bg:'#AE81FF',
            time:2
        });
		$("#description").focus();
	return false;
	}
	if($("#name").val()==""){
		$("#name").tips({
			side:3,
            msg:'请输入流程名称',
            bg:'#AE81FF',
            time:2
        });
		$("#name").focus();
	return false;
	}
	if($("#process_id").val()==""){
		$("#process_id").tips({
			side:3,
            msg:'请选择流程标识',
            bg:'#AE81FF',
            time:2
        });
		$("#process_id").focus();
	return false;
	}
	if($("#process_author").val()==""){
		$("#process_author").tips({
			side:3,
            msg:'请输入流程作者',
            bg:'#AE81FF',
            time:2
        });
		$("#process_author").focus();
	return false;
	}
	$("#Form").submit();
	$("#showform").hide();
	$("#jiazai").show();
}

</script>
</body>
</html>