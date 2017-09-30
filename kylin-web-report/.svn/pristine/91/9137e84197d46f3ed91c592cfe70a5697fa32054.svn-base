<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>重点项目监控</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<link rel="stylesheet" type="text/css" href="${staticPath}css/Monitor_table.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery.min1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
		<script type="text/javascript" src="${staticPath}js/main.js" ></script>
		<script type="text/javascript" src="${staticPath}js/sheet/monitorMajor.js" ></script>
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
						<p>当前位置：<span>业务报表查询</span>><i>重点项目监控表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>重点项目监控表</h2>
						<div class="collect-form depart">
							<form action="">
								<label id="label-img">
									发运日期：<input id="beginTime" name="beginTime" readonly="readonly" type="text" class="collect-input" style="width: 130px;" value="${page.list[0].beginTime }" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
										}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<label id="label-img">
       &nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;<input id="endTime" name="endTime" readonly="readonly" type="text" class="collect-input" style="width: 130px;" value="${page.list[0].endTime }" onfocus="if(value =='点击添入内容')
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
					           <select name="platformType" id="platformType">
					               <option value="all">合计</option>
					               <option value="shiti" selected="selected">实体</option>
					               <option value="pingtai">平台</option>
				                </select>
				                <span class="greater">
				                	<span class="montypesear">实体</span>收入大于：
				                </span>
				                <input type="text" id="incomeSum" name="incomeSum" value=""/>
				                <span class="greater">
				                	<span class="montypesear">实体</span>毛利率小于：
				                </span>
				                <input type="text" id="grossProfitRate" name="grossProfitRate" value=""/><span>%</span>
								<div class="btn" onclick="searchMon(1);">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao" onclick="monitorExport();">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table id="monTable">
							<c:if test="${empty page.list}">
						  		<tr>
									<td colspan="8">没有查询到匹配的数据..</td>
								</tr>
					  		</c:if>
					  		<c:if test="${not empty page.list}">
					  			<c:if test="${not empty page.list[0].incomeTotal && not empty page.list[0].costTotal && not empty page.list[0].grossProfitTotal}">
						  			<caption id="captionMon">
						  				<span>
						  					当前筛选条件下：<span class="montype">实体</span>收入总合计<b id="incomesum">￥<fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${page.list[0].incomeTotal }" /></b>元，
						  					<span class="montype">实体</span>成本总合计<b id="costsum">￥<fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${page.list[0].costTotal }" /></b>元，
						  					<span class="montype">实体</span>毛利总合计<b id="grossProfitsum">￥<fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${page.list[0].grossProfitTotal }" /></b>元
						  				</span>
						  			</caption>
						  		</c:if>
						  		<c:if test="${empty page.list[0].incomeTotal || empty page.list[0].costTotal || empty page.list[0].grossProfitTotal}">
						  			<caption id="captionMon">
						  				暂无合计
						  			</caption>
						  		</c:if>
								<thead>
									<tr>
										<th width="10%">序号</th>
										<th width="10%">分公司名称</th>
										<th width="10%">客户编号</th>
										<th width="30%">客户名称</th>
										<th width="10%"><span class="montype1">实体</span>收入（元）</th>
										<th width="10%"><span class="montype1">实体</span>成本（元）</th>
										<th width="10%"><span class="montype1">实体</span>毛利（元）</th>
										<th width="10%"><span class="montype1">实体</span>毛利率</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${page.list}" var="results" varStatus="status">
										<tr>
											<td >${status.index+1 }</td>
											<td >${results.groupName }</td>
											<c:if test="${empty results.customerCode }">
												<td></td>
											</c:if>
											<c:if test="${not empty results.customerCode }">
												<td >${results.customerCode }</td>
											</c:if>
											<td >${results.customerName }</td>
											<td ><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.incomeSum }" /></td>
											<td ><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.costSum }" /></td>
											<td ><fmt:formatNumber type="number" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${results.grossProfit }" /></td>
											<td ><fmt:formatNumber type="percent" pattern="#0.00%" value="${results.grossProfitRate }" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</c:if>
						</table>
						<!--分页-->
						<c:if test="${not empty page.list}">
							<div id="paging">
								<p>共计：${page.totalRecords }条 &nbsp;&nbsp;&nbsp;每页显示
								<select name="" id="kuang" class="kuang" onchange="searchMon(${page.pageNo })">
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="30">30</option>
								</select>条&nbsp;&nbsp;&nbsp;
								    <span id="list">
								    	<span>
									    	<a onclick="searchMon(1);" class="pointer">首页</a>
									    	<input class="pointer" type="button" value="&lt" onclick="searchMon(${page.previousPageNo });"/>
						                    <strong>当前页为：${page.pageNo }</strong>
						                    <input class="pointer" type="button" value="&gt" onclick="searchMon(${page.nextPageNo });" />
						                    <a class="pointer" onclick="searchMon(${page.totalPages })">末页</a>   
								    	</span>			        
								    </span>         
								   到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;
								<button id="confim" onclick="searchMon(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：${page.totalPages }页</p>
						    </div>
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
	</body>
</html>