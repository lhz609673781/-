<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<title></title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/mineProjectTeam.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
</head>
<body  style="background-color: #f8f8f8;">
    <div class="weui-cells">
		<div class="weui-cell">
			<div class="weui-cell__bd">
			  <p>用户名称</p>
			</div>
			<div class="weui-cell__ft">${UserDetail.uname}</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__bd">
			  <p>手机号</p>
			</div>
			<div class="weui-cell__ft">${UserDetail.mobilephone }</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__bd">
			  <p>创建时间</p>
			</div>
			<div class="weui-cell__ft"><fmt:formatDate pattern="yyyy-MM-dd" value="${UserDetail.createtime}" /></div>
		</div>
		<c:if test="${user.id == guserid}">
		<a class="weui-cell weui-cell_access limitWidth" href="<%=basePath%>weixin/mine/editGroupUserRole.html?groupid=${groupid}&userid=${UserDetail.id}&roleid=${roleid}">
			<div class="weui-cell__hd">
			  <p>组中角色</p>
			</div>
			<div class="weui-cell__ft">${roleName}</div>
		</a>
		</c:if>
		<c:if test="${user.id != guserid}">
		    <div class="weui-cell">
			    <div class="weui-cell__bd">
				  <p>组中角色</p>
				</div>
				<div class="weui-cell__ft">${roleName}</div>
			</div>
		</c:if>
    </div>
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
  <script src="<%=basePath%>js/jquery-2.1.4.js"></script>
  <script src="<%=basePath%>js/jquery-weui.js"></script>
  <script type="text/javascript">
	
  </script>
</html>
