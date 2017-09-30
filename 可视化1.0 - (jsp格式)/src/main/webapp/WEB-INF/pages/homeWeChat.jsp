<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="./resourceswx.jsp" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<%
			String path = request.getContextPath();
			// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
			String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
		%>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<meta name="description" content="">
		<title>首页</title>
		<link rel="stylesheet" href="<%=basePath %>weixinCss/weui.css">
		<link rel="stylesheet" href="<%=basePath %>weixinCss/jquery-weui.css">
		<link rel="stylesheet" href="<%=basePath %>weixinCss/demos.css?times=<%=times%>">
		<link rel="stylesheet" href="<%=basePath %>weixinCss/indexNew.css?times=<%=times%>" />
	</head>
	<body ontouchstart style="background:#fafafa;">
		<!--banner-->
		<div class="banner">
			<img src="<%=basePath %>images/index-banner2.png" alt="扫码关注公众号" />
		</div>
		<!--图标导航-->
		<div class="weui-grids">
			<a href="<%=basePath %>weixin/ReceiptUp.html" class="weui-grid js_grid">
		        <div class="weui-grid__icon">
		          <img src="<%=basePath %>images/upload-pic.png" alt="">
		        </div>
		        <p class="weui-grid__label">
		          	上传回单
		        </p>
		    </a>
		    <a href="<%=basePath %>weixin/waybill.html" class="weui-grid js_grid">
		        <div class="weui-grid__icon">
		          <img src="<%=basePath %>images/my-tasks.png" alt="">
		        </div>
		        <p class="weui-grid__label">
		          	项目组任务
		        </p>
		    </a>
		    <a href="<%=basePath %>weixin/dailyTotal.html" class="weui-grid js_grid">
		        <div class="weui-grid__icon">
		          <img src="<%=basePath %>images/day-count.png" alt="">
		        </div>
		        <p class="weui-grid__label">
		          	发货统计
		        </p>
		    </a>
		    <a href="<%=basePath%>weixin/myTask.html" class="weui-grid js_grid">
		        <div class="weui-grid__icon">
		          <img src="<%=basePath %>images/mybill.png" alt="">
		        </div>
		        <p class="weui-grid__label">
		          	我的任务
		        </p>
		    </a>
		    <a href="<%=basePath %>weixin/mine/mineResouce.html" class="weui-grid js_grid">
		        <div class="weui-grid__icon">
		          <img src="<%=basePath %>images/project-team.png" alt="">
		        </div>
		        <p class="weui-grid__label">
		          	项目组管理
		        </p>
		    </a>
		    <a href="<%=basePath %>weixin/toPage.html?page=about" class="weui-grid js_grid">
		        <div class="weui-grid__icon">
		          <img src="<%=basePath %>images/platform.png" alt="">
		        </div>
		        <p class="weui-grid__label">
		          	关于千里码
		        </p>
		    </a>
		</div>
		<!--我的任务-->
		<div class="my-task padding hide">
			<div class="weui-flex">
		      	<div class="task-left">
		      		<img src="../../images/task.png" alt="" />
		      	</div>
	      		<div class="weui-flex__item task-right">
	      			<h4>我的任务</h4>
	      			<span>7:25</span>
	      			<p class="task-bind">您有新的任务需要绑定！</p>
	      			<p>赶快去绑定吧！！！</p>
	      		</div>
		    </div>
		    <div class="task-info"></div>
		</div>
		<!--底部导航-->
		<div class="weui-footer weui-footer_fixed-bottom">
		  	<div class="weui-flex">
		      	<div class="weui-flex__item">
		      		<a href="<%=basePath %>weixin/toHomeWeChat.html">
			      		<div class="weui-grid__icon footer-item">
				          	<img src="<%=basePath %>images/index-new.png" alt="">
				        </div>
				        <p class="footer-item-text">首页</p>
			        </a>
		      	</div>
		      	<div class="weui-flex__item footer-swap">
		      		<div class="footer-swap-circle" onclick="scanQRCode()"></div>
		      	</div>
		      	<div class="weui-flex__item">
		      		<a href="<%=basePath %>weixin/mine.html">
		      			<div class="weui-grid__icon footer-item">
				          	<img src="<%=basePath %>images/people-center.png" alt="">
				        </div>
				        <p class="footer-item-text">个人中心</p>
		      		</a>
		      	</div>
		    </div>
		</div>
		<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
		<script src="<%=basePath%>js/fastclick.js"></script>
		<script src="<%=basePath%>js/jquery-weui.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
		<script>
			var appId = '${appId}'; // 必填，公众号的唯一标识
		    var timestamp = '${timestamp}'; // 必填，生成签名的时间戳
		    var nonceStr = '${nonceStr}'; // 必填，生成签名的随机串
		    var signature = '${signature}';
		    var basePath = '<%=basePath%>';
		  $(function() {
		    FastClick.attach(document.body);
		  });
		</script>
		<script src="<%=basePath%>js/weixin.js?times=<%=times%>"></script>
	</body>
</html>
