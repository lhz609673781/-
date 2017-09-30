<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
  <head>
    <%@include file="../../resourceswx.jsp" %>
  	<base href="<%=basePath%>">
    <title>发货统计</title>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<meta name="description" content="">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/deliverGoodsCount.css?times=<%=times%>" />
  </head>
<body ontouchstart style="background:#fafafa;">
<form action="<%=basePath%>weixin/dailyTotal.html" method="post">
	<!--状态筛选-->
	<div class="task-status">
		<div class="weui-flex">
		    	<div class="weui-flex__item deliver-team">
		      		<select name="groupid">
		      			<c:forEach items="${groups}" var="group">
		      				<c:if test="${group.id == waybill.groupid}">
		      					<option value="${group.id }" selected="selected">${group.groupName }</option>
		      				</c:if>
		      				<c:if test="${group.id != waybill.groupid}">
		      					<option value="${group.id }">${group.groupName }</option>
		      				</c:if>
		      			</c:forEach>
		      		</select>
		      		<span class="select-down"></span>
		      	</div>
		      	<div class="weui-flex__item deliver-year">
		      		<select name="selectYear">
		      			<c:forEach begin="2016" end="2017" step="1" var="y">
		      				<c:if test="${y == waybill.selectYear}">
		      					<option value="${y }" selected="selected">${y }年</option>
		      				</c:if>
		      				<c:if test="${y != waybill.selectYear}">
		      					<option value="${y }">${y}年</option>
		      				</c:if>
		      			</c:forEach>
		      		</select>
		      		<span class="select-down"></span>
		      	</div>
		      	<div class="weui-flex__item deliver-month">
		      		<select name="selectMonth">
		      			<c:forEach begin="1" end="12" step="1" var="m">
		      				<c:if test="${m == waybill.selectMonth}">
		      					<option value="${m }" selected="selected">${m }月</option>
		      				</c:if>
		      				<c:if test="${m != waybill.selectMonth}">
		      					<option value="${m }">${m}月</option>
		      				</c:if>
		      			</c:forEach>
		      		</select>
		      		<span class="select-down"></span>
		      	</div>
	    </div>
	</div>
		    </form>
	<!--发货统计内容-->
	<div class="count-con">
		<c:if test="${total.allCount > 0}">
			<!--循环从这开始-->
			<c:forEach items="${total.dailyTotals}" var="d">
				<div class="count-con-item" >
					<p class="count-con-item-title">${d.date }</p>
					<div class="count-con-item-con">
						<div class="weui-flex">
							<div class="weui-flex__item">
								发货任务：<span class="color-mark">${d.taskCount }</span>
							</div>
							<div class="weui-flex__item">
								已到货任务: <span class="color-mark">${d.totalArriveCount }</span>
							</div>
						</div>
						<div class="weui-flex">
							<div class="weui-flex__item">
								准时到达：<span class="color-mark">${d.arriveCount }</span>
							</div>
							<div class="weui-flex__item">
								按时到达率: <span class="color-mark">${d.arriveRate }</span>
							</div>
						</div>
					</div>
					<a href="<%=basePath%>weixin/dailyDetail/${waybill.groupid}/${d.date}.html" hidden="hidden">21321321</a>
				</div> 
			</c:forEach>
			<!--循环在这结束-->
		</c:if>
		<c:if test="${total.allCount == null || total.allCount <= 0}">
				<div class="task-project-tips">
					<p>
						<span><em class="color-mark">暂无数据</em></span>
					</p>
				</div>
		</c:if>
	</div>
	<%@include file="/floor.jsp" %>
	<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath%>js/fastclick.js"></script>
	<script>
		$(function() {
			FastClick.attach(document.body);
		});
	</script>
	<script src="<%=basePath%>js/jquery-weui.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			
			//点击添加下划线
			$('.task-status .weui-flex__item').click(function(){
				$(this).addClass('active').siblings().removeClass('active');
			})
			
			//点击进入项目组任务列表
			$('.count-con-item').click(function(){
				window.location.href = $(this).find('a').attr('href');
			})
			$('select').on("change", function(){
				$("form").submit();
			});
		});
      	
	</script>
</body>
</html>