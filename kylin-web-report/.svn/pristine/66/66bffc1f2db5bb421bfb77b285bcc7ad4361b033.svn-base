<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>分公司毛利率统计表</title>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery-1.11.1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="http://www.js-css.cn/jscode/jquery.min.js"></script>
		<script type="text/javascript" src="${staticPath}js/jquery.date_input.pack.js"></script>
		<!--[if lt IE 9]>
	      <script src="js/respond.min.js"></script>
	    <![endif]-->
	    <script type="text/javascript">
		      var basePath = "${basePath}";
		</script>
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
						<p>当前位置：<span>运营部报表</span>><i>分公司毛利统计表</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>分公司毛利统计表</h2>
						<div class="collect-form depart">
							<form action="">
								<label id="label-img">
									发运日期：<input type="text" class="collect-input" style="width: 130px;" value="2017-03-25" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
										}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<label id="label-img">
       &nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;<input type="text" class="collect-input" style="width: 130px;" value="2017-03-25" onfocus="if(value =='点击添入内容')
										{value=''
										}"onblur="
										if(value ==''){
											value='点击添入内容'
											}" />
										<img src="${staticPath}images/time-button.png" alt="" class="time-img" />
								</label>
								<span id="tong-j">
									 统计类型：
								</span>
					           <select name="" id="terrace">
					               <option value="合计">合计</option>
					               <option value="非实体" selected="selected">非实体</option>
					               <option value="平台">平台</option>
				                </select>
								<div class="btn">
									<input type="button" value="确定" class="btn-yes"/>
								</div>
								<div class="btn-dao">
									<input type="button" value="导出" id="import-one"/>
								</div>
							</form>
						</div>
					  <!--表格-->
						<table>
							<thead>
								<tr id="sheet-tr">
									<td colspan = "6" id="header-red">
						实体收入合计<span><b>￥89999.00</b></span>元，实体成本合计<span><b>￥567389.00</b></span>元，实体毛利合计<span><b>￥123456.00</b></span>元
									</td>
								</tr>
								<tr>
									<th width="15%">序号</th>
									<th width="35%">分公司名称</th>
									<th width="25%">实体收入</th>
									<th width="25%">实体成本</th>
									<th width="25%">实体毛利</th>
									<th width="25%">实体毛利率</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>重庆分公司</td>
									<td>20000.00</td>
									<td>20000.00</td>
									<td>20000.00</td>
									<td>20000.00</td>
								</tr>
							</tbody>
						</table>
			<!--分页-->
		<div id="paging">
			<p>共计：911525条 &nbsp;&nbsp;&nbsp;每页显示20条&nbsp;&nbsp;&nbsp;
			    <span id="list">
			    	<span>
			    	首页	<input type="button" value="&lt" />
                          <strong>0</strong>
                        <input type="button" value="&gt" />尾页   
			    	</span>			        
			    </span>         
			   到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;
			<button id="confim">确定</button>&nbsp;&nbsp;&nbsp;共计：9115页</p>
	    </div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>