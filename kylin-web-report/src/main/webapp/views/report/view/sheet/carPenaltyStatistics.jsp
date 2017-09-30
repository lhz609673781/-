<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>车辆罚款统计</title>
	<!-- layui -->
	<link rel="stylesheet" type="text/css" href="${staticPath}layui/layui.css">
	<link rel="stylesheet" href="${staticPath}css/reset.css" />
	<link rel="stylesheet" href="${staticPath}css/layout.css" />
	<!-- Custom -->
	<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css" />
	<link rel="stylesheet" href="${staticPath}font-awesome/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/resetfile.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/public.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/clientSeacher.css" />
	<link rel="stylesheet" href="${staticPath}css/swiper.min.css">
	<link rel="stylesheet" type="text/css" href="${staticPath}css/carPenaltyStatistics.css" />
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
					<p>当前位置：<span>车辆管理</span>&gt;<i>车辆罚款统计与概率分析</i></p>
				</div>
				<div class="fr">
					<span class="admin"><a href=''>退出</a></span>
				</div>
			</div>
			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<div class="layui-form clearAfter">
						<form>
							<div class="layui-inline">
						      <label class="layui-form-label">公司名称</label>
						      <div class="layui-input-inline companyName input_label">
						        <select name="modules" lay-verify="required" class='select-company' lay-search="" id="show_companyName">
						          <option value="">上海</option>
						        </select>
						      </div>
						    </div>
						    
						    <div class="layui-inline">
						      <label class="layui-form-label">查询日期</label>
								<div class="layui-input-inline">
									<input class="layui-input" id="SearchDateStart" placeholder="请输入开始日期" onclick="layui.laydate({elem: this})">
								</div>
								<span style="margin-right: 10px; line-height: 38px;">至</span>
								<div class="layui-input-inline">
									<input class="layui-input" id="SearchDateStop" placeholder="请输入结束日期" onclick="layui.laydate({elem: this})">
								</div>
						    </div>
						    <a href='javascript:void(0);' class="layui-btn layui-btn-normal SearchBtn" id="carInformationSearchBtn">确定</a>
						</form>
					</div>
				</div>
				<hr>
				<div id='chartsSummary'>
					<div id="bar-container" class='bar-content'>
							<p class='barchrts-title'><span class='barcharts-name'></span>违章类型统计</p>
							<div class="swiper-container">
						        <div class="swiper-wrapper">
						            
						        </div>
						        <!-- Add Pagination -->
						        <div class="swiper-pagination"></div>
						    </div>
					</div>
					<div class="right-container">
						<p class='slider-title'>车辆未处理的扣分排名表</p>
						<i class="prev-btn btn"></i>   
						<i class="next-btn btn"></i>
						<p class='summary-show'>未处理的罚金：<b id='untreatedMoney' class='shownumber'></b>元</p>
						<p class='summary-show'>未处理的扣分：<b id='untreatedPoints' class='shownumber'></b>分</p>
						<div class='chartsSlider'>
							<p class='controCar-title'>未处理的扣分︵  分 ︶ </p>
							<div class="slider-container"></div>
						</div>
						<div id="dot-container">
						</div> 
					</div>
				</div>
				<button id="carBasic_excelImpl" class='layui-btn layui-btn-warm  dataOut'>数据导出</button>
				<table class="layui-table Table-rendering">
					<colgroup>
					    <col width="6%">
					    <col width="12%">
					    <col width="12%">
					    <col width="12%">
					    <col width="12%">
					    <col width="20%">
				    </colgroup>
					<thead>
						<tr id='table-thead'>
							<th>序列</th>
							<th>车牌号</th>
							<th>车辆品牌</th>
							<th>车型</th>
							<th>违法次数</th>
							<th>罚款总金额 / 已处理  / 未处理</th>
							<th>合计扣分 / 已消除 / 未消除</th>
						</tr>
					</thead>
					<tbody id="showcarInformationList"></tbody>
				</table>
				<div class="pageWrap" style="text-align:center;">
					<span>共计：<b class='totalNumber'></b>&nbsp;条</span>&nbsp;&nbsp;
					<span class="select-pagerow layui-laypage-total" style="display:inline-block;">每页显示&nbsp;&nbsp;&nbsp;<form id="select-form"><select name="modules" lay-verify="required" lay-search="" class="selectValue"><option value="10">10</option><option value="20">20</option><option value="30">30</option></select></form>&nbsp;&nbsp;&nbsp;条</span>
					<div id="page" style="display:inline-block;"></div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${staticPath}js/jquery.min.js"></script>
	<script src="${staticPath}js/swiper.min.js"></script>
	<script type="text/javascript" src="${staticPath}js/json2.js"></script>
	<!--  <script type="text/javascript" src="${staticPath}js/system-config.js"></script>-->
	<script type="text/javascript" src="${staticPath}js/public.js" ></script>
	<script type="text/javascript" src="${staticPath}layui/layui.js"></script>
	<!-- 引入layer,element,laydate模块 -->
	<script type="text/javascript">
		initDatehandler (false);
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
			<td class='car-Number'>
				<span>{{:carNumber}}</span>
			</td>
			<td>
				<span>{{:carBrand}}</span>
			</td>
			<td>
				<span>{{:carModel}}</span>
			</td>
			<td>
				<span>{{:fineCount}}</span>
			</td>
			<td>
				<span>{{:fineMoney}} / {{:alreadyMoney}} / {{:untreatedMoney}}</span>
			</td>
			<td>
				<span>{{:points}} / {{:eliminated}} / {{:uneliminated}}</span>
			</td>
		</tr>
	</script>
	<script type="text/javascript">
		      var basePath = "${basePath}";
	</script>
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/carPenaltyStatistics.js" ></script>
</body>
</html>