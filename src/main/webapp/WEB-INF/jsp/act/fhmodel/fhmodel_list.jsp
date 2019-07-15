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
    <meta name="author" content="" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

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
                                    <form action="fhmodel/list" method="post" name="Form" id="Form">
                                        <div style="padding-left: 15px;padding-top: 15px;">
											<!-- 检索条件  -->
											<table>
												<tr>
													<td>
								                        <div class="input-group input-group-sm mb-3">
                                                        	<input class="form-control" id="KEYWORDS" type="text" name="KEYWORDS" value="${pd.KEYWORDS }" placeholder="这里输入关键词" />
                                                    	</div>
													</td>
													<td style="vertical-align:top;padding-left:5px;">
														<select name="category" id="category" title="模型分类"  style="height: 30px;width:96px;padding-left:6px;border: 1px solid #CED4DA;transparent;appearance:none;-moz-appearance:none;-webkit-appearance:none;">
														</select>
													</td>
													<td style="vertical-align:top;padding-left:5px;">
														<a class="btn btn-light btn-sm" onclick="searchs();" style="width: 23px;height:30px;margin-top:1px;" title="检索"><i style="margin-top:-3px;margin-left: -6px;"  class="feather icon-search"></i></a>
													</td>
												</tr>
											</table>
											<!-- 检索  -->
                                        </div>
                                        <div class="card-block table-border-style" style="margin-top: -15px">
                                            <div class="table-responsive">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
										                 	<th style="width: 50px;" id="cts">
									                            <div class="checkbox d-inline">
		                                                            <input type="checkbox" name="fhcheckbox" id="zcheckbox">
		                                                            <label  style="max-height: 12px;" for="zcheckbox" class="cr"></label>
		                                                        </div>
															</th>
										                    <th style="width: 50px;">NO</th>
															<th>模型名称</th>
															<th>分类</th>
															<th>创建时间</th>
															<th>最后更新时间</th>
															<th>版本</th>
															<th style="width: 350px;">操作</th>
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
		                                                            	<input type="checkbox" id="zcheckbox${vs.index }" name='ids' value="${var.ID_}">
		                                                            	<label  style="max-height: 12px;" for="zcheckbox${vs.index }" class="cr"></label>
		                                                        	</div>
																 </td>
											                     <td scope="row" id="F${var.ID_}">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											                     <td>${var.NAME_}</td>
											                     <td>${var.DNAME}
											                     	<span class="green" style="cursor: pointer;">
																		<i class="feather icon-edit" title="修改" onclick="goEditType('${var.ID_}');"></i>
																	</span>
											                     </td>
											                     <td>${fn:substring(var.CREATE_TIME_ ,0,19)}</td>
											                     <td>${fn:substring(var.LAST_UPDATE_TIME_ ,0,19)}</td>
											                     <td>v.${var.VERSION_}</td>
											                     <td>
											                     	<shiro:hasPermission name="fhmodel:edit">
											                     		<a style="height:20px;margin-left: -10px;" class="btn btn-light btn-sm" onclick="editor('${var.ID_}');"><div style="margin-top:-6px;margin-left: -1px;">流程设计器</div></a>
											                     		<a style="height:20px;margin-left: -10px;" class="btn btn-light btn-sm" onclick="deployment('${var.ID_}','F${var.ID_}');"><div style="margin-top:-6px;margin-left: -1px;">部署</div></a>
											                     	</shiro:hasPermission>
											                     	<shiro:hasPermission name="fhmodel:cha">
											                     		<a style="height:20px;margin-left: -10px;" class="btn btn-light btn-sm" onclick="view('${var.ID_}','F${var.ID_}');"><div style="margin-top:-6px;margin-left: -1px;">预览</div></a>
											                     		<a style="height:20px;margin-left: -10px;" class="btn btn-light btn-sm" onclick="exportXml('${var.ID_}','F${var.ID_}');"><div style="margin-top:-6px;margin-left: -1px;">导出</div></a>
											                     	</shiro:hasPermission>
											                     	<shiro:hasPermission name="fhmodel:del">
											                     		<a style="height:20px;margin-left: -10px;" class="btn btn-light btn-sm" title="删除" onclick="del('${var.ID_ }');"><div style="margin-top:-6px;margin-left: -1px;">删除</div></a>
											                     	</shiro:hasPermission>
											                     </td>
											                 </tr>
										                 </c:forEach>
										                </c:when>
														<c:otherwise>
															<tr>
																<td colspan="10">没有相关数据</td>
															</tr>
														</c:otherwise>
													 </c:choose>
									                </tbody>
                                                </table>
                                                
                                                <table style="width:100%;margin-top:15px;">
													<tr>
														<td style="vertical-align:top;">
															<shiro:hasPermission name="fhmodel:add"><a class="btn btn-light btn-sm" onclick="add();">新增</a></shiro:hasPermission>
															<shiro:hasPermission name="fhmodel:del"><a class="btn btn-light btn-sm" onclick="makeAll('确定要删除选中的数据吗?');">删除</a></shiro:hasPermission>
														</td>
														<td style="vertical-align:top;"><div style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
													</tr>
												</table>
                                                
                                            </div>
                                        </div>
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
<script type="text/javascript">

	//检索
	function searchs(){
		$("#Form").submit();
	}
	
	//新增
	function add(){
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增模型";
		 diag.URL = '<%=basePath%>fhmodel/goAdd';
		 diag.Width = 600;
		 diag.Height = 315;
		 diag.Modal = true;				//有无遮罩窗口
		 diag. ShowMaxButton = true;	//最大化按钮
	     diag.ShowMinButton = true;		//最小化按钮
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
				var sunval = diag.innerFrame.contentWindow.document.getElementById('sunval').value;
				editor(sunval);//打开流程编辑器
				searchs();
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//删除
	function del(Id){
		swal({
			title: '',
            text: "确定要删除吗?",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
            	$.ajax({
        			type: "POST",
        			url: '<%=basePath%>fhmodel/delete',
        	    	data: {ID_:Id,tm:new Date().getTime()},
        			dataType:'json',
        			cache: false,
        			success: function(data){
        				 if("success" == data.result){
        					 swal("删除成功", "已经从列表中删除!", "success");
        				 }
        				 setTimeout(searchs, 1500);
        			}
        		});
            }
        });
	}
	
	//批量操作
	function makeAll(msg){
		swal({
            title: '',
            text: msg,
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
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
			            msg:'点这里全选',
			            bg:'#AE81FF',
			            time:3
			        });
	                swal("", "您没有选择任何内容!", "warning");
					return;
				}else{
					if(msg == '确定要删除选中的数据吗?'){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>fhmodel/deleteAll?tm='+new Date().getTime(),
					    	data: {DATA_IDS:str},
							dataType:'json',
							cache: false,
							success: function(data){
								if("success" == data.result){
									swal("删除成功", "已经从列表中删除!", "success");
		        				 }
		        				 setTimeout(searchs, 1500);
							}
						});
					}
				}
            }
        });
	}

	//打开修改类型页面
	function goEditType(ID_){
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="修改类型";
		 diag.URL = '<%=basePath%>fhmodel/goEdit?ID_='+ID_;
		 diag.Width = 399;
		 diag.Height = 146;
		 diag.Modal = true;				//有无遮罩窗口
		 diag. ShowMaxButton = false;	//最大化按钮
	     diag.ShowMinButton = false;	//最小化按钮
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('showform').style.display == 'none'){
				 searchs();
			}
			diag.close();
		 };
		 diag.show();
	}

	//打开流程设计器
	function editor(modelId){
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="流程设计器";
		 diag.URL = '<%=basePath%>fhmodel/editor?modelId='+modelId;
		 diag.Width = 1230;
		 diag.Height = 700;
		 diag.Modal = true;				//有无遮罩窗口
		 diag. ShowMaxButton = true;	//最大化按钮
	     diag.ShowMinButton = true;		//最小化按钮
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
	
	//部署流程定义
	function deployment(modelId,id){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>fhmodel/deployment?tm='+new Date().getTime(),
	    	data: {modelId:modelId},
			dataType:'json',
			cache: false,
			success: function(data){
				if("error" == data.result){
					$("#"+id).tips({
						side:2,
			            msg:'部署失败! 检查下是否已经画正确的流程图了?',
			            bg:'#F50100',
			            time:15
			        });
				}else{
					$("#"+id).tips({
						side:2,
			            msg:'部署成功! 可到流程管理中查看',
			            bg:'#87B87F',
			            time:15
			        });
				}
			}
		});
	}
	
	//预览
	function view(modelId,id){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>fhmodel/isCanexportXml?tm='+new Date().getTime(),
	    	data: {modelId:modelId},
			dataType:'json',
			cache: false,
			success: function(data){
				if("error" == data.result){
					$("#"+id).tips({
						side:2,
			            msg:'预览失败! 检查下是否已经画正确的流程图了?',
			            bg:'#F50100',
			            time:8
			        });
				}else{
					var diag = new top.Dialog();
					diag.Drag=true;
					diag.Title ="预览XML";
					diag.URL = '<%=basePath%>fhmodel/goView?modelId='+modelId;
					diag.Width = 1000;
					diag.Height = 608;
					diag.Modal = true;				//有无遮罩窗口
					diag. ShowMaxButton = true;		//最大化按钮
				    diag.ShowMinButton = true;		//最小化按钮
					diag.CancelEvent = function(){ 	//关闭事件
					diag.close();
					};
					diag.show();
				}
			}
		});
	}
	
	//导出模型xml
	function exportXml(modelId,id){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>fhmodel/isCanexportXml?tm='+new Date().getTime(),
	    	data: {modelId:modelId},
			dataType:'json',
			cache: false,
			success: function(data){
				if("error" == data.result){
					$("#"+id).tips({
						side:2,
			            msg:'导出失败! 检查下是否已经画正确的流程图了?',
			            bg:'#F50100',
			            time:8
			        });
				}else{
					window.location.href='<%=basePath%>fhmodel/exportXml?modelId='+modelId;
				}
			}
		});
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
		
		var category = "${pd.category}";
		$.ajax({
			type: "POST",
			url: '<%=basePath%>dictionaries/getLevels?tm='+new Date().getTime(),
	    	data: {DICTIONARIES_ID:'act001'},//act001 为工作流分类
			dataType:'json',
			cache: false,
			success: function(data){
				$("#category").html('<option value="" >请选择分类</option>');
				 $.each(data.list, function(i, dvar){
					 if(category == dvar.BIANMA){
						 $("#category").append("<option value="+dvar.BIANMA+" selected='selected'>"+dvar.NAME+"</option>");
					 }else{
						 $("#category").append("<option value="+dvar.BIANMA+">"+dvar.NAME+"</option>");
					 }
				 });
			}
		});
		
	})
	
</script>

</body>
</html>