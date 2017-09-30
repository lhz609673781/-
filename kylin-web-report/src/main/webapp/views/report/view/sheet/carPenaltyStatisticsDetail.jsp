<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>车辆罚款详情</title>
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
	<link rel="stylesheet" type="text/css" href="${staticPath}css/carPenaltyStatistics.css" />
</head>
<body>
	<!-- wrap -->
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
					<p>当前位置：<span>车辆管理</span>&gt;<i id='backToCost'><a href='javascript:history.back(-1)'>车辆罚款统计与概率分析</a></i>&gt;<i>车辆罚款详情</i></p>
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
						      <label class="layui-form-label carBrand-title"><span class='getcompany'></span>分公司车牌号：</label>
						      <div class="layui-input-inline companyName input_label" id='carBrandId'>
							      <input id='project-name' type="text" name="title" lay-verify="title" autocomplete="off" placeholder="" class="layui-input">
						      	  <div class='deleteAll'>⨯</div>
							      <ul id='selectSearch' class='select-show' style='display:none'>
							      		
							      </ul>
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
				<hr/>
				<div id='chartsSummary'>
					<div class='left-container'>
						<p class='pitCharts-title'>当前车辆各违章占比</p>
						<div id='pie-container'></div>
					</div>
					<div class='right-container'>
						<p class='line-title'>当前车辆最近一年违章次数走势</p>
						<p style='z-index: 999;width: 100%;position: absolute; bottom: -20px; text-align: center;font-size: 12px;'>（此为效果图，非标准数据！）</p>
						<div class='summary-div'>
							<p class='summary-container'>未处理的扣分：<b class = 'Points'></b>分</p>
							<p class='summary-container'>未交罚款：<b class = 'fine'></b>元</p>
							<p class='summary-container'>违章次数：<b class = 'Illegal-frequence'></b>次</p>
						</div>
						<div id='line-container'></div>
					</div>
				</div>
				<button id="carBasic_excelImpl" class='layui-btn layui-btn-warm  dataOut'>数据导出</button>
				<table class="layui-table Table-rendering">
					<colgroup>
					    <col width="4%">
					    <col width="8%">
					    <col width="20%">
					    <col width="6%">
					    <col width="20%">
					    <col width="8%">
					    <col width="6%">
					    <col width="8%">
					    <col width="6%">
				    </colgroup>
					<thead>
						<tr id='table-thead'>
							<th>序列</th>
							<th>违法时间</th>
							<th>违法地点</th>
							<th>违法代码</th>
							<th>违法行为</th>
							<th>是否处理</th>
							<th>罚款金额</th>
							<th>交款状态</th>
							<th>扣分</th>
							<th>是否消分</th>
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
	<script type="text/javascript" src="${staticPath}js/json2.js"></script>
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
	<script type="text/x-jsrender" id='projectNameSearch'>
		<li>{{:carNumber}}</li>
	</script>
	<script type="text/x-jsrender" id="SearchTpl">
		<tr data-uid="">
			<td>
				<span>{{: #index+1}}</span>
			</td>
			<td>
				<span>{{:illegalDate}}</span>
			</td>
			<td class='collong'>
				<span>{{:illegalAddress}}</span>
			</td>
			<td>
				<span>{{:illegalCode}}</span>
			</td>
			<td class='collong'>
				<span>{{:illegalActivities}}</span>
			</td>
			<td>
				<span>{{:handleFlag}}</span>
			</td>
			<td>
				<span>{{:fineMoney}}</span>
			</td>
			<td>
				<span>{{:points}}</span>
			</td>
			<td class='hourFee'>
				<span>{{:points}}</span>
			</td>
			<td>
				<span>{{:points}}</span>
			</td>
		</tr>
	</script>
	<script type="text/javascript">
		      var basePath = "${basePath}";
	</script>
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/carPenaltyStatisticsDetail.js" ></script>
</body>
</html>