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
<title>Insert title here</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="<%=basePath%>css/base.css">
<link rel="stylesheet" href="<%=basePath%>css/order.css">
<script src="<%=basePath%>js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>js/company/addCompany.js"></script>
<script type="text/javascript">
      var basePath = "<%=basePath%>";
</script>
</head>
<body>
<form id="addCompany">
		<div class="order-info">
			<div class="order-title">承运商信息</div>
			<div class="order-content">
				<div class="form-box clearfix">
					<div class="form-control fl">
						<label for="company-name">承运商名称：</label> <input type="text"
							id="name" name="name">
					</div>
					<div class="form-control fl">
						<label for="company-name">联系人：</label> <input type="text"
							id="contacts" name="contacts">
					</div>
					<div class="form-control fl">
						<label for="order-num">承运商电话：</label> <input type="text"
							id="phone" name="phone">
					</div>
					<div class="form-control fl">
						<label for="send-person">承运商账号：</label> <input type="text"
							name="accountid" id="accountid">
					</div>
				</div>
				<div class="btn-control">
					<button class="save" type="button" onclick="add();">新增</button>
					<button class="reset" type="reset">重置</button>
				</div>
			</div>
		</div>
		<!-- <div class="order-info">
			<div class="order-title">添加司机</div>
			<div class="order-content">
				<table id="order-table">
					<thead>
						<tr>
							<th>司机</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<select id="driver[0]" name="driver">
									<option value="driverId">driverId</option>
								</select>
							</td>
							<td><a onclick="removeRow(this);" class="delete">删除</a></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="8"><a href="javascript:void(0)" class="add-tr">+新增</a>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div> -->
	</form>
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