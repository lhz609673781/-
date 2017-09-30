<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>公司理赔查询</title>
	<!-- layui -->
	<link rel="stylesheet" type="text/css" href="${staticPath}layui/layui.css">
	<link rel="stylesheet" href="${staticPath}css/reset.css" />
	<link rel="stylesheet" href="${staticPath}css/layout.css" />
	<!-- Custom -->
	<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/resetfile.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/clientSeacher.css" />
	<style type="text/css">
		.description{
			margin-top: 50px;
		}
		.layui-table td, .layui-table th{
			text-align: center;
			font-size:13px;
		}
		.layui-table th{
			color:#358ff0;
			font-weight:normal;
		}
		#content {
		    padding: 0 0 20px 280px;
		}
		@media screen and (max-width:1200px){
			.Table-rendering td, .Table-rendering th {
			    padding: 9px 0px;
			    font-size: 12px !important;
		}
	</style>
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
					<p>当前位置：<span>理赔报表查询</span>&gt;<i>公司理赔对比</i></p>
				</div>
				<div class="fr">
					<span class="admin"><a href=''>退出</a></span>
				</div>
			</div>
			
			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<div class="layui-form clearAfter">
						<form>
							<div class="layui-form-item fl cn">
								<div class="layui-input-inline select-tab">
							      <input type="checkbox" checked="" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="">
							    </div> 
							
								<label class="layui-form-label">查询日期</label>
								<div class="layui-input-inline">
									<input class="layui-input" id="SearchDateStart" placeholder="请输入开始日期">
								</div>
								<span style="float: left; margin-right: 10px; line-height: 38px;">至</span>
								<div class="layui-input-inline">
									<input class="layui-input" id="SearchDateStop" placeholder="请输入结束日期">
								</div>
								
								<div class="layui-inline check-criteria">
									<label class="layui-form-label">查询条件</label>
									<div class="layui-input-inline" id="searchType">
										<select name="order-status" id="company_findtype">
											<option value="0" slected="">受理时间</option>
											<option value="1">发货时间</option>
										</select>
									</div>
								</div>
							</div>
						</form>
						<button class="layui-btn layui-btn-warm fl" id="companySearchSearchBtn">确定</button>
					</div>
					<div class="charts clearAfter">
						<div class="charts-left fl">
							<div class="charts-item fl">
								<div class="charts-item-pic" id="charts-item1-pic"></div>
								<p class="charts-item-value ellipsis"><b id="charts-item1-value"></b></p>
								<p class="charts-item-name ellipsis"><b>前三个月赔付平均值</b></p>
							</div>
							<div class="charts-item fl">
								<div class="charts-item-pic" id="charts-item2-pic"></div>
								<p class="charts-item-value ellipsis"><b id="charts-item2-value"></b></p>
								<p class="charts-item-name ellipsis"><b>同期赔付增减</b></p>
							</div>
							<div class="charts-item fl">
								<div class="charts-item-pic" id="charts-item3-pic"></div>
								<p class="charts-item-value ellipsis"><b id="charts-item3-value"></b></p>
								<p class="charts-item-name ellipsis"><b>环比赔付增减</b></p>
							</div>
							<div class="charts-item fl">
								<div class="charts-item-pic" id="charts-item5-pic"></div>
								<p class="charts-item-value ellipsis"><b id="charts-item5-value"></b></p>
								<p class="charts-item-name ellipsis"><b>当期赔付总计</b></p>
							</div>
						</div>
						<div class="charts-right fl">
							<dl class="description">
								<dt>汇总信息描述：</dt>
								<dd>1. 根据当前的查询条件，前三个月赔付的平均值约为：<b id="desAverage"></b>万元</dd>
								<dd>2. 同期赔付<span class="SamePay">增加</span>了：<b id="desSameCompensation"></b>%</dd>
								<dd>3. 环比赔付<span class="ringPay">减少</span>了：<b id="desSurroundCompensation"></b>%</dd>
								<dd>4. 当期赔付<span class="amountPay">总计</span>：<b id="payAmout"></b>万元</dd>
								<dd>5. 当期赔付需供应商承担：<b id="Supplier_percent"></b>%，金额：<b id="Supplier_amount"></b>万元，
									需转移保险公司<b id="Insurance_percent"></b>%，涉及金额<b id="Insurance_amount"></b>万元，
									自留风险<b id="Retention_percent"></b>%，涉及金额<b id="Retention_amount"></b>万元。
								</dd>
							</dl>
						</div>
					</div>
				<button id="company_excel_impl" class='layui-btn layui-btn-warm dataOut'>数据导出</button>
					<table class="layui-table Table-rendering">
						<colgroup>
					      <col width="5%">
					      <col width="7%">
					      <col width="9%">
					      <col width="15%">
					      <col width="15%">
					      <col width="10%">
					      <col width="10%">
					      <col width="11%">
					      <col width="10%">
					    </colgroup>
						<thead>
							<tr>
								<th>序号</th>
								<th>远成公司</th>
								<th>当期赔付(万元)</th>
								<th>前推第1/2/3月(万元)</th>
								<th>前三个月平均赔付值(万元)</th>
								<th>同期赔付</th>
								<th>环比赔付</th>
								<th>需供应商承担</th>
								<th>需保险公司承担</th>
								<th>自留风险</th>
							</tr>
						</thead>
						<tbody id="showSearchList"></tbody>
					</table>
					<div class="pageWrap" style="text-align:center;">
						<span>共计：<b class='totalNumber'></b>&nbsp;条</span>&nbsp;&nbsp;
						<span class="select-pagerow layui-laypage-total" style="display:inline-block;">每页显示&nbsp;&nbsp;&nbsp;<form id="select-form"><select name="modules" lay-verify="required" lay-search="" class="selectValue"><option value="10">10</option><option value="20">20</option><option value="30">30</option></select></form>&nbsp;&nbsp;&nbsp;条</span>
						<div id="page" style="display:inline-block;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${staticPath}js/jquery.min.js"></script>
	<script type="text/javascript" src="${staticPath}js/json2.js"></script>
	<!--  <script type="text/javascript" src="${staticPath}js/system-config.js"></script>-->
	<script type="text/javascript" src="${staticPath}layui/layui.js"></script>
	<!-- 引入layer,element,laydate模块 -->
	<script type="text/javascript">
		layui.use(['layer','element','laydate','form','laypage'], function(){
  			var layer = layui.layer,
  			    element = layui.element(),
  				laydate = layui.laydate,
  				form = layui.form(),
  				flag,
  				laypage = layui.laypage;
  			
			var start = {
			    min: '2016-1-1'
			    ,max: laydate.now()
			    ,istime: true
			    ,format: 'YYYY-MM' 
			    ,choose: function(datas){
			      end.min = datas; //开始日选好后，重置结束日的最小日期
			      end.start = datas //将结束日的初始值设定为开始日
			    }
			};
			   
			var end = {
			    min: '2016-1-1'
			    ,max: laydate.now()
			    ,istime: true
			    ,format: 'YYYY-MM'
			    ,choose: function(datas){
			      start.max = datas; //结束日选好后，重置开始日的最大日期
			    }
			};
			  
			document.getElementById('SearchDateStart').onclick = function(){
			    start.elem = this;
			    laydate(start);
			    if($(".layui-form-switch").hasClass("layui-form-onswitch")){
			    	$("#laydate_table").css('display','none');
			    }else{
			    	$("#laydate_table").css('display','block');
			    }
			}
			document.getElementById('SearchDateStop').onclick = function(){
			    end.elem = this
			    laydate(end);
			    if($(".layui-form-switch").hasClass("layui-form-onswitch")){
			    	$("#laydate_table").css('display','none');
			    }else{
			    	$("#laydate_table").css('display','block');
			    }
			}
			form.on('switch(switchTest)', function(data){
			    if($(".layui-form-switch").hasClass("layui-form-onswitch")){
			    	flag = true
			    	start.format = end.format = "YYYY-MM" ;
			    	$(".laydate_table").css('display','none');
			    	$('#SearchDateStart').attr({'placeholder':'请输入开始日期'}).val("");
			    	$('#SearchDateStop').attr('placeholder','请输入结束日期').val("");
			    }else{
			    	flag = false
			    	start.format = end.format = "YYYY-MM-DD";
			    	$(".laydate_table").css('display','block');
			    	$('#SearchDateStart').attr('placeholder','请输入开始日期').val("");
			    	$('#SearchDateStop').attr('placeholder','请输入结束日期').val("");
			    }
			  });
			
		});
	</script>
	<script type="text/javascript" src="${staticPath}js/highcharts.js"></script>
	<script type="text/javascript" src="${staticPath}js/highcharts-3d.js"></script>
	<script type="text/javascript" src="${staticPath}js/jsrender-min.js"></script>
	<!-- 定义客户查询模板 -->
	<script type="text/x-jsrender" id="SearchTpl">
		<tr data-uid="{{}}">
			<td>
				<span class="showCompanySearchSeq">{{: #index+1}}</span>
			</td>
			<td>
				<span class="showCompanySearchCustomName">{{:companyName}}</span>
			</td>
			<td>
				<span class="showCompanySearchCurrentCompensation">{{:payAmount}}</span>
			</td>
			<td>
				<span class="showCompanySearchFirst">{{:firstMonthLastSeason}} / {{:secondMonthLastSeason}} / {{:thirdMonthLastSeason}}</span>
			</td>
			<td>
				<span class="showCompanySearchAverage">{{:averageLastSeason}}</span>
			</td>
			<td>
				<span class="showCompanySearchSameCompensation">{{:contemporaneousPayment}}</span>
			</td>
			<td>
				<span class="showCompanySearchSurroundCompensation">{{:ringPayment}}</span>
			</td>
			<td>
				<span class="showCompanySearchSupplierBear">{{:carrierPayPercent}}</span>
			</td>
			<td>
				<span class="showCompanySearchInsuranceBear">{{:insurancePayPercent}}</span>
			</td>
			<td>
				<span class="showCompanySearchMyBear">{{:companyPayPercent}}</span>
			</td>
		</tr>
	</script>
	<script type="text/javascript">
		      var basePath = "${basePath}";
	</script>
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/function.js"></script>
	<script type="text/javascript" src="${staticPath}js/sheet/companySeacher.js"></script>
</body>
</html>