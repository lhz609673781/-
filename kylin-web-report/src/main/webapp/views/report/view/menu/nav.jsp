<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../config.jsp" %>
				<div class="nav-list">
					<ul>
			            <li class="nav1 parent-li">
			                <a href="#" class="parent-menu"><span class="span-icon"></span>市场部报表查询<i class="icon"></i></a>
			                <ul class="sub-menu">
			                    <li class='subtitle' navId='1'><a href="${basePath}branchData/getfilialeachievement.do?navId=1">分公司营业数据查询</a></li>
								<li class='subtitle' navId='2'><a href="${basePath}buData/getbuachievement.do?navId=2">事业部营业数据查询</a></li>
			                </ul>
			            </li>
			            <li class="nav1 parent-li">
			                <a href="#" class="parent-menu">
			                	<span class="span-icon"></span>业务部报表查询<i class="icon"></i>
			                </a>
			                <ul class="sub-menu">
			                    <%-- <li class='subtitle' navId='3'><a href="${basePath}buData/getbuachievement.do?navId=3">业务查询</a></li> --%>
			                </ul>
			            </li>
			            <li class="nav2 parent-li">
			                <a href="#" class="parent-menu">
			                	<span id="logo-maoli">
			                		<img src="${staticPath}images/logo-maoli.png" id="img-logo"/> 
			                	</span>
			                	&nbsp;运营部报表查询<i class="icon"></i>
			                </a>
			                <ul class="sub-menu">
			                    <li class='subtitle' navId='4'><a href="${basePath}operationStatis/grossProfitStatis.do?navId=4">分公司毛利统计表</a></li>
						        <li class='subtitle' navId='5'><a href="${basePath}operationStatis/grossProfitCompare.do?navId=5">分公司毛利对比表</a></li>
						        <li class='subtitle' navId='6'><a href="${basePath}companyCompare/findIdentical.do?navId=6">分公司成本同比表</a></li>
						        <li class='subtitle' navId='7'><a href="${basePath}companyCompare/findAround.do?navId=7">分公司成本环比表</a></li>
						        <li class='subtitle' navId='8'><a href="${basePath}companyCompare/findMonitorMajor.do?navId=8">重点项目监控表</a></li>
						        <li class='subtitle' navId='9'><a href="${basePath}operationKeyIndicator/keyIndicator.do?navId=9">运营关键指标表</a></li>
						        <li class='subtitle' navId='10'><a href="${basePath}operationCarrier/infoQuantization.do?navId=10">信息量化统计表</a></li>
			         			<li class='subtitle' navId='11'><a href="${basePath}operationMoneyFlushInfo/moneyFlushInfo.do?navId=11">财凭冲红统计表</a></li>
			         			<li class='subtitle' navId='12'><a href="${basePath}operationReturn/findOperationReturn.do?navId=12">返单统计表</a></li>
			         			<li class='subtitle' navId='23'><a href="${basePath}views/report/view/sheet/groupOpration.jsp?navId=23">集团运营</a></li>
			                </ul>
			            </li>
			            <li class="nav1 parent-li">
			                <a href="#" class="parent-menu">
			                	<span class="span-icon"></span>车辆查询<i class="icon"></i>
			                </a>
			                <ul class="sub-menu">
			                    <li class='subtitle' navId='25'><a href="${basePath}views/report/view/sheet/carInfomation.jsp?navId=25">车辆基本信息</a></li>
			                    <li class='subtitle' navId='26'><a href="${basePath}views/report/view/sheet/carMaintenanceCost.jsp?navId=26">车辆维修成本控制</a></li>
			                    <li class='subtitle' navId='24'><a href="${basePath}views/report/view/sheet/carPenaltyStatistics.jsp?navId=24">车辆罚款统计</a></li>
			                </ul>
			            </li>
			            <li class="nav1 parent-li">
			                <a href="#" class="parent-menu">
			                	<span class="span-icon"></span>理赔报表查询<i class="icon"></i>
			                </a>
			                <ul class="sub-menu">
			                    <li class='subtitle' navId='14'><a href="${basePath}claimDetail/claimDetail.do?navId=14">理赔占比明细表</a></li>
						        <li class='subtitle' navId='15'><a href="${basePath}views/report/view/sheet/operationClaimReport.jsp?navId=15">理赔报表统计</a></li>
						        <li class='subtitle' navId='20'><a href="${basePath}views/report/view/sheet/clientSeacher.jsp?navId=20">客户理赔对比</a></li>
						        <li class='subtitle' navId='21'><a href="${basePath}views/report/view/sheet/companySeacher.jsp?navId=21">公司理赔对比</a></li>
			                </ul>
			            </li>
			            <li class="nav4 parent-li">
			                <a href="#" class="parent-menu">
			                	<span class="span-icon2">
			                		<img src="${staticPath}images/logo-teo.png" id="img-teo"/>
			                	</span>
			                	财务管理<i class="icon"></i></a>
			                <ul class="sub-menu">
			                    <li class='subtitle' navId='16'><a href="${basePath}financial/findFinancial.do?navId=16">付款单查询</a></li>
			                    <li class='subtitle' navId='17'><a href="${basePath}financial/findCarrierIncome.do?navId=17">载体营业收入表</a></li>
			                    <li class='subtitle' navId='27'><a href="${basePath}views/report/view/sheet/grossStatistics.jsp?navId=27">分公司毛利统计表</a></li>
			                    <%-- <li class='subtitle' navId='28'><a href="${basePath}views/report/view/sheet/grossStatisticsDetail.jsp?navId=28">毛利详情</a></li> --%>
			                </ul>
			            </li>
			            <c:if test="${backuser.roottype == 2 }">
				            <li class="nav2 parent-li">
				                <a href="#" class="parent-menu"><span class="span-icon"></span>基础设置中心<i class="icon"></i></a>
				                <ul class="sub-menu">
				                    <li class='subtitle' navId='18'><a href="${basePath}targetManage/revenueList.do?navId=18">销售指标管理</a></li>
									<li class='subtitle' navId='19'><a href="${basePath}divisionManage/cognateCustList.do?pageSize=10&currPage=1&navId=19">事业部关联客户管理</a></li>
				                </ul>
				            </li>
			            </c:if>
			            <%-- <li class="nav1 parent-li">
			                <a href="#" class="parent-menu">
			                	<span class="span-icon2">
			                		<img src="${staticPath}images/logo-teo.png" id="img-teo"/>
			                	</span>
			                	BI测试页面<i class="icon"></i></a>
			                <ul class="sub-menu">
			                	<li class='subtitle' navId='22'><a href="${basePath}views/report/view/sheet/BI-test.jsp?pageSize=10&currPage=1&navId=22">BI理赔汇总</a></li>
			                    <!-- <li class='subtitle' navId='22'><a href="http://172.16.67.73:37799/WebReport/ReportServer?op=fr_bi&cmd=bi_init&id=121&createBy=-999&navId=22">BI理赔汇总</a></li> -->
			                </ul>
			            </li> --%>
			        </ul>
				</div>
