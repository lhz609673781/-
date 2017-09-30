<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>车辆基本信息</title>
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
	<link rel="stylesheet" type="text/css" href="${staticPath}css/carInfomation.css" />
	<link rel="stylesheet" href="${staticPath}css/swiper.min.css">
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
					<p>当前位置：<span>车辆查询</span>&gt;<i class='menushow' id='ownCarInfo'>车辆基本信息</i><i class='Anchored-menu' id='AnchoredCarInfo' style='display:none'>&gt;<span class='menushow '>挂靠车辆</span></i></p>
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
						          <option value="">所有公司</option>
						          <option >所有公司</option>
						        </select>
						      </div>
						    </div>
						    
						    <div class="layui-inline">
						      <label class="layui-form-label">车辆性质</label>
						      <div class="layui-input-inline carProperty input_label">
						        <select name="modules" lay-verify="required" lay-search="" id="show_carType">
						          <option value="1">自有车辆</option>
						          <option value="2">挂靠车辆</option>
						        </select>
						      </div>
						    </div>
						    
						    <a href='javascript:void(0);' class="layui-btn layui-btn-normal SearchBtn" id="carInformationSearchBtn">确定</a>
						</form>
						
					</div>
				</div>
				<hr/>
				<div id='chartsSummary'>
					<div class='left-container'>
						<div class="groupControlCar">
							<div class='controlledCar'>可控车辆：<span id='controlledCar-number'></span>辆</div>
							<div class='Anchored-car'>挂靠车辆：<span id='Anchored-car-number'></span>辆</div>
							<div class='Anchored-car Self-support-car'>自营车辆：<span id='Self-support-number'></span>辆</div>
						</div>
						<div id="bar-container" class='bar-content'>
							<p class='barchrts-title'><span class='barcharts-name'></span>分公司各车型数量</p>
							<div class="swiper-container">
						        <div class="swiper-wrapper">
						            
						        </div>
						        <!-- Add Pagination -->
						        <div class="swiper-pagination"></div>
						    </div>
						</div>
					</div>
					<div class='right-content'>
						<div class="right-container">
							<p class='slider-title'>各分公司可控车辆统计图</p>
							<i class="prev-btn btn"></i>   
							<i class="next-btn btn"></i>
							<div class='chartsSlider'>
								<p class='controCar-title'>可控车辆数︵  辆  ︶ </p>
								<div class="slider-container"></div>
							</div>
							<div id="dot-container">
							</div> 
						</div>
						<div class='pie-draw'>
							<p class='pieDrawTitle'>车辆品牌占比</p>
							<p id='branchOfficeName'>︵ <span>所有</span>分公司车辆  ︶</p>
							<div id='pie-container' class='pie-content'></div>
						</div>
						<div class="Anchored-container">
								<div class="layui-tab">
									  <p class='ranking-title'>挂靠车辆数（辆）</p>
									  <ul class="layui-tab-title menuList">
									    <li class="layui-this rankingIndex">分公司排名</li>
									    <li class="rankingIndex">承运商排名</li>
									  </ul>
									  <div class="layui-tab-content">
									    <div class="layui-tab-item layui-show">
									    	<div class="branchOfficeRanking">
												<i class="left-btn btn"></i>   
												<i class="right-btn btn"></i>
												<div class='chartsShow'>
													<div class="slider-container"></div>
												</div>
												<div id="chartsShowdot-container"></div> 
											</div>
									    </div>
									    <div class="layui-tab-item">
									    	<div class="CarrierRanking">
												<i class="prev-btn btn"></i>   
												<i class="next-btn btn"></i>
												<div class='Carrier-chart'>
													<div class="slider-container"></div>
												</div>
												<div id="dot-container"></div> 
											</div>
									    </div>
									  </div>
								</div>
						</div>
					</div>
				</div>
				<button id="carBasic_excelImpl" class='layui-btn layui-btn-warm  dataOut'>数据导出</button>
				<table class="layui-table Table-rendering">
					<colgroup>
					    <col width="4%">
					    <col width="10%">
					    <col width="10%">
					    <col width="8%">
					    <col width="12%">
					    <col width="8%">
					    <col width="8%">
					    <col width="8%">
					    <col width="12%">
					    <!--<col width="8%">
					    <col width="10%"> -->
				    </colgroup>
					<thead>
						<tr id='table-thead'>
							<th>序列</th>
							<th>车牌号</th>
							<th data-type='car_brand'>车辆品牌</th>
							<th>车型</th>
							<th data-type='board_Date'>上牌日期</th>
							<th>排放标准</th>
							<th data-type='car_company'>隶属公司</th>
							<th data-type='car_use '>车辆用途</th>
							<th>所在营业部或线路</th>
							<th>核载吨位</th>
							<th>装载体积</th>
						</tr>
					</thead>
					<tbody id="showcarInformationList"></tbody>
				</table>
				<table class="layui-table AnchoredTable-rendering" style='display:none'>
					<colgroup>
					    <col width="4%">
					    <col width="15%">
					    <col width="10%">
					    <col width="8%">
					    <col width="12%">
					    <col width="8%">
					    <col width="8%">
					    <col width="12%">
					    <col width="12%">
					    <!--<col width="8%">
					    <col width="10%"> -->
				    </colgroup>
					<thead>
						<tr id='Anchoredtable-thead'>
							<th>序列</th>
							<th>车牌号</th>
							<th>车型</th>
							<th>上牌日期</th>
							<th>车辆类型</th>
							<th>隶属公司</th>
							<th>挂靠时间</th>
							<th>审批报告号</th>
							<th>车辆用途</th>
							<th>核载吨位</th>
						</tr>
					</thead>
					<tbody id="showcarAnchoredList"></tbody>
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
	<script type="text/javascript" src="${staticPath}layui/layui.js"></script>
	<script type="text/javascript" src="${staticPath}js/public.js" ></script>
	<!-- 引入layer,element,laydate模块 -->
	<script type="text/javascript">
	layui.use(['layer','element','laydate','form','laypage','layedit'], function(){
		var layer = layui.layer,
		    element = layui.element(),
			laydate = layui.laydate,
			form = layui.form(),
			layedit = layui.layedit,
			laypage = layui.laypage;
		});
	</script>
	<script type="text/javascript" src="${staticPath}js/highcharts.js"></script>
	<script type="text/javascript" src="${staticPath}js/highcharts-3d.js"></script>
	<script type="text/javascript" src="https://img.hcharts.cn/highcharts/highcharts-more.js"></script>
	<!-- <script type="text/javascript" src="https://img.hcharts.cn/highcharts/modules/exporting.js"></script> 
	<script type="text/javascript" src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script> -->
	<script type="text/javascript" src="${staticPath}js/jsrender-min.js"></script>
	<!-- 定义客户查询模板 -->
	<script type="text/x-jsrender" id="SearchTpl">
		<tr data-uid="">
			<td>
				<span>{{: #index+1}}</span>
			</td>
			<td id="CompanyName">
				<span>{{:carNumber}}</span>
			</td>
			<td>
				<span>{{:carBrand}}</span>
			</td>
			<td>
				<span>{{:comparType}}</span>
			</td>
			<td>
				<span>{{:boardDateStr}}</span>
			</td>
			<td>
				<span>{{:emissStand}}</span>
			</td>
			<td>
				<span>{{:carCompany}}</span>
			</td>
			<td>
				<span>{{:carUse}}</span>
			</td>
			<td>
				<span>{{:carPlace}}</span>
			</td>
			<td>
				<span>{{:carLoad}}</span>
			</td>
			<td>
				<span>{{:loadVolume}}</span>
			</td>
		</tr>
	</script>
	<script type="text/x-jsrender" id="anchoredList">
		<tr data-uid="">
			<td>
				<span>{{: #index+1}}</span>
			</td>
			<td class='carNum'>
				<span>{{:carNumber}}</span>
			</td>
			<td>
				<span>{{:carModel}}</span>
			</td>
			<td>
				<span>{{:boardDate}}</span>
			</td>
			<td>
				<span>{{:carType}}</span>
			</td>
			<td>
				<span>{{:carCompany}}</span>
			</td>
			<td>
				<span>{{:attacheDate}}</span>
			</td>
			<td>
				<span>{{:reportNumber}}</span>
			</td>
			<td>
				<span>{{:carUse}}</span>
			</td>
			<td>
				<span>{{:standMass}}</span>
			</td>
		</tr>
	</script>
	<script type="text/javascript">
		      var basePath = "${basePath}";
	</script>
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/AnchoredInfo.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/carInfomation.js" ></script>
</body>
</html>