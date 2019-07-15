<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
    <meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width"/>
    <title>FH Admin</title>
    <link rel="stylesheet" type="text/css" href="mobile/static/login/css/login.css">
</head>

<body  >
<div class="mobileSina" style="margin-top:69px;">
    <header class="login_header">

        <h1><i class="logo_ico" style="display: inline-block;width: 7.3125em;height: 2.1875em;text-indent: -9999em;background: url(mobile/static/login/images/logo.png) no-repeat;background-size: 6.96875em;">FH Admin</i></h1>
        <h2 class="prompt" id="loginSource"></h2>
        
    </header>
    <section id="beforeLogin" class="login_main">
        <form method="post">
           
            <ul class="info">
                <li class="account"  id = "loginNamePanel">
                    <input type="text" name="loginname" id="loginname" autocapitalize="off" autocorrect="off" placeholder="用户名" />
                </li>
                <li  id = "loginPasswordPanel"><input type="password" name="password" id="password" placeholder="密码"/></li>
            </ul>
            <a onclick="severCheck();" class="btn_login" id="loginAction">登录</a>
                 
    	</form>
	</section>
</div>

	<center><div style="font-size:10px"></center>

</body>
<script src="assets/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">

//服务器校验
function severCheck(){
	if(check()){
		var loginname = $("#loginname").val();
		var password = $("#password").val();
		var code = " fh"+loginname+",fh,"+password;
		$.ajax({
			type: "POST",
			url: 'mobile/check',
	    	data: {KEYDATA:code,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				if("success" == data.result){
					window.location.href="mobmain/index";
					$("#loginNamePanel").tips({
						side : 1,
						msg : '正在登录 , 请稍后 ...',
						bg : '#68B500',
						time : 10
					});
				}else if("usererror" == data.result){
					$("#loginname").tips({
						side : 1,
						msg : "用户名或密码有误",
						bg : '#FF5080',
						time : 15
					});
					$("#loginname").focus();
				}else{
					$("#loginname").tips({
						side : 1,
						msg : "缺少参数",
						bg : '#FF5080',
						time : 15
					});
					$("#loginname").focus();
				}
			}
		});
	}
}

//客户端校验
function check() {
	if ($("#loginname").val() == "") {
		$("#loginname").tips({
			side : 1,
			msg : '用户名不得为空',
			bg : '#AE81FF',
			time : 3
		});
		$("#loginname").focus();
		return false;
	} else {
		$("#loginname").val(jQuery.trim($('#loginname').val()));
	}
	if ($("#password").val() == "") {
		$("#password").tips({
			side : 1,
			msg : '密码不得为空',
			bg : '#AE81FF',
			time : 3
		});
		$("#password").focus();
		return false;
	}
	return true;
}

</script>

</html>
	