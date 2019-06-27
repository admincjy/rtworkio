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
    <title>${sessionScope.sysName} - 注册</title>
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
    <meta name="author" content="FH Admin q 3 1 35 96 790" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

</head>

<body>
    <div class="auth-wrapper aut-bg-img-side cotainer-fiuid align-items-stretch">
        <div class="row align-items-center w-100 align-items-stretch bg-white">
        	<!-- w3-agilefireworks 这个为烟花效果clss，去掉的话，删除下面div中class的 w3-agilefireworks  -->
            <div class="w3-agilefireworks d-none d-lg-flex col-lg-8 aut-bg-img align-items-center d-flex justify-content-center">
                <div class="col-md-8">
                    <h1 class="text-white mb-5">FH Admin</h1>
                    <p class="text-white">Fhadmin is the most praised framework platform in the world.</p>
                </div>
            </div>
            <div class="col-lg-4 align-items-stret h-100 align-items-center d-flex justify-content-center">
                <div class="auth-content text-center">
                    <div class="mb-4">
                        <i class="feather icon-user-plus auth-icon"></i>
                    </div>
                    <h3 class="mb-4">注册</h3>
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="请输入用户名" name="RUSERNAME" id="RUSERNAME">
                    </div>
                    <div class="input-group mb-4">
                        <input type="password" class="form-control" placeholder="请输入密码" name="RPASSWORD" id="RPASSWORD">
                    </div>
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="您的姓名" name="RNAME" id="RNAME">
                    </div>
                    <button class="btn btn-primary shadow-2 mb-4" onclick="register();">提交</button>
                    <p class="mb-0 text-muted">已经有账户? <a href="admin/login"> 登录</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Required Js -->
    <script src="assets/js/vendor-all.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    
    <script src="assets/js/register.js"></script>
    <script src="assets/js/jquery.tips.js"></script>
    <script src="assets/js/jQuery.md5.js"></script>
    
	<!-- 烟花效果 --> 
	<script type="text/javascript" src="assets/register/js/jquery.fireworks.js"></script>
	<script>	
		setTimeout(function() {
			$('.w3-agilefireworks').fireworks();   
		});
	</script>
	<!-- //烟花效果  -->

</body>
</html>
