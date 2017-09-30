<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<title>选择任务单</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath %>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/demos.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/checkTaskFormList.css?times=<%=times%>" />
<style type="text/css">
	#weui-search-bar__box{
		position: absolute;
		padding-left: 0px;
		padding-right:96px;
		height: 5%;
		width: 100%;
		box-sizing: border-box;
		z-index:0;
	}
	#weui-icon-clear{
		position: absolute;
		right: 90px;
		color: #B2B2B2;
		font-size: 14px;
	}
	#weui-icon-search{
		position: absolute;
		top:20px;
		left:14px;
		font-size:16px;
		z-index: 2;
	}
	
</style>
</head>

<body style="background:#fafafa;">
      		<div class="check-task-search">
      			<form id="search_form" action="<%=basePath%>weixin/searchmoreLocationList.html" method="get">
				<div class="weui-flex">
					<div class="weui-flex__item">
						<i class="weui-icon-search" onclick="doSubmit2()" id="weui-icon-search"></i>
					 <div class="weui-search-bar__box" id="weui-search-bar__box">
						<input class="task-search-input" type="text" id="searchData" name="searchData" placeholder="搜索" value="${searchData}"/>
						 <a href="javascript:searchClear();" class="weui-icon-clear" id="weui-icon-clear"></a>
					</div>
					</div>
					<div class="task-search-btn" onclick="doSubmit2();">
						<a href="javascript:void(0)" class="weui-btn weui-btn_mini weui-btn_primary">搜索</a>
					</div>
				</div>
				</form>
			</div>
			
			
			 <!--状态改变，数据放在这个box中-->
		    <div class="task-list-con">
		    	<!--一天的任务单-->
		    	<div class="task-list-item">
		    		<c:if test="${empty items}">
						<p style="text-align: center;padding:6px 0" class="task-list-item-title">未找到相关任务单</p>
    				</c:if>		    	
				   <!--多条任务单-->
				   <c:forEach items="${items}" var="itemMap" varStatus="status">
				    		<p class="task-list-item-title">${itemMap.key}</p>
					    <c:forEach items="${itemMap.value}" var="item">
					    <div class="task-list-item-con">
				      			<div class="task-list-item-part">
				      			<form action="<%=basePath%>weixin/ReceiptUp.html"  method="get" id="${item.id}">
				      				<input name="wayBillId" value="${item.id}" hidden="hidden">
				      				<input name="shareId" value="${item.shareid}" hidden="hidden">
				      				<input name="flag" value="1" hidden="hidden">
				      			    <a href="javascript:void(0);" onclick="doSubmit('${item.id}')">
					      				<div class="weui-flex">
									      	<div class="task-con-title">任务单号 :</div>
									      	<div class="weui-flex__item task-con-title" >${item.barcode.barcode }</div>
									    </div>
									    <div class="weui-flex">
									      	<div class="task-con-title">送货单号 :</div>
									      	<div class="weui-flex__item task-con-title" >${item.deliveryNumber}</div>
									    </div>
									    <div class="weui-flex">
											<div class="task-con-title">收货客户 :</div>
											<div class="weui-flex__item task-con-title one-line-hide">${item.customer.companyName }</div>
										</div>
										<div class="weui-flex">
											<div  class="task-con-title">收货地址 :</div>
											<div class="weui-flex__item task-con-title more-line-hide">${item.customer.address }</div>
										</div>
										<div class="weui-flex">
									      	<div  class="task-con-title">任务摘要 :</div>
									      	<div class="weui-flex__item task-con-title one-line-hide">${item.orderSummary }</div>
									    </div>
									    
									     <div class="weui-flex">
									    	<span class="span-info">发货时间：<fmt:formatDate value="${item.createtime}" pattern="yyyy-MM-dd  HH:mm"/></span></div>
									    <div class="weui-flex">
											<span class="span-info">要求到货：<fmt:formatDate value="${item.arrivaltime}" pattern="yyyy-MM-dd  HH:mm"/></span></div>
									    <div class="weui-flex">
											<span class="span-info">实际到货：<fmt:formatDate value="${item.receipts[0].createtime}" pattern="yyyy-MM-dd  HH:mm"/></span></div>
									     <div class="weui-flex">
									    	<span class="span-info">来源：
											    <c:if test="${item.type==1}">
											    <em class="color-mark">扫码</em>
											    </c:if>
											    <c:if test="${item.type==2}">
											   <%--  ${item.shareName} --%>
											    	<em class="color-mark">分享</em>
											    </c:if>
									    	</span>
									   		 <span class="span-info">已运：<em class="color-mark">${item.totalTime}</em>天</span>
									   		 <span class="span-info">定位次数：<em class="color-mark">${item.numOfReport}</em>次</span></div>
									   
									    <c:if test="${item.barcode.bindstatus==20}">
										    <span class="upload-task-status color-blue">已绑定</span>
										</c:if>
										<c:if test="${item.barcode.bindstatus==30}">
										    <span class="upload-task-status color-green">运输中</span>
										</c:if>
										<c:if test="${item.barcode.bindstatus==40}">
										    <span class="upload-task-status color-yellow">已到货</span>
										</c:if>
									</a>
				      		</form>
				      		</div></div>
		      			</c:forEach>
				   </c:forEach>
	      		</div>
	      	</div>
	<script src="<%=basePath %>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath %>js/jquery-weui.js"></script>
	<script>
		
		$("#searchData").keydown(function(evt){
			if(evt.keyCode==13){
				var data = $("#searchData").val().replace(/(^\s*)|(\s*$)/g, "");
				$("#searchData").val(data);
				$('#search_form').submit();
			}
		});
		
		function doSubmit2(){
			var data = $("#searchData").val().replace(/(^\s*)|(\s*$)/g, "");
			$("#searchData").val(data);
			$('#search_form').submit();
		}
		function doSubmit(org){
			$('#'+org).submit();
		}
		function searchClear(){
			$("#searchData").val("");
		}
	</script>
	
	<%@include file="/floor.jsp" %>
</body>
</html>