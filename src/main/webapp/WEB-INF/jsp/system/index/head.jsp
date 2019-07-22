<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  
        <div class="m-header">
            <a class="mobile-menu" id="mobile-collapse1" style="cursor:pointer;"><span></span></a>
            <a href="main/index" class="b-brand">
                   <div class="b-bg">
                       <i class="feather icon-trending-up"></i>
                   </div>
                   <span class="b-title">${sessionScope.sysName}</span>
               </a>
        </div>
        <a class="mobile-menu" id="mobile-header" style="cursor:pointer;">
            <i class="feather icon-more-horizontal"></i>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
            	<li><a style="cursor:pointer;" class="full-screen" onclick="callMeal()"><i class="feather icon-codepen"></i></a></li>
            	<li><a style="cursor:pointer;" class="full-screen" onclick="javascript:toggleFullScreen()"><i class="feather icon-maximize"></i></a></li>
                <li>
                    <div class="dropdown">
                        <a class="dropdown-toggle" style="cursor:pointer;" data-toggle="dropdown" id="myIm"><i class="icon feather icon-bell" id="taskCount"></i></a>
                        <div class="dropdown-menu dropdown-menu-right notification">
                            <div class="noti-head">
                                <h6 class="d-inline-block m-b-0">待办任务</h6>
                            </div>
                            <ul class="noti-body" id="myTask" >
                            </ul>
                            <div class="noti-footer">
                                <span onclick="rutasklist();" style="cursor:pointer;"><a><font color="black">查看我的任务列表</font></a></span>
                            </div>
                        </div>
                    </div>
                </li>
                <li><a style="cursor:pointer;" class="displayChatbox" onclick="fhsms();" id="fhsmsCount"><i class="icon feather icon-mail"></i></a></li>
                <li>
                    <div class="dropdown drp-user">
                        <a style="cursor:pointer;" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="icon feather icon-settings"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right profile-notification">
                            <div class="pro-head">
                                <img src="assets/images/user/avatar-2.jpg" class="img-radius" id="userPhoto">
                                <span id="user_name"></span>
                                <a href="main/logout" class="dud-logout" title="退出系统">
                                    <i class="feather icon-log-out"></i>
                                </a>
                            </div>
                            <ul class="pro-body">
                                <li id="systemset" onclick="sysSet();"><a style="cursor:pointer;" class="dropdown-item"><i class="feather icon-settings"></i> 系统设置</a></li>
                                <li><a href="javascript:goEditMyInfo();"" class="dropdown-item"><i class="feather icon-user"></i> 修改资料</a></li>
                                <li><a href="javascript:editPhoto();" class="dropdown-item"><i class="feather icon-image"></i> 修改头像</a></li>
                                <li><a href="main/logout" class="dropdown-item"><i class="feather icon-lock"></i> 退出系统</a></li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    
 <div id="fhsmsobj"><!-- 声音消息提示 --></div>
 
<script type="text/javascript" src="assets/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>
<script src="assets/plugins/sweetalert/js/sweetalert.min.js"></script>
<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">
     
     function callMeal(){
         var date=new Date();
         var isDate=date.getHours()+(date.getMinutes()/60);
				 if(isDate>11){
				   swal("订餐失败", "请在当日11时之前订餐!", "success");
				   return;
				 }
         $.ajax({
        				type: "POST",
        				url: '<%=basePath%>meal/callMeal',
        		    data: {},
        				dataType:'json',
        				cache: false,
        				success: function(data){
        				    if("success" == data.result){
	    	        			swal("订餐成功", "请准时就餐!", "success");
	    	        		}else if("admin" == data.result){
	    	        		  swal("订餐失败", "管理员无法在此订餐!", "success");
	    	        		}else{
	    	        		  swal("订餐失败", "今日您已订餐,无需再订!", "success");
	    	        		}
        				}
        			});
     }


</script>