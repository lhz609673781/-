<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>分公司环比查询</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<link rel="stylesheet" href="${staticPath}css/Gross_margin_comparison.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery-1.11.1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/sheet/companyAround.js" ></script>
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
						<p>当前位置：<span>运营部报表</span>><i>分公司环比查询</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>分公司环比查询</h2>
						<div class="collect-form depart">
							<form id="serachAround" method="post">
						      	<label class="sel">
										<em>&nbsp;&nbsp;&nbsp;年份：</em>
										<select id="year" name="yearParam" onchange="sedyear();">
										</select>
								</label>
								<label class="sel">
										<em>&nbsp;&nbsp;&nbsp;季度：</em>
										<select id="quarter" name="quarterParam" onchange="sedquarter();">
											<option value="-1">全部</option>
											<option value="1">第一季度</option>
											<option value="2">第二季度</option>
											<option value="3">第三季度</option>
											<option value="4">第四季度</option>
										</select>
								</label>
								<label class="sel">
										<em>&nbsp;&nbsp;&nbsp;月份：</em>
										<select id="month" name="monthParam" onchange="sedmonth();">
											<option value="-1">全部</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
								</label>
								<label class="sel">
										<em>&nbsp;&nbsp;&nbsp;周：</em>
										<select id="week" name="weekParam" onchange="sedweek();">
											<option value="-1">全部</option>
											<option value="1">第一周</option>
											<option value="2">第二周</option>
											<option value="3">第三周</option>
											<option value="4">第四周</option>
										</select>
								</label>
								<label class="sel">
										<em>&nbsp;&nbsp;&nbsp;日：</em>
										<select id="day" name="dayParam" onchange="sedWeekByDays();">
										</select>
								</label>
								<label class="sel">
								   <em>&nbsp;&nbsp;&nbsp;分公司：</em>
						           <select name="groupName" id="groupName">
					                </select>
					            </label>
								<div class="btn">
									<input type="button" value="确定" class="btn-yes" onclick="seracharound();"/>
								</div>
								<div class="btn-dao" onclick="aroundExport();">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table id="companyAround">
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
										<th width="">发运日期</th>
										<th width="">实体收入合计（元）</th>
										<th width="">实体成本合计（元）</th>
										<th width="">实体毛利合计（元）</th>
										<th width="">实体毛利率</th>
										<th width="">环比增长率</th>
									</tr>
								</thead>
									<c:forEach items="${osList}" var="results" varStatus="status">
										<tbody>
											<tr>
												<td>${status.index+1 }</td>
												<td>${results.date }</td>
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
				var year = parseInt("${year}");
				var month = parseInt("${month}");
				var day = parseInt("${day}");
				addYearselect();//加载年份
				var days = getDay(year,month);
				$("#month").val(month);//选中当前月
				sedmonth();//加载季度
				addDayselectByDay(days);//加载天数
				$("#day").val(day);
				sedWeekByDays();//根据当前天选中周
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