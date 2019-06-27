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
<html>
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8">
	<title>FH Admin - 未找到页面  404</title>
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link rel="icon" href="assets/404/images/favicon.ico" type="image/x-icon"/>
	<!-- Google font-->
	<link rel="stylesheet" type="text/css" href="assets/404/css/style.css"/>
	<script type="text/javascript">
		isAc();
		function isAc(){
			if((window.location+"").indexOf('activiti-editor')> 0){top.Dialog.close();}
		}
	</script>
</head>
<body>
	<div id="container" class="container">
		<ul id="scene" class="scene">
			<li class="layer" data-depth="1.00"><img src="assets/404/images/404-01.png"></li>
			<li class="layer" data-depth="0.60"><img src="assets/404/images/shadows-01.png"></li>
			<li class="layer" data-depth="0.20"><img src="assets/404/images/monster-01.png"></li>
			<li class="layer" data-depth="0.40"><img src="assets/404/images/text-01.png"></li>
			<li class="layer" data-depth="0.10"><img src="assets/404/images/monster-eyes-01.png"></li>
		</ul>
		<h1 id="showform">您访问的页面不存在！</h1>
		<span>1.检查请求链接地址是不是有误  &nbsp;2.检查处理类视图映射路径</span>
	</div>
	<!-- Scripts -->
	<script src="assets/404/js/parallax.js"></script>
	<script>
	// Pretty simple huh?
	var scene = document.getElementById('scene');
	var parallax = new Parallax(scene);
	</script>

</body>
</html>
