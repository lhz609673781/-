<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<meta charset="UTF-8">
<title>关注公众号</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css?times=<%=times%>" />
<style>
	h2{font-weight: 400;padding: 50px 0 0px;font-size: 30px;}
	.text_align{text-align: center;}
	#qrcodeimg{text-align: center;}
	#qrcodeimg>img{width:160px;height:160px;background:#fff;}
	p{font-size: 16px;color:#666;}
	p.p1{margin-bottom: 20px;}
	p.p2{margin:20px 0;}
</style>
</head>
	<body ontouchstart style="background-color: #f8f8f8;">
		<h2 class="text_align">千里码</h2>
		<p class="text_align p1">从此让运输更简单</p>
		<div id="qrcodeimg">
			<img src="<%=basePath%>images/public.jpg" alt="" />
		</div>
		<p class="text_align p2">微信扫描二维码即可关注千里码公众平台</p>
	</body>
	<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
</html>