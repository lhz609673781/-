<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>分公司毛利对比表</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<link rel="stylesheet" href="${staticPath}css/Gross_margin_comparison.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery-1.11.1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/main.js" ></script>
		<script type="text/javascript" src="${staticPath}js/sheet/grossProfitCompare.js" ></script>
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
						<p>当前位置：<span>运营部报表</span>><i>分公司毛利对比表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>分公司毛利对比表</h2>
						<div class="collect-form depart">
							<form action="">
							   <span id="year">年份：</span>
						       <select name="year" id="year_id">
					               <option value="2017" <c:if test="${year=='2017'}">selected="selected"</c:if>>2017</option>
					               <option value="2016" <c:if test="${year=='2016'}">selected="selected"</c:if>>2016</option>
				               </select>
				               <span id="month">月份：</span>
                               <select name="month" id="month_id">
					               <option value="01" <c:if test="${month=='1'}">selected="selected"</c:if>>1月</option>
					               <option value="02" <c:if test="${month=='2'}">selected="selected"</c:if>>2月</option>
					               <option value="03" <c:if test="${month=='3'}">selected="selected"</c:if>>3月</option>
					               <option value="04" <c:if test="${month=='4'}">selected="selected"</c:if>>4月</option>
					               <option value="05" <c:if test="${month=='5'}">selected="selected"</c:if>>5月</option>
					               <option value="06" <c:if test="${month=='6'}">selected="selected"</c:if>>6月</option>
					               <option value="07" <c:if test="${month=='7'}">selected="selected"</c:if>>7月</option>
					               <option value="08" <c:if test="${month=='8'}">selected="selected"</c:if>>8月</option>
					               <option value="09" <c:if test="${month=='9'}">selected="selected"</c:if>>9月</option>
					               <option value="10" <c:if test="${month=='10'}">selected="selected"</c:if>>10月</option>
					               <option value="11" <c:if test="${month=='11'}">selected="selected"</c:if>>11月</option>
					               <option value="12" <c:if test="${month=='12'}">selected="selected"</c:if>>12月</option>              
				                </select>
								<span id="tong-j">
									 统计类型：
								</span>
					           <select name="platform" id="platform_id">
					               <option value="all">合计</option>
					               <option value="shiti">实体</option>
					               <option value="pingtai">平台</option>
				                </select>
								<div class="btn" onclick="searchGrossProfitCompare()">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao" onclick="exportGrossProfitCompare();">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
					  	<div id="month_part_1">
						<table id="show_content">
							<thead>
								<tr>
									<th width="10%">序号</th>
									<th width="10%">分公司名称</th>
									<c:forEach begin="1" end="10" var="day">
										<th id="day_${day}" width="10%">${fn:substring(list[0].date,5,7)}-${day<10?"0":""}${day}</th>
									</c:forEach>		
								</tr>	
							</thead>
							<tbody>
								<c:forEach var="monthRate" items="${list}" varStatus="m">
								<tr>	
									<td width="10%">${m.index+1}</td>
									<td width="10%">${monthRate.groupName}分公司</td>
									<c:forEach var="dayRate" items="${monthRate.grossProfitRateList}" varStatus="d">
										<c:if test="${d.index<10}">
												<td class="cnt_${d.index+1}" width="10%">
												<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${dayRate*100}"/>%</td>
										</c:if>	
									</c:forEach>
								</tr>			
								</c:forEach>
							
							</tbody>
						</table>
						</div>
						
						<div id="month_part_2" style="display:none;">
						<table id="show_content">
							<thead>
								<tr>
									<th width="10%">序号</th>
									<th width="10%">分公司名称</th>
									<c:forEach begin="11" end="20" var="day">
										<th id="day_${day}" width="10%">${fn:substring(list[0].date,5,7)}-${day<10?"0":""}${day}</th>
									</c:forEach>		
								</tr>	
							</thead>
							<tbody>
								<c:forEach var="monthRate" items="${list}" varStatus="m">
								<tr>	
									<td width="10%">${m.index+1}</td>
									<td width="10%">${monthRate.groupName}分公司</td>
									<c:forEach var="dayRate" items="${monthRate.grossProfitRateList}" varStatus="d">
										<c:if test="${d.index>=10 && d.index<20}">
												<td class="cnt_${d.index+1}" width="10%">
												<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${dayRate*100}"/>%
												</td>
										</c:if>	
									</c:forEach>
								</tr>			
								</c:forEach>
							
							</tbody>
						</table>
						</div>
						
						
						
						<div id="month_part_3" style="display:none;">
						<table id="show_content">
							<thead>
								<tr>
									<th width="10%">排名</th>
									<th width="10%">分公司名称</th>
									<c:forEach begin="21" end="${fn:length(list[0].grossProfitRateList)}" var="day">
										<th id="day_${day}" width="10%">${fn:substring(list[0].date,5,7)}-${day<10?"0":""}${day}</th>
									</c:forEach>		
								</tr>	
							</thead>
							<tbody>
								<c:forEach var="monthRate" items="${list}" varStatus="m">
								<tr>	
									<td width="10%">${m.index+1}</td>
									<td width="10%">${monthRate.groupName}分公司</td>
									<c:forEach var="dayRate" items="${monthRate.grossProfitRateList}" varStatus="d">
										<c:if test="${d.index>=20}">
												<td class="cnt_${d.index+1}" width="10%">
												<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${dayRate*100}"/>%
												</td>
										</c:if>	
									</c:forEach>
								</tr>			
								</c:forEach>
							
							</tbody>
						</table>
						</div>
			<!--分页-->
		<div id="paging">
			<p>共计：${fn:length(list)}条 &nbsp;&nbsp;&nbsp;
			    <span id="list">
			    	<span>
			 	<a onclick="gotoPage(1);" class="pointer">首页</a>
					<input class="pointer" type="button" value="&lt" onclick="prevPage()"/>
					    <strong>当前页为：<span id="currPageNo">1</span></strong>
					     <input class="pointer" type="button" value="&gt" onclick="nextPage();" />
					       <a class="pointer" onclick="gotoPage(3)">末页</a>   
				</span>						   		       	        
			    </span>         
			   到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;
			<button id="confim" onclick="gotoWhichPage();">确定</button>&nbsp;&nbsp;&nbsp;共计：3页</p>
	    </div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
