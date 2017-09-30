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
<title>编辑客户</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="<%=basePath%>css/base.css">
<link rel="stylesheet" href="<%=basePath%>css/order.css">
<script src="<%=basePath%>js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>js/customer/isCustomer.js"></script>
<script type="text/javascript">
      var basePath = "<%=basePath%>";
</script>
</head>
<body>
	<c:if test="${not empty mas }">
			<input style="display:none;" id="mas" value="${mas}" />
			<script type="text/javascript">
				if($("#mas").val() != "" || $("#mas").val() != null || $("#mas").val() != undefined){
					alert($("#mas").val());
				}
				$("#mas").val("");
			</script>
	</c:if>
	<form action="<%=basePath%>customer/revise.do" method="post"
		id="editCustomer">
		<c:if test="${not empty customerForOut }">
			<div class="order-info">
				<div class="order-title">编辑客户</div>
				<div class="order-content">
					<input id="id" name="id" type="hidden" value="${customerForOut.id }">
					<input id="status" name="status" type="hidden" value="${customerForOut.status }">
					<input id="createtime" name="createtime" type="hidden" value="${customerForOut.createtime }">
					<div class="form-box clearfix">
						<div class="form-control fl">
							<label>公司名称：</label> <input type="text"
								name="name" id="name" value="${customerForOut.name }" />
						</div>
						<div class="form-control fl">
							<label>登录名：</label><input type="text"
								id="accountid" name="accountid" value="${customerForOut.accountid }" />
						</div>
						<div class="form-control fl">
							<label>密码：</label> <input type="password"
								id="accountpass" name="accountpass" value="${customerForOut.accountpass }" />	
						</div>
					</div>
					<div class="form-box clearfix">
						<div class="form-control fl">
							<label>联系人：</label> <input type="text"
								id="connector" name="connector" value="${customerForOut.connector }" />
						</div>
						<div class="form-control fl">
							<label>联系电话：</label> <input type="text"
								id="phone" name="phone" value="${customerForOut.phone }" />
						</div>
						<div class="form-control fl">
							<label>备注：</label> <input type="text"
								class="address-width" id="remark" name="remark" value="${customerForOut.remark }" />
						</div>
					</div>
					<div class="btn-control">
							<button class="save" type="button" onclick="edit();">保存</button>
							<button class="reset" type="reset">取消</button>
					</div>
				</div>
				
			</div>
		</c:if>
	</form>
</body>
</html>