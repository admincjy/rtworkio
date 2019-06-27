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
    <meta name="author" content="FH Admin QQ313596790" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
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
	    
							    <form action="user/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
							    <input type="hidden" name="USER_ID" id="USER_ID" value="${pd.USER_ID }"/>
							    <textarea style="display: none;" name="ROLE_IDS" id="ROLE_IDS" >${pd.ROLE_IDS }</textarea>
							    <c:if test="${fx == 'head'}">
									<input name="ROLE_ID" id="role_id" value="${pd.ROLE_ID }" type="hidden" />
									<input name="NUMBER" id="NUMBER" value="${pd.NUMBER }" type="hidden" />
								</c:if>
							    <div id="showform">
							    	<c:if test="${fx != 'head'}">
									<div class="input-group input-group-sm mb-3" id="ROLE_IDts">
										<select class="js-example-placeholder-multiple col-sm-12" name="ROLE_ID" id="ROLE_ID" data-placeholder="请选择主职角色">
											<option value=""></option>
											<c:forEach items="${roleList}" var="role">
											<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
											</c:forEach>
										</select>
						            </div>
							    	</c:if>
							    	<c:if test="${fx != 'head'}">
									<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
										<select class="js-example-basic-multiple col-sm-12" multiple="multiple" name="ZROLE_IDS" id="ZROLE_IDS" data-placeholder="请选择副职角色">
                                            <option value=""></option>
											<c:forEach items="${roleList}" var="role">
											<option value="${role.ROLE_ID }" <c:if test="${role.RIGHTS == '1' }">selected</c:if>>${role.ROLE_NAME }</option>
											</c:forEach>
                                        </select>
						            </div>
							    	</c:if>
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">用户名</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="USERNAME" id="USERNAME" value="${pd.USERNAME }" maxlength="32" placeholder="这里输入用户名" title="用户名">
	                                </div>
						            <c:if test="${fx != 'head'}">
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">编号</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="NUMBER" id="NUMBER" value="${pd.NUMBER }" maxlength="32" placeholder="这里输入编号" title="编号" onblur="hasNumber('${pd.USERNAME }')">
	                                </div>
									</c:if>
									<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">密码</span></span>
	                                    </div>
	                                    <input class="form-control" type="password" name="PASSWORD" id="PASSWORD"  maxlength="32" placeholder="输入密码" title="密码">
	                                </div>
									<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">确认密码</span></span>
	                                    </div>
	                                    <input class="form-control" type="password" name="chkpwd" id="chkpwd"  maxlength="32" placeholder="确认密码" title="确认密码">
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">姓名</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="NAME" id="NAME"  value="${pd.NAME }"  maxlength="32" placeholder="这里输入姓名" title="姓名" >
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">手机号</span></span>
	                                    </div>
	                                    <input class="form-control" type="number" name="PHONE" id="PHONE"  value="${pd.PHONE }"  maxlength="32" placeholder="这里输入手机号" title="手机号" >
	                                </div>
									<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">邮箱</span></span>
	                                    </div>
	                                    <input class="form-control" type="email" name="EMAIL" id="EMAIL"  value="${pd.EMAIL }" maxlength="32" placeholder="这里输入邮箱" title="邮箱" onblur="hasEmail('${pd.USERNAME }')">
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="max-width: 553px;margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">员工状态</span></span>
	                                    </div>
	                                    <select name="STATE" id="STATE"  title="员工状态" style="width:475px;padding-left:10px;border: 1px solid #CED4DA;transparent;appearance:none;-moz-appearance:none;-webkit-appearance:none;"></select>
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">备注</span></span>
	                                    </div>
	                                    <input class="form-control" type="text" name="BZ" id="BZ"value="${pd.BZ }" placeholder="这里输入备注" maxlength="64" title="备注">
	                                </div>
						            <div class="input-group" style="margin-top:10px;background-color: white" >
						            	<span style="width: 100%;text-align: center;">
						            		<a class="btn btn-light btn-sm" onclick="save();">保存</a>
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

<!-- select插件 -->
<script src="assets/plugins/select2/js/select2.full.min.js"></script>
<script src="assets/plugins/multi-select/js/jquery.quicksearch.js"></script>
<script src="assets/plugins/multi-select/js/jquery.multi-select.js"></script>
<script src="assets/js/pages/form-select-custom.js"></script>

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
  
<script type="text/javascript">
	//初始选择项,调用数据字典
	$(function() {
		//流程分类
		$.ajax({
			type: "POST",
			url: '<%=basePath%>dictionaries/getLevels?tm='+new Date().getTime(),
	    	data: {DICTIONARIES_ID:'1a8c426bc62e4bcea47916aa3d82afac'},//act001 为工作流分类
			dataType:'json',
			cache: false,
			success: function(data){
				$("#STATE").html('<option value="" >请选择员工状态</option>');
				 $.each(data.list, function(i, dvar){
						$("#STATE").append("<option value="+dvar.BIANMA+">"+dvar.NAME+"</option>");
				 });
			}
		});
	});
	
	
  
	$(document).ready(function(){
		if($("#USER_ID").val()!=""){
			$("#USERNAME").attr("readonly","readonly"); //用户禁止修改
		}
	});
  
	//键盘回车事件，执行保存
	$(document).keyup(function(event) {
		if (event.keyCode == 13) {
			$("#to-save").trigger("click");
		}
	});
	
	//保存
	function save(){
		
		if($("#ROLE_ID").val()==""){
			$("#ROLE_IDts").tips({
				side:3,
	            msg:'选择主职角色',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ROLE_ID").focus();
			return false;
		}
		
		if('null' != $("#ZROLE_IDS").val()){
			$("#ROLE_IDS").val($("#ZROLE_IDS").val());
		}		
		
		if($("#USERNAME").val()=="" || $("#USERNAME").val()=="此用户名已存在!"){
			$("#USERNAME").tips({
				side:3,
	            msg:'输入用户名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#USERNAME").focus();
			$("#USERNAME").val('');
			return false;
		}else{
			$("#USERNAME").val(jQuery.trim($('#USERNAME').val()));
		}
		if($("#NUMBER").val()==""){
			$("#NUMBER").tips({
				side:3,
	            msg:'输入编号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#NUMBER").focus();
			return false;
		}else{
			$("#NUMBER").val($.trim($("#NUMBER").val()));
		}
		if($("#USER_ID").val()=="" && $("#PASSWORD").val()==""){
			$("#PASSWORD").tips({
				side:3,
	            msg:'输入密码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PASSWORD").focus();
			return false;
		}
		if($("#PASSWORD").val()!=$("#chkpwd").val()){
			
			$("#chkpwd").tips({
				side:3,
	            msg:'两次密码不相同',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#chkpwd").focus();
			return false;
		}
		if($("#NAME").val()==""){
			$("#NAME").tips({
				side:3,
	            msg:'输入姓名',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#NAME").focus();
			return false;
		}
		var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
		if($("#PHONE").val()==""){
			$("#PHONE").tips({
				side:3,
	            msg:'输入手机号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PHONE").focus();
			return false;
		}else if($("#PHONE").val().length != 11 && !myreg.test($("#PHONE").val())){
			$("#PHONE").tips({
				side:3,
	            msg:'手机号格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PHONE").focus();
			return false;
		}
		if($("#EMAIL").val()==""){
			$("#EMAIL").tips({
				side:3,
	            msg:'输入邮箱',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}else if(!ismail($("#EMAIL").val())){
			$("#EMAIL").tips({
				side:3,
	            msg:'邮箱格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}
		if($("#USER_ID").val()==""){
			hasUser();
		}else{
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
	}
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
	}
	
	//判断用户名是否存在
	function hasUser(){
		var USERNAME = $.trim($("#USERNAME").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasUser',
	    	data: {USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#Form").submit();
					$("#showform").hide();
					$("#jiazai").show();
				 }else{
					$("#USERNAME").tips({
						side:3,
			            msg:'此用户名已存在',
			            bg:'#AE81FF',
			            time:2
			        });
					setTimeout("$('#USERNAME').val('此用户名已存在!')",500);
				 }
			}
		});
	}
	
	//判断邮箱是否存在
	function hasEmail(USERNAME){
		var EMAIL = $.trim($("#EMAIL").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasEmail',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#EMAIL").tips({
							side:3,
				            msg:'邮箱 '+EMAIL+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#EMAIL").val('');
				 }
			}
		});
	}
	
	//判断编码是否存在
	function hasNumber(USERNAME){
		var NUMBER = $.trim($("#NUMBER").val());
		if(NUMBER=="")return false;
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasNumber',
	    	data: {NUMBER:NUMBER,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#NUMBER").tips({
							side:3,
				            msg:'编号 '+NUMBER+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#NUMBER").val('');
				 }
			}
		});
	}
  
 </script>
</body>
</html>
