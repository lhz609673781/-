<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<base href="<%=basePath%>">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<meta name="description" content="">
		<%@ include file="./resourceswx.jsp" %>
		<title>关于千里码</title>
		<link rel="stylesheet" href="<%=basePath %>weixinCss/weui.css">
		<link rel="stylesheet" href="<%=basePath %>weixinCss/jquery-weui.css">
		<link rel="stylesheet" href="<%=basePath %>weixinCss/demos.css">
		<link rel="stylesheet" href="<%=basePath %>weixinCss/about.css" />
	</head>
	<body ontouchstart style="background:#fafafa;">
		<div class="about-banner">
			<div class="weui-flex">
				<div class="about-banner-img">
					<img src="<%=basePath %>images/about-erweima.png" alt="" />
				</div>
				<div class="weui-flex__item about-banner-con">
					<h1>专注物流领域  让运输更简单</h1>
					<p>欢迎联系我们：</p>
					<p>电话：021-51841010</p>
					<p>网址：ksh.ycgwl.com</p>
					<p>地址：上海市普陀区真南路2339号</p>
				</div>
			</div>
		</div>	
		<div class="about-con">
			<h2>千里码能做什么</h2>
			<div class="about-con-con">
				<div class="weui-line">
					<span class="block p-40 color-azureblue">运输轨迹</span>
				</div>
				<div class="weui-line">
					<span class="block p-40 color-lightgray">电子回单</span>
					<span class="block p-20 color-lightorange">一键到货</span>
				</div>
				<div class="weui-line">
					<span class="block p-9 color-skyblue">查看异常</span>
					<span class="block p-30 color-lightpink">查看报表</span>
				</div>
				<div class="weui-line">
					<span class="block p-13 color-lightyellow">web和微信协同管理</span>
					<span class="block p-20 color-lightgreen">记账账单</span>
				</div>
				<div class="weui-line">
					<span class="block p-32 color-lightgreen1">分享功能</span>
				</div>
			</div>
		</div>
		<div class="about-use">
			<h2>千里码怎么用</h2>
			<div class="about-use-item">
				<h3>创建项目组</h3>
				<p>邀请管理同事加入，并为项目组申请跟踪使用的二维码</p>
			</div>
			<div class="about-use-item">
				<h3>现场贴码</h3>
				<p>现场管理同事粘贴二维码于回单上，并使用微信扫一扫，绑定运输信息</p>
			</div>
			<div class="about-use-item">
				<h3>司机扫码</h3>
				<p>请驾驶员使用微信扫一扫，在重要的节点进行扫码，并上传已签字的回单</p>
			</div>
			<div class="about-use-item">
				<h3>查看运输任务</h3>
				<p>微信和web均可以查询运输执行情况，查询统计报表</p>
			</div>
		</div>
<%@include file="/floor.jsp" %>
	</body>
</html>
