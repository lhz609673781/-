<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>分公司毛利详情</title>
	<!-- layui -->
	<link rel="stylesheet" type="text/css" href="${staticPath}layui/layui.css">
	<link rel="stylesheet" href="${staticPath}css/reset.css" />
	<link rel="stylesheet" href="${staticPath}css/layout.css" />
	<!-- Custom -->
	<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/resetfile.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/public.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/grossStatisticsDetail.css" />
	
</head>
<body>
	<!-- wrap -->
	<span id="urlpath" style='display:none'>${basePath}</span>
	<div class="wrap">
		<!-- 侧导航-->
			<div id="navigation" style='height:880px'>
				<h1>远成物流</h1>
			    <jsp:include page="../menu/nav.jsp"/>
			</div>
		<!--内容-->
		<div class="layui-tab layui-tab-brief content-margin" lay-filter="docDemoTabBrief" id='content'>
			<div class="con-title">
				<div class="fl">
					<p>当前位置：<span>财务管理</span>&gt;<i><a onClick='javascript:history.back(-1);' style="cursor:pointer;color:#888a8f;">分公司毛利统计表</a></i>&gt;<i>分公司毛利统计详情</i></p>
				</div>
				<div class="fr">
					<span class="admin"><a href=''>退出</a></span>
				</div>
			</div>
			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<div class="layui-form clearAfter">
						<form>
							<div class="layui-input-inline select-tab">
						    	<input type="checkbox" checked="" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="">
						    </div> 
							<label class="layui-form-label">查询日期</label>
							<div class="layui-input-inline date-input">
								<input class="layui-input" id="SearchDateStart" placeholder="请输入开始日期">
							</div>
							<span style="float: left; margin-right: 10px; line-height: 38px;">至</span>
							<div class="layui-input-inline date-input">
								<input class="layui-input" id="SearchDateStop" placeholder="请输入结束日期">
							</div>
							<div class="layui-inline select-company">
						      <label class="layui-form-label" style='text-align: center'>公司名称</label>
						      <div class="layui-input-inline companyName input_label" style='width: 132px;'>
						        <select name="modules" lay-verify="required" class='select-companyN' lay-search="" id="show_companyName">
						          <option value="" id='default-company'>上海</option>
						        </select>
						      </div>
						    </div> 
						    
						</form>
						<button class="layui-btn layui-btn-normal fl" id="clientSearchSearchBtn">搜索</button>
					</div>
				</div>
				<div class="data-content">
					<div class="ranking-chart">
						<!-- <p class='ranking-title'>货物吨位数︵ 万吨 ︶</p> -->
						<div id="ranking-container" style="height:350px"></div>
					</div>
					<div class="right-charts">
						<div id="ranking-right" style="width:100%; height:330px"></div>
					</div>
				</div>
				<div style='position: relative;'>
				<!-- 数据导出按钮 -->
				<button  class='layui-btn layui-btn-warm dataOut' id="importBut">数据导出</button>
				<div id='loading'>
					<img alt="" src="${staticPath}images/0.gif">
				</div>
				<table class="layui-table Table-rendering" id='table-thead'>
					<colgroup>
					    <!-- <col width="4%">
					    <col width="22%">
					    <col width="10%">
					    <col width="6%">
					    <col width="6%">
					    <col width="8%">
					    <col width="10%">
					    <col width="8%">
					    <col width="8%">
					    <col width="10%"> -->
				    </colgroup>
					<thead>
						<tr id='table-title'>
							<th>序号</th>
							<th data-type='date'>日期</th>
							<th data-type='income'>合计收入</th>
							<th data-type='cost'>合计成本</th>
							<th data-type='gross_profit'>合计毛利</th>
							<th data-type='gross_profit_rate'>合计毛利率</th>
						</tr>
					</thead>
					<tbody id="showgroupOperationList"></tbody>
				</table>
				</div>
				<div class="pageWrap" style="text-align:center;">
					<span>共计：<b class='totalNumber'></b>&nbsp;条</span>&nbsp;&nbsp;
					<span class="select-pagerow layui-laypage-total" style="display:inline-block;">每页显示&nbsp;&nbsp;&nbsp;<form id="select-form"><select name="modules" lay-verify="required" lay-search="" class="selectValue"><option value="10">10</option><option value="20">20</option><option value="30">30</option></select></form>&nbsp;&nbsp;&nbsp;条</span>
					<div id="page" style="display:inline-block;"></div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${staticPath}js/jquery.min.js"></script>
	<script type="text/javascript" src="${staticPath}js/json2.js"></script>
	<!--  <script type="text/javascript" src="${staticPath}js/system-config.js"></script>-->
	<script type="text/javascript" src="${staticPath}layui/layui.js"></script>
	<script type="text/javascript" src="${staticPath}js/public.js" ></script>
	<!-- 引入layer,element,laydate模块 -->
	<script type="text/javascript">
		var flag = true;
		initDatehandler (flag);
	</script>
	<script type="text/javascript" src="${staticPath}js/highcharts.js"></script>
	<script type="text/javascript" src="${staticPath}js/highcharts-3d.js"></script>
	<script type="text/javascript" src="https://img.hcharts.cn/highcharts/highcharts-more.js"></script>
	<script type="text/javascript" src="${staticPath}js/jsrender-min.js"></script>
	<!-- 定义客户查询模板 -->
	<script type="text/x-jsrender" id="SearchTpl">
		<tr data-uid="">
			<td>
				<span>{{: #index+1}}</span>
			</td>
			<td>
				<span>{{:date}}</span>
			</td>
			<td>
				<span>{{:income}}</span>
			</td>
			<td>
				<span>{{:cost}}</span>
			</td>
			<td>
				<span>{{:grossProfit}}</span>
			</td>
			<td>
				<span>{{:grossProfitRate}}</span>
			</td>
		</tr>
	</script>
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/grossStatisticsDetail.js" ></script>
</body>
</html>