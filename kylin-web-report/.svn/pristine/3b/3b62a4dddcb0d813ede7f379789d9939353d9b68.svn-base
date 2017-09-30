<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>分公司毛利统计表</title>
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
	<link rel="stylesheet" type="text/css" href="${staticPath}css/grossStatistics.css" />
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
					<p>当前位置：<span>财务管理</span>&gt;<i>分公司毛利统计表</i></p>
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
						    <a href='javascript:void(0);' class="layui-btn layui-btn-normal SearchBtn" id="carInformationSearchBtn">确定</a>
							<p class='turn-to-next' id='turn-to-next'>
								分公司详情
								<img style='width: 27px' src="${staticPath}images/turn_next.jpg"/> 
							</p>
						</form>
					</div>
				</div>
				<hr>
				<div class='left-container'>
					<div class='pie-container'>
						<p class='pitCharts-title'>各公司的收入占比（前10名）</p>
						<div id='pie-container'></div>
					</div>
					<div class="spider-map">
						<p class='spider-title pitCharts-title'>各分公司的毛利率</p>
						<div class="swiper-container">
					        <div class="swiper-wrapper spider-swiper">
					            
					        </div>
					        <!-- Add Pagination -->
					        <div class="swiper-pagination"></div>
					    </div>
					</div> 
				</div>
				<div class='right-container'>
					<div id="bar-container" class='bar-content cost-income'>
							<p class='barchrts-title'><span class='barcharts-name'></span>各公司成本/收入（万元）</p>
							<div class="swiper-container">
						        <div class="swiper-wrapper">
						            
						        </div>
						        <!-- Add Pagination -->
						        <div class="swiper-pagination"></div>
						    </div>
						    <div class='bar-summary'>
								<p>平均成本（万）： <span id='num_one'></span>万元</p>
								<p style='margin-left: 20px;'>平均收入（万）： <span id='num_two'></span>万元</p>
							</div>
					</div>
					<div class="clunm-container income-index">
						<p class='slider-title'>各分公司的的收入/收入指标/毛利     (万元)</p>
						<i class="prev-btn btn"></i>   
						<i class="next-btn btn"></i>
						<div class='chartsSlider'>
							<div class="slider-container"></div>
						</div>
						<div id="dot-container">
						</div> 
						<div class='bar-summary colunm-summary'>
							<p>总毛利（万）： <span id='num_three'></span>万元</p>
							<p style='margin-left: 90px;'>平均毛利（万）： <span id='num_four'></span>万元</p>
						</div>
					</div>
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
		initDatehandler (true);
	</script>
	<script type="text/javascript" src="${staticPath}js/highcharts.js"></script>
	<script type="text/javascript" src="${staticPath}js/highcharts-3d.js"></script>
	<script type="text/javascript" src="${staticPath}js/echarts.min.js"></script>
	<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
	<!-- <script type="text/javascript" src="https://img.hcharts.cn/highcharts/highcharts-more.js"></script> -->
	<script type="text/javascript" src="${staticPath}js/jsrender-min.js"></script>
	<!-- 定义客户查询模板 -->
	<script type="text/x-jsrender" id="SearchTpl">
		
	</script>
	<script type="text/javascript">
		      var basePath = "${basePath}";
	</script>
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/grossStatistics.js" ></script>
</body>
</html>