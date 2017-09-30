<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@page import="com.ycgwl.kylin.web.report.utils.DateUtils"  %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>财凭冲红统计表</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<link rel="stylesheet" href="${staticPath}css/Gross_margin_comparison.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery.min1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/main.js" ></script>
		<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
		<script type="text/javascript" src="${staticPath}js/sheet/moneyFlushInfo.js" ></script>
		<!--[if lt IE 9]>
	      <script src="js/respond.min.js"></script>
	    <![endif]-->
	    <script type="text/javascript">
		      var basePath = "${basePath}";
		</script>
	</head>
	<body>
		<div class="wrap">
		 <!-- 侧导航-->
			<div id="navigation">
				<h1>远成物流</h1>
			   	<jsp:include page="../menu/nav.jsp"/>
			</div>
		 <!--内容-->
			<div id="content">
				<div class="con-title">
					<div class="fl">
						<p>当前位置：<span>运营部报表</span>><i>财凭冲红统计表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>财凭冲红统计表</h2>
						<div class="collect-form depart">
							<form id="serachMoneyFlushInfo" method="post">
								<label id="label-img">
									发运日期：<input id="beginTime_id" name="beginTime" readonly="readonly" type="text" class="collect-input" style="width: 130px;" value="${beginTime }" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
										}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<label id="label-img">&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;<input id="endTime_id" name="endTime" readonly="readonly" type="text" class="collect-input" style="width: 130px;" value="${endTime }" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
											}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<div class="btn" onclick="searchMoneyFlushInfo();">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao" onclick="exportMoneyFlushInfo();">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table id="show_content">
							<c:if test="${empty list}">
						  		<tr>
									<td  colspan="7">没有查询到匹配的数据..</td>
								</tr>
					  		</c:if>
					  		<c:if test="${not empty list}">
					  		<caption id="captionMon"><span>当前筛选条件下：办单票数合计</span><b>${list[0].totalCountSum}</b>票，30分钟内冲红票数合计<b>${list[0].totalInThirtySum}</b>票，30分钟外冲红票数合计<b>${list[0].totalOutThirtySum}</b>票</span></caption>
								<thead>
									<tr>
										<th width="">序号</th>
										<th width="">分公司</th>
										<th width="">办单票数</th>
										<th width="">票数（30分钟内）</th>
										<th width="">占比（30分钟内）</th>
										<th width="">票数（30分钟外）</th>
										<th width="">占比（30分钟外）</th>
										<th width="">综合占比</th>
										<th width="">奖惩明细</th>
									</tr>
								</thead>
								<c:forEach items="${list}" var="obj" varStatus="status">
									<tbody>
										<tr>
											<td>${status.index+1 }</td>
											<td>${obj.companyName }分公司</td>
											<td>${obj.countSum }</td>
											<td>${obj.flushInThirtyMinuteSum}</td>
											<td>${obj.flushInThirtyMinuteRate}%</td>
											<td>${obj.flushOutThirtyMinuteSum}</td>
											<td>${obj.flushOutThirtyMinuteRate}%</td>
											<td>${obj.totalRate}%</td>
											<td>${obj.awardDetail}</td>
										</tr>
									</tbody>
								</c:forEach>
							</c:if>
						</table>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>