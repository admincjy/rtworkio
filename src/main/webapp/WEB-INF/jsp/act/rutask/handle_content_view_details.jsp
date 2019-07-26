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
			th{
				background:#455661;
				color: white;
			}
		th,td {
				text-align: center;
				word-break: break-all;
				word-wrap: normal;
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
                		<c:if test="${pd.key == 'conclusion' || pd.key == 'study'}">
                            <!-- [ Main Content ] start -->
                            <div class="row">
                            	<div class="col-xl-12">
                                    <div class="card">
                                    	<c:if test="${pd.key == 'conclusion'}">
			    						    <input type="text" class="form-control" name="TYPE" id="TYPE" value="${TYPE}" maxlength="255" placeholder="" title="总结类型"  disabled="false">
			    					    </c:if>
			    						<table>
											<tr>
												<td colspan="10" id="omsg" style="padding-bottom: 15px;">
													<textarea  name="contents" id="contents" maxlength="10000" style="display:none" ></textarea>
													<script id="editor" type="text/plain" style="width:100%;height:350px;">${contents}</script>
												</td>
											</tr>
			    						</table>
			    						<!--<c:if test="${isScore == 'yes'}">
			    						<input type="number" class="form-control" name="SCORE" id="SCORE" value="${SCORE}" maxlength="255" placeholder="请对上文进行评分" title="评分">
			    					    </c:if>
			    						<c:if test="${isShowScore == 'yes'}">
			    						<input type="number" class="form-control" name="SCORE" id="SCORE" value="${SCORE}" maxlength="255" placeholder="请对上文进行评分" title="评分" disabled="false">
			    					    </c:if>-->
                                    </div>
			    				</div>
                        	</div>
                        	<!-- [ Main Content ] end -->
                        	<!--<footer>
								<div style="width: 100%;padding-bottom: 2px;margin-top: 10px;" class="center">
									<a class="btn btn-light btn-sm" onclick="editScore('${pd.PROC_INST_ID_}')">确认</a>
								</div>
						    </footer>-->
                        </c:if>
                		<c:if test="${pd.key == 'synergy' || pd.key == 'distributed'}">
                            <!-- [ Main Content ] start -->
                            <div class="row">
                            	<div class="col-xl-12">
                                    <div class="card">
                                    	<table class="table table-hover">
											<thead>
												<tr>
													<th style="width:50px;">NO</th>
													<th>标题</th>
													<th>提交内容</th>
												</tr>
											</thead>
																	
											<tbody>
											<!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty contents}">
													<c:forEach items="${contents}" var="var" varStatus="vs">
														<tr>
															<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
															<td>${var.TITLE}</td>
															<td>${var.CONTENT}</td>
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
									</div>
			    				</div>
                        	</div>
                        	<!-- [ Main Content ] end -->
                        </c:if>
                		<c:if test="${pd.key == 'studyplan'}">
                            <!-- [ Main Content ] start -->
                            <div class="row">
                            	<div class="col-xl-12">
                                    <div class="card">
                                    	<table class="table table-hover" id="tab">
											<thead>
												<tr>
													<th style="width:50px;">NO</th>
													<th>学习书目</th>
													<th>书本信息</th>
													<th>学习情况</th>
													<th>开始时间</th>
													<th>完成时间</th>
													<c:if test="${isScore == 'yes'}">
													<th>评分</th>
													</c:if>
													<c:if test="${isShowScore == 'yes'}">
													<th>评分</th>
													</c:if>
												</tr>
											</thead>
																	
											<tbody id="tablboy">
											<!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty contents}">
													<c:forEach items="${contents}" var="var" varStatus="vs">
														<tr>
															<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
															<td>${var.BOOKNAME}</td>
															<td>${var.BOOKCONTET}</td>
															<td>${var.COUNT}</td>
															<td>${var.STUDYSTARTTIME}</td>
															<td>${var.STUDYENDTIME}</td>
															<c:if test="${isScore == 'yes'}">
															<td>
																<input type="number" name="SCORE" id="SCORE" value="${var.SCORE}" maxlength="255" style="width: 65px;" placeholder="" title="评分">
															</td>
															</c:if>
															<c:if test="${isShowScore == 'yes'}">
															<td>
																<input type="number" name="SCORE" id="SCORE" value="${var.SCORE}" maxlength="255" style="width: 65px;" placeholder="" title="评分" disabled="false">
															</td>
															</c:if>
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
			                        	<!--<footer>
											<div style="width: 100%;padding-bottom: 2px;margin-top: 10px;" class="center">
												<a class="btn btn-light btn-sm" onclick="editSPScore('${pd.PROC_INST_ID_}')">确认</a>
											</div>
									    </footer>-->
									</div>
			    				</div>
                        	</div>
                        	<!-- [ Main Content ] end -->
                        </c:if>
                		<c:if test="${pd.key == 'workplan'}">
                            <!-- [ Main Content ] start -->
                            <div class="row">
                            	<div class="col-xl-12">
                                    <div class="card">
                                    	<table class="table table-hover">
											<thead>
												<tr>
													<th style="width:50px;">NO</th>
													<th>计划标题</th>
													<th>计划明细</th>
													<th>完成时间</th>
													<th>完成进度</th>
													<c:if test="${isScore == 'yes'}">
													<th>评分</th>
													</c:if>
													<c:if test="${isShowScore == 'yes'}">
													<th>评分</th>
													</c:if>
												</tr>
											</thead>
																	
											<tbody id="tablboy">
											<!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty contents}">
													<c:forEach items="${contents}" var="var" varStatus="vs">
														<tr>
															<td scope="row">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
															<td>${var.TITLE}</td>
															<td>${var.CONTENTDETAIL}</td>
															<td>${var.PLANTIME}</td>
															<td>${var.PROGRESS}</td>
															<c:if test="${isScore == 'yes'}">
																<td>
																	<input type="number" name="SCORE" id="SCORE" value="${var.SCORE}" maxlength="255" style="width: 65px;" placeholder="" title="评分">
																</td>
															</c:if>
															<c:if test="${isShowScore == 'yes'}">
																<td>
																	<input type="number" name="SCORE" id="SCORE" value="${var.SCORE}" maxlength="255" style="width: 65px;" placeholder="" title="评分"  disabled="false">
																</td>
															</c:if>
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
			                        	<!--<footer>
											<div style="width: 100%;padding-bottom: 2px;margin-top: 10px;" class="center">
												<a class="btn btn-light btn-sm" onclick="editWPScore('${pd.PROC_INST_ID_}')">确认</a>
											</div>
									    </footer>-->
									</div>
			    				</div>
                        	</div>
                        	<!-- [ Main Content ] end -->
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- [ 主内容区 ] end -->
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>

<!-- 百度富文本编辑框-->
<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
<!-- 百度富文本编辑框-->

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>

<script type="text/javascript">
	
	function editScore(id){
		if($("#SCORE").val()==""){
			$("#SCORE").tips({
				side:3,
	            msg:'请对上文进行评分',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SCORE").focus();
		return false;
		}
        $.ajax({
			type: "POST",
			url: '<%=basePath%>rutask/putScore?PROC_INST_ID_='+id+'&SCORE='+$("#SCORE").val(),
		    data: {},
				dataType:'json',
				cache: false,
				success: function(data){
				}
		});
		top.Dialog.close()
	}
	function editSPScore(id){
		var scores=[];
		var isNUll=false;
        $("#tablboy").find("tr").each(function(){  
          var tdArr = $(this).children();  
          var score = tdArr.eq(6).find("input").val(); 
		  if(score==""){
		  	isNUll=true;
		  }
          scores.push(score)
        }); 
		if(isNUll==true){
			$("#SCORE").tips({
				side:3,
	            msg:'请对所有学习计划进行评分',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SCORE").focus();
		return false;
		}
        $.ajax({
			type: "POST",
			url: '<%=basePath%>rutask/putScore?PROC_INST_ID_='+id+'&scores='+scores,
		    data: {},
			dataType:'json',
			cache: false,
			success: function(data){
			}
		});
		top.Dialog.close()
	}
	function editWPScore(id){
		var scores=[];
		var isNUll=false;
        $("#tablboy").find("tr").each(function(){  
          var tdArr = $(this).children();  
          var score = tdArr.eq(4).find("input").val();
		  if(score==""){
		  	isNUll=true;
		  }
          scores.push(score)
        }); 
		if(isNUll==true){
			$("#SCORE").tips({
				side:3,
	            msg:'请对所有工作计划进行评分',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SCORE").focus();
		return false;
		}
        $.ajax({
			type: "POST",
			url: '<%=basePath%>rutask/putScore?PROC_INST_ID_='+id+'&scores='+scores,
		    data: {},
			dataType:'json',
			cache: false,
			success: function(data){
			}
		});
		top.Dialog.close()
	}
</script>
<script type="text/javascript">
//百度富文本
setTimeout("ueditor()",500);
function ueditor(){
	var ue = UE.getEditor('editor');
}
//ueditor有标签文本
function getContent() {
    var arr = [];
    arr.push(UE.getEditor('editor').getContent());
    return arr.join("");
}
</script>
</body>
</html>