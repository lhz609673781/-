<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>销售指标管理</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/eject.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/findCompanData.css">
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery-1.11.1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/sheet/revenueData.js" ></script> 
		<!--[if lt IE 9]>
	      <script src="${staticPath}js/sheet/respond.min.js"></script>
	    <![endif]-->
		<script type="text/javascript">
		      var basePath = "${basePath}";
		</script>
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
						<p>当前位置：<span>营业数据管理</span>><i>销售指标管理</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>销售指标管理</h2>
						<div class="collect-form sale-target">
								<div class="btn mar-left">
									<input type="button" class="import" value="导入销售指标" id="import-one" />
								</div>
								<label class="sel">
										<em>年份:</em>
										<select name="year" id="year">
											<option value="2017" selected="selected">2017</option>
											<option value="2016">2016</option>
										</select>
								</label>
								<div class="btn">
									<input type="button" value="确定" onclick="search()" />
								</div>
						</div>
						<table id="turnoverList">
							<c:if test="${not empty turnoverList}">
								<caption><span id="titleYear"></span>年销售指标汇总</caption>
								<thead>
									<tr>
										<th width="4%">序号</th>
										<th width="9%">分公司/事业部名称</th>
										<th width="8%">年度指标(万元)</th>
										<th width="6%">1月指标</th>
										<th width="6%">2月指标</th>
										<th width="6%">3月指标</th>
										<th width="6%">4月指标</th>
										<th width="6%">5月指标</th>
										<th width="6%">6月指标</th>
										<th width="6%">7月指标</th>
										<th width="6%">8月指标</th>
										<th width="6%">9月指标</th>
										<th width="6%">10月指标</th>
										<th width="6%">11月指标</th>
										<th width="6%">12月指标</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="turnover" items="${turnoverList}" varStatus="status">
										<tr>
											<td>${status.index+1}</td>
											<td>${turnover.name}</td>
											<td>${turnover.totalIndex}</td>
											<td>${turnover.oneMonthIndex}</td>
											<td>${turnover.twoMonthIndex}</td>
											<td>${turnover.threeMonthIndex}</td>
											<td>${turnover.fourMonthIndex}</td>
											<td>${turnover.fiveMonthIndex}</td>
											<td>${turnover.sixMonthIndex}</td>
											<td>${turnover.sevenMonthIndex}</td>
											<td>${turnover.eightMonthIndex}</td>
											<td>${turnover.nineMonthIndex}</td>
											<td>${turnover.tenMonthIndex}</td>
											<td>${turnover.elevenMonthIndex}</td>
											<td>${turnover.twelveMonthIndex}</td>									
										</tr>
									</c:forEach>
								</tbody>
							</c:if>
							<c:if test="${empty turnoverList}">
								<c:if test="${not empty mas}">
									<tr><td>${mas}</td></tr>
								</c:if>
							</c:if>
						</table>
					</div>
				</div>
			</div>
			<div id="base3">
			    <div id="pop-small">
			    	<p id="title-s">导入销售指标</p>
			    	<div id="radius-s" class="pointer">
			    		<b>&times;</b>
			    	</div>
			    	<ul id="small-content">
			    		<li id="bottom-s">
			    			<input type="button" id="button-s" onclick="leading();" value="确认" />
			    		</li>
			    		<li id="look-s">
			    			<form id="model-lo" action="${basePath}divisionManage/model.do?type=2" method="post"></form>
			    			<b">请先下载模板：<span id="blue-s" onclick="downmodel();" class="pointer">销售指标导入模板.excel</span>&nbsp;填写内容后进行上传</b>
			    		</li> <br />
			    		<li>
			    			<b id="upload">上传文件：</b> 
			    			<br />
			    				<input type="file" id="text-b" type="" value="" placeholder="济南邮区中心"/>
			    				<!--<b id="liu-b">浏览</b></p> -->
			    				<!--<input type="text" name="" id="pic" value="浏览" />-->
    					</li>
			    	</ul>
			    </div>
			</div>
		</div>
	</body>
</html>