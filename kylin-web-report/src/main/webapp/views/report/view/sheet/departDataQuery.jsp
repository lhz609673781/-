<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>事业部营业报表</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${staticPath}css/reset.css" />
<link rel="stylesheet" href="${staticPath}css/layout.css" />
<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
<script type="text/javascript">
	var basePath = "${basePath}";
</script>
<script type="text/javascript" src="${staticPath}js/jquery-1.11.1.js" ></script>
<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
<script src="${staticPath}js/sheet/findBUData.js" type="text/javascript"></script>
<!--[if lt IE 9]>
	      <script src="${staticPath}js/sheet/respond.min.js"></script>
<![endif]-->
</head>
	<body>
		<div class="wrap">
			<div id="navigation">
				<h1>远成物流</h1>
			    <jsp:include page="../menu/nav.jsp"/>
			</div>
			<div id="content">
				<div class="con-title">
					<div class="fl">
						<p>当前位置：<span>报表管理</span>><i>事业部营业数据查询</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-news">
						<h2>物流集团销售业绩快讯</h2>
						<c:if test="${empty annualAlerts || empty topList}">
							<table style="text-align: center;">
								<tr style="height: 30px;">
									<td>暂无快讯信息..</td>
								</tr>
							</table>
						</c:if>
						<c:if test="${not empty annualAlerts}">
							<ul class="clearfix">
								<li><span class="data"><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${annualAlerts.yearIndex }" /></span>年度指标</li>
								<li><span class="data"><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${annualAlerts.haveSales }" /></span>已销售</li>
								<li><span class="data"><fmt:formatNumber type="percent" pattern="#0%" value="${annualAlerts.yearCompletion }" /></span>年度完成率</li>
								<li><span class="data"><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${annualAlerts.monthSales }" /></span><i id="monthmarket"></i></li>
								<li><span class="data"><fmt:formatNumber type="percent" pattern="#0%" value="${annualAlerts.monthCompletion }" /></span><i id="monthmarketcom"></i></li>
								<li><span class="data"><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${annualAlerts.weekSales }" /></span><i id="weekmarket"></i></li>
								<li><span class="data"><fmt:formatNumber type="percent" pattern="#0%" value="${annualAlerts.weekCompletion }" /></span><i id="weekmarketcom"></i></li>
								<li><span class="data"><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${annualAlerts.daySales }" /></span><i id="daymarket"></i></li>
								<li><span class="data"><fmt:formatNumber type="percent" pattern="#0%" value="${annualAlerts.dayCompletion }" /></span><i id="daymarketcom"></i></li>
							</ul>
							<h3>物流集团<i id="monthindex"></i>月收入指标<i><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${annualAlerts.monthIndex }" /></i><span id="enddate1"></span><i><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${annualAlerts.monthSales }" /></i>，完成率<i><fmt:formatNumber type="percent" pattern="#0%" value="${annualAlerts.monthCompletion }" /></i></h3>
						</c:if>
						<div class="clearfix">
							<c:if test="${not empty topList}">
								<table class="tab">
									<tbody>
										<c:forEach items="${topList.bralist1}" var="results" varStatus="status">
											<tr>
												<td><i class="suc-icon"></i>${results.branchName }：<span class="bramonth"></span>月收入指标<fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${results.monthIndicators }" />，实际完成<fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${results.sales }" />，完成率<fmt:formatNumber type="percent" pattern="#0%" value="${results.monthCompletion }" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<table class="tab tab-reverse">
									<tbody>
										<c:forEach items="${topList.bralist2}" var="results" varStatus="status">
											<tr>
												<td><i class="lose-icon">${status.index+1 }</i>${results.branchName }：<span class="bramonth"></span>月收入指标<fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${results.monthIndicators }" />，实际完成<fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${results.sales }" />，完成率<fmt:formatNumber type="percent" pattern="#0%" value="${results.monthCompletion }" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
						<p><span id="enddate2"></span>各分公司完成情况Top5（单位：万元）</p>
					</div>
					<div class="part part-collect">
						<h2>事业部销售业绩汇总</h2>
						<div class="collect-form">
							<form action="">
								<label class="sel">
										<em>年份：</em>
										<select id="year" name="year" onchange="sedyear();">
										</select>
								</label>
								<label class="sel">
										<em>月份：</em>
										<select id="month" name="month" onchange="sedmonth();">
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
										<select id="week" name="week" onchange="sedweek();">
											<option value="-1">全部</option>
											<option value="1">第一周</option>
											<option value="2">第二周</option>
											<option value="3">第三周</option>
											<option value="4">第四周</option>
										</select>
								</label>
								<label class="sel">
										<em>&nbsp;&nbsp;&nbsp;日：</em>
										<select id="day" name="day" onchange="sedWeekByDays();">
										</select>
								</label>
								<div class="btn">
									<input type="button" value="确定" onclick="searchajaxcp();"/>
									<input type="button" class="export" value="导出" onclick="downLoad()" style="display: none;"/>
								</div>
							</form>
						</div>
						<div id="company-info">
							<table>
								<c:if test="${ empty resultsSummaryls }">
										<tr>
											<td  colspan="7">销售业绩加载失败..</td>
										</tr>
								</c:if>
								<c:if test="${not empty resultsSummaryls }">
									<caption>
										<span id="seadate"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="seaindex"></span>
									</caption>
									<thead>
										<tr>
											<th width="5%">排名</th>
											<th width="18%">事业部名称</th>
											<th width="13%"><span class="rstitle"></span>销售指标</th>
											<th width="13%"><span class="rstitle"></span>销售额</th>
											<th width="13%"><span class="rstitle"></span>差额</th>
											<th width="13%"><span class="rstitle"></span>完成率</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${resultsSummaryls}" var="results" varStatus="status">
											<tr>
												<td>${status.index+1 }</td>
												<td>${results.divisionName }</td>
												<td><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${results.salesIndicators }" /></td>
												<td><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${results.sales}" /></td>
												<td><fmt:formatNumber type="number" maxFractionDigits="0" minFractionDigits="0" value="${results.difference}" /></td>
												<td><fmt:formatNumber type="percent" pattern="#0%" value="${results.completion }" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</c:if>
							</table>
						</div>
						<c:if test="${not empty annualAlerts }">
							<script type="text/javascript">
								var str = "${annualAlerts.currentdata }";
								var newDate = new Date(str.replace(/-/g,"/"));
								var fyear = newDate.getFullYear();
								var fmonth = newDate.getMonth()+1;
								var fday = newDate.getDate();
								var fhours = newDate.getHours();
								var fmill = newDate.getMinutes() < 10 ? "0" + newDate.getMinutes() : newDate.getMinutes();
								var fweek = getWeekByDay(fday);
								addYearselect();//加载年份
								if (str == "" || str == null || str == undefined) {
									fyear = year;
									fmonth = month;
									fday = day;
								}
								var days = getDay(fyear,fmonth);
								$("#month").val(fmonth);//选中当前月
								addDayselectByDay(days);//加载天数
								$("#day").val(fday);
								sedWeekByDays();//根据当前天选中周
								$("#ptitle").html("截止"+fyear+"年"+fmonth+"月"+fday+"号24点00分");
								$("#monthmarket").html(""+fmonth+"月销售");
								$("#monthmarketcom").html(""+fmonth+"月完成率");
								$("#weekmarket").html("第"+fweek+"周销售");
								$("#weekmarketcom").html("第"+fweek+"周完成率");
								$("#daymarket").html(""+fday+"日销售");
								$("#daymarketcom").html(""+fday+"日完成率");
								$("#monthindex").html(""+fmonth+"");
								$("#enddate1").html("，截止"+fmonth+"月"+fday+"号24点00分已完成");
								$("#enddate2").html("截止"+fmonth+"月"+fday+"号");
								$("#seadate").html(""+fyear+"年"+fmonth+"月"+fday+"日-"+fyear+"年"+fmonth+"月"+fday+"日");
								$(".bramonth").html(fmonth);
								$(".rstitle").html(""+fday+"日");
								var sumsalesIndicators = 0;
								var sumdifference = 0;
								var sumcompletion = 0;
								var j = 0;
								<c:forEach items="${resultsSummaryls}" var="result" varStatus="status">
									sumsalesIndicators += '${result.salesIndicators}'*1;
									sumdifference += '${result.difference}'*1;
									sumcompletion += '${result.completion}'*1;
									j++;
								</c:forEach>
								$("#seaindex").html("销售业绩汇总：销售指标共计"+sumsalesIndicators.toFixed(1)+"，共计差额"+sumdifference.toFixed(1)+"，共计完成"+(sumcompletion*100/j).toFixed(1)+"%");
							</script>
						</c:if>
						<c:if test="${empty annualAlerts }">
							<script type="text/javascript">
								addYearselect();//加载年份
								var days = getDay(year,month);
								$("#month").val(month);//选中当前月
								addDayselectByDay(days);//加载天数
								$("#day").val(day);
								sedWeekByDays();//根据当前天选中周
							</script>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>