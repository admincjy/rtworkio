<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

		<style type="text/css">
		#dialog-add,#dialog-message,#dialog-comment{width:100%; height:100%; position:fixed; top:0px; z-index:99999999; display:none;}
		.commitopacity{position:absolute; width:100%; height:700px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.5; -khtml-opacity: 0.5; opacity: 0.5; top:0px; z-index:99999;}
		.commitbox{width:100%; margin:0px auto; position:absolute; top:0px; z-index:99999;}
		.commitbox_inner{width:96%; height:255px;  margin:6px auto; background:#efefef; border-radius:5px;}
		.commitbox_top{width:100%; height:253px; margin-bottom:10px; padding-top:10px; background:#FFF; border-radius:5px; box-shadow:1px 1px 3px #e8e8e8;}
		.commitbox_top textarea{width:95%; height:195px; display:block; margin:0px auto; border:0px;}
		.commitbox_cen{width:95%; height:40px; padding-top:10px;}
		.commitbox_cen div.left{float:left;background-size:15px; background-position:0px 3px; padding-left:18px; color:#f77500; font-size:16px; line-height:27px;}
		.commitbox_cen div.left img{width:30px;}
		.commitbox_cen div.right{float:right; margin-top:7px;}
		.commitbox_cen div.right span{cursor:pointer;}
		.commitbox_cen div.right span.save{border:solid 1px #c7c7c7; background:#6FB3E0; border-radius:3px; color:#FFF; padding:5px 10px;}
		.commitbox_cen div.right span.quxiao{border:solid 1px #f77400; background:#f77400; border-radius:3px; color:#FFF; padding:4px 9px;}
		</style>
		
	</head>
<body style="background-color: white">

    <!-- [加载状态 ] start -->
    <div class="loader-bg">
        <div class="loader-track">
            <div class="loader-fill"></div>
        </div>
    </div>
    <!-- [ 加载状态  ] End -->
		
	<!-- 编辑用户名  -->
	<div id="dialog-add">
		<div class="commitopacity"></div>
	  	<div class="commitbox">
		  	<div class="commitbox_inner">
		        <div class="commitbox_top">
		        	<textarea name="EMAILS" id="EMAILS"  placeholder="请选输入邮箱,多个请用(;)分号隔开" title="请选输入邮箱,多个请用(;)分号隔开"></textarea>
		            <div class="commitbox_cen">
		                <div class="left" id="cityname"></div>
		                <div class="right"><span class="save" onClick="cancel_pl()">确定</span>&nbsp;&nbsp;<span class="quxiao" onClick="cancel_pl()">取消</span></div>
		            </div>
		        </div>
		  	</div>
	  	</div>
	</div>

	<div id="showform">
	<textarea name="CONTENT" id="CONTENT" style="display:none" ></textarea>
	<input type="hidden" name="TYPE" id="TYPE" value="2"/>
	<table style="width:98%;margin-top: 10px;margin-left: 1px;">
		<tr>
			<td style="margin-top:0px;">
				 <div style="float: left;" style="width:100%" class="input-group input-group-sm mb-3">
				 	<textarea class="form-control" name="EMAIL" id="EMAIL" rows="1" cols="50" style="max-width:958px;height:30px;" placeholder="请选输入邮箱,多个请用(;)分号隔开" title="请选输入邮箱,多个请用(;)分号隔开">${pd.EMAIL}</textarea>
				 	<div style="float: right;margin-right: 5px;margin-top: -3px;margin-left: 5px;">
				 		<a class="btn btn-light btn-sm" onclick="dialog_open();" style="width: 23px;height:30px;margin-top:3px;" title="查看邮箱"><i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i></a>
				 	</div>
				 </div>
			</td>
		</tr>
		<tr>
			<td>
	            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
                   <div class="input-group-prepend">
                       <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">标题</span></span>
                   </div>
                   <input type="text" class="form-control" name="TITLE" id="TITLE" value="" maxlength="100" placeholder="这里输入标题" title="标题">
                </div>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;">
				 <script id="editor" type="text/plain" style="width:995px;height:429px;margin-top: -10px;"></script>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;padding-top: 15px;padding-left: 15px;" id="nr">
				<div style="float: left;">
					<div class="radio radio-primary d-inline" style="margin-top: -10px;">
	                    <input type="radio" name="radio-p-fill-5" id="fhradio0" onclick="setType('2');" checked=""/>
	                    <label for="fhradio0" class="cr">带标签</label>
	                </div>
	                <div class="radio radio-primary d-inline" style="margin-top: -10px;">
	                    <input type="radio" name="radio-p-fill-5" id="fhradio1" onclick="setType('1');"/>
	                    <label for="fhradio1" class="cr">纯文本</label>
	                </div>
                </div>
                <div>
				<a class="btn btn-light btn-sm" onclick="sendEmail();">发送</a>
				<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">取消</a>
				</div>
			</td>
		</tr>
	</table>
	</div>
	
	<!-- [加载状态 ] start -->
    <div id="jiazai" style="display:none;margin-top:50px;text-align: center;"">
    	<div><br/><br/><br/><h4>正在发送..<font color="red"><strong id="second_shows">3秒</strong></font>后关闭</h4></div>
    	<div class="d-flex justify-content-center">
         <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only" id='msg'>Loading...</span>
            </div>
        </div>
    </div>
    <!-- [ 加载状态  ] End -->
		
	<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="assets/js/pre-loader.js"></script>
    
    <!-- 表单验证提示 -->
  	<script src="assets/js/jquery.tips.js"></script>

	<!-- 百度富文本编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
	<!-- 百度富文本编辑框-->

	<!--引入属于此页面的js -->
	<script type="text/javascript" src="assets/js/fhemail.js"></script>
    <script type="text/javascript">
    	var local = "<%=basePath%>";
    </script>
</body>
</html>