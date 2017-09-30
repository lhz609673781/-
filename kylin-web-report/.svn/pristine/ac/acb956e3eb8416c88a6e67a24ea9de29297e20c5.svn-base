<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/static/report/";
	// 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。 
	pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="height: 100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>承运商管理</title>
<link rel="stylesheet" href="<%=basePath%>css/base.css">
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/search.css">
<link rel="stylesheet" href="<%=basePath%>css/order.css">
<script src="<%=basePath%>js/jquery.min.js" type="text/javascript"></script>
<script src="<%=basePath%>js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath%>js/main.js" type="text/javascript"></script>
<script src="<%=basePath%>js/company/companyList.js"></script>
<script type="text/javascript">
      var basePath = "<%=basePath%>";
</script>
</head>
<body>
	<c:if test="${not empty page.list}">
		<c:forEach var="company" items="${page.list}">
				<table class="orders order-finish">
					<tbody>
						<tr class="orders-title">
							<td style="width:120px;">承运商名称</td>
							<td style="width:100px;">联系人</td>
							<td style="width:120px;">承运商电话</td>
							<td style="width:120px;">承运商账号</td>
							<td>创建时间</td>
							<td style="width:120px;">操作人</td>
							<td style="width:100px;">状态</td>
							<td style="width:300px;">操作</td>
						</tr>
						<tr class="order-goods">
							<td style="width:120px;">${company.name}</td>
							<td style="width:100px;">${company.contacts}</td>
							<td style="width:120px;">${company.phone }</td>
							<td style="width:120px;">${company.accountid }</td>
							<td>${company.createtime }</td>
							<td style="width:120px;">${company.operator }</td>
							<td style="width:100px;">
								<c:if test="${company.status==0 }">
									审核中
								</c:if>
								<c:if test="${company.status==1 }">
									启用
								</c:if>
								<c:if test="${company.status==2 }">
									停用
								</c:if>
							</td>
							<td style="width:300px;">
								<button class="button3" onclick="look(${company.id})">
									<span>查看</span>
								</button>
								<c:if test="${company.status==0 }">
									<c:if test="${sessionScope.user.usertype==1}">
										<button class="button4">
										<span>审核通过</span>
									</button>
									</c:if>
									<c:if test="${sessionScope.user.usertype==2}">
										<button class="button4">
										<span>审核通过</span>
									</button>
									</c:if>
									<c:if test="${sessionScope.user.usertype==3}">
										<button class="button1" onclick="able(${company.id});">
											<span>审核通过</span>
										</button>
									</c:if>
								</c:if>
								<c:if test="${company.status==1 }">
									<c:if test="${sessionScope.user.usertype==1}">
										<button class="button4">
										<span>停用</span>
									</button>
									</c:if>
									<c:if test="${sessionScope.user.usertype==2}">
										<button class="button4">
										<span>停用</span>
									</button>
									</c:if>
									<c:if test="${sessionScope.user.usertype==3}">
										<button class="button0" onclick="disable(${company.id});">
											<span>停用</span>
										</button>
									</c:if>
								</c:if>
								<c:if test="${company.status==2 }">
									<c:if test="${sessionScope.user.usertype==1}">
										<button class="button4">
										<span>启用</span>
									</button>
									</c:if>
									<c:if test="${sessionScope.user.usertype==2}">
										<button class="button4">
										<span>启用</span>
									</button>
									</c:if>
									<c:if test="${sessionScope.user.usertype==3}">
										<button class="button2" onclick="able(${company.id});">
											<span>启用</span>
										</button>
									</c:if>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</c:forEach>
			</c:if>
			<c:if test="${empty page}">
				<c:if test="${not empty mas}">
					<div style="font-size:20px;margin-top:30px;text-align:center;">${mas}</div>
				</c:if>
			</c:if>
		<input type="text" id="datetimepicker" />
		<div class="pages">
			<a onclick="companySearch(1)">首页</a>
			<a onclick="companySearch(${page.previousPageNo })">上一页</a>
			<c:forEach var="ye" begin="1" end="${page.totalPages }" varStatus="status">
				<c:if test="${status.count==page.pageNo }">
					<a id="currentPage" style="background:#4768f3;" onclick="companySearch(${status.count})">${status.count}</a>
				</c:if>
				<c:if test="${status.count!=page.pageNo }">
					<a onclick="companySearch(${status.count})">${status.count}</a>
				</c:if>
			</c:forEach>
			<a onclick="companySearch(${page.nextPageNo })">下一页</a> 
			<a onclick="companySearch(${page.totalPages })">末页</a>
			<span class="page-sum">共${page.totalRecords }个</span> <span>每页显示</span> 
			<select id="pageSize" onchange="companySearch(1)">
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="30">30</option>
			</select>
		</div>
		<script type="text/javascript">
      		var pageSize = ${page.pageSize};
      		$("#pageSize").val(pageSize);
		</script>
		<script>
			$(function() {
				$(
						'#datetimepicker1,#datetimepicker2,#datetimepicker3,#datetimepicker4')
						.datetimepicker({
							format : 'yyyy-mm-dd',
							minView : 2
						})
			})
		</script>
</body>
</html>