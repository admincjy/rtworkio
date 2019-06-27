<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>${pd.TITLE }-聊天记录</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->

<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="mobile/fhim/dist/css/layui.css">
<style>
body .layim-chat-main{height: auto;}
</style>
</head>
<body>

	<table style="width: 100%">
	<tr bgcolor="#36373C" height="39px;" >
		<td onclick="javascript:window.location.href='mobileindex/goIm'">
			<font color="white">&nbsp;&nbsp;&lt;&nbsp;返回</font>
		</td>
	</tr>
	</table>


	<div class="layim-chat-main">
	  <ul id="LAY_view"></ul>
	</div>
	<div id="LAY_page" style="margin: 0 10px;"></div>

	<textarea title="消息模版" id="LAY_tpl" style="display:none;">
		<!-- 开始循环 -->	
		<c:choose>
			<c:when test="${not empty varList}">
				<c:forEach items="${varList}" var="var" varStatus="vs">
					<c:if test="${pd.USERNAME == var.USERNAME }">
				    <li class="layim-chat-mine"><div class="layim-chat-user"><img src="${var.PHOTO}"><cite><i>${var.CTIME}</i>${var.NAME}</cite></div><div class="layim-chat-text">{{ layui.layim.content('${var.CONTENT}') }}</div></li>
					</c:if>
					<c:if test="${pd.USERNAME != var.USERNAME }">
				    <li><div class="layim-chat-user"><img src="${var.PHOTO}"><cite>${var.NAME}<i>${var.CTIME}</i></cite></div><div class="layim-chat-text">{{ layui.layim.content('${var.CONTENT}') }}</div></li>
					</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
					<td colspan="100" class="center" >没有聊天记录</td>
			</c:otherwise>
		</c:choose>
	</textarea>

	<form action="mobhismsg/himsglist" method="post" name="Form" id="Form">
	<input type="hidden" name="id" id="id" value="${pd.id }" />
	<input type="hidden" name="type" id="type" value="${pd.type }" />
	<input type="hidden" name="title" id="title" value="${pd.title }" />
	</form>
	<table style="width:100%;">
		<tr>
			<td style="color: black;float: right;padding-right: 15px;padding-top: 13px;">${page.pageStrSimplify}</td>
		</tr>
	</table>
<!-- 页面底部js¨ -->
<!-- ace scripts -->
<script src="mobile/fhim/dist/layui.js"></script>
<script>
layui.use(['layim', 'laypage'], function(){
  var layim = layui.layim
  ,laytpl = layui.laytpl
  ,$ = layui.jquery
  ,res = { };
  var html = laytpl(LAY_tpl.value).render({
    data: res.data
  });
  $('#LAY_view').html(html);
  
});

</script>
</body>
</html>