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

	<div id="showform">
		<div style="overflow: scroll; scrolling: yes;height:421px;width: 319px;">
		<ul id="tree" class="tree" style="overflow:auto;"></ul>
		</div>
		
		<div style="width: 100%;padding-top: 5px;text-align: center;">
			<a class="btn btn-light btn-sm" onclick="save();">保存</a>
			<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">取消</a>
		</div>
	</div>

    <!-- [加载状态 ] start -->
    <div id="jiazai" style="display:none;margin-top:35px;">
    	<div class="d-flex justify-content-center">
         <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
    </div>
    <!-- [ 加载状态  ] End -->
	
	<!-- App functions and actions -->
	<script type="text/javascript" src="assets/js/pre-loader.js"></script>
	<script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>
  
	<script type="text/javascript">
		var zTree;
		$(document).ready(function(){
			var setting = {
			    showLine: true,
			    checkable: true
			};
			var zTreeNodes = eval(${zTreeNodes});
			zTree = $("#tree").zTree(setting, zTreeNodes);
		});
	
		//保存
		 function save(){
			var nodes = zTree.getCheckedNodes();
			var tmpNode;
			var ids = "";
			for(var i=0; i<nodes.length; i++){
				tmpNode = nodes[i];
				if(i!=nodes.length-1){
					ids += tmpNode.id+",";
				}else{
					ids += tmpNode.id;
				}
			}
			var msg = "${msg}";
			var ROLE_ID = "${ROLE_ID}";
			var url = "<%=basePath%>role/saveB4Button";
			var postData;
			postData = {"ROLE_ID":ROLE_ID,"menuIds":ids,"msg":msg};
			$("#showform").hide();
			$("#jiazai").show();
			$.post(url,postData,function(data){
				top.Dialog.close();
			});
		 }
	</script>
</body>
</html>