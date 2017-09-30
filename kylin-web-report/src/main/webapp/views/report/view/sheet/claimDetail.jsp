<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@page import="com.ycgwl.kylin.web.report.utils.DateUtils"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>理赔占比明细表</title>
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
<script type="text/javascript" src="${staticPath}js/sheet/claimDetail.js"></script>
<!--[if lt IE 9]>
	      <script src="js/respond.min.js"></script>
	    <![endif]-->
<script type="text/javascript">
	var pageTotalRecords = 0;
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
						<p>当前位置：<span>运营部报表查询</span>&gt;<i>理赔占比明细表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>理赔占比明细表</h2>
						<div class="collect-form depart">
							<form action="">
								<label id="label-img">
									受理日期：<input id="beginTime_id" name="beginTime" readonly="readonly" type="text" class="collect-input" style="width: 130px;" value="${beginTime }" onfocus="if(value =='点击添入内容')
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
								<label class="sel">
					            	<em>&nbsp;&nbsp;&nbsp;分公司：</em>
					            	<select name="groupName" id="groupName">
				                	</select>
				                </label>
								<div class="btn">
									客户名称：<input name="customerName" id="customerName" class="kuang-yes" type="text" />
								</div>
								<div class="btn" onclick="searchClaimDetail();">
									<input type="button" value="确定" class="btn-yes" />
								</div>
								<div class="btn-dao" onclick="exportClaimDetail();">
									<input type="button" value="导出" id="import-one" />
								</div>
							</form>
						</div>
					  <!--表格-->
					  <table id="show_content">
							<c:if test="${empty statisPage.list}">
						  		<tr>
									<td  colspan="7">没有查询到匹配的数据..</td>
								</tr>
					  		</c:if>
					  		<c:if test="${not empty statisPage.list}">
					  		<caption id="captionMon"><span>当前筛选条件下：赔付金额合计<b>${statisPage.list[0].payAmountSum}</b>元</span></caption>
								<thead>
								<tr>
									<th width="10%">序号</th>
									<th width="10%">分公司</th>
									<th width="10%">赔付金额</th>
									<th width="10%">运输收入合计</th>
									<th width="10%">理赔占比</th>
								</tr>
								</thead>
								<c:forEach items="${statisPage.list}" var="obj" varStatus="status">
									<tbody>
										<tr>
											<td width="10%">${status.index+1 }</td>
											<td width="10%">${obj.companyName }分公司</td>
											<td width="10%">${obj.payAmount }</td>
											<td width="10%">${obj.businIncome}</td>
											<td width="10%">${obj.claimRate}%</td>
										</tr>
									</tbody>
								</c:forEach>
							</c:if>
						</table>
		         		<!--分页-->
		         		<div id="paging">
						<c:if test="${not empty statisPage.list}">
								<p>共计：${statisPage.totalRecords }条 &nbsp;&nbsp;&nbsp;每页显示
								<select name="" id="kuang" class="kuang" onchange="searchClaimDetail(${statisPage.pageNo })">
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="30">30</option>
								</select>条&nbsp;&nbsp;&nbsp;
								    <span id="list">
								    	<span>
									    	<a onclick="searchClaimDetail(1);" class="pointer">首页</a>
									    	<input class="pointer" type="button" value="&lt" onclick="searchClaimDetail(${statisPage.previousPageNo });"/>
						                    <strong>当前页为：${statisPage.pageNo }</strong>
						                    <input class="pointer" type="button" value="&gt" onclick="searchClaimDetail(${statisPage.nextPageNo });" />
						                    <a class="pointer" onclick="searchClaimDetail(${statisPage.totalPages })">末页</a>   
								    	</span>			        
								    </span>         
								   到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;
								<button id="confim" onclick="searchClaimDetail(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：${statisPage.totalPages }页</p>
							<script type="text/javascript">
								pageTotalRecords = ${statisPage.totalRecords };
								var initPageSize = ${statisPage.pageSize };
								$("#kuang").val(initPageSize);
							</script>
						</c:if> 
						 </div>
			</div>
		</div>
	</div>
</div>
		<script type="text/javascript">
				var html = '<option value="1" selected="selected">全部分公司</option>';
				<c:forEach items="${listName}" var="result">
					html+='<option value="${result}" >${result}分公司</option>';
				</c:forEach>
				$("#groupName").html(html);
		</script>
</body>
</html>