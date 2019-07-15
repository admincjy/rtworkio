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
    <meta name="author" content="" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
    <style type="text/css">
		div.costs-uploadfile-div{
		    position:relative;
		    cursor:pointer;
		    margin-left: 2px;
		}
		div.costs-uploadfile-div #textfield{
		    width:473px;
		    height:30px;
		    cursor:pointer;
		}
		div.costs-uploadfile-div #fileField{
		    width:473px;
		    height:30px;    
		    position: absolute;
		    top: 0;
		    left:0;
		    filter: alpha(opacity:0);
		    opacity: 0;
		    cursor:pointer;
		}
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
	    
						    <form action="procdef/uploadPro" name="Form" id="Form" method="post" enctype="multipart/form-data" style="width: 100%;">
						    <div id="showform">
						    <p class="text-warning bigger-110 orange" style="padding-top: -10px;margin-top: -10px;margin-left: 3px;">注意：压缩包中不能包含目录</p>
					            <div class="input-group input-group-sm mb-3" style="width: 555px;">
					                <div class="input-group-prepend">
                                       <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">模型文件</span></span>
                                    </div>
				                    <div class="costs-uploadfile-div">                             
									    <input type="file" name="zip" id="fileField" onchange="checkFileType(this)" /> 
									    <input type='text' id="textfield" class="btn btn-light btn-sm" value="请选择选择zip格式的压缩包" /> 
									</div>
					            </div>
					            <div class="input-group" style="margin-top:10px;background-color: white" >
					            	<span style="width: 100%;text-align: center;">
					            		<a class="btn btn-light btn-sm" onclick="save();">导入</a>
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
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
    
    <script type="text/javascript">
	    
		function checkFileType(obj){
			document.getElementById('textfield').value=obj.value;
			var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		    if(fileType != '.zip'){
		    	$("#fileField").tips({
					side:3,
		            msg:'请上传zip格式的压缩包',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#fileField").val('');
		    	$("#textfield").val('请选择zip格式的压缩包');
		    }
		}
		
		//保存
		function save(){
			if($("#fileField").val()==""){
				$("#fileField").tips({
					side:3,
		            msg:'请选择压缩包',
		            bg:'#AE81FF',
		            time:3
		        });
				return false;
			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
    
	</script>
</body>
</html>
