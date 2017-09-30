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
<title>组二维码</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/mineCard.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
</head>
	<body ontouchstart style="background-color: #f8f8f8;">
		<p class="text_align">分享项目组二维码邀请组员加入</p>
		<div id="qrcodeimg"></div>
			<!-- 
    <div class="weui-tabbar weui-footer_fixed-bottom">
        <a href="<%=basePath%>weixin/toHomeWeChat.html" class="weui-tabbar__item">
          <div class="weui-tabbar__icon a_tab1">   
          </div>
          <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="<%=basePath%>weixin/waybill.html" class="weui-tabbar__item">
          <div class="weui-tabbar__icon  a_tab2">
          </div>
          <p class="weui-tabbar__label">任务单</p>
        </a>
        <a href="<%=basePath%>weixin/mine.html" class="weui-tabbar__item weui-bar__item--on">
          <div class="weui-tabbar__icon  a_tab3">
          </div>
          <p class="weui-tabbar__label">我的</p>
        </a>
    </div>
    -->
	<%@include file="/floor.jsp" %>
	</body>
	<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.qrcode.min.js"></script>
	<script>
	$(function(){
        $("#qrcodeimg").qrcode({ 
          render: "canvas",
          //width: 200, //宽度 
          //height:200, //高度 
          typeNumber  : -1,      //计算模式    
          correctLevel: 0,//纠错等级    
          background: "#ffffff",//背景颜色    
          foreground: "#000000", //前景颜色   
          //添加组员  
          text: '<%=basePath%>weixin/weixinAuth.html?type=4&groupId='+${groupId}
        });
	});
	</script>
</html>
