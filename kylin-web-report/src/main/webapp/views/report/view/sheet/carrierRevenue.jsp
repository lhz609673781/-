<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=devvice-width,initial=scale-1"/>
		<title>载体营业收入表</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery.min1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/main.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
		<script type="text/javascript" src="${staticPath}js/sheet/carrierRevenue.js"></script>
		<!--[if lt IE 9]>
	      <script src="js/respond.min.js"></script>
	    <![endif]-->
	    <script type="text/javascript">
		      var basePath = "${basePath}";
		      var pageTotalRecords = false;
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
						<p>当前位置：<span>财务部报表查询</span>&gt;<i>载体营业收入报表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>载体营业收入报表</h2>
						<div class="collect-form depart">
							<form action="">
								<label id="label-img">
									发运日期：<input type="text" id="beginTime" readonly="readonly" class="collect-input" style="width: 130px;" value="${lsOci[0].beginTime }" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
										}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<label id="label-img">
       &nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;<input type="text" id="endTime" readonly="readonly" class="collect-input" style="width: 130px;" value="${lsOci[0].endTime }" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
											}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<span class="spanpp">
									 分公司：
								</span>
								<input name="groupName" id="groupName" type="text"/>
								<div class="btn" id="searchBut">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao" id="importBut">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table class="teb" id="carrReveTable">
							<c:if test="${empty lsOci}">
							  		<tr>
										<td colspan="5">没有查询到匹配的数据..</td>
									</tr>
						  	</c:if>
						  	<c:if test="${not empty lsOci}">
						  			<script type="text/javascript">
		      							pageTotalRecords = true;
									</script>
						  			<c:if test="${not empty lsOci[0].incomeSum}">
							  			<caption id="captionMon">
							  				<span>
							  					当前筛选条件下：综合收入合计<b id="actualPayMoneySum">￥<fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${lsOci[0].incomeSum }" /></b>元
							  				</span>
							  			</caption>
							  		</c:if>
							  		<c:if test="${empty lsOci[0].incomeSum}">
							  			<caption id="captionMon">
							  				暂无合计
							  			</caption>
							  		</c:if>
								<thead>
									<tr>
										<th>序号</th>
										<th>分公司</th>
										<th>行包收入</th>
										<th>行邮收入</th>
										<th>五定收入</th>
										<th>新干线收入</th>
										<th>集装箱收入</th>
										<th>综合收入</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${lsOci}" var="results" varStatus="status">
										<tr>
											<td>${status.index+1 }</td>                        
											<td>${results.companyName }</td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.xingbaoIncome }" /></td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.xingyouIncome }" /></td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.wudingIncome }" /></td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.xinganxianIncome }" /></td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.jizhuangxiangIncome }" /></td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.totalIncome }" /></td>
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