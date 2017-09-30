<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>    
<!DOCTYPE html>
<html>
  <head>
    <%@include file="./resourceswx.jsp" %>
	<title>错误页面</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/weui.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/jquery-weui.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/demos.css"/>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
	 <script type="text/javascript">  
        function GoBack() {  
        	wx.closeWindow();
        }  
         
    </script>  
  </head>
  <body>
    <div class="weui-msg">
      <div class="weui-msg__icon-area"><i class="weui-icon-warn weui-icon_msg"></i></div>
      <div class="weui-msg__text-area">
        <h2 class="weui-msg__title">${error}</h2>
        <p class="weui-msg__desc">异常时间: ${exception_time}</p>
      </div>
      <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
          <a href="javascript:void(0);" onclick="GoBack()" class="weui-btn weui-btn_primary">关闭页面</a>
          <a href="<%=basePath%>weixin/toHomeWeChat.html" class="weui-btn weui-btn_default">返回首页</a>
        </p>
      </div>

    </div>

  </body>
</html>
