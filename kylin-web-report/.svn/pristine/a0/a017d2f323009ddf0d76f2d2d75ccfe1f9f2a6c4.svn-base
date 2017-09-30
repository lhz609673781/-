<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@page import="com.ycgwl.kylin.web.report.utils.DateUtils"  %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>信息量化统计表</title>
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
		<script type="text/javascript" src="${staticPath}js/sheet/infoQuantization.js" ></script>
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
						<p>当前位置：<span>运营部报表</span>><i>信息量化统计表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>信息量化统计表</h2>
						<div class="collect-form depart">
							<form id="serachInfoQuantization" method="post">
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
								<div class="btn" onclick="searchInfoQuantization();">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao" onclick="exportInfoQuantization();">
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
								<thead>
									<tr>
										<th width="">序号</th>
										<th width="">分公司</th>
										<th width="">托运票数</th>
										<th width="">未发运</th>
										<th width="">发运完成率</th>
										<th width="">成本未录入</th>
										<th width="">成本录入完成率</th>
										<th width="">财凭未生成</th>
										<th width="">财凭录入完成率</th>
										<th width="">毛利<-5%</th>
										<th width="">差异占比</th>
									</tr>
								</thead>
								<c:forEach items="${list}" var="obj" varStatus="status">
									<tbody>
										<tr>
											<td>${status.index+1 }</td>
											<td>${obj.companyName }分公司</td>
											<td>${obj.totalSum }</td>
											<td>${obj.notDeliveSum }</td>
											<td>${obj.deliveFinishRate}%</td>
											<td>${obj.notCostSum}</td>
											<td>${obj.costFinishRate}%</td>
											<td>${obj.notIncomeSum }</td>
											<td>${obj.notIncomeFinishRate}%</td>
											<td>${obj.grossProfitSum }</td>
											<td>${obj.grossProfitRate}%</td>
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