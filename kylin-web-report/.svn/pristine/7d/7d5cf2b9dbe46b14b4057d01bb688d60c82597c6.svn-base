<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>项目运营</title>
	<!-- layui -->
	<link rel="stylesheet" type="text/css" href="${staticPath}layui/layui.css">
	<link rel="stylesheet" href="${staticPath}css/reset.css" />
	<link rel="stylesheet" href="${staticPath}css/layout.css" />
	<!-- Custom -->
	<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/resetfile.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/public.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}css/groupOpration.css" />
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
					<p>当前位置：<span>运营部报表查询</span>&gt;
						<i>
							<a class='nav-address' href='${basePath}views/report/view/sheet/groupOpration.jsp?navId=23'>集团运营</a>
						</i>&gt;
						<i>
							<a class='nav-address' href='javascript:void(0)'><span class='compName'></span>运营</a>
						</i>
					</p>
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
							    <label class="layui-form-label">项目名称：</label>
							    <div class="layui-input-block"  style='width:413px;position:relative'>
							      <input id='project-name' type="text" name="title" lay-verify="title" autocomplete="off" placeholder="" class="layui-input">
							      <div class='deleteAll'>⨯</div>
							      <ul id='selectSearch' class='select-show' style='display:none'>
							      		
							      </ul>
							    </div>
							</div>
							
							<div class="layui-form-item fl cn">
								<label class="layui-form-label">查询日期：</label>
								<div class="layui-input-inline date-box">
									<input class="layui-input" id="SearchDateStart" placeholder="请输入开始日期">
								</div>
								<span style="float: left; margin-right: 10px; line-height: 38px;">至</span>
								<div class="layui-input-inline date-box">
									<input class="layui-input" id="SearchDateStop" placeholder="请输入结束日期">
								</div>
							</div>
						</form>
						<button class="layui-btn layui-btn-normal fl" id="clientSearchSearchBtn">搜索</button>
					</div>
				</div>
				<div class="data-content">
					<div class="currentDayOperation">
						<p style='background: #7ec3ef;' class='titleAttr'>今日运输票数：<b id='ransport-votes'></b>票</p>
						<p style='background: #f8bf3a;' class='titleAttr'>今日运输重量：<b id='ransport-weight'></b>吨</p>
						<p style='background: #91a7cd;' class='titleAttr'>今日运输体积：<b id='ransport-volume'></b>m³</p>
					</div>
					
					<div class="summary-chart">
						<div class='summary-title'>当前项目5个指标维度汇总图</div>
						<div id="summary-container" style="height: 350px; margin: 0 auto"></div>
						<div id='lengend-container'>
							<p style='color:#016f86'><b>A</b>:毛利率</p>
							<p style='color:#275586'><b>B</b>:提货及时率</p>
							<p style='color:#00455f'><b>C</b>:返单合格及时率</p>
							<p style='color:#013356'><b>D</b>:到货及时率</p>
							<p style='color:#143139'><b>E</b>:信息录入准确率</p>
						</div>
					</div>
					
					<div class="ranking-chart">
						<div id="ranking-container" style="width:100%; height:330px"></div>
					</div>
				</div>
				<div style='position: relative;'>
				<!-- 数据导出按钮 -->
				<button  class='layui-btn layui-btn-warm dataOut' id="projectExcelImpl">数据导出</button>
				<div id='loading'>
					<img alt="" src="${staticPath}images/0.gif">
				</div>
				<table class="layui-table Table-rendering">
					<colgroup>
					    <col width="4%">
					    <col width="10%">
					    <col width="6%">
					    <col width="10%">
					    <col width="6%">
					    <col width="8%">
					    <col width="10%">
					    <col width="8%">
					    <col width="8%">
					    <col width="10%">
				    </colgroup>
					<thead>
						<tr>
							<th>序号</th>
							<th>公司名称</th>
							<th>票数</th>
							<th>重量(吨)</th>
							<th>体积(立方)</th>
							<th>项目毛利率指标</th>
							<th>提货及时率</th>
							<th>到货及时率</th>
							<th>返单合格及时率</th>
							<th>信息录入准确率</th>
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
	<script type="text/javascript" src="${staticPath}js/public.js" ></script>
	<script type="text/javascript" src="${staticPath}layui/layui.js"></script>
	<!-- 引入layer,element,laydate模块 -->
	<script type="text/javascript">
		initDatehandler (false);
	</script>
	<script type="text/javascript" src="${staticPath}js/highcharts.js"></script>
	<script type="text/javascript" src="https://img.hcharts.cn/highcharts/highcharts-more.js"></script>
	<script type="text/javascript" src="${staticPath}js/jsrender-min.js"></script>
	<!-- 定义客户查询模板 -->
	<script type="text/x-jsrender" id='projectNameSearch'>
		<li>{{:projectName}}</li>
	</script>
	<script type="text/x-jsrender" id="tableExhibition">
		<tr data-uid="">
			<td>
				<span>{{: #index+1}}</span>
			</td>
			<td id="CompanyName" class='detail_page'>
				<span>{{:companyName}}</span>
			</td>
			<td>
				<span>{{:sumOperaNum}}</span>
			</td>
			<td>
				<span>{{:sumWeight}}</span>
			</td>
			<td>
				<span>{{:sumVolume}}</span>
			</td>
			<td>
				<span>{{:gross}}</span>
			</td>
			<td>
				<span>{{:prompt}}</span>
			</td>
			<td>
				<span>{{:RateIntime}}</span>
			</td>
			<td>
				<span>{{:prompt}}</span>
			</td>
			<td>
				<span>{{:info}}</span>
			</td>
		</tr>
	</script>
	
		<script type="text/javascript">
		      var basePath = "${basePath}";
	</script>
	
	<script type="text/javascript" src="${staticPath}js/easy.ajax.js"></script>
	<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
	<script type="text/javascript" src="${staticPath}js/main.js" ></script>
	<script type="text/javascript" src="${staticPath}js/public.js" ></script>
	<script type="text/javascript" src="${staticPath}js/sheet/projectOperation.js" ></script>
</body>
</html>