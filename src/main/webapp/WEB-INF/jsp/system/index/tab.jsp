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
<script type="text/javascript" src="assets/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="plugins/tab/js/framework.js"></script>
<link  type="text/css" href="plugins/tab/css/import_basic.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" id="skin" prePath="plugins/tab/" />
<script type="text/javascript" charset="utf-8" src="plugins/tab/js/tab.js"></script>

<!-- 右键菜单 -->
<script type="text/javascript" src="plugins/contextmenu/jquery.contextmenu.js"></script>
<link rel="stylesheet" href="plugins/contextmenu/jquery.contextmenu.css">
<script type="text/javascript">
var nowid = "";
</script>
</head>
<body style="background-color: rgba(255, 255, 255, 0);">
	<div id="tab_menu"></div>
	<div style="width: 100%;">
		<div id="page" style="width: 100%; height: 100%;"></div>
	</div>
</body>
<script src="assets/js/tab.js"></script>
</html>

