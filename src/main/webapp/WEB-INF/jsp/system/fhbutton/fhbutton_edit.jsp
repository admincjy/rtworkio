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
        <div class="pcoded-wrapper">
            <div class="pcoded-content">
                <div class="pcoded-inner-content">
                    <div class="main-body">
                        <div class="page-wrapper">
                            <!-- [ Main Content ] start -->
                            <div class="row">
                            
								<form action="fhbutton/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
	    							<input type="hidden" name="FHBUTTON_ID" id="FHBUTTON_ID" value="${pd.FHBUTTON_ID}"/>
									<div id="showform" style="padding-top: 1px;">
	                            
		                                <div class="input-group input-group-sm mb-3">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">按钮名称</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="NAME" id="NAME" value="${pd.NAME }" maxlength="32" placeholder="这里输入按钮名称" title="按钮名称">
		                                 </div>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">权限标识</span></span>
		                                     </div>
		                                     <input type="text" class="form-control" name="SHIRO_KEY" id="SHIRO_KEY" oninput="changecode(this.value)"  value="${pd.SHIRO_KEY }"  maxlength="32" placeholder="这里输入权限标识" title="权限标识" >
		                                 </div>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">备注说明</span></span>
		                                     </div>
		                                     <input class="form-control" type="text" name="BZ" id="BZ"  value="${pd.BZ }"  maxlength="50" placeholder="这里输入备注说明" title="备注说明" >
		                                 </div>
		                                 <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                     <div class="input-group-prepend">
		                                         <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">标签代码</span></span>
		                                     </div>
		                                     <textarea class="form-control" rows="5" cols="10" id="code" readonly="readonly" title="代码区,禁止手动输入"></textarea>
		                                 </div>
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
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">
	$(function() {
		var str1 = '<shiro'+':hasPermission name="'+$("#SHIRO_KEY").val();
		var str2 = '">这里放按钮<'+'/shiro:'+'hasPermission>';
		$("#code").val(str1+str2);
	});
	//拼代码
	function changecode(value){
		var str1 = '<shiro'+':hasPermission name="';
		var str2 = '">这里放按钮<'+'/shiro:'+'hasPermission>';
		$("#code").val(str1 + value +str2);
	}
	//保存
	function save(){
		if($("#NAME").val()==""){
			$("#NAME").tips({
				side:3,
	            msg:'请输入名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NAME").focus();
		return false;
		}
		if($("#SHIRO_KEY").val()==""){
			$("#SHIRO_KEY").tips({
				side:3,
	            msg:'请输入权限标识',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SHIRO_KEY").focus();
		return false;
		}
		if($("#BZ").val()==""){
			$("#BZ").tips({
				side:3,
	            msg:'请输入备注',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BZ").focus();
		return false;
		}
		$("#Form").submit();
		$("#showform").hide();
		$("#jiazai").show();
		}
</script>
</body>
</html>