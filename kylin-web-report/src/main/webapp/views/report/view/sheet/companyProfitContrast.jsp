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
						       <select name="" id="terrace">
					               <option value="" selected="selected">2017</option>
					               <option value="">2016</option>
				               </select>
				               <span id="month">月份：</span>
                               <select name="" id="terrace">
					               <option value="">全部</option>
					               <option value="" selected="selected">1月</option>
					               <option value="">2月</option>
					               <option value="">3月</option>
					               <option value="">4月</option>
					               <option value="">5月</option>
					               <option value="">6月</option>
					               <option value="">7月</option>
					               <option value="">8月</option>
					               <option value="">9月</option>
					               <option value="">10月</option>
					               <option value="">11月</option>
					               <option value="">12月</option>              
				                </select>
								<span id="tong-j">
									 统计类型：
								</span>
					           <select name="" id="terrace">
					               <option value="合计">合计</option>
					               <option value="非实体" selected="selected">非实体</option>
					               <option value="平台">平台</option>
				                </select>
								<div class="btn">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table>
							<thead>
								<tr id="sheet-tr">
									<td colspan = "12" id="header-color">
						              <span><b>2017</b>年<b>04</b>月&nbsp;&nbsp;&nbsp;分公司<b>实体</b>毛利率汇总</span>
						              <span><b>2017</b>年<b>04</b>月&nbsp;&nbsp;&nbsp;分公司<b>实体</b>毛利率汇总</span>
						              <span><b>2017</b>年<b>04</b>月&nbsp;&nbsp;&nbsp;分公司<b>实体</b>毛利率汇总</span>
									</td>
								</tr>
								<tr>
									<th width="">排名</th>
									<th width="">分公司名称</th>
									<th width="">04-01</th>
									<th width="">04-02</th>
									<th width="">04-03</th>
									<th width="">04-04</th>
									<th width="">04-05</th>
									<th width="">04-06</th>
									<th width="">04-07</th>
									<th width="">04-08</th>
									<th width="">04-09</th>
									<th width="">04-10</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>重庆分公司</td>
									<td>100.00%</td>
									<td>100.00%</td>
									<td>100.00%</td>
									<td>100.00%</td>
									<td>100.00%</td>
									<td>100.00%</td>
									<td>100.00%</td>
									<td>100.00%</td>
									<td>100.00%</td>
									<td>100.00%</td>
								</tr>
							</tbody>
						</table>
			<!--分页-->
		<div id="paging">
			<p>共计：911525条 &nbsp;&nbsp;&nbsp;每页显示20条&nbsp;&nbsp;&nbsp;
			    <span id="list">
			    	<span>
			    	首页	<input type="button" value="&lt" />
                          <strong>0</strong>
                        <input type="button" value="&gt" />尾页   
			    	</span>			        
			    </span>         
			   到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;
			<button id="confim">确定</button>&nbsp;&nbsp;&nbsp;共计：9115页</p>
	    </div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
