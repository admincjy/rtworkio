<%@ page language="java" contentType="text/html; charset=UTF-8" import="org.fh.util.UetidorActionEnter" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%

    request.setCharacterEncoding( "utf-8" );
	response.setHeader("Content-Type" , "text/html");
	
	String rootPath = application.getRealPath( "/" );
	rootPath = rootPath + "/";
	out.write( new UetidorActionEnter( request, rootPath ).exec() );
	
%>