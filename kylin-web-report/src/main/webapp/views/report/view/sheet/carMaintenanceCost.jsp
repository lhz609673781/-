<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>车辆维修成本控制</title>
	<!-- layui -->
	<link rel="stylesheet" type="text/css" href="${staticPath}layui/layui.css">
	<link rel="stylesheet" href="${staticPath}css/reset.css" />
	<link rel="stylesheet" href="${staticPath}css/layout.css" />
	<!-- Custom -->
	<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css" />
	<link rel="stylesheet" href="${staticPath}font-awesome/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/resetfile.css" />
	<%-- <link rel="stylesheet" type="text/css" href="${staticPath}css/public.css" /> --%>
	<link rel="stylesheet" type="text/css" href="${staticPath}css/clientSeacher.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/carInfomation.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/carMaintenanceCost.css" />
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
					<p>当前位置：<span>车辆管理</span>&gt;<i>车辆维修成本控制</i></p>
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
				<hr/>
				<div id='chartsSummary'>
					<div class="groupControlCar mantenanceCost">
						<ul class='information_detail'>
							<li><span>维修车辆：<b class='carCount'></b>辆</span></li>
							<li><span>维修次数：<b class='maintainCount'></b>次</span></li>
							<li><span>维修时长：<b class='maintainTime'></b>小时</span></li>
							<li><span>维修金额：<b class='maintainAmount'></b>万元</span></li>
						</ul>
						<div class='descripInfo'>
							<dl>
								<dt>基本信息描述：</dt>
								<dd>
									<span><b id='company_name'></b>分公司，在<b id='begin-time'></b>至<b id='stop-time'></b>维修信息如下：</span>
									<ol>
										<li>1.有<b class='carCount'></b>辆车进行维修，占所有车辆的<b id='carCountpercent'></b>%。</li>
										<li>2.维修<b class='maintainCount'></b>次。</li>
										<li>3.维修<b class='maintainTime'></b>小时，均摊时长<b id='averageTime'></b>小时/次。</li>
										<li>4.维修金额<b class='maintainAmount'></b>万元。</li>
									</ol>
								</dd>
							</dl>
						</div>
					</div>
					<div class="right-content">
						<div id='carMaintenance-frequency' style='height:350px'>
							<div class="swiper-container">
						        <div class="swiper-wrapper">
						            
						        </div>
						        <!-- Add Pagination -->
						        <div class="swiper-pagination"></div>
						    </div>
						</div>
					</div>
					<div class='center-container'>
						<div id='car-proportion'></div>
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
							<th>车辆品牌</th>
							<th>车型</th>
							<th>发动机功率单位/KW</th>
							<th>发动机马力</th>
							<th>上牌日期</th>
							<th>车辆用途</th>
							<th>维修次数</th>
							<th>维修时长</th>
							<th>维修金额</th>
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
	<!--  <script type="text/javascript" src="${staticPath}js/system-config.js"></script>-->
	<script type="text/javascript" src="${staticPath}js/public.js" ></script>
	<script type="text/javascript" src="${staticPath}layui/layui.js"></script>
	<!-- 引入layer,element,laydate模块 -->
	<script type="text/javascript">
		initDatehandler (true);
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
			<td id="CompanyName" class='car-Number'>
				<span>{{:carNumber}}</span>
			</td>
			<td>
				<span>{{:carBrand}}</span>
			</td>
			<td>
				<span>{{:comparType}}</span>
			</td>
			<td>
				<span>{{:enginePower}}</span>
			</td>
			<td>
				<span>{{:engineHpower}}</span>
			</td>
			<td>
				<span>{{:boardDate}}</span>
			</td>
			<td>
				<span>{{:carUse}}</span>
			</td>
			<td>
				<span>{{:maitainNum}}</span>
			</td>
			<td>
				<span>{{:maitainHour}}</span>
			</td>
			<td>
				<span>{{:maitainSum}}</span>
			</td>
		</tr>
	</script>
	<script type="text/javascript">
		      var basePath = "${basePath}";
	</script>
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/carMaintenanceCost.js" ></script>
</body>
</html>