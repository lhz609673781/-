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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="<%=basePath%>css/base.css">
<link rel="stylesheet" href="<%=basePath%>css/order.css">
<script src="<%=basePath%>js/jquery.min.js" type="text/javascript"></script>
<script src="<%=basePath%>js/modal.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/company/company.js"></script>
<script type="text/javascript">
      var basePath = "<%=basePath%>";
</script>
</head>
<body>
<div class="order-info">
	<div class="order-title">承运商信息</div>
	<c:if test="${not empty company }">
		<form id="editOrder">
			<input id="id" name="id" value="${company.id}" style="display:none;" />
			<input id="code" name="code" value="${company.code}" style="display:none;" />
			<input id="accountpass" name="accountpass" value="${company.accountpass}" style="display:none;" />
			<input id="createtime" name="createtime" value="${company.createtime}" style="display:none;" />
			<input id="status" name="status" value="${company.status}" style="display:none;" />
			<div class="order-content">
				<div class="form-box clearfix">
					<div class="form-control fl">
						<label for="company-name">承运商名称：</label> <input type="text"
							id="name" name="name" value="${company.name}">
					</div>
					<div class="form-control fl">
						<label for="company-name">联系人：</label> <input type="text"
							id="contacts" name="contacts" value="${company.contacts}">
					</div>
					<div class="form-control fl">
						<label for="company-name">承运商电话：</label> <input type="text"
							id="phone" name="phone" value="${company.phone }">
					</div>
					<div class="form-control fl">
						<label for="waybill-num">承运商账号：</label>
						<input type="text" id="accountid" name="accountid" value="${company.accountid }" />
					</div>
					
					<div class="form-control fl" id="bakDiv" style="display:none;">
						<label for="waybill-num">备注：</label>
						<input type="text" id="remark" name="remark" value="${company.remark }" />
					</div>
				</div>
				<c:if test="${sessionScope.user.usertype==2}">
					<!-- 点击图片以后可编辑 -->
					<div id="imageClick">
						<img alt="" src="<%=basePath%>/images/u654.png" onclick="showEdit()">
					</div>
					<div class="btn-control" id="buttons" style="display:none;">
						<button class="save" type="button" onclick="edit()">保存</button>
						<button class="reset" type="button" onclick="location.reload([false])">重置</button>
					</div>
				</c:if>
			</div>
		</form>
	</c:if>
	<c:if test="${empty company }">
		<script type="text/javascript">
			alert("详情查看失败！");
		</script>
	</c:if>
	</div>
	<script>
		$(function() {
			$('.delete').click(function() {
				$(this).parent().parent().remove();
				$('tbody tr').each(function() {
					var target = $(this).find('td')[0];
					$(target).html($(this).prevAll('tr').length + 1)
				})
			});

			$(".add-tr")
					.click(
							function() {
								var num = $('tbody tr').length + 1;
								$('tbody')
										.append(
												' <tr> <td>'
														+ num
														+ '</td> <td><input type="text" class="aditIn" name="goods['+(num-1)+'].name"></td> <td><input type="text" class="aditIn" name="goods['+(num-1)+'].type"></td> <td><input type="text" class="aditIn" name="goods['+(num-1)+'].packaging"></td> <td><input type="text" class="aditQu" name="goods['+(num-1)+'].quantity"></td> <td><input type="text" class="aditNu" name="goods['+(num-1)+'].weight"></td><td><input type="text" class="aditNu" name="goods['+(num-1)+'].size"></td> <td><a href="javascript:void(0)" class="delete">删除</a></td> </tr>')
								//绑定delete事件
								$('.delete')
										.click(
												function() {
													$(this).parent().parent()
															.remove();
													$('tbody tr')
															.each(
																	function() {
																		var target = $(
																				this)
																				.find(
																						'td')[0];
																		$(
																				target)
																				.html(
																						$(
																								this)
																								.prevAll(
																										'tr').length + 1)
																	})
												});
							})
		})
	</script>
</body>
</html>