<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String pathf = request.getContextPath();
	String basePathf = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ pathf + "/";
	
	
	//   class="active"
%>

<!-- 一级菜单循环开始 -->
<c:forEach items="${menuList}" var="menu1">

	<!-- 判断此一级菜单是否有权限，并且状态是可视的 -->
	<c:if test="${menu1.hasMenu && '1' == menu1.MENU_STATE}">

	      <li class="nav-item pcoded-hasmenu" id="lm${menu1.MENU_ID }">
	          <a style="cursor:pointer;" class="nav-link"><span class="pcoded-micon">${menu1.MENU_ICON}</span><span class="pcoded-mtext">${menu1.MENU_NAME }</span></a>
	          <ul class="pcoded-submenu">
	          
	          	<!-- 判断是否有二级级菜单 -->
	           	<c:if test="${'[]' != menu1.subMenu}">
	           	
	           		<!--二级菜单循环开始 -->
	           		<c:forEach items="${menu1.subMenu}" var="menu2">
	           			
	           			<!-- 判断此二级菜单是否有权限，并且状态是可视的 -->
	           			<c:if test="${menu2.hasMenu && '1' == menu2.MENU_STATE}">
			              
			              <li ${'[]' != menu2.subMenu?'class="pcoded-hasmenu"':''} id="z${menu2.MENU_ID }">
			                  <a style="cursor:pointer;" <c:if test="${not empty menu2.MENU_URL && '#' != menu2.MENU_URL}">target="mainFrame" onclick="siMenu('z${menu2.MENU_ID }','lm${menu1.MENU_ID }','${menu2.MENU_NAME }','${menu2.MENU_URL }')"</c:if>>
			                  	${menu2.MENU_NAME }
			                  </a>
			                  
			                  <!-- 判断是否有三级级菜单 -->
	               			  <c:if test="${'[]' != menu2.subMenu}">
				                  <ul class="pcoded-submenu">
				                  
				                  	<!--三级菜单循环开始 -->
	               					<c:forEach items="${menu2.subMenu}" var="menu3">
	               					
	               						<!-- 判断此三级菜单是否有权限，并且状态是可视的 -->
	               						<c:if test="${menu3.hasMenu && '1' == menu3.MENU_STATE}">
	               						
						                      <li id="m${menu3.MENU_ID }">
						                      	
						                      	<!-- 有四级级菜单 -->
	               						  		<c:if test="${'[]' != menu3.subMenu}">
												<a style="cursor:pointer;" target="mainFrame" onclick="siMenu('m${menu3.MENU_ID }','lm${menu1.MENU_ID }','${menu3.MENU_NAME }','menu/otherlistMenu?MENU_ID=${menu3.MENU_ID }')">
													${menu3.MENU_NAME }<i style="margin-left: 8px;" class="feather icon-chevron-right"></i>
												</a>
												</c:if>
									            <!-- 没有四级级菜单 -->
									           	<c:if test="${'[]' == menu3.subMenu}">
									                 <a style="cursor:pointer;" <c:if test="${not empty menu3.MENU_URL && '#' != menu3.MENU_URL}">target="mainFrame" onclick="siMenu('m${menu3.MENU_ID }','lm${menu1.MENU_ID }','${menu3.MENU_NAME }','${menu3.MENU_URL }')"</c:if>>
									                 	${menu3.MENU_NAME }
									                 </a>
									            </c:if> 
						                      
						                      </li>
				                      
				                      	</c:if>
				                      	<!-- 判断此三级菜单是否有权限，并且状态是可视的 -->
									     
	               					</c:forEach>
	               					<!--三级菜单循环结束 -->
				                      
				                  </ul>
			                  </c:if>
			                  <!-- 判断是否有三级级菜单 -->
			                  
			              </li>
			              
			            </c:if>
			            <!-- 判断此二级菜单是否有权限，并且状态是可视的 -->
			            
	              </c:forEach>
	               <!--二级菜单循环结束 -->
	               
	           </c:if>
	           <!-- 判断是否有二级级菜单 -->     
	              
	          </ul>
	      </li>
     
     </c:if>
     <!-- 判断此一级菜单是否有权限，并且状态是可视的 --> 
	
</c:forEach>
<!-- 一级菜单循环结束 -->