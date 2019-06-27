<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" href="assets/fonts/material/css/materialdesignicons.min.css">
    
    <!--引入弹窗组件-->
	<link type="text/css" rel="stylesheet" href="plugins/fhdrag/style.css" />
	
	<!-- 及时通讯css -->
	<link rel="stylesheet" href="plugins/fhim/dist/css/layui.css">
	<link rel="stylesheet" href="plugins/fhim/dist/css/contextMenu.css">

</head>

<body id="FHSKIN3" class="${fn:split(SKIN, ',')[2] }">
    <!-- [ Pre-loader ] start -->
    <div class="loader-bg">
        <div class="loader-track">
            <div class="loader-fill"></div>
        </div>
    </div>
    <!-- [ Pre-loader ] End -->

    <!-- [ navigation menu ] start  pcoded-navbar mob-open -->
    <nav id="FHSKIN1" class="${fn:split(SKIN, ',')[0] }">
        <div class="navbar-wrapper">
            <div class="navbar-brand header-logo">
                <a href="main/index" class="b-brand">
                    <div class="b-bg">
                        <i class="feather icon-facebook"></i>
                    </div>
                    <span class="b-title">${sessionScope.sysName}</span>
                </a>
                <a class="mobile-menu" id="mobile-collapse" style="cursor:pointer;"><span></span></a>
            </div>
            <div class="navbar-content scroll-div">
                <ul class="nav pcoded-inner-navbar">
                    
                    <!-- 菜单开始 -->
						<!-- 左侧菜单 -->
						<%@ include file="leftMenu.jsp"%>
                   <!-- 菜单结束 -->
                   
                </ul>
            </div>
        </div>
    </nav>
    <!-- [ navigation menu ] end -->

    <!-- [ Header ] start -->
    <header id="FHSKIN2" class="${fn:split(SKIN, ',')[1] }">
   	<%@ include file="head.jsp"%>
   	</header>
    <!-- [ Header ] end -->

    <!-- [ 主内容区 ] start -->
    <section class="pcoded-main-container">

		<iframe name="mainFrame" id="mainFrame" frameborder="0" src="<%=basePath%>main/tab" style="margin:0 auto;width:100%;height:100%;"></iframe>

    </section>
    <!-- [ 主内容区 ] end -->

    <!-- Warning Section start -->
    <!-- Older IE warning message -->
    <!--[if lt IE 11]>
        <div class="ie-warning">
            <h1>警告!!</h1>
            <p>您使用的是过时版本的Internet Explorer，请升级
               <br/>使用以下任何Web浏览器访问此网站.
            </p>
            <div class="iew-container">
                <ul class="iew-download">
                    <li>
                        <a href="http://www.google.com/chrome/">
                            <img src="assets/images/browser/chrome.png" alt="Chrome">
                            <div>Chrome</div>
                        </a>
                    </li>
                    <li>
                        <a href="https://www.mozilla.org/en-US/firefox/new/">
                            <img src="assets/images/browser/firefox.png" alt="Firefox">
                            <div>Firefox</div>
                        </a>
                    </li>
                    <li>
                        <a href="http://www.opera.com">
                            <img src="assets/images/browser/opera.png" alt="Opera">
                            <div>Opera</div>
                        </a>
                    </li>
                    <li>
                        <a href="https://www.apple.com/safari/">
                            <img src="assets/images/browser/safari.png" alt="Safari">
                            <div>Safari</div>
                        </a>
                    </li>
                    <li>
                        <a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie">
                            <img src="assets/images/browser/ie.png" alt="">
                            <div>IE (11 & above)</div>
                        </a>
                    </li>
                </ul>
            </div>
            <p>抱歉给您带来不便！!</p>
        </div>
    <![endif]-->
    <!-- Warning Section Ends -->

	<!-- 右侧菜单设置 -->
	<div id="styleSelector" class="menu-styler">
		<div class="style-toggler">
			<a style="cursor:pointer;"></a>
		</div>
		<div class="style-block">
			<h6 class="mb-2">风格设置</h6>
			<hr class="my-0">
			<h6>皮肤</h6>
			<div class="theme-color layout-type" onclick="saveSkin()">
				<a style="cursor:pointer;" class="${fn:split(SKIN, ',')[0]=='pcoded-navbar'?'active':''}" data-value="menu-dark" data-toggle="tooltip" title="默认风格" onclick="saveSkindef()"><span></span><span></span></a>
				<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'menu-light')?'active':''}" data-value="menu-light" data-toggle="tooltip" title="浅色风格"><span></span><span></span></a>
				<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'dark')?'active':''}" data-value="dark" data-toggle="tooltip" title="黑色风格"><span></span><span></span></a>
			</div>
			<h6>预构建布局</h6>
			<div class="form-group mb-3">
				<div class="switch switch-primary d-inline m-r-10">
					<input type="checkbox" id="icon-colored" ${fn:contains(fn:split(SKIN, ',')[0], 'icon-colored')?'checked':''}><label for="icon-colored" class="cr"></label>
				</div>
				<label>图标颜色</label>
			</div>
			<ul class="nav nav-pills mb-2" id="pills-cust-tab" role="tablist">
				<li class="nav-item"><a class="nav-link active" id="pills-color-tab" data-toggle="pill" href="#pills-color" role="tab" aria-controls="pills-color" aria-selected="true">颜色</a></li>
				<li class="nav-item"><a class="nav-link" id="pills-pages-tab" data-toggle="pill" href="#pills-pages" role="tab" aria-controls="pills-pages" aria-selected="false">布局</a></li>
			</ul>
			<div class="tab-content" id="pills-cust-tabContent">
				<div class="tab-pane fade show active" id="pills-color" role="tabpanel" aria-labelledby="pills-color-tab">
					<h6>页眉背景</h6>
					<div class="theme-color header-color" onclick="saveSkin()">
						<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[1], 'header-default')?'active':''}" data-value="header-default"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[1], 'header-blue')?'active':''}" data-value="header-blue"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[1], 'header-red')?'active':''}" data-value="header-red"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[1], 'header-purple')?'active':''}" data-value="header-purple"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[1], 'header-lightblue')?'active':''}" data-value="header-lightblue"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[1], 'header-dark')?'active':''}" data-value="header-dark"><span></span><span></span></a>
					</div>
					<h6>菜单背景</h6>
					<div class="theme-color navbar-color" onclick="saveSkin()">
						<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-default')?'active':''}" data-value="navbar-default"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-blue')?'active':''}" data-value="navbar-blue"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-red')?'active':''}" data-value="navbar-red"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-purple')?'active':''}" data-value="navbar-purple"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-lightblue')?'active':''}" data-value="navbar-lightblue"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-dark')?'active':''}" data-value="navbar-dark"><span></span><span></span></a>
					</div>
					<h6>右上颜色</h6>
					<div class="theme-color brand-color" onclick="saveSkin()">
						<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'brand-default')?'active':''}" data-value="brand-default"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'brand-blue')?'active':''}" data-value="brand-blue"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'brand-red')?'active':''}" data-value="brand-red"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'brand-purple')?'active':''}" data-value="brand-purple"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'brand-lightblue')?'active':''}" data-value="brand-lightblue"><span></span><span></span></a><a 
						style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'brand-dark')?'active':''}" data-value="brand-dark"><span></span><span></span></a>
					</div>
					<h6>菜单背景图片</h6>
					<div class="theme-color navbar-images" onclick="saveSkin()">
						<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-image-1')?'active':''}" data-value="navbar-image-1"><span></span><span></span></a>
						<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-image-2')?'active':''}" data-value="navbar-image-2"><span></span><span></span></a>
						<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-image-3')?'active':''}" data-value="navbar-image-3"><span></span><span></span></a>
						<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-image-4')?'active':''}" data-value="navbar-image-4"><span></span><span></span></a>
						<a style="cursor:pointer;" class="${fn:contains(fn:split(SKIN, ',')[0], 'navbar-image-5')?'active':''}" data-value="navbar-image-5"><span></span><span></span></a>
					</div>
				</div>
				<div class="tab-pane fade" id="pills-pages" role="tabpanel" aria-labelledby="pills-pages-tab">
					<div class="form-group mb-0">
						<div class="switch switch-primary d-inline m-r-10">
							<input type="checkbox" id="menu-fixed" ${fn:contains(fn:split(SKIN, ',')[0], 'menupos-static')?'':'checked'}><label for="menu-fixed" class="cr"></label>
						</div>
						<label>菜单固定</label>
					</div>
					<div class="form-group mb-0">
						<div class="switch switch-primary d-inline m-r-10">
							<input type="checkbox" id="header-fixed" ${fn:contains(fn:split(SKIN, ',')[1], 'headerpos-fixed')?'checked':''}><label for="header-fixed" class="cr"></label>
						</div>
						<label>页眉固定</label>
					</div>
					<div class="form-group mb-0">
						<div class="switch switch-primary d-inline m-r-10">
							<input type="checkbox" id="box-layouts" ${fn:contains(fn:split(SKIN, ',')[2], 'container box-layout')?'checked':''}><label for="box-layouts" class="cr"></label>
						</div>
						<label>总体居中</label>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 右侧菜单设置 -->

    <!-- Required Js -->
    <script src="assets/js/vendor-all.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/pcoded.js"></script>
    <script src="assets/js/menu-setting.js"></script>
    <script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>
    
   	<!--引入弹窗组件start-->
	<script type="text/javascript" src="plugins/fhdrag/drag.js"></script>
	<script type="text/javascript" src="plugins/fhdrag/dialog.js"></script>
	<!--引入弹窗组件end-->
	
	<!-- 提示 -->
  	<script src="assets/js/jquery.tips.js"></script>
	
	<script src="assets/js/index.js"></script>
	
	<script type="text/javascript">
        	var wlocal = "<%=basePath%>";
        	$(document).ready(function(){
        		getInfo();
        	});
    </script>
	<!-- 及时通讯js¨ -->
	<script src="plugins/fhim/dist/layui.js"></script>
 		<!-- 及时通讯页面¨ -->
	<!--<%@ include file="im.jsp"%>-->
	
</body>
</html>