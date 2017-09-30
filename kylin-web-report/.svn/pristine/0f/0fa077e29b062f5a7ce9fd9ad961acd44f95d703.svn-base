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
<title>客户资料详情</title>
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
				<div class="order-title">客户详情</div>
				<div class="order-content">
					<input id="id" name="id" type="hidden" value="${customerForOut.id }">
					<div class="form-box clearfix">
						<div class="form-control fl">
							<label>公司名称：</label> <input type="text"
								name="name" id="name" value="${customerForOut.name }" readonly="readonly"/>
						</div>
						<div class="form-control fl">
							<label>登录名：</label><input type="text"
								id="accountid" name="accountid" value="${customerForOut.accountid }" readonly="readonly"/>
						</div>
						<div class="form-control fl">
							<label>密码：</label> <input type="text"
								id="accountpass" name="accountpass" value="******" readonly="readonly"/>
						</div>
					</div>
					<div class="form-box clearfix">
						<div class="form-control fl">
							<label>创建时间：</label> <input id="createtime" name="createtime" type="text" value="${customerForOut.createtime }" readonly="readonly"/>
						</div>
						<div class="form-control fl">
							<label>更新时间：</label> <input type="text"
								 id="updatetime" name="updatetime" value="${customerForOut.updatetime }" readonly="readonly"/>
						</div>
						<div class="form-control fl">
							<label>操作人：</label> <input id="operator" name="operator" type="text" value="${customerForOut.operator }" readonly="readonly"/>
						</div>
					</div>
					<div class="form-box clearfix">
						<div class="form-control fl">
							<label>联系人：</label>
							<c:if test="${not empty customerForOut.connector }">
								<input type="text" id="connector" name="connector" value="${customerForOut.connector }" readonly="readonly"/>
							</c:if>
							<c:if test="${empty customerForOut.connector }">
								<input type="text" id="connector" name="connector" value="暂无联系人" readonly="readonly"/>
							</c:if>
						</div>
						<div class="form-control fl">
							<label>联系电话：</label>
							<c:if test="${not empty customerForOut.phone }">
								<input type="text" id="phone" name="phone" value="${customerForOut.phone }" readonly="readonly"/>
							</c:if>
							<c:if test="${empty customerForOut.phone }">
								<input type="text" id="phone" name="phone" value="暂无联系电话" readonly="readonly"/>
							</c:if>
						</div>
					</div>
					<div class="form-box clearfix">
						<div class="form-control fl">
							<label>状态：</label> 
							<c:if test="${customerForOut.status==0 }">
								<input id="status" name="status" type="text" value="待审核" readonly="readonly"/>
							</c:if>
							<c:if test="${customerForOut.status==1 }">
								<input id="status" name="status" type="text" value="已启用" readonly="readonly"/>
							</c:if>
							<c:if test="${customerForOut.status==2 }">
								<input id="status" name="status" type="text" value="已停用" readonly="readonly"/>
							</c:if>
						</div>
						<div class="form-control fl">
							<label>备注：</label>
							<c:if test="${not empty customerForOut.remark }">
								<input type="text" class="address-width" id="info" name="info" value="${customerForOut.remark }" readonly="readonly"/>
							</c:if>
							<c:if test="${empty customerForOut.remark }">
								<input type="text" class="address-width" id="info" name="info" value="暂无备注信息" readonly="readonly"/>
							</c:if>
						</div>
					</div>
				</div>
				
			</div>
		</c:if>
	</form>
</body>
</html>