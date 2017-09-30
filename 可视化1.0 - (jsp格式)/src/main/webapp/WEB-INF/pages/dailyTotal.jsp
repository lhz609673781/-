<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>每日统计</title>
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/reset.css" />
<link rel="stylesheet" href="<%=basePath%>css/layout.css" />
<link rel="stylesheet" href="<%=basePath%>css/count.css" />
<link rel="stylesheet"
	href="<%=basePath%>plugin/css/bootstrap-datetimepicker.css" />
<link rel="stylesheet"
	href="<%=basePath%>font-awesome/css/font-awesome.css" />
<style type="text/css">
</style>
</head>
<body>
	<div class="custom-content">
		<form id="searchDailyForm" action="<%=basePath%>dailyTotal.html"
			method="post">
			<div class="content-search">
				<div class="clearfix">
					<div class="fl col-middle">
						<label class="labe_l">项目组:</label>
						<select class="tex_t selec_t" name="groupid" id="selectGroup">
							<c:forEach items="${groups}" var="group">
								<option value="${ group.id}"
									<c:if test="${waybill.groupid == group.id }">selected</c:if>>${group.groupName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="fl col-max">
						<label class="labe_l">发货日期:</label>
						<div class="clearfix tex_t reset_text">
							<div class="input-append date fl" id="datetimeStart">
								<input type="text" class="" name="bindStartTime"
									value="${waybill.bindStartTime }" readonly>
								<span class="add-on">
									<i class="icon-th"></i>
								</span>
							</div>
							<span class="to_link">至</span>
							<div class="input-append date fl" id="datetimeEnd">
								<input type="text" class="" name="bindEndTime"
									value="${waybill.bindEndTime }" readonly>
								<span class="add-on">
									<i class="icon-th"></i>
								</span>
							</div>
						</div>
					</div>
					<div class="fl col-middle">
						<label class="labe_l">收货客户:</label>
						<input type="text" class="tex_t" placeholder="请输入客户名称筛选"
							name="customerName"
							value="${waybill.customerName }">
					</div>
				</div>
				<div>
					<a href="javascript:;" class="content-search-btn"
						onclick="searchDaily()">查询</a>
				</div>
			</div>
		</form>
		<div class="table-style">
			<table>
				<thead>
					<tr>
						<th>发货日期</th>
						<th>发货任务数</th>
						<th>已到货任务数</th>
						<th>准时到货任务数</th>
						<th>准时到货率</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${total.dailyTotals }" var="dailyTotal">
						<tr>
							<td>${dailyTotal.date}</td>
							<td>${dailyTotal.taskCount}</td>
							<td>${dailyTotal.totalArriveCount}</td>
							<td>${dailyTotal.arriveCount}</td>
							<td>${dailyTotal.arriveRate}</td>
							<td>
								<a href="javascript:;" class="add-info"
									onclick="goDetail('${dailyTotal.date}')">查看详情</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<th>总计</th>
						<th>${total.allCount }</th>
						<th>${total.allTotalArriveCount }</th>
						<th>${total.allArriveCount }</th>
						<th>${total.allRate }</th>
						<th></th>
					</tr>
				</tfoot>

			</table>
			<div class="pageTest clearfix"></div>
		</div>
	</div>

	<script src="<%=basePath%>js/jquery.min.js"></script>
	<script src="<%=basePath%>js/bootstrap.min.js"></script>
	<script src="<%=basePath%>plugin/js/bootstrap-datetimepicker.js"></script>
	<script src="<%=basePath%>plugin/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/datetimepicker.js"></script>
	<script src="<%=basePath%>js/nav.js"></script>
	<script>

		//搜索
		function searchDaily() {
			$("#searchDailyForm").submit();
		}

		function goDetail(date) {
			var groupid = $("#selectGroup").val();
			location.href = "<%=basePath%>dailyDetail/" + groupid+"/" + date +".html";	  
		  }
	</script>
</body>
</html>