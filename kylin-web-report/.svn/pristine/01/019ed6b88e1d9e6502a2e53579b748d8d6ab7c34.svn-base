<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@page import="com.ycgwl.kylin.web.report.utils.DateUtils"  %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>付款单查询</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery.min1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/main.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
		<script type="text/javascript" src="${staticPath}js/sheet/payment.js?t=1"></script>
		<!--[if lt IE 9]>
	      <script src="js/respond.min.js"></script>
	    <![endif]-->
	    <script type="text/javascript">
		      var basePath = "${basePath}";
		      var pageTotalRecords = 0;
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
						<p>当前位置：<span>财务部报表查询</span>&gt;<i>付款单查询</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>付款单查询</h2>
						<div class="collect-form depart">
							<form action="">
								<label id="label-img">
									发运日期：<input type="text" id="beginTime" class="collect-input" style="width: 130px;" readonly="readonly" value="<%=DateUtils.firstDateOfTerdayMonth()%>" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
										}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<label id="label-img">
       &nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;<input type="text" id="endTime" class="collect-input" style="width: 130px;" readonly="readonly" value="<%=DateUtils.yesterday()%>" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
											}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<div class="btn" onclick="searPay(1);">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao" onclick="exportPay();">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table class="teb" id="payTable">
							<c:if test="${empty page.list}">
							  		<tr>
										<td colspan="5">没有查询到匹配的数据..</td>
									</tr>
						  	</c:if>
						  	<c:if test="${not empty page.list}">
						  			<c:if test="${not empty page.list[0].actualPayMoneySum}">
							  			<caption id="captionMon">
							  				<span>
							  					当前筛选条件下：实付金额合计<b id="actualPayMoneySum">￥<fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${page.list[0].actualPayMoneySum }" /></b>元
							  				</span>
							  			</caption>
							  		</c:if>
							  		<c:if test="${empty page.list[0].actualPayMoneySum}">
							  			<caption id="captionMon">
							  				暂无合计
							  			</caption>
							  		</c:if>
								<thead>
									<tr>
										<th width="10%">序号</th>
										<th width="15%">录入公司</th>
										<th width="45%">摘要</th>
										<th width="15%">实付金额（元）</th>
										<th width="15%">提交时间</th>
									</tr>	
								</thead>
								<tbody>
									<c:forEach items="${page.list}" var="results" varStatus="status">
										<tr>
											<td>${status.index+1 }</td>                        
											<td>${results.groupName }</td>
											<td><div style="width:86%;margin-left:7%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${results.description }">${results.description }</div></td>
											<td><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.actualPayMoney }" /></td>
											<td>${results.submitTime }</td>
										</tr>
									</c:forEach>
								</tbody>
							</c:if>
						</table>
						<!--分页-->
							<div id="paging">
								<c:if test="${not empty page.list}">
									<p>共计：${page.totalRecords }条 &nbsp;&nbsp;&nbsp;每页显示
									<select name="" id="kuang" class="kuang" onchange="searPay(${page.pageNo })">
										<option value="10">10</option>
										<option value="20">20</option>
										<option value="30">30</option>
									</select>条&nbsp;&nbsp;&nbsp;
									    <span id="list">
									    	<span>
										    	<a onclick="searPay(1);" class="pointer">首页</a>
										    	<input class="pointer" type="button" value="&lt" onclick="searPay(${page.previousPageNo });"/>
							                    <strong>当前页为：${page.pageNo }</strong>
							                    <input class="pointer" type="button" value="&gt" onclick="searPay(${page.nextPageNo });" />
							                    <a class="pointer" onclick="searPay(${page.totalPages })">末页</a>   
									    	</span>			        
									    </span>         
									   到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;
									<button id="confim" onclick="searPay(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：${page.totalPages }页</p>
								<script type="text/javascript">
									pageTotalRecords = ${page.totalRecords };
									var initPageSize = ${page.pageSize };
									$("#kuang").val(initPageSize);
								</script>
								</c:if>
						    </div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>