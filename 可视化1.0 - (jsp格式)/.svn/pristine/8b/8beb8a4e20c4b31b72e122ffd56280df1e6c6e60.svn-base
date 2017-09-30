<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/datetag" prefix="fmtDate"%>
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
<title>每日统计详情</title>
<link rel="stylesheet" href="<%=basePath%>css/reset.css" />
<link rel="stylesheet" href="<%=basePath%>css/layout.css" />
<link rel="stylesheet" href="<%=basePath%>css/page.css" />
<link rel="stylesheet" href="<%=basePath%>css/countDetail.css" />
</head>
<body>
	<div class="track-content">
		<form id="searchDetailForm"
			action="<%=basePath%>dailyDetailSearch.html" method="post">
			<input type="hidden" id="pageNo_" name="pageNo" value=""> 
			<input type="hidden" id="pageSize_" name="pageSize" value="">
			<div class="content-search">
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">项目组:</label> <select class="tex_t selec_t"
							name="waybill.groupid">
							<option value="${ group.id}">${group.groupName }</option>
						</select>
					</div>
					<div class="fl col-min">
						<label class="labe_l">送货单号:</label> <input type="text"
							class="tex_t" name="waybill.deliveryNumber"
							value="${waybill.deliveryNumber }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">发货日期:</label> <input type="text"
							class="tex_t" name="waybill.bindtime"
							value="${waybill.bindtime }" readonly>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">任务状态:</label> <select class="tex_t selec_t"
							name="waybill.barcode.bindstatus">
							<option value="">全部</option>
							<option value="20"
								<c:if test="${'20' eq waybill.barcode.bindstatus}">selected</c:if>>已绑定</option>
							<option value="30"
								<c:if test="${'30' eq waybill.barcode.bindstatus}">selected</c:if>>运输中</option>
							<option value="40"
								<c:if test="${'40' eq waybill.barcode.bindstatus}">selected</c:if>>已到货</option>
						</select>
					</div>
					<div class="fl col-min">
						<label class="labe_l">收货客户:</label> <input type="text"
							class="tex_t" name="waybill.customer.companyName"
							value="${waybill.customer.companyName }">
					</div>
					<!-- <div class="fl col-min">
						<label class="labe_l">是否超时:</label> <select class="tex_t selec_t">
							<option value="">全部</option>
							<option value="">是</option>
							<option value="">否</option>
						</select>
					</div> -->
				</div>

				<div>
					<a href="javascript:;" class="content-search-btn"
						onclick="searchDetail(1)">查询</a>
				</div>
			</div>
		</form>
		<div class="table-style">
			<table class="dtable">
				<thead>
					<tr>
						<th>任务状态</th>
						<th>任务单号</th>
						<th>送货单号</th>
						<th>任务摘要</th>
						<th>收货客户</th>
						<th>收货地址</th>
						<th>要求到货时间</th>
						<th>绑定时间</th>
						<th>实际到货时间<br />（回单上传时间）
						</th>
						<th>是否超时</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="waybill">
						<tr>
							<td><c:if test="${waybill.barcode.bindstatus==20 }">
		    			已绑定
		    			</c:if> <c:if test="${waybill.barcode.bindstatus==30 }">
		    			运输中
		    			</c:if> <c:if test="${waybill.barcode.bindstatus==40 }">
		    			已到货
		    			</c:if></td>
							<td>${waybill.barcode.barcode }</td>
							<td>${waybill.deliveryNumber }</td>
							<td>${waybill.orderSummary }</td>
							<td>${waybill.customer.companyName }</td>
							<td>${waybill.customer.address }</td>
							<td><c:if test="${not empty waybill.arrivaltime }">
									<fmtDate:stringToDate pattern="yyyy-MM-dd HH:mm"
										value="${waybill.arrivaltime}" />
								</c:if></td>
							<td><fmtDate:stringToDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${waybill.createtime}" /></td>
							<td><c:if test="${not empty waybill.receipts }">
									<fmtDate:stringToDate pattern="yyyy-MM-dd HH:mm:ss"
										value="${waybill.receipts[0].createtime}" />
								</c:if></td>
							<td><c:if test="${waybill.delay != null && waybill.delay }">
										<font color="red">是</font>
									</c:if>
									<c:if test="${waybill.delay == null || !waybill.delay }">
										否
									</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${not empty page.list}">
				<div class="pages clearfix">
					<div class="pageCenter">
					<select
							id="pageSize" onchange="searchDetail(1)">
							<option value="10"
								<c:if test="${page.pageSize==10 }">selected</c:if>>10条/页</option>
							<option value="20"
								<c:if test="${page.pageSize==20 }">selected</c:if>>20条/页</option>
							<option value="50"
								<c:if test="${page.pageSize==50 }">selected</c:if>>50条/页</option>
						</select>
						<span class="page-sum">第${page.pageNum }/${page.pages }页(共${page.total }条)</span>
						<c:choose>
							<c:when test="${page.pageNum != 1}">
								<a href="javascript:;" onclick="searchDetail(1)">首页</a>
								<a href="javascript:;" onclick="searchDetail(${page.prePage })">上一页 </a>
							</c:when>
							<c:otherwise>
                                <span>首页</span>
								<span>上一页 </span>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.pageNum != page.pages}">
								<a href="javascript:;" onclick="searchDetail(${page.nextPage })">下一页</a>
								<a href="javascript:;" onclick="searchDetail(${page.pages })">末页</a>
							</c:when>
							<c:otherwise>
                                <span>下一页</span>
								<span>末页 </span>
							</c:otherwise>
						</c:choose>
						<input id="jumpPageNo" type="text" class="enterNum" value="${page.pageNum }">
						<a href="javascript:;" onclick="jump2Page()">跳转</a>
					</div>
				</div>
			</c:if>
		</div>
	</div>

	<script src="<%=basePath%>js/jquery.min.js"></script>
	<script src="<%=basePath%>js/nav.js"></script>
	<script>
	   //搜索查询
    function searchDetail(pageNum){
    	$("#pageNo_").val(pageNum);
     	var pageSize = $("#pageSize").val();
		$("#pageSize_").val(pageSize);
        $("#searchDetailForm").submit();
     }
	   
    //页面跳转
    function jump2Page(){
  	  var pageNo = $("#jumpPageNo").val();
  	  searchDetail(pageNo);
    }
   </script>
</body>
</html>