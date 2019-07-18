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
					
								<form action="workplan/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
									<input type="hidden" name="WORKPLAN_ID" id="WORKPLAN_ID" value="${pd.WORKPLAN_ID}"/>
									<div id="showform">
										<c:if test="${'save' == msg }">
										<div class="card-block table-border-style" style="margin-top: -15px">
				            				<div class="table-responsive">
												<table class="table table-hover mb-0">	
													<thead>
														<tr>
															<th style="width: 50px;" id="cts">
									                            <div class="checkbox d-inline">
				                                                    <input type="checkbox" name="fhcheckbox" id="zcheckbox">
				                                                    <label  style="max-height: 12px;" for="zcheckbox" class="cr"></label>
				                                                </div>
															</th>
															<!--<th style="width:50px;">NO</th>-->
															<th>工作计划标题</th>
															<th>工作计划明细</th>
															<th>计划完成时间</th>
															<th>完成进度百分比</th>
															<th>考核评分</th>
														</tr>
													</thead>
																			
													<tbody>
													<!-- 开始循环 -->	
													<c:choose>
														<c:when test="${not empty varList}">
															<c:forEach items="${varList}" var="var" varStatus="vs">
																<tr>
																	<td>
																	  	<div class="checkbox d-inline">
				                                                        	<input type="checkbox" id="zcheckbox${vs.index }" name='ids' value="${var.WORKPLANMX_ID}">
				                                                        	<label  style="max-height: 12px;" for="zcheckbox${vs.index }" class="cr"></label>
				                                                    	</div>
																	</td>
																	<!--<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>-->
																	<td>${var.TITLE}</td>
																	<td>${var.CONTENTDETAIL}</td>
																	<td>${var.PLANTIME}</td>
																	<td>${var.PROGRESS}</td>
																	<td>${var.SCORE}</td>
																</tr>
															
															</c:forEach>
														</c:when>
														<c:otherwise>
															<tr>
																<td colspan="100">没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
													</tbody>
												</table>
												<!--<table style="width:100%;margin-top:15px;">
													<tr>
														<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
													</tr>
												</table>-->
												<input type="hidden" name="DATA_IDS" id="DATA_IDS" value=""/>
												<input type="hidden" name="MSG" id="MSG" value=""/>
											</div>
										</div>	
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
													<input  style="width:10%;visibility: hidden;" />
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
										<!--<div>如需要继续完成未完成计划,请勾选</div>-->
								        </c:if>
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

								<c:if test="${'edit' == msg }">
									<div style="margin-top: 10px;width: 100%;"">
										<iframe name="treeFrame" id="treeFrame" frameborder="0" src="<%=basePath%>/workplanmx/list?WORKPLAN_ID=${pd.WORKPLAN_ID}" style="margin:0 auto;width:100%;height:500px;;"></iframe>
									</div>
								</c:if>
								
								<footer>
								<c:if test="${'yes' != isEdit && 'edit' != msg }">
									<div style="width: 100%;padding-bottom: 2px;margin-top: 10px;" class="center" id="buta">
										<a class="btn btn-light btn-sm" onclick="save('no');">新增</a>
										<a class="btn btn-light btn-sm" onclick="save('yes');">修改</a>
										<a class="btn btn-light btn-sm" onclick="del();">删除</a>
									</div>
								</c:if>
								<c:if test="${'yes' == isEdit || 'edit' == msg }">
									<div style="width: 100%;padding-bottom: 2px;margin-top: 10px;" class="center" id="butb">
										<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">确定</a>
									</div>
								</c:if>
								</footer>

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
		function save(msg){
//			var msg='';
//			var strs = '';
//			for(var i=0;i < document.getElementsByName('ids').length;i++){
//				  if(document.getElementsByName('ids')[i].checked){
//				  	if(strs=='') strs += document.getElementsByName('ids')[i].value;
//				  	else strs += ',' + document.getElementsByName('ids')[i].value;
//				  }
//			}
//			if(strs==''){
//				msg='no';
//			}else{
//				msg='yes';
//			}
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
			if (msg=='yes'&&document.getElementsByName('ids').length>0){
				var str = '';
    			for(var i=0;i < document.getElementsByName('ids').length;i++){
    				  if(document.getElementsByName('ids')[i].checked){
    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
    				  	else str += ',' + document.getElementsByName('ids')[i].value;
    				  }
    			}
    			if(str==''){
    				$("#cts").tips({
    					side:2,
    		            msg:'您没有选择任何内容!',
    		            bg:'#AE81FF',
    		            time:3
    		      });
			      return false;
    			}
				$("#DATA_IDS").val(str);
				$("#MSG").val(msg);
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
		//删除未完成得计划
		function del(){
			if (document.getElementsByName('ids').length>0){
				var str = '';
    			for(var i=0;i < document.getElementsByName('ids').length;i++){
    				  if(document.getElementsByName('ids')[i].checked){
    				  	if(str=='') str += document.getElementsByName('ids')[i].value;
    				  	else str += ',' + document.getElementsByName('ids')[i].value;
    				  }
    			}
    			if(str==''){
    				$("#cts").tips({
    					side:2,
    		            msg:'您没有选择任何内容!',
    		            bg:'#AE81FF',
    		            time:3
    		      });
			      return false;
    			}
				$.ajax({
					type: "POST",
					url: '<%=basePath%>workplanmx/delNoEnd',
			    	data: {DATA_IDS:str},
					dataType:'json',
					cache: false,
					success: function(data){
        				
					}
				});
				swal({
	                title: '',
		            text: "确定要删除后重新新增吗?",
		            icon: "warning",
		            buttons: true,
		            dangerMode: true,
	            }).then((willDelete) => {
	            	if (willDelete) {
				       top.Dialog.close();
	            	}
		        });
			}
		}
		
		$(function() {
			//复选框控制全选,全不选 
			$('#zcheckbox').click(function(){
			 if($(this).is(':checked')){
				 $("input[name='ids']").click();
			 }else{
				 $("input[name='ids']").attr("checked", false);
			 }
			});
		})
		$(function() {
		});
</script>

</body>
</html>