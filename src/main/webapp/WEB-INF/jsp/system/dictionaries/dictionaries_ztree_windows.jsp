<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	
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
    
	<script type="text/javascript" src="assets/js/jquery-1.7.2.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/2.6/zTreeStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
	<style type="text/css">
		span{ color:black;}
	</style>
<body>

</head>
<body>

    <!-- [加载状态 ] start -->
    <div class="loader-bg">
        <div class="loader-track">
            <div class="loader-fill"></div>
        </div>
    </div>
    <!-- [ 加载状态  ] End -->

	<div style="overflow: scroll; scrolling: yes;height:435px;width: 338px;">
	<ul id="tree" class="tree" style="overflow:auto;"></ul>
	</div>
	
	<input name="DICTIONARIES_ID" id="DICTIONARIES_ID" value="" type="hidden" />
	
	<script type="text/javascript" src="assets/js/pre-loader.js"></script>
	<script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>
	
	<script type="text/javascript">
		var zTree;
		$(document).ready(function(){
			
			var setting = {
			    showLine: true,
			    checkable: false
			};
			var zTreeNodes = eval(${zTreeNodes});
			zTree = $("#tree").zTree(setting, zTreeNodes);
		});
	
		//设置ID给父窗口
		 function setDID(DICTIONARIES_ID){
			$("#DICTIONARIES_ID").val(DICTIONARIES_ID);
			top.Dialog.close();
		 }
	
	</script>
</body>
</html>