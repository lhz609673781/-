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
<style>
* {
	margin: 0;
	padding: 0;
	list-style: none;
}

html, body {
	height: 100%;
	font-family: 'Microsoft Yahei';
}

.bg {
	width: 100%;
	height: 100%;
	background-image: url(<%=basePath%>images/bg.png);
	background-repeat: no-repeat;
	background-position: center 26%;
	background-size: 100%;
}

.bg .logo {
	text-align: center;
	position: absolute;
	top: 4%;
	left: 50%;
	-webkit-transform: translateX(-50%);
	transform: translateX(-50%);
}

.bg .logo>h2 {
	color: #333;
	font-weight: 400;
	font-size: 32px;
	padding: 12px 0 5px 0;
}

.bg .logo>p {
	color: #666;
}

.bg .logo>img {
	width: 100px;
}

.bg .loginBoxBg {
	width: 529px;
	height: 346px;
	background: url(<%=basePath%>images/loginBoxBg.png) no-repeat center center;
	position: absolute;
	bottom: 15%;
	left: 50%;
	-webkit-transform: translateX(-50%);
	transform: translateX(-50%);
	text-align: center;
}

.bg .loginBoxBg>img {
	width: 200px;
	height: 200px;
	margin-top: 60px;
	margin-bottom: 15px;
}

.bg .loginBoxBg>p {
	color: #4868f2;
}

@media ( max-width : 1400px) {
	.bg .logo {
		top: 4%;
	}
	.bg .logo>img {
		width: 82px;
	}
	.bg .logo>h2 {
		font-size: 20px;
	}
	.bg .logo>p, .bg .loginBoxBg>p {
		font-size: 14px;
	}
	.bg .loginBoxBg {
		bottom: 10%;
	}
}
</style>
</head>
<body onload="">
	
	 <div class="bg">
        <div class="logo">
            <img src="<%=basePath%>images/icon02.png">
            <h2>千里码运输管理平台</h2>
            <p>--从此让运输更简单</p>
        </div>
        <div class="loginBoxBg" id="login_container">
           <div id="loginBox" style="text-align:center;margin-top:150px;">
				<form action="<%=basePath%>user/login.html" method="post" onsubmit="return checkUser();">
				   OPENID:  <input type="text"  name="openid" value="oS3I7wUUjbJZvkO6o9yz9P369_zk" style="width:270px;background-color:#000000;color: #ffffff"/><br/>
					<input type="submit" value="登录" style="width:200px;background-color:blue;color: #ffffff">
				</form>
			</div>
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

	<%-- var obj = new WxLogin({
		   id:"login_container", 
		   appid: "wxd040e79c9bb89c54", 
		   scope: "snsapi_login", 
		   redirect_uri:"<%=toUrl%>",
		   state: "<%=sessionId%>",
		   style: "white",
		   href: ""
		}); --%>
</script>

</html>