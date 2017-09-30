<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@page import="com.ycgwl.kylin.web.report.utils.DateUtils"  %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>分公司毛利率统计表</title>
<link rel="stylesheet" href="${staticPath}css/reset.css" />
<link rel="stylesheet" href="${staticPath}css/layout.css" />
<link rel="stylesheet" href="${staticPath}css/popup.css" />
<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css" />
<script type="text/javascript" src="${staticPath}js/jquery.min1.js"></script>
<script type="text/javascript" src="${staticPath}js/nav.js"></script>
<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
<script type="text/javascript" src="${staticPath}js/main.js" ></script>
<script type="text/javascript" src="${staticPath}js/sheet/grossProfitStatis.js"></script>
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
						<p>当前位置：<span>运营部报表</span>><i>分公司毛利统计表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>分公司毛利统计表</h2>
						<div class="collect-form depart">
							<form id="gross_profit_form" method="post">
								<label id="label-img">
									发运日期：<input type="text" name="beginTime" readonly="readonly" id="beginTime_id" class="collect-input" style="width: 130px;" value="${beginTime}" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
										}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<label id="label-img">&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;<input type="text" readonly="readonly" id="endTime_id" name="endTime" class="collect-input" style="width: 130px;" value="${endTime}" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
											}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<span id="tong-j">
									 统计类型：
								</span>
					           <select id="platform_id" name="platform">
					               <option value="all" selected="selected">合计</option>
					               <option value="shiti">实体</option>
					               <option value="pingtai">平台</option>
				                </select>
								<div class="btn">
									<input type="button" onclick="javascript:searchGrossProfitStatis();" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao" onclick="exportGrossProfitStatis();">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table id="show_content">
							<c:if test="${empty statisPage.list}">
						  		<tr>
									<td  colspan="7">没有符合条件的数据..</td>
								</tr>
					  		</c:if>
							<c:if test="${not empty statisPage.list}">
							<caption id="captionMon">${statisPage.list[0].platform}总收入<span><b>￥${statisPage.list[0].incomeSum}</b></span>元，${statisPage.list[0].platform}总成本<span><b>￥${statisPage.list[0].costSum}</b></span>元，${statisPage.list[0].platform}总毛利<span><b>￥${statisPage.list[0].grossProfitSum}</b></span>元</caption>
							<thead>
								<tr>
									<th width="15%">序号</th>
									<th width="35%">分公司名称</th>
									<th width="25%">${statisPage.list[0].platform}收入（元）</th>
									<th width="25%">${statisPage.list[0].platform}成本（元）</th>
									<th width="25%">${statisPage.list[0].platform}毛利（元）</th>
									<th width="25%">${statisPage.list[0].platform}毛利率</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="obj" items="${statisPage.list}" varStatus="status">
								<tr>
									<td>${status.index+1}</td>
									<td>${obj.groupName}分公司</td>
									<td>${obj.income}</td>
									<td>${obj.cost}</td>
									<td>${obj.grossProfit}</td>
									<td><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${obj.grossProfitRate*100}" />%
							</td>
								</tr>
								</c:forEach>
							</tbody>
							</c:if>
						</table>
					</div>
				</div>
			</div>
		</div>
</body>
</html>