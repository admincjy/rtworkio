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
	    
							   <form action="dictionaries/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
								<input type="hidden" name="DICTIONARIES_ID" id="DICTIONARIES_ID" value="${pd.DICTIONARIES_ID}"/>
								<input type="hidden" name="PARENT_ID" id="PARENT_ID" value="${null == pd.PARENT_ID ? DICTIONARIES_ID:pd.PARENT_ID}"/>
								<input type="hidden" name="YNDEL" id="YNDEL" value="no"/>
							    <div id="showform">
							    
							    	<h6 style="padding-left: 6px;">上级：${null == pds.NAME ?'(无) 此项为顶级':pds.NAME}</h6>
						            
						            <div class="input-group input-group-sm mb-3">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">名称</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="NAME" id="NAME" value="${pd.NAME }" maxlength="32" placeholder="这里输入名称" title="名称">
	                                </div>
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">英文</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="NAME_EN" id="NAME_EN" value="${pd.NAME_EN }" maxlength="32" placeholder="这里输入英文名称" title="英文名称">
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">编码</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="BIANMA" id="BIANMA" value="${pd.BIANMA }" maxlength="32" placeholder="这里输入编码 (不重复, 禁止修改)" title="编码" <c:if test="${null != pd.BIANMA}">readonly="readonly"</c:if> <c:if test="${null == pd.BIANMA}">onblur="hasBianma();"</c:if>>
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">排序</span></span>
	                                    </div>
	                                    <input type="number" class="form-control" name="ORDER_BY" id="ORDER_BY" value="${pd.ORDER_BY }" maxlength="32" placeholder="这里输入排序" title="排序">
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">备注</span></span>
	                                    </div>
	                                    <input class="form-control" type="text" name="BZ" id="BZ"  value="${pd.BZ }"  maxlength="50" placeholder="这里输入备注说明" title="备注说明" >
	                                </div>
						            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">排查表</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="TBSNAME" id="TBSNAME" value="${pd.TBSNAME }" maxlength="100" placeholder="这里输入表名, 多个用逗号分隔(非必录)" title="排查表">
	                                </div>
	                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
	                                    <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">关联字段</span></span>
	                                    </div>
	                                    <input type="text" class="form-control" name="TBFIELD" id="TBFIELD" value="${pd.TBFIELD }" maxlength="32" placeholder="这这里输入关联字段,默认:BIANMA(非必录)" title="关联字段">
	                                </div>
	                                <c:if test="${msg == 'save' }">
									<h6 style="padding-left: 6px;margin-top: -5px;">排查表：删除此条数据时会去此表查询是否被占用(是:禁止删除)</h6>
									<div class="input-group input-group-sm mb-3" style="margin-top: 0px;">
						                <div class="input-group-prepend">
	                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">禁止删除</span></span>
	                                    </div>
					                    <div class="switch switch-info d-inline m-r-10" style="margin-top: -7px;margin-left: 10px;">
                                             <input type="checkbox" id="switch-i-1" onclick="yesOrNO();">
                                             <label for="switch-i-1" class="cr"></label>
                                        </div>
						            </div>
						            </c:if>
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
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
    
    <script type="text/javascript">

		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#NAME_EN").val()==""){
				$("#NAME_EN").tips({
					side:3,
		            msg:'请输入英文',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME_EN").focus();
			return false;
			}
			if($("#BIANMA").val()==""){
				$("#BIANMA").tips({
					side:3,
		            msg:'请输入编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BIANMA").focus();
			return false;
			}
			if($("#ORDER_BY").val()==""){
				$("#ORDER_BY").tips({
					side:3,
		            msg:'请输入数字',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ORDER_BY").focus();
			return false;
			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
		
		//判断编码是否存在
		function hasBianma(){
			var BIANMA = $.trim($("#BIANMA").val());
			if("" == BIANMA)return;
			$.ajax({
				type: "POST",
				url: '<%=basePath%>dictionaries/hasBianma',
		    	data: {BIANMA:BIANMA,tm:new Date().getTime()},
				dataType:'json',
				cache: false,
				success: function(data){
					 if("success" == data.result){
					 }else{
						$("#BIANMA").tips({
							side:1,
				            msg:'编码'+BIANMA+'已存在,重新输入',
				            bg:'#AE81FF',
				            time:5
				        });
						$('#BIANMA').val('');
					 }
				}
			});
		}
		
		//禁删开关
		function yesOrNO(){
			if("no" == $("#YNDEL").val()){
				$("#YNDEL").val('yes');
			}else{
				$("#YNDEL").val('no');
			}
		}
	</script>
</body>
</html>
