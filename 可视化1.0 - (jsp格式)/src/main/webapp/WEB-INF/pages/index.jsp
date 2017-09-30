<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
      <%@include file="./resourceswx.jsp" %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title></title>
        <link rel="stylesheet" href="<%=basePath%>css/reset.css" />
        <link rel="stylesheet" href="<%=basePath%>css/layout.css" />
        <link rel="stylesheet" href="<%=basePath%>css/home.css?times=<%=times%>" />
         <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    </head>
    <body>
    	<!--头部-->
    	<div id="header">
    		<h1>千里码运输管理平台</h1>
    		<c:if test="${not empty user }">
    		<div class="admin">
    			<div class="welcome"><i>欢迎你,</i><span>${user.uname }</span></div>
    			<div class="exit"><a href="<%=basePath%>user/logout.html" style="color:white;">退出登录</a></div>
            </div>
    		</c:if>
    	</div>
    	<!--左侧菜单栏-->
        <div id="navigation">
            <ul>
                <li class="submenu active">
					<a href="javascript:;" class="menu_a" link="<%=basePath%>dailyTotal.html"><i class="i-icon"></i><span>每日统计</span></a>
				</li>
				<li class="submenu">
					<a href="javascript:;" class="menu_a" link="<%=basePath%>trace.html"><i class="i-icon"></i><span>任务单管理</span></a>
				</li>
				<li class="submenu">
					<a href="javascript:;" class="menu_a" link="<%=basePath%>customer.html"><i class="i-icon"></i><span>客户管理</span></a>
				</li>
				<li class="submenu">
					<a href="javascript:;" class="menu_a" link="<%=basePath%>MyAccountBook.html"><i class="i-icon"></i><span>我的记账</span></a>
				</li>
				<%-- <li class="submenu">
					<a href="javascript:;" class="menu_a" link="<%=basePath%>outBill/outbill.html"><i class="i-icon"></i><span>订单信息</span></a>
				</li> --%>
			</ul>
        </div>
        <!--右侧内容-->
        <div id="content">
         	 <iframe src="<%=basePath%>dailyTotal.html" id="iframe-main" frameborder='0'></iframe> 
 		</div>
		
        <script type="text/javascript" src="<%=basePath%>js/jquery.min.js" ></script>
        <script type="text/javascript" src="<%=basePath%>js/nav.js" ></script>
        <script src="<%=basePath%>js/bootstrap.min.js"></script>
        <script type="text/javascript">
			//初始化相关元素高度
			$(function(){
				init();
				$(window).resize(function(){
					init();
				});
			});
			
			function init(){
				$('#navigation').height($(window).height()-80);
				$('#iframe-main').height($(window).height()-80);
				$('#iframe-main').width($(window).width()-240);
			}
			
		</script>

    </body>
</html>