<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="ycgwl.track.entity.User"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	// 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。 
	pageContext.setAttribute("basePath", basePath);
	String appUrl =  request.getScheme() + "://" + request.getServerName()+"/weixin/weixinCallback.html";
	String toUrl = URLEncoder.encode(appUrl, "UTF-8");
	String sessionId = request.getSession().getId();
	//已登录逻辑处理
	if(null!=request.getSession()){
		User user = (User)request.getSession().getAttribute("user");
		if(null!=user && StringUtils.isNotEmpty(user.getMobilephone())){
			response.sendRedirect(basePath+"index.html");
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>物流跟踪</title>
<meta charset="UTF-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reset.css">
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/login.js"></script>
<script type="text/javascript" src="<%=basePath%>js/weixin_login.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/login.css" />
</head>
<body onload="init()">
	
	 <div class="bg">
        <div class="logo">
            <img src="<%=basePath%>images/login_logo.png">
            <h2>千里码运输管理平台</h2>
            
        </div>
        <div class="loginBoxBg" id="login_container">
           <%--  <img src="<%=basePath%>images/public.jpg">
            <p>微信扫一扫登录</p> --%>
        </div>
    </div>
	
</body>
<script type="text/javascript">
    function init(){
    	//解决子框架嵌套的问题  
    	if(window != window.parent){  
    	    window.parent.location.reload(true);  
    	}  
    }

	var obj = new WxLogin({
		   id:"login_container", 
		   appid: "wxd040e79c9bb89c54", 
		   scope: "snsapi_login", 
		   redirect_uri:"<%=toUrl%>",
		   state: "<%=sessionId%>",
		   style: "white",
		   href: ""
		});
</script>

</html>