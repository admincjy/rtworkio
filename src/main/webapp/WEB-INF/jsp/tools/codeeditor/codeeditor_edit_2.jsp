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
    <meta name="author" content="FH Admin  " />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
	
	<!-- 代码编辑器 -->
    <script src="plugins/codeEditor/jquery.min.js"></script>
    <script>
   	 	var codetype="php7";
    	var unid="59398d6898fb6";
    </script>
    <script src="plugins/codeEditor/runcode.js"></script>
	<style type="text/css" media="screen">
   		#editor { 
      			 //position: absolute;
      			 width: 100%;
      			 height: 600px;
      			 float: left;
       		font-size: 14px;
  				 }
	</style>
	<!-- 代码编辑器 -->
	
</head>
<body>

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
                <div class="main-body" style="margin-top: -10px">
                    <div class="page-wrapper">
                        <!-- [ Main Content ] start -->
                        <div class="row">
			   				<!-- [ Hover-table ] start -->
                            <div class="col-xl-12">
                                <div class="card">
                                	<div class="card-block table-border-style" style="margin-top: -20px">
                                    	<div class="table-responsive">
                                             <table class="table table-hover">
												<tr>
													<td colspan="10">
										 			  <div class="starter-template">
														 	<div id="editor" class="ace_editor ace-monokai ace_dark"><textarea id="codeContent" class="ace_text-input" wrap="off" autocorrect="off" autocapitalize="off" spellcheck="false" style="opacity: 0; height: 17px; width: 8px; left: 45px; top: 0px;"></textarea></div>
													  </div>
													</td>
												</tr>
											</table>
											<table style="margin-left: 15px;">
												<tr>
													<td>
														<a class="btn btn-light btn-sm" onclick="save();" id="sts">保存</a>
														<a class="btn btn-light btn-sm" onclick="reduction();" id="hts">还原</a>
														<a class="btn btn-light btn-sm" onclick="history();">历史编辑</a>
													</td>
												</tr>
											</table>
										</div>
	                                </div>
                                </div>
                             </div>
                             <!-- [ Hover-table ] end -->
                          </div>
                          <!-- [ Main Content ] end -->
                    </div>
                 </div>
            </div>
       </div>
   </div>
<!-- [ 主内容区 ] end -->

<script type="text/javascript" src="assets/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script src="plugins/codeEditor/ace.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
		
		$(getCode());
		$(cmainFrame());
		
		window.onresize=function(){  
			cmainFrame();
		};
		
		//保存
		function save(){
			var codeTxt  = getCodeTxt();
			var type = "${pd.type}";
			var ftlNmame = "${pd.ftl}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>codeeditor/save',
		    	data: {codeTxt:codeTxt,type:type,ftlNmame:ftlNmame,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					if("success" == data.result){
					  $("#sts").tips({
							side:1,
				            msg:'保存成功',
				            bg:'#83CB4F',
				            time:8
				       });
					 }
				}
			});
		}
		
		//获取code
		function getCode(){
			var type = "${pd.type}";
			var ftlNmame = "${pd.ftl}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>codeeditor/getCode',
		    	data: {type:type,ftlNmame:ftlNmame,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					if("success" == data.result){
					  setCodeTxt(data.code);
					 }
				}
			});
		}
		
		//还原
		function reduction(){
			var type = "${pd.type}";
			var ftlNmame = "${pd.ftl}";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>codeeditor/reduction',
		    	data: {type:type,ftlNmame:ftlNmame,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					if("success" == data.result){
					  setCodeTxt(data.code);
					  $("#hts").tips({
							side:1,
				            msg:'还原成功',
				            bg:'#83CB4F',
				            time:8
				       });
					 }
				}
			});
		}
		
		//历史编辑
		function history(){
			 var type = "${pd.type}";
			 var ftlNmame = "${pd.ftl}";
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="历史编辑";
			 diag.URL = '<%=basePath%>codeeditor/list?msg=2&TYPE='+type+'&FTLNMAME='+ftlNmame;
			 diag.Width = 800;
			 diag.Height = 500;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				if(diag.innerFrame.contentWindow.document.getElementById('msg').value == 'yes'){
					location.reload();
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//设置代码内容
		function setCodeTxt(value){
		    if(typeof(editor) == "undefined"){
		        $('#editorBox').val(value);
		    }else{
		        editor.setValue(value,-1);
		    } 
		}
		
		//获取代码内容
		function getCodeTxt(){
		    if(typeof(editor) == "undefined"){
		        return $('#editorBox').text();
		    }else{
		        return editor.getValue();
		    } 
		}
		
		if(ie_error()){
	        $('#editor').hide();
	    }else{
	        $('#editorBox').hide();
	        ace.require("ace/ext/language_tools");
	        var editor = ace.edit("editor");
	        editor.setOptions({
	            enableBasicAutocompletion: true,
	            enableSnippets: true,
	            enableLiveAutocompletion: true
	        });
	        editor.setTheme("ace/theme/monokai");
	        editor.getSession().setMode("ace/mode/php");
	    }
		
		function cmainFrame(){
			var hmain = document.getElementById("editor");
			var bheight = document.documentElement.clientHeight;
			hmain .style.width = '100%';
			hmain .style.height = (bheight  - 215) + 'px';
		}
</script>
</body>
</html>