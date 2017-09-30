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
	<!-- 弹出表格 -->
	<table class="layui-table parts-fee" id='partsFeeshowlist'>
		<thead>
			<tr id='table-thead'>
				<th>序号</th>
				<th>维修项目</th>
				<th>配件名称</th>
				<th>规格/型号</th>
				<th>品牌</th>
				<th>单价</th>
				<th>数量</th>
				<th>金额</th>
				
			</tr>
		</thead>
		<tbody id="showpartsFee">
			<tr>
				<td colspan = '6'><b>合计</b></td>
				<td id='numberSum'></td>
				<td id='feeSum'></td>
			</tr>
		</tbody>
	</table>
	<table class="layui-table parts-fee" id='workTimeFee'>
		<thead>
			<tr id='table-thead'>
				<th>序号</th>
				<th>维修项目</th>
				<th>工时单价</th>
				<th>工时</th>
				<th>工时费用</th>
			</tr>
		</thead>
		<tbody id="showworkTimeFee">
			<tr>
				<td colspan = '3'><b>合计</b></td>
				<td id='workhour'></td>
				<td id='workhourFee'></td>
			</tr>
		</tbody>
	</table>
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
					<p>当前位置：<span>车辆管理</span>&gt;<i id='backToCost'><a href='javascript:history.back(-1)'>车辆维修成本控制</a></i>&gt;<i>车辆维修详情</i></p>
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
						      <label class="layui-form-label" style='width: auto'><span class='getcompany'></span>分公司车牌号：</label>
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
					<div class="groupControlCar mantenanceCost">
						<ul class='information_detail'>
							<li><span>维修工时：<b class='carCount'></b>小时</span></li>
							<li><span>维修次数：<b class='maintainCount'></b>次</span></li>
							<li><span>维修金额：<b class='maintainTime'></b>元</span></li>
							<li><span>总费用：<b class='maintainAmount'></b>元</span></li>
						</ul>
						<div class='descripInfo'>
							<dl>
								<dt>基本信息描述：</dt>
								<dd>
									<span>车牌号<b id='company_name'></b>，在<b id='begin-time'></b>至<b id='stop-time'></b>维修信息如下：</span>
									<ol>
										<li>1.一共维修<b class='maintainCount'></b>次。</li>
										<li>2.维修工时：<b class='carCount'></b>小时。</li>
										<li>3.维修费用：<b class='maintainTime'></b>元。</li>
										<li>4.合计费用：<b class='maintainAmount'></b>元。</li>
									</ol>
								</dd>
							</dl>
						</div>
					</div>
					<div class="right-content">
						<div id='carMaintenance-frequency' style='height:350px'></div>
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
					    <col width="6%">
					    <col width="8%">
					    <col width="12%">
					    <col width="8%">
					    <col width="8%">
					    <col width="8%">
					    <col width="6%">
					    <col width="12%">
					    <col width="10%">
				    </colgroup>
					<thead>
						<tr id='table-thead'>
							<th>序列</th>
							<th>维修日期</th>
							<th>维修里数</th>
							<th>维修厂名称</th>
							<th>维修性质</th>
							<th>联系电话</th>
							<th>配件费用</th>
							<th>工时</th>
							<th>工时费用</th>
							<th>报告号</th>
							<th>总费用</th>
							<th>备注</th>
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
		initDatehandler (true);
	</script>
	<script type="text/javascript" src="${staticPath}js/highcharts.js"></script>
	<script type="text/javascript" src="${staticPath}js/highcharts-3d.js"></script>
	<script type="text/javascript" src="https://img.hcharts.cn/highcharts/highcharts-more.js"></script>
	<script type="text/javascript" src="${staticPath}js/jsrender-min.js"></script>
	<!-- 定义客户查询模板 -->
	<!-- 定义客户查询模板 -->
	<script type="text/x-jsrender" id='projectNameSearch'>
		<li>{{:carNumber}}</li>
	</script>
	<script type="text/x-jsrender" id="SearchTpl">
		<tr data-uid="">
			<td>
				<span>{{: #index+1}}</span>
			</td>
			<td id="CompanyName">
				<span>{{:repairDate}}</span>
			</td>
			<td>
				<span>{{:repairMileage}}</span>
			</td>
			<td>
				<span>{{:repairShopName}}</span>
			</td>
			<td>
				<span>{{:repairProject}}</span>
			</td>
			<td>
				<span>{{:telephone}}</span>
			</td>
			<td class='repairFee'>
				<span>{{:repairFee}}</span>
			</td>
			<td>
				<span>{{:hour}}</span>
			</td>
			<td class='hourFee'>
				<span>{{:hourFee}}</span>
			</td>
			<td>
				<span>{{:reportNumber}}</span>
			</td>
			<td>
				<span>{{:totalFee}}</span>
			</td>
			<td>
				<span>{{:ramark}}</span>
			</td>
		</tr>
	</script>
	<script type="text/x-jsrender" id="partsFee">
		<tr data-uid=""  class='partsdataList'>
			<td>
				<span>{{: #index+1}}</span>
			</td>
			<td>
				<span>{{:repairProject}}</span>
			</td>
			<td>
				<span>{{:accessoryName}}</span>
			</td>
			<td>
				<span>{{:model}}</span>
			</td>
			<td>
				<span>{{:brand}}</span>
			</td>
			<td>
				<span>{{:price}}</span>
			</td>
			<td class='number'>
				<span>{{:number}}</span>
			</td>
			<td class='money'>
				<span>{{:money}}</span>
			</td>
		</tr>
	</script>
	<script type="text/x-jsrender" id="workTimeFeelist">
		<tr data-uid="" class='partsdataList'>
			<td>
				<span>{{: #index+1}}</span>
			</td>
			<td>
				<span>{{:repairProject}}</span>
			</td>
			<td>
				<span>{{:timeUnitPrice}}</span>
			</td>
			<td>
				<span>{{:timeUnit}}</span>
			</td>
			<td>
				<span>{{:hourFee}}</span>
			</td>
		</tr>
	</script>
	<script type="text/javascript">
		      var basePath = "${basePath}";
	</script>
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/carMaintenanceDetail.js" ></script>
</body>
</html>