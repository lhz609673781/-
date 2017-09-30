<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    // 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    // 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。 
    pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<title>绑定手机号</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
<link rel="stylesheet" href="<%=basePath%>weixinCss/bindPhone.css?times=<%=times%>" />
</head>
<body ontouchstart style="background-color: #efeff4;">

    <div class="weui-cells weui-cells_form margin-top">
        <div class="weui-cell">
            <div class="weui-cell__hd">
              <label class="weui-label">手机号</label>
            </div>
            <div class="weui-cell__bd">
              <input class="weui-input" data-id="${id}" id="tel" type="tel" placeholder="请输入手机号">
            </div>
        </div>
        <div class="weui-cell weui-cell_vcode">
            <div class="weui-cell__hd">
              <label class="weui-label">验证码</label>
            </div>
            <div class="weui-cell__bd">
              <input class="weui-input" id="code" type="number" placeholder="请输入验证码">
            </div>
            <div class="weui-cell__ft">
              <button class="weui-vcode-btn"  id="getCode" style="cursor:pointer">获取验证码</button>
            </div>
        </div>  
    </div>
    <div class='demos-content-padded'>
        <a href="javascript:;" id="showTooltips" class="weui-btn weui-btn_primary">确定</a>
    </div>
    <input type="hidden" id="groupId" name="groupId" value="${groupId}"/>
    <input type="hidden" id="state" name="state" value="${state}"/>
    <input type="hidden" id="type" name="type" value="${type}"/>

<script src="<%=basePath%>js/jquery-2.1.4.js" ></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script src="<%=basePath%>js/login.js?times=<%=times%>"></script>
<script type="text/javascript">
var basePath= '<%=basePath%>';
</script>
	
</body>
</html>