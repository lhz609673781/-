 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<%@page import="com.ycgwl.kylin.web.report.utils.DateUtils"  %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>理赔报表统计</title>
		<link rel="stylesheet" type="text/css" href="${staticPath}layui/layui.css">
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<link rel="stylesheet" href="${staticPath}css/operationClaimReport.css" />
		<script type="text/javascript" src="${staticPath}js/jquery.min1.js" ></script>
		<script type="text/javascript" src="${staticPath}layui/layui.js"></script>
		<script type="text/javascript">
			layui.use(['layer','element','laydate','form','laypage'], function(){
	  			var layer = layui.layer,
	  			    element = layui.element(),
	  				laydate = layui.laydate,
	  				form = layui.form(),
	  			    laypage = layui.laypage;
	  			
	  			var start = {
  				    min: '2016-1-1'
  				    ,max: laydate.now()
  				    ,istime: true
  				    ,format: 'YYYY-MM-DD' 
  				    ,choose: function(datas){
  				      end.min = datas; //开始日选好后，重置结束日的最小日期
  				      end.start = datas //将结束日的初始值设定为开始日
  				    }
  				};
	  				   
  				var end = {
  				    min: '2016-1-1'
  				    ,max: laydate.now()
  				    ,istime: true
  				    ,format: 'YYYY-MM-DD'
  				    ,choose: function(datas){
  				      start.max = datas; //结束日选好后，重置开始日的最大日期
  				    }
  				};
	  				  
  				document.getElementById('beginTime').onclick = function(){
  				    start.elem = this;
  				    laydate(start);
  				}
  				document.getElementById('endTime').onclick = function(){
  				    end.elem = this
  				    laydate(end);
  				}

			})

		</script>
		<script src="${staticPath}js/highcharts.js"></script>
		<script src="${staticPath}js/highcharts-3d.js"></script>
		<script type="text/javascript" src="${staticPath}js/main.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
		<script type="text/javascript" src="${staticPath}js/sheet/operationClaimReport.js" ></script>
		<!--[if lt IE 9]>
	      <script src="js/respond.min.js"></script>
	    <![endif]-->
	    <script type="text/javascript">
		      var basePath = "${basePath}";
		      var pageTotalRecords = 0;
		</script>
		<style type="text/css">
			.time-img ,#label-img {
   				position: static;
			}
			.data-input{
				height: 22px;
				line-height:22px;
			}
			.date-item{
				display: inline-block;
				margin-bottom: 0px;
			}
			.datalabel{
				padding: 16px 15px;
			}
			.searchName{
				display:inline-block;
				vertical-align:7px;
			}
		</style>
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
						<p>当前位置：<span>理赔报表查询</span>&gt;<i>理赔报表统计</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>理赔报表统计</h2>
						<div class="collect-form depart">
							<form id="form" action="">
								<label class="layui-form-label datalabel">查询日期：</label>
								<div class="layui-form-item date-item cn">
									<div class="layui-input-inline dateselected">
										<input class="layui-input data-input" id="beginTime" placeholder="">
									</div>
									<span style="float: left; margin-right: 10px;">至</span>
									<div class="layui-input-inline dateselected">
										<input class="layui-input data-input" id="endTime" placeholder="">
									</div>
								</div>
								<label class="searchName">
					                <span class="searchSpan">公司名称：
					                	<select class="searchText" id="companyName">
					                		<option value="">所有公司</option>
					                	</select>
					                </span>
				                </label>
				                <label class="searchSpan searchName">
				                	客户名称：
				                	<div id="selCompany" class="searchDiv" style="border: 1px solid #e1e5ed;display:inline-block;">
				                		<span id="isCustomerText"><input class="searchText" id="customerName" type="text" style="border: 0;width: 130px;"/></span>
				                		<span onclick="getCustomer()" style="cursor: pointer;color: #358ff0;" class="serachIcon" id="serachIcon">
				                			
				                		</span>
				                	</div>
				                </label>
				                 
								<div class="btn" onclick="searchOperationReport(1);" style="margin-left: 10px;">
									<input type="button" value="确定" class="btn-yes searchName" style="margin-right: -20px;"/>
								</div>
							</form>
						</div>
						
							<!-- <div id="graphTop1">
								<div class="graphPie" id="graphPie1">
									<span class='pie1-data'>2.69万元</span>
									<div id="container1" style="height: 350px;width: 100%; margin: 0 auto"></div>
								</div>
							</div> -->
							<div id="graphTop">
								<div class="graphPie" id="graphPie1">
									<span class='pie1-data'></span>
									<div id="container1" style="height: 350px;width: 100%; margin: 0 auto"></div>
								</div>
								<div class="graphPie" id="graphPie2">
									<span class='pie1-data'></span>
									<div id="container2" style="height: 350px;width: 100%; margin: 0 auto"></div>
								</div>
								<div class="graphPie" id="graphPie3">
									<div id="container3" style="height: 350px;width: 100%; margin: 0 auto"></div>
								</div>
								<div class="graphPie" id="graphPie4">
									<div id="container4" style="height: 350px;width: 100%; margin: 0 auto"></div>
								</div>
								<div class="graphPie" id="graphPie5">
									<div id="container5" style=" height: 350px;width: 100%; margin: 0 auto"></div>
								</div>	
							</div>
						
						
						<div id="graphCentre">
							<!-- <div id="graphDescribe">
								<p style="margin-top: 30px;">（汇总信息描述）从<span class="spanText" id="serBeginTimeText"></span>到<span class="spanText" id="serEndTimeText"></span>的汇总信息如下</p>
								<p>1：赔付金额共：<span class="spanText" id="spanText1"></span></p>
								<p>2：当前赔付票数：<span class="spanText" id="spanText2"></span></p>
								<p>3：整体赔付占营业额的百分比：<span class="spanText" id="spanText3"></span></p>
								<p>4：异常签收占比：<span class="spanText" id="spanText4"></span></p>
								<p>5：风险转移比例：需承运商承担<span  class="spanText" id="spanText5"></span>，需保险公司承担<span  class="spanText" id="spanText6"></span>，自留风险<span  class="spanText" id="spanText7"></span></p>
							</div> 
							<div id="graphRight" style="height: 280px">
								
							</div>-->
						</div>
					  <!--表格-->
					  <button id="export_data" class='layui-btn layui-btn-warm dataOut'>数据导出</button>
						<table class="teb" id="operationReportTable">
						</table>
						<!--分页-->
							<div id="paging">
						    </div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>