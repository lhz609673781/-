<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="远成物流">
<meta name="description" content="远成物流">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="copyright" content="远成物流">
<!--需要加载的css文件-->
<link rel="stylesheet" href="${staticPath}css/base.css"/>
<link rel="stylesheet" href="${staticPath}css/style.css"/>
<!--结束-->
<title>远成物流</title>
</head>
<body>
	<c:if test="${not empty loginmas }">
		<script type="text/javascript">
			parent.location.reload();
		</script>
	</c:if>
	<div class="bg">
        <div class="logo"><a href="#"></a></div>
        <div class="loginBoxBg" style="padding-top: 15px;">
            <form class="login-box" action="<%=basePath%>user/tmslogin" method="post" id="login">
                <div class="control">
                    <input type="text" name="username" id="username" placeholder="请输入用户名"/>
                    <span class="user"></span>
                </div>
                <div class="control" style="margin-top: 10px;">
                    <input type="password" name="password" id="password" placeholder="请输入密码"/>
                    <span class="pwd"></span>
                </div>
                <!-- <div id="container">
						<span><input name="loginradio" type="radio" class="input_check" id="check3" checked="checked" value="1"><label for="check3"></label>&nbsp;&nbsp;管理员</span>
						<span><input name="loginradio" type="radio" class="input_check" id="check4" value="2"><label for="check4"></label>&nbsp;&nbsp;操作员</span>
						<span><input name="loginradio" type="radio" class="input_check" id="check5" value="3"><label for="check5"></label>&nbsp;&nbsp;审核员</span>
				</div> -->
				<div class="message" style="color: red;margin-top: 15px;">
                  ${login}
  				  </div> 
                <div class="control submit" style="margin-top: 30px;">
                    <input type="button" value="登录" onclick="getUser();"/>
                </div>
            </form>
        </div>
    </div>
    <script src="${staticPath}js/jquery.min.js"></script>
    <script src="${staticPath}js/index.js"></script>
</body>
</html>