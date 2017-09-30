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
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<meta charset="UTF-8">
<title>我的项目组</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/mineResouce.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
</head>
<body  ontouchstart style="background-color: #f8f8f8;">
    
    <div class="weui-flex mr_part1">
        <div class="weui-flex__item">
        	<a href="<%=basePath%>weixin/mine/enterMineResApply.html?type=1">
        		<img src="<%=basePath%>images/icon_resource1.png" alt="" />
        		<p>申请二维码</p>
        	</a>
        </div>
        <div class="weui-flex__item">
        	<a href="<%=basePath%>weixin/mine/mineResAdd.html">
        		<img src="<%=basePath%>images/icon_resource2.png" alt="" />
        		<p>添加项目组</p>
        	</a>
        </div>
    </div>

    <div class="mr_part2 weui-panel">
    	<div class="weui-panel__hd clearfix">
    		<p class="fl">我的项目组</p>
    		<p class="fr">二维码(剩余/全部)</p>
    	</div>
    	<div class="weui-cells">
    	    <c:forEach items="${groupList }" var="group">
			<a class="weui-cell weui-cell_access" href="<%=basePath%>weixin/mine/detailResGroup.html?id=${group.id}">
				<div class="weui-cell__bd">
				  <p>${group.groupName }</p>
				</div>
				<div class="weui-cell__ft"><span>${group.number }</span>/<span>${group.totalNum }</span></div>
			</a>
			</c:forEach>
	    </div>
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
</html>
