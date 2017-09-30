<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>申请二维码状态</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/mineResApply.css?times=<%=times%>" />
</head>
<body ontouchstart style="background-color: #f8f8f8;">
	<form id="resForm" action="<%=basePath%>weixin/mine/mineResApply.html" method="post">
		<input type="hidden" name="userid" value="${user.id }">
		<c:if test="${not empty resourceApp }">
			<div class="weui-cells apply_status">
				<div class="weui-cell">
					<c:if test="${appStatus eq 'success' }">
						<div class="weui-cell__bd">
							<p style="text-align:center;">资源申请提交成功，系统会在3个工作日内审核，请保持电话畅通</p>
						</div>
					</c:if>
					<c:if test="${appStatus eq 'fail'  }">
						<div class="weui-cell__bd">
							<p style="text-align:center;">
								申请失败，
								<a href="javascript:;" onclick="reSendResourceApp()">重新提交申请</a>
							</p>
						</div>
					</c:if>
				</div>
			</div>
		</c:if>
		<div class="weui-cells weui-cells_form margin-top">
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">项目组</label>
				</div>
				<div class="weui-cell__bd">
					<select class="weui-select" name="groupid">
			            <option value="${group.id}">${group.groupName}</option>
					</select>
				</div>
			</div>
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">二维码数</label>
				</div>
				<div class="weui-cell__bd">
					<input readonly value="${resourceApp.number }" name="number" class="weui-input" type="text"
						min="1" max="1000" placeholder="请输入申请条码数量">
				</div>
			</div>
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">邮寄地址</label>
				</div>
				<div class="weui-cell__bd">
					<input readonly value="${resourceApp.address }" name="address" class="weui-input" type="text"
						placeholder="请输入邮寄地址">
				</div>
			</div>
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">联系人</label>
				</div>
				<div class="weui-cell__bd">
					<input readonly value="${resourceApp.contacts }" name="contacts" class="weui-input" type="text"
						placeholder="请输入联系人姓名">
				</div>
			</div>
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">联系电话</label>
				</div>
				<div class="weui-cell__bd">
					<input readonly value="${resourceApp.contactNumber }" name="contactNumber" class="weui-input"
						type="tel" placeholder="请输入联系电话">
				</div>
			</div>
		</div>
	</form>	<!-- 
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
	<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath%>js/jquery-weui.js"></script>
	<script>
		//重新提交申请
		function reSendResourceApp() {
			$("#resForm").submit();
		}
	</script>

	<%@include file="/floor.jsp" %>
</body>
</html>