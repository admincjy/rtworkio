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
					
									<form action="qgroup/search" name="Form" id="Form" method="post">
										<div id="showform" style="padding-top: 10px;padding-left: 10px;">
										<table style="width: 900px;">
											<tr>
												<td>
							                        <div class="input-group input-group-sm mb-3">
							                           	<input class="form-control" id="keywords" type="text" name="keywords" value="${pd.keywords }" placeholder="请输入群名称" />
							                        </div>
												</td>
												<td style="float: left;padding-left: 10px;">
													<a class="btn btn-light btn-sm" onclick="tosearch();" style="width: 23px;height:30px;margin-top:1px;" title="检索">
														<i style="margin-top:-3px;margin-left: -6px;" class="feather icon-search"></i>
													</a>
													<a class="btn btn-light btn-sm" href="friends/goAdd" style="height:30px;margin-top:1px;" title="找人">
														找人
													</a>
												</td>
											</tr>
										</table>
										<table>
											<tr>
												<td>
													<table>
														<tr>
															<!-- 开始循环 -->	
															<c:choose>
																<c:when test="${not empty varList}">
																	<c:forEach items="${varList}" var="var" varStatus="vs">
																		<td>
																			<div style="padding-left:30px;padding-top:15px;padding-bottom:15px" class="center">
																			    <li data-uid="${var.QGROUP_ID}" data-fromGroup="0" data-username="${var.NAME}" data-avatar="${(null == var.PHOTO or '' == var.PHOTO)?'assets/images/user/avatar-2.jpg':var.PHOTO}" >
																			      <a data-type="agree" class="layui-fh" style="cursor:pointer;">
																			        <img src="${(null == var.PHOTO or '' == var.PHOTO)?'assets/images/user/avatar-2.jpg':var.PHOTO}" width="50" height="50" class="layui-circle layim-msgbox-avatar">
																			      </a>
																			      <p class="layim-msgbox-user" style="text-align: center;">
																			        <a data-type="agree" class="layui-fh" style="cursor:pointer;">${var.NAME}</a>
																			      </p>
																			    </li>
																			</div>
																		</td>
																		${vs.index % 10 == 0 && vs.index > 0?"</tr><tr>":"" }
																	</c:forEach>
																</c:when>
																<c:otherwise>
																	<tr>
																		<td colspan="100">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${null == pd.keywords?"请先搜索":'没有相关群'}</td>
																	</tr>
																	<tr>
																		<td style="height: 15px;"></td>
																	</tr>
																</c:otherwise>
															</c:choose>
														</tr>
													</table>
												</td>
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
	           msg:'群名',
	           bg:'#AE81FF',
	           time:2
	       });
	});

	//检索
	function tosearch(){
		$("#Form").submit();
		$("#jiazai").show();
	}
	
	//点击群的头像
	var cache = {}; //用于临时记录请求到的数据
	layui.use(['layim', 'flow'], function(){
		  var layim = layui.layim
		  ,layer = layui.layer
		  ,laytpl = layui.laytpl
		  ,$ = layui.jquery
		  ,flow = layui.flow;
		  //操作
		  var active = { 
			agree: function(othis){
				var li = othis.parents('li')
			      ,uid = li.data('uid')
			      ,from_group = li.data('fromGroup')
			      ,username = li.data('username')
			      ,avatar = li.data('avatar')
				
				layim.add({
					  type: 'group' 			//friend：申请加好友、group：申请加群
					  ,groupname: username 		//好友昵称，若申请加群，参数为：groupname
					  ,avatar: avatar		 	//头像
					  ,submit: function(group, remark, index){ 
					    console.log(remark); 	//获取附加信息
					    layer.close(index); 	//关闭改面板
						$.ajax({
							type: "POST",
							url: 'iminterface/addQGroup',	//添加群接口
					    	data: {QGROUP_ID:uid,BZ:remark,tm:new Date().getTime()},
							dataType:'json',
							cache: false,
							success: function(data){
								if('01' == data.result){
									swal("申请成功", "等待群主同意", "success");
									top.applyQgroup(uid);	//申请加群消息发送给群主，此函数在 im.jsp页面
								}else{
									swal("申请失败", "您已经在此群了,无需再申请", "warning");
								}
							}
						});
					  }
					});
			}
		  };
		  $('body').on('click', '.layui-fh', function(){
			    var othis = $(this), type = othis.data('type');
			    active[type] ? active[type].call(this, othis) : '';
			});
	});
</script>
</body>
</html>