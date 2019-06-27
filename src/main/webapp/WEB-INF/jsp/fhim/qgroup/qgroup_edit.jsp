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
    
    <style type="text/css">
    	.costs-marl15{margin-left: 15px;}
		div.costs-uploadfile-div{
		    position:relative;
		    cursor:pointer;
		    margin-left: 2px;
		}
		div.costs-uploadfile-div #textfield{
		    width:461px;
		    height:30px;
		    cursor:pointer;
		}
		div.costs-uploadfile-div #tp{
		    width:461px;
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
	
									<form action="qgroup/${msg }" name="Form" id="Form" method="post" enctype="multipart/form-data" style="width: 100%;">
										<input type="hidden" name="QGROUP_ID" id="QGROUP_ID" value="${pd.QGROUP_ID}"/>
										<input type="hidden" name="QID" id="QID" value="${pd.QID}"/>
										<div id="showform" style="padding-top: 0px;">
										
								            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
			                                    <div class="input-group-prepend">
			                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">群名称</span></span>
			                                    </div>
			                                    <input type="text" class="form-control" name="NAME" id="NAME" value="${pd.NAME }" maxlength="32" placeholder="这里输入群名称" title="群名称">
		                                 	</div>
								            
											<div class="input-group input-group-sm mb-3" style="margin-top: -5px;">
								                <div class="input-group-prepend">
			                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">群头像</span></span>
			                                    </div>
							                    <div class="costs-uploadfile-div">   
							                        <c:if test="${pd == null || pd.PHOTO == '' || pd.PHOTO == null }">                   
												    <input type="file" name="tp" id="tp" onchange="fileType(this)" /> 
												    <input type='text' id="textfield" class="btn btn-light btn--icon-text" value="请选择选择图片" /> 
												    </c:if>
												    <c:if test="${pd != null && pd.PHOTO != '' && pd.PHOTO != null }">
													<a href="${pd.PHOTO}" target="_blank">&nbsp;<img src="${pd.PHOTO}" width="50"/></a>
													<a title="删除" onclick="delP('${pd.PHOTO}','${pd.QGROUP_ID }');" style="cursor:pointer;"><i class="feather icon-x"></i></a>
													<input type="hidden" name="tpz" id="tpz" value="${pd.PHOTO }"/>
													</c:if>
												</div>
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
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
  	
<script type="text/javascript">
		
		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入群名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if(typeof($("#tpz").val()) == "undefined"){
				if($("#tp").val()=="" || document.getElementById("tp").files[0] =='请选择图片'){
					
					$("#tp").tips({
						side:3,
			            msg:'请选图片',
			            bg:'#AE81FF',
			            time:3
			        });
					return false;
				}
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		//过滤类型
		function fileType(obj){
			document.getElementById('textfield').value=obj.value;
			var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		    if(fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg'){
		    	$("#tp").tips({
					side:3,
		            msg:'请上传图片格式的文件',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#tp").val('');
		    	document.getElementById("tp").files[0] = '请选择图片';
		    }
		}
		
		//删除
		function delP(PATH,QGROUP_ID){
			swal({
            	title: '',
                text: "确定要删除图片吗?",
                icon: "warning",
                buttons: true,
                dangerMode: true,
                
            }).then((willDelete) => {
                if (willDelete) {
	            	$.ajax({
	        			type: "POST",
	        			url: '<%=basePath%>qgroup/deltp',
	        	    	data: {PATH:PATH,QGROUP_ID:QGROUP_ID,tm:new Date().getTime()},
	        			dataType:'json',
	        			cache: false,
	        			success: function(data){
	        				 if("success" == data.result){
	        					 swal("删除成功", "已经从列表中删除!", "success");
	        				 }
	        				 setTimeout("document.location.reload()", 1500);
	        			}
	        		});
                }
            });
		}
		
		</script>
</body>
</html>