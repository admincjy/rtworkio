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
    <meta name="author" content="FH Admin" />

    <link href="assets/css/bootstrap-treeview.css" rel="stylesheet" />
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
    	
    <!-- 日期插件 -->
    <link rel="stylesheet" href="assets/plugins/material-datetimepicker/css/bootstrap-material-datetimepicker.css">
    
    <!-- select插件 -->
    <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="assets/plugins/multi-select/css/multi-select.css">
    
	<style type="text/css">
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

    <!-- [ 主内容区 ] start -->
        <div class="pcoded-wrapper">
            <div class="pcoded-content">
                <div class="pcoded-inner-content">
                    <div class="main-body">
                        <div class="page-wrapper">
                            <!-- [ Main Content ] start -->
                            <div class="row">
	    
							    <form action="role/${msg}" name="Form" id="Form" method="post" style="width: 100%;">
							    	<input type="hidden" name="ROLE_ID" id="id" value="${pd.ROLE_ID}"/>
									<input name="PARENT_ID" id="parent_id" value="${pd.parent_id }" type="hidden">
							    	<div id="showform">
							            <div class="input-group input-group-sm mb-3">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">名称</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="ROLE_NAME" id="ROLE_NAME" value="${pd.ROLE_NAME }" maxlength="32" placeholder="这里输入名称" title="名称">
		                                </div>	
		                                <c:if test="${msg =='add'}">	
										<div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">上级</span></span>
		                                    </div>
		                                    <div style="width:86%;">
												<select style="height: 30px;" class="js-example-placeholder-multiple col-sm-12" name="FATHER_ROLE_ID" id="FATHER_ROLE_ID" data-placeholder="请选择上级角色">
													<option value=""></option>
													<c:forEach items="${roleList}" var="role">
													<option value="${role.ROLE_ID }">${role.ROLE_NAME}</option>
													</c:forEach>
												</select>
		                                    </div>
		                                </div>
							    	    </c:if>
							             <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">部门</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="DEPARTMENT" id="DEPARTMENT" value="${pd.DEPARTMENT }"  maxlength="32" placeholder="点击选择部门,请勿手动输入" title="部门名称"  onclick="$('#tree').show()">
							             </div>
							            <div class="input-group input-group-sm mb-3">
		                                    <div id="tree" style="display: none; position:absolute; z-index:1010; background-color:white;margin-top:-10px ; margin-left:75px; width: 60%;"></div>
		                                 </div>
		                                 <input type="text" class="form-control" name="DICTIONARIES_ID" id="DICTIONARIES_ID"  maxlength="32" placeholder="点击选择部门,请勿手动输入" title="部门名称ID" style="visibility: hidden;">
							
							            <div class="input-group" style="background-color: white;margin-top: 10px;">
							            	<span style="width: 25%;text-align: center;margin-left: 450px;">
							            		<a class="btn btn-light btn-sm" onclick="save();">保存</a>
							            		<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">取消</a>
							            	</span>
							            </div>
						            
						           </div>
						           
						           <!-- [加载状态 ] start -->
								    <div id="jiazai" style="display:none;margin-top:10px;">
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
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script src="assets/js/bootstrap-treeview.js"></script>
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
		if($("#ROLE_NAME").val()==""){
			$("#ROLE_NAME").tips({
				side:3,
	            msg:'输入名称',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#ROLE_NAME").focus();
			return false;
		}
		if($("#FATHER_ROLE_ID").val()==""){
			$("#FATHER_ROLE_ID").tips({
				side:3,
	            msg:'选择上级',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#FATHER_ROLE_ID").focus();
			return false;
		}
		console.log($("#FATHER_ROLE_ID").val())
		if($("#DEPARTMENT").val()==""){
			$("#DEPARTMENT").tips({
				side:3,
	            msg:'选择部门',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#DEPARTMENT").focus();
			return false;
		}
		var a=$("#ROLE_NAME").val();
		var b=$("#DEPARTMENT").val();
		if(a.indexOf("(")==-1&&a.indexOf(")")==-1){
		    $("#ROLE_NAME").val(a+"("+b+")")
		}
		$("#Form").submit();
		$("#showform").hide();
		$("#jiazai").show();
	}
    $.ajax({
				type: "POST",
				url: '<%=basePath%>role/selectDel',
		        data: {},
				dataType:'json',
				cache: false,
				success: function(data){
	                $('#tree').treeview({
	                    data: data.dictionaries,        // 数据源
		                levels: 100,
	                    showCheckbox: true,   //是否显示复选框
	                    highlightSelected: true,    //是否高亮选中
	                    //nodeIcon: 'glyphicon glyphicon-user',    //节点上的图标
	                    nodeIcon: 'glyphicon glyphicon-globe',
	                    emptyIcon: '',    //没有子节点的节点图标
	                    multiSelect: false,    //多选
	                    onNodeChecked: function (event,data) {
	                    },
	                    onNodeSelected: function (event, data) {
	                    	$("#DICTIONARIES_ID").val(data.dictionaries_ID);
	                    	$("#DEPARTMENT").val(data.text);
	                    	document.getElementById("tree").style.display="none";
	                    }
	                });
				}
    		});
  </script>
</body>
</html>
