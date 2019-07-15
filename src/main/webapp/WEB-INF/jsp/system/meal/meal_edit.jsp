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
    <meta name="author" content="FH Admin  " />

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
					
								<form action="meal/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
									<input type="hidden" name="MEAL_ID" id="MEAL_ID" value="${pd.MEAL_ID}"/>
									<div id="showform">
										<div class="input-group input-group-sm mb-3" id="USER_IDts">
											<select class="js-example-placeholder-multiple col-sm-12" name="USER_ID" id="USER_ID" data-placeholder="请选择订餐人">
												<option value=""></option>
												<c:forEach items="${userList}" var="user">
												<option value="${user.USER_ID }">${user.NAME}</option>
												</c:forEach>
											</select>
							            </div>
							            <!--<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">创建时间</span></span>
		                                    </div>
		                                    <input type="text" class="form-control date" name="CREATETIME" id="CREATETIME" value="${pd.CREATETIME}" maxlength="32" placeholder="这里输入创建时间" title="创建时间">
		                                </div>
							            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">更新时间</span></span>
		                                    </div>
		                                    <input type="text" class="form-control date" name="UPDATETIME" id="UPDATETIME" value="${pd.UPDATETIME}" maxlength="32" placeholder="这里输入更新时间" title="更新时间">
		                                </div>
							            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">菜单</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="MENU" id="MENU" value="${pd.MENU}" maxlength="255" placeholder="这里输入菜单" title="菜单">
		                                </div>
							            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">是否订餐(0否1是)</span></span>
		                                    </div>
		                                    <input type="number" class="form-control" name="ISORDER" id="ISORDER" value="${pd.ISORDER}" maxlength="32" placeholder="这里输入是否订餐(0否1是)" title="是否订餐(0否1是)">
		                                </div>
							            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">是否停止订餐(0否1是)</span></span>
		                                    </div>
		                                    <input type="number" class="form-control" name="ISSTOPORDER" id="ISSTOPORDER" value="${pd.ISSTOPORDER}" maxlength="32" placeholder="这里输入是否停止订餐(0否1是)" title="是否停止订餐(0否1是)">
		                                </div>
							            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">就餐时间</span></span>
		                                    </div>
		                                    <input type="text" class="form-control date" name="DINNERTIME" id="DINNERTIME" value="${pd.DINNERTIME}" maxlength="32" placeholder="这里输入就餐时间" title="就餐时间">
		                                </div>-->
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

<!-- 日期插件 -->
<script src="assets/js/pages/moment-with-locales.min.js"></script>
<script src="assets/plugins/material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>
<script src="assets/js/pages/form-picker-custom.js"></script>

<!-- select插件 -->
<script src="assets/plugins/select2/js/select2.full.min.js"></script>
<script src="assets/plugins/multi-select/js/jquery.quicksearch.js"></script>
<script src="assets/plugins/multi-select/js/jquery.multi-select.js"></script>
<script src="assets/js/pages/form-select-custom.js"></script>

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">
		//保存
		function save(){
			if($("#USER_ID").val()==""){
				$("#USER_ID").tips({
					side:3,
		            msg:'请输入订餐人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USER_ID").focus();
			return false;
			}
//			if($("#CREATETIME").val()==""){
//				$("#CREATETIME").tips({
//					side:3,
//		            msg:'请输入创建时间',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#CREATETIME").focus();
//			return false;
//			}
//			if($("#UPDATETIME").val()==""){
//				$("#UPDATETIME").tips({
//					side:3,
//		            msg:'请输入更新时间',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#UPDATETIME").focus();
//			return false;
//			}
//			if($("#MENU").val()==""){
//				$("#MENU").tips({
//					side:3,
//		            msg:'请输入菜单',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#MENU").focus();
//			return false;
//			}
//			if($("#ISORDER").val()==""){
//				$("#ISORDER").tips({
//					side:3,
//		            msg:'请输入是否订餐(0否1是)',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#ISORDER").focus();
//			return false;
//			}
//			if($("#ISSTOPORDER").val()==""){
//				$("#ISSTOPORDER").tips({
//					side:3,
//		            msg:'请输入是否停止订餐(0否1是)',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#ISSTOPORDER").focus();
//			return false;
//			}
//			if($("#DINNERTIME").val()==""){
//				$("#DINNERTIME").tips({
//					side:3,
//		            msg:'请输入就餐时间',
//		            bg:'#AE81FF',
//		            time:2
//		        });
//				$("#DINNERTIME").focus();
//			return false;
//			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
		
		$(function() {
			

		});
</script>

</body>
</html>