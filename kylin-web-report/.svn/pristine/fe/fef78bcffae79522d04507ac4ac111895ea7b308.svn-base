<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@page import="com.ycgwl.kylin.web.report.utils.DateUtils"  %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width,initial=scale-1"/>
		<title>返单统计表</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery.min1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/main.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/sheet/returnasingle.js" ></script>
		<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
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
						<p>当前位置：<span>运营部报表查询</span>&gt;<i>返单统计表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>返单统计表</h2>
						<div class="collect-form depart" style="margin-bottom:50px;">
							<form action="">
						 <span class="parti"> 年份：</span><select id="beginYear" name="beginYear" class="cular">
					                   <option value="2017">2017</option>
					                   <option value="2016">2016</option>					   
				                   </select>
						 <span class="parti"> 月份：</span><select id="beginMonth" name="beginMonth" class="cular">
					                <option value="1">1月</option>
					                <option value="2">2月</option>
					                <option value="3">3月</option>
					                <option value="4">4月</option>
					                <option value="5">5月</option>
					                <option value="6">6月</option>
					                <option value="7">7月</option>
					                <option value="8">8月</option>
					                <option value="9">9月</option>
					                <option value="10">10月</option>
					                <option value="11">11月</option>
					                <option value="12">12月</option>
				              </select><span class="parti"> 至</span>
		                 <span class="parti"> 年份：</span><select id="endYear" name="endYear" class="cular">
					               <option value="2017" selected="selected">2017</option>
					               <option value="2016">2016</option>					   
				              </select>
					     <span class="parti"> 月份：</span><select id="endMonth" name="endMonth" class="cular">
					                <option value="1" selected="selected">1月</option>
					                <option value="2">2月</option>
					                <option value="3">3月</option>
					                <option value="4">4月</option>
					                <option value="5">5月</option>
					                <option value="6">6月</option>
					                <option value="7">7月</option>
					                <option value="8">8月</option>
					                <option value="9">9月</option>
					                <option value="10">10月</option>
					                <option value="11">11月</option>
					                <option value="12">12月</option>
				            </select>
								<div class="btn" id="searchBut">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao" id="importBut">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table class="teb" id="returnasingleTab">
							<c:if test="${empty orList}">
							  		<tr>
										<td>没有查询到匹配的数据..</td>
									</tr>
						  	</c:if>
						  	<c:if test="${not empty orList}">
						  		<script type="text/javascript">
		      							pageTotalRecords = true;
								</script>
								<thead>
									<tr>
										<th>序号</th>
										<th>分公司</th>
										<c:forEach items="${orList[0].list}" var="result">
											<th>${result.keyName }</th>
										</c:forEach>
										<th>合计</th>
									</tr>
								</thead>
								<tbody>	
									<c:forEach items="${orList}" var="results" varStatus="status">							
										<tr>
											<td>${status.index+1 }</td>                        
											<td>${results.companyName }分公司</td>
											<c:forEach items="${results.list}" var="rs">
												<td>${rs.objValue }</td>
											</c:forEach>
											<td>${results.totalSum }</td>
										</tr>
									</c:forEach>
								</tbody>
								<script type="text/javascript">
		      						var pageTotalRecords = true;
								</script>
						  	</c:if>
						</table>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			var year = "${year}";
			var month = "${month}";
			$("#beginYear").val(year);
			$("#beginMonth").val(1);
			$("#endYear").val(year);
			$("#endMonth").val(month);
		</script>
	</body>
</html>