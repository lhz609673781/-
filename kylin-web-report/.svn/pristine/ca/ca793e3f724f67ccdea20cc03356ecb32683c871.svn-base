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
<title>货主方账户管理</title>
<link rel="stylesheet" href="<%=basePath%>css/base.css">
<link rel="stylesheet"
	href="<%=basePath%>css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/search.css">
<link rel="stylesheet" href="<%=basePath%>css/order.css">
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<script src="<%=basePath%>js/jquery.min.js" type="text/javascript"></script>
<script src="<%=basePath%>js/bootstrap-datetimepicker.min.js"></script>
<!-- <script src="<%=basePath%>js/main.js" type="text/javascript"></script> -->
<script src="<%=basePath%>js/modal.min.js"></script>
<script type="text/javascript">
      var basePath = "<%=basePath%>";
</script>
<script type="text/javascript" src="<%=basePath%>js/customer/customerList.js"></script>
<style type="text/css">
.order-info table tr td{
	padding-top: 0px;
}
</style>
</head>
<body>
		<c:if test="${empty page.list}">
				<script type="text/javascript">
					alert("暂无结果");
				</script>
		</c:if>
		<c:if test="${not empty page.list}">
					<c:forEach var="customer" items="${page.list}" varStatus="status">
						<table class="orders order-finish">
							<tbody>
								<tr class="orders-title">
									<td width="150px">序号</td>
									<td width="200px">公司名称</td>
									<td>登录名</td>
									<td>密码</td>
									<td>联系电话</td>
									<td width="150px;">状态</td>
									<c:if test="${user.usertype==2 }">
										<td width="150px;">操作</td>
									</c:if>
									<c:if test="${user.usertype==3 }">
										<td width="150px;">操作</td>
									</c:if>
								</tr>
								<tr class="order-goods">
									<td width="150px">${status.index+1 }</td>
									<td width="200px"><a onclick="detailsCustomer(${customer.id });">${customer.name }</a></td>
									<td>${customer.accountid }</td>
									<td>******</td>
									<td>${customer.phone }</td>
									<c:if test="${customer.status==0 }">
										<td width="150px;" style="color: red;">待审核</td>
									</c:if>
									<c:if test="${customer.status==1 }">
										<td width="150px;" style="color: green;">可用</td>
									</c:if>
									<c:if test="${user.usertype==2 }">
										<td class="finish" width="150px;" onclick="customerEdit(${customer.id});">
												<button class="button3">
													<span>编辑</span>
												</button>
										</td>
									</c:if>
									<c:if test="${user.usertype==3 }">
										<c:if test="${customer.status==0 }">
											<td class="finish" width="150px;" onclick="adopt(${customer.id});">
												<button class="button3">
													<span>启用</span>
												</button>
											</td>
										</c:if>
										<c:if test="${customer.status==1 }">
											
											<td class="finish" width="150px;">
												<button class="button4" style="cursor: default;">
													<span>启用</span>
												</button>
											</td>
										</c:if>
									</c:if>
								</tr>
							</tbody>
						</table>
					</c:forEach>
					
		</c:if>
						<div class="pages">
							<a onclick="searchCustomer(1)">首页</a>
							<a onclick="searchCustomer(${page.previousPageNo })">上一页</a>
							<c:forEach var="ye" begin="1" end="${page.totalPages }" varStatus="status">
								<c:if test="${status.count==page.pageNo }">
									<a id="currentPage" style="background:#4768f3;" onclick="searchCustomer(${status.count})">${status.count}</a>
								</c:if>
								<c:if test="${status.count!=page.pageNo }">
									<a onclick="searchCustomer(${status.count})">${status.count}</a>
								</c:if>
							</c:forEach>
							<a onclick="searchCustomer(${page.nextPageNo })">下一页</a> 
							<a onclick="searchCustomer(${page.totalPages })">末页</a>
							<span class="page-sum">共${page.totalRecords }个</span> <span>每页显示</span> 
							<select id="pageSize" onchange="searchCustomer(${page.pageNo })" style="width: 70px;float: none;">
								<option value="10">10</option>
								<option value="20">20</option>
								<option value="30">30</option>
							</select>
							<script type="text/javascript">
							    var pageSize = ${page.pageSize};
								$("#pageSize").val(pageSize);
							</script>
						</div>
</body>
</html>