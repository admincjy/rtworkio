<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"  %>
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
    <title>添加好友</title>
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
    
    <link rel="stylesheet" href="plugins/fhim/dist/css/layui.css?v=1">
    
</head>

<body>
    
    <!-- [加载状态 ] start -->
    <div class="loader-bg">
        <div class="loader-track">
            <div class="loader-fill"></div>
        </div>
    </div>
    <!-- [ 加载状态  ] End -->
    
    <table style="width: 100%">
	<tr bgcolor="#36373C" height="39px;" >
		<td onclick="javascript:window.location.href='mobileindex/goIm'">
			<font color="white">&nbsp;&nbsp;&lt;&nbsp;返回</font>
		</td>
	</tr>
	</table>

    <!-- [ 主内容区 ] start -->
        <div class="pcoded-wrapper">
            <div class="pcoded-content">
                <div class="pcoded-inner-content">
                    <div class="main-body">
                        <div class="page-wrapper">
                            <!-- [ Main Content ] start -->
                            <div class="row">

							    <!-- [ Hover-table ] start -->
                                <div class="col-xl-12">
                                    <div class="card">
					
										<form action="mobfriends/search" name="Form" id="Form" method="post">
											<div id="showform" style="padding-top: 10px;padding-left: 10px;">
												<table>
												<tr>
													<td>
								                        <div class="input-group input-group-sm mb-3">
								                           	<input class="form-control" id="keywords" type="text" name="keywords" value="${pd.keywords }" placeholder="用户名或者姓名" />
								                        </div>
													</td>
													<td style="float: left;padding-left: 10px;">
														<a class="btn btn-light btn-sm" onclick="tosearch();" style="width: 23px;height:30px;margin-top:1px;" title="检索">
															<i style="margin-top:-3px;margin-left: -6px;" class="feather icon-search"></i>
														</a>
														<a class="btn btn-light btn-sm" href="mobqgroup/goAdd" style="height:30px;margin-top:1px;" title="找群">
															找群
														</a>
													</td>
												</tr>
												</table>
												<table>
													<tr>
														<!-- 开始循环 -->	
														<c:choose>
															<c:when test="${not empty varList}">
																<c:forEach items="${varList}" var="var" varStatus="vs">
																	<td>
																		<div style="padding-left:26px;padding-top:15px;padding-bottom:15px" class="center">
																		    <li data-uid="${var.USERNAME}" data-fromGroup="0" data-username="${var.NAME}" data-avatar="${(null == var.PHOTO1 or '' == var.PHOTO1)?'assets/images/user/avatar-2.jpg':var.PHOTO1}" >
																		      <a data-type="agree" class="layui-fh" style="cursor:pointer;" onclick="add('${var.USERNAME}');">
																		        <img src="${(null == var.PHOTO2 or '' == var.PHOTO2)?'assets/images/user/avatar-2.jpg':var.PHOTO2}" width="63px;" height="63px;" class="layui-circle layim-msgbox-avatar">
																		      </a>
																		      <p class="layim-msgbox-user" style="text-align: center;">
																		        <a data-type="agree" class="layui-fh1" onclick="viewUser('${var.USERNAME}');" style="cursor:pointer;">${var.NAME}</a>
																		      </p>
																		    </li>
																		</div>
																	</td>
																	${(vs.index+1) % 3 == 0 && vs.index > 0?"</tr><tr>":"" }
																</c:forEach>
															</c:when>
															<c:otherwise>
																<tr>
																	<td colspan="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${null == pd.keywords?"请先搜索":'没有相关好友'}</td>
																</tr>
																<tr>
																	<td style="height: 15px;"></td>
																</tr>
															</c:otherwise>
														</c:choose>
													</tr>
												</table>
											</div>
											<!-- [加载状态 ] start -->
										    <div id="jiazai" style="display:none;margin-top:1px;">
										    	<div class="d-flex justify-content-center">
			                                   <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
			                                          <span class="sr-only">Loading...</span>
			                                      </div>
			                                  </div>
			                                  <br><br>
			                              	</div>
										    <!-- [ 加载状态  ] End -->
										</form>
					
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
<script src="plugins/fhim/dist/layui.js?v=1"></script>
<script type="text/javascript">
	
		$(function(){
			$("#keywords").tips({
				side:3,
	            msg:'用户名或姓名',
	            bg:'#AE81FF',
	            time:2
	        });
		});
	
		//检索
		function tosearch(){
			$("#Form").submit();
			$("#jiazai").show();
		}
		
		//查看用户资料
		function viewUser(USERNAME){
			if("admin" == USERNAME){
				layer.alert('不能查看admin用户');
				return;
			}
			layer.open({
			    type: 2,
			    title: '他(她)的资料',
			    shadeClose: true,
			    shade: false,
			    maxmin: false, //开启最大化最小化按钮
			    area: ['300px', '368px'],
			    content: '<%=basePath%>user/view?USERNAME='+USERNAME
			  });
		}
		
		function add(uid){
			//询问框
			layer.confirm('<font color="black">您是要加他(她)好友吗?</font>', {
			  btn: ['申请','<font color="black">取消</font>'] //按钮
			}, function(){
			  $.ajax({
					type: "POST",
					url: 'appiminterface/addFriends',	//添加好友接口
			    	data: {FUSERNAME:uid,FGROUP_ID:'9999',BZ:'申请加好友',tm:new Date().getTime()},
					dataType:'json',
					cache: false,
					success: function(data){
						if('01' == data.result){
							layer.msg('<font color="black">添加成功,等待对方同意</font>', {icon: 1});
						}else{
							layer.msg('<font color="black">您已经添加过他(她)了,无需再添加了</font>', {icon: 2});
						}
					}
				});
			}, function(){
			  
			});
		}
				
		layui.use(['layim', 'flow'], function(){
		});
	</script>
</body>
</html>