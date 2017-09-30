<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
response.flushBuffer();
long times = System.currentTimeMillis();%>

<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/nav.js"></script>
<script type="text/javascript" src="<%=basePath%>js/commons/status.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/js/BeAlert.js"></script>
<script type="text/javascript" src="<%=basePath%>js/commons/baseweb.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>

<link rel="stylesheet" href="<%=basePath%>css/page.css" />
<link rel="stylesheet" href="<%=basePath%>css/reset.css" />
<link rel="stylesheet" href="<%=basePath%>css/layout.css" />
<link rel="stylesheet" href="<%=basePath%>css/weblistInfo.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>plugin/css/BeAlert.css" />
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />