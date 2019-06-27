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
    <meta name="author" content="FH Admin " />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
    <!-- 日期插件 -->
    <link rel="stylesheet" href="assets/plugins/material-datetimepicker/css/bootstrap-material-datetimepicker.css">
    
    <!-- select插件 -->
    <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="assets/plugins/multi-select/css/multi-select.css">

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
					
								<form action="conclusion/${msg}" name="Form" id="Form" method="post" style="width: 100%;">
									<input type="hidden" name="CONCLUSION_ID" id="CONCLUSION_ID" value="${pd.CONCLUSION_ID}"/>
									<div id="showform">
										<div class="input-group input-group-sm mb-3" id="types">
											<select class="js-example-placeholder-multiple col-sm-12" name="TYPE" id="TYPE" data-placeholder="请选择工作总结的类型">
												<option>${pd.TYPE}</option>
												<option>周总结</option>
												<option>月总结</option>
												<option>半年总结</option>
												<option>年总结</option>
											</select>
							            </div>
		                                <table>
											<tr>
												<td colspan="10" id="omsg" style="padding-bottom: 15px;">
													<textarea  name="CONTENT" id="CONTENT" maxlength="10000" style="display:none" ></textarea>
													<script id="editor" type="text/plain" style="width:100%;height:350px;">${pd.CONTENT}</script>
												</td>
											</tr>
										</table>
										<c:if test="${'save' == msg }">
										<div>
											<shiro:hasPermission name="NextASSIGNEE_">
												<td width="320">
													指定下一办理对象：
													<input type="text" name="ASSIGNEE_2" id="ASSIGNEE_2" placeholder="请指定下一办理对象" value=""  title="指定下一办理对象" style="width:150px;" readonly="readonly"/>
													<a class="btn btn-light btn-sm" onclick="clean();" title="清空" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;"><div style="margin-top:0px;margin-left: -6px;">清</div></a>
													<a class="btn btn-light btn-sm" title="选择办理人(单人)" onclick="getUser();" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;">
														<i class="feather icon-user" style="margin-top:-6px;margin-left: -6px;"></i>
													</a>
													<a class="btn btn-light btn-sm" title="选择办理角色(此角色下所有人都可以办理)" onclick="getRole();" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;margin-left:-8px;">
														<i class="feather icon-users" style="margin-top:-6px;margin-left: -6px;"></i>
													</a>
												</td>
												<td width="320">
													<input  style="width:40%;visibility: hidden;" />
												</td>
												<td width="320">
													指定下一抄送对象(选填)：
													<input type="text" name="ASSIGNEE_3" id="ASSIGNEE_3" placeholder="抄送对象可多选" value=""  title="指定抄送对象" style="width:150px;" readonly="readonly"/>
													<a class="btn btn-light btn-sm" onclick="cleanCC();" title="清空" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;"><div style="margin-top:0px;margin-left: -6px;">清</div></a>
													<a class="btn btn-light btn-sm" title="选择抄送人(多人)" onclick="getCCUser();" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;">
														<i class="feather icon-user" style="margin-top:-6px;margin-left: -6px;"></i>
													</a>
													<!--<a class="btn btn-light btn-sm" title="选择办理角色(此角色下所有人都可以办理)" onclick="getRole();" style="width: 23px;height:30px;margin-top:1px;cursor:pointer;margin-left:-8px;">
														<i class="feather icon-users" style="margin-top:-6px;margin-left: -6px;"></i>
													</a>-->
												</td>
											</shiro:hasPermission>
							            </div>
								        </c:if>
							            <div class="input-group" style="margin-top:10px;background-color: white" >
							            	<span style="width: 100%;text-align: center;">
							            		<a class="btn btn-light btn-sm" onclick="save();">发起流程</a>
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
    
<script type="text/javascript" src="assets/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>

<!-- 日期插件 -->
<script src="assets/js/pages/moment-with-locales.min.js"></script>
<script src="assets/plugins/material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>
<script src="assets/js/pages/form-picker-custom.js"></script>

<!-- select插件 -->
<script src="assets/plugins/select2/js/select2.full.min.js"></script>
<script src="assets/plugins/multi-select/js/jquery.quicksearch.js"></script>
<script src="assets/plugins/multi-select/js/jquery.multi-select.js"></script>
<script src="assets/js/pages/form-select-custom.js"></script>

<!-- 百度富文本编辑框-->
<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
<!-- 百度富文本编辑框-->

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">
	    var types=[{
	    	key:1,
	    	val:"周"
	    },{
	    	key:2,
	    	val:"月"
	    },{
	    	key:3,
	    	val:"半年"
	    },{
	    	key:4,
	    	val:"年"
	    }]
		//保存
		function save(){
		    
	        $("#CONTENT").val(getContent());
			if($("#TYPE").val()==""){
				$("#TYPE").tips({
					side:3,
		            msg:'请选择总结类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TYPE").focus();
			return false;
			}
			if($("#CONTENT").val()==""){
				$("#CONTENT").tips({
					side:3,
		            msg:'请输入内容',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTENT").focus();
			return false;
			}
			if($("#ASSIGNEE_2").val()==""){
				$("#ASSIGNEE_2").tips({
					side:3,
		            msg:'请选择下一办理对象',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ASSIGNEE_2").focus();
			return false;
			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
		//选择办理人
		function getUser(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="选择办理人";
			 diag.URL = '<%=basePath%>user/listUsersForWindow';
			 diag.Width = 700;
			 diag.Height = 545;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 var USERNAME = diag.innerFrame.contentWindow.document.getElementById('USERNAME').value;
				 if("" != USERNAME){
					 $("#ASSIGNEE_").val(USERNAME);
					 $("#ASSIGNEE_2").val(USERNAME);
				 }
				diag.close();
			 };
			 diag.show();
		}
		//选择抄送人
		function getCCUser(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="选择抄送人";
			 diag.URL = '<%=basePath%>user/listCCUsersForWindow';
			 diag.Width = 700;
			 diag.Height = 545;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 var USERNAME = diag.innerFrame.contentWindow.document.getElementById('NAMES').value;
				 if("" != USERNAME){
					 $("#ASSIGNEE_3").val(USERNAME);
				 }
				diag.close();
			 };
			 diag.show();
		}
		
		//选择角色
		function getRole(){
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="选择角色";
			 diag.URL = '<%=basePath%>role/roleListWindow?ROLE_ID=1';
			 diag.Width = 700;
			 diag.Height = 545;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 var RNUMBER = diag.innerFrame.contentWindow.document.getElementById('RNUMBER').value;
				 if("" != RNUMBER){
					 $("#ASSIGNEE_").val(RNUMBER);
					 $("#ASSIGNEE_2").val(RNUMBER);
				 }
				diag.close();
			 };
			 diag.show();
		}
		
		//清空下一任务对象
		function clean(){
		 	$("#ASSIGNEE_").val("");
		 	$("#ASSIGNEE_2").val("");
		}
		//清空下一抄送对象
		function cleanCC(){
		 	$("#ASSIGNEE_").val("");
		 	$("#ASSIGNEE_3").val("");
		}
		$(function() {
			

		});
</script>
<c:if test="${null == pd.msg or pd.msg != 'admin' }">
<script type="text/javascript">
//百度富文本
setTimeout("ueditor()",500);
function ueditor(){
	var ue = UE.getEditor('editor');
}
//ueditor有标签文本
function getContent() {
    var arr = [];
    arr.push(UE.getEditor('editor').getContent());
    return arr.join("");
}
</script>
</c:if>

</body>
</html>