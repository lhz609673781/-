<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/datetag" prefix="fmtDate"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
  <head>
    <%@include file="../../resourceswx.jsp" %>
  	<base href="<%=basePath%>">
    <title>每日任务详情</title>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<meta name="description" content="">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/tdailyTotalDetail.css?times=<%=times%>" />
  </head>
<body ontouchstart style="background:#fafafa;">
<form id="search_form" action="<%=basePath%>weixin/dailyDetailSearch.html" method="post">
<!--搜索-->
	<div class="check-task-search">
		<div class="weui-flex">
			<div class="weui-flex__item relative">
				<i class="weui-icon-search" id="weui-icon-search" onclick="doSubmit();"></i>
				 <div class="weui-search-bar__box"  id="weui-search-bar__box">
					<input id="searchData" class="task-search-input" type="text" name="waybill.customer.companyName" value="${waybill.customer.companyName}" />
				 </div>
			 	<a href="javascript:searchClear();" class="weui-icon-clear" id="weui-icon-clear"></a>
			</div>
			<div class="task-search-btn"  onclick="doSubmit();">
				<a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">搜索</a>
			</div>
		</div>	
	</div>
	<!--状态筛选-->
	<div class="task-status">
		<div class="task-status-con weui-flex">
			<div class="task-status-item task-project">	
				<input class="change-value" type="text" value="${group.groupName }" readonly>
				<input class="task-s-time" type="text" name="waybill.groupid" value="${group.id }" readonly>
			</div>
	      	<div class="task-status-item deliver-time relative">
	      		${waybill.bindtime }
	      		<input type="text" class="task-s-time" name="waybill.bindtime" value="${waybill.bindtime }" readonly/>
	      		<!--从发货统计页跳转到项目组任务后，会带上项目组的日期，给这个input再加一个input-show class名-->
	      	</div>
	      	<div class="task-status-item task-s">	
	      		<select name="waybill.barcode.bindstatus">
					<option value="">全部</option>
					<option value="20"
						<c:if test="${'20' eq waybill.barcode.bindstatus}">selected</c:if>>已绑定</option>
					<option value="30"
						<c:if test="${'30' eq waybill.barcode.bindstatus}">selected</c:if>>运输中</option>
					<option value="40"
						<c:if test="${'40' eq waybill.barcode.bindstatus}">selected</c:if>>已到货</option>
				</select>
		      	<span class="select-down"></span>
	      	</div>
	    </div>
	</div>
 </form>
	<!--到达率
	<div class="task-project-tips">
		<p>
			<span>发货任务<em class="color-mark">10</em></span>
			<span>已到<em class="color-mark">8</em></span>
			<span>按时到达率<em class="color-mark del-margin">80%</em></span>
		</p>
	</div>
	-->
	<!--任务单内容-->
	<div class="task-list-con">
		<div class="task-list-item">
			<div class="task-list-item-con">
				<!--循环从这开始-->
				<c:forEach items="${page.list }" var="waybill">
					<div class="task-list-item-part">
						<input class="wayId" type="hidden" value="${waybill.id }">
						<input class="shareId" type="hidden" value="${waybill.shareid }">
						<div class="weui-flex">
							<div class="task-con-title">任务单号</div>
							<div class="weui-flex__item">${waybill.barcode.barcode }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title one-line-hide">送货单号</div>
							<div class="weui-flex__item">${waybill.deliveryNumber }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">收货客户</div>
							<div class="weui-flex__item one-line-hide">${waybill.customer.companyName }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">收货地址</div>
							<div class="weui-flex__item more-line-hide">${waybill.customer.address }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">任务摘要</div>
							<div class="weui-flex__item one-line-hide">${waybill.orderSummary }</div>
						</div>
						
						<p>发货时间：<span class="upload-task-time1">
							<fmtDate:stringToDate pattern="yyyy-MM-dd HH:mm:ss" value="${waybill.createtime}" />
						</span></p>
						<p>要求到货时间：<span class="upload-task-time2">
							<c:if test="${not empty waybill.arrivaltime }">
								<fmtDate:stringToDate pattern="yyyy-MM-dd HH:mm" value="${waybill.arrivaltime}" />
							</c:if>
						</span></p>
						<p>实际到货时间：<span class="upload-task-time2">
							<c:if test="${not empty waybill.receipts }">
								<fmtDate:stringToDate pattern="yyyy-MM-dd HH:mm:ss" value="${waybill.receipts[0].createtime}" />
							</c:if>
						</span></p>
						<p>
							<span class="span-info">来源：<em class="color-mark">扫码</em></span>
							<span class="span-info">已运：<em class="color-mark">${waybill.totalTime }</em>天</span>
							<span class="span-info">定位次数：<em class="color-mark">
								<c:if test="${ waybill.numOfREPORT > 999}">
									999+
								</c:if>
								<c:if test="${ waybill.numOfREPORT <= 999}">
									${waybill.numOfREPORT }
								</c:if>
							</em>次</span>
						</p>
						<!-- 
						<c:if test="${waybill.receiptNumber > 0 }">
							<span class="upload-task-status waybill-tips color-orange">有回单</span>
						</c:if>
						 -->
						
						<c:if test="${waybill.delay == true }">
							<span class="upload-task-status status-delay color-red">已延迟</span>
						</c:if>
						<c:if test="${'20' == waybill.barcode.bindstatus}">
							<span class="upload-task-status color-green">已绑定</span>
						</c:if>
						<c:if test="${'30' == waybill.barcode.bindstatus}">
							<span class="upload-task-status color-blue">运输中</span>
						</c:if>
						<c:if test="${'40' == waybill.barcode.bindstatus}">
							<span class="upload-task-status color-gray">已到货</span>
						</c:if>
						<!--运输中 字体颜色color-blue,  已绑定 color-green , 已完成  color-gray-->
					</div>
				</c:forEach>
				<!--循环在这结束-->
			</div>
		</div>
	</div>

	<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath%>js/fastclick.js"></script>
	<script>
		$(function() {
			FastClick.attach(document.body);
		});
	</script>
	<script src="<%=basePath%>js/jquery-weui.js"></script>
	<script type="text/javascript">
		var basePath = '<%=basePath%>';
		//点击添加下划线
		$('.task-status .task-status-item').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
		})
		
		//点击任务列表进入任务详情
		$('.task-list-item-con').click(function(){
			//点击任务列表进入任务详情
			var id = $(this).find('.wayId').val();
			var shareId = $(this).find('.shareId').val();
			window.location.href =basePath+'weixin/myTaskDetails.html?wayBillId='+id+'&shareId='+shareId;
		})
		
		$('form').find('a').on("click", function(){
			$('form').submit();
		});
		$('select').on("change", function(){
			$("form").submit();
		});
		
		function doSubmit(){
			var data = $("#searchData").val().replace(/(^\s*)|(\s*$)/g, "");
			$("#searchData").val(data);
			$("form").submit();
		}
		function searchClear(){
			$("#searchData").val("");
		}
	</script>
</body>
</html>