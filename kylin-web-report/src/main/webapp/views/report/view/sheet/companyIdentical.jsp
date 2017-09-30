<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>分公司同比查询</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<link rel="stylesheet" href="${staticPath}css/Gross_margin_comparison.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery.min1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/main.js" ></script>
		<!--<script type="text/javascript" src="http://www.js-css.cn/jscode/jquery.min.js"></script>-->
		<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
		<script type="text/javascript" src="${staticPath}js/sheet/companyIdentical.js" ></script>
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
						<p>当前位置：<span>运营部报表</span>><i>分公司同比查询</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>分公司同比查询</h2>
						<div class="collect-form depart">
							<form id="serachIdentical" method="post">
								<label id="label-img">
									发运日期：<input id="beginTime" name="beginTime" readonly="readonly" type="text" class="collect-input" style="width: 130px;" value="${osList[0].beginTime }" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
										}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<label id="label-img">
       &nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;<input id="endTime" name="endTime" readonly="readonly" type="text" class="collect-input" style="width: 130px;" value="${osList[0].endTime }" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
											}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<label class="sel">
					            	<em>&nbsp;&nbsp;&nbsp;分公司：</em>
					            	<select name="groupName" id="groupName">
				                	</select>
				                </label>
								<div class="btn">
									<input type="button" value="确定" class="btn-yes" onclick="serachidentical();"/>
								</div>
								<div class="btn-dao" onclick="identicalExport();">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table id="companyIdentical">
							<c:if test="${empty osList}">
						  		<tr>
									<td  colspan="7">没有查询到匹配的数据..</td>
								</tr>
					  		</c:if>
					  		<c:if test="${not empty osList}">
					  			<caption id="captionMon"><span>当前筛选条件下：实体收入总合计<b id="incomesum"></b>元，实体成本总合计<b id="costsum"></b>元，实体毛利总合计<b id="grossProfitsum"></b>元</span></caption>
								<thead>
									<tr>
										<th width="">序号</th>
										<th width="">起始时间</th>
										<th width="">结束时间</th>
										<th width="">实体收入合计（元）</th>
										<th width="">实体成本合计（元）</th>
										<th width="">实体毛利合计（元）</th>
										<th width="">实体毛利率</th>
										<th width="">同比增长率</th>
									</tr>
								</thead>
								<c:forEach items="${osList}" var="results" varStatus="status">
									<tbody>
										<tr>
											<td>${status.index+1 }</td>
											<td>${results.beginTime }</td>
											<td>${results.endTime }</td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.income }" /></td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.cost }" /></td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.grossProfit }" /></td>
											<td><fmt:formatNumber type="percent" pattern="#0.00%" value="${results.grossProfitRate }" /></td>
											<c:if test="${results.riseIndex!='/' }">
												<td><fmt:formatNumber type="percent" pattern="#0.00%" value="${results.riseIndex }" /></td>
											</c:if>
											<c:if test="${results.riseIndex=='/' }">
												<td>${results.riseIndex }</td>
											</c:if>
										</tr>
									</tbody>
								</c:forEach>
							</c:if>
						</table>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
				var html = '<option value="" selected="selected">全部分公司</option>';
				<c:forEach items="${listName}" var="result">
					html+='<option value="${result}" >${result}分公司</option>';
				</c:forEach>
				$("#groupName").html(html);
		</script>
		<c:if test="${not empty osList}">
			<script type="text/javascript">
				var incomeSum = 0;
				var costSum = 0;
				var grossProfitSum = 0;
				<c:forEach items="${osList}" var="result" varStatus="status">
					incomeSum += '${result.income}'*1;
					costSum += '${result.cost}'*1;
					grossProfitSum += '${result.grossProfit}'*1;
				</c:forEach>
				$("#incomesum").html("￥"+incomeSum.toFixed(2));
				$("#costsum").html("￥"+costSum.toFixed(2));
				$("#grossProfitsum").html("￥"+grossProfitSum.toFixed(2));
			</script>
		</c:if>
	</body>
</html>