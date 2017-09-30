<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>事业部关联客户管理</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/eject.css" />
		<link rel="stylesheet" href="${staticPath}css/popup.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<link rel="stylesheet" href="${staticPath}css/findCompanData.css">
		<link rel="stylesheet" href="${staticPath}css/Maori_statistics.css"/>
		<script type="text/javascript" src="${staticPath}js/jquery-1.11.1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/sheet/divisionManage.js" ></script>
		<!--[if lt IE 9]>
	      <script src="${staticPath}js/sheet/respond.min.js"></script>
	    <![endif]-->
		<script type="text/javascript">
		      var basePath = "${basePath}";
		</script>
	</head>
	<body>
		<div class="wrap">
			<div id="navigation">
				<h1>远成物流</h1>
			    <jsp:include page="../menu/nav.jsp"/>
			</div>
			<div id="content">
				<div class="con-title">
					<div class="fl">
						<p>当前位置：<span>营业数据管理</span>><i>事业部关联客户管理</i></p>
					</div>
					<div class="fr">
						<span class="admin"><a href=''>退出</a></span>
					</div>
				</div>
				<div class="con-main">
					<div class="part part-collect">
						<h2>事业部关联客户管理</h2>
						<div class="collect-form depart">
							<form action="">
								<label>
									客户名称：<input name="customerName" id="customerName" type="text" class="collect-input" />
								</label>
								<label>
									事业部名称：<input name="bindDivision" id="bindDivision" type="text" class="collect-input" />
								</label>
								<label>
									客户类型：<select class="customerType" id="customerType">
												<option value="" name="customerType" id="customerType">全部</option>
												<option value="platform">平台</option>
												<option value="not_platform">非平台</option>
										   </select>
								</label>
								<div class="btn">
									<input type="button" value="搜索" onclick="searchdivis(1)" />
								</div>
								<div class="btn special">
									<input type="button" value="添加" class="depart-add" />
									<input type="button" value="导入" class="import" />
									<!--<input type="button" value="编辑" class="refresh" />-->
								</div>
							</form>
						</div>
						<table id="bctList">
							<c:if test="${not empty page.list}">
								<thead>
									<tr>
										<th width="10%">序号</th>
										<th width="13%">事业部</th>
										<th width="27%">客户名称</th>
										<th width="10%">客户类别</th>
										<th width="15%">客户代码</th>
										<th width="15%">客户所属分公司</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="bct" items="${page.list}" varStatus="status">
										<tr>
											<td>${status.index+1}</td>
											<td>
												<form action="${basePath}divisionManage/findDivision.do" id="from${status.index }" method="post">
													<input type="hidden" name="bindDivision" value="${bct.bindDivision}"/>
												</form>
												<a href="#" onclick="finddivis(${status.index });">${bct.bindDivision}</a>
											</td>
											<td>${bct.customerName}</td>
											<c:if test="${bct.customerType == 'not_platform'}">
												<td>非平台</td>
											</c:if>
											<c:if test="${bct.customerType == 'platform'}">
												<td>平台</td>
											</c:if>
											<td>${bct.clientCode}</td>
											<td>${bct.computerName}</td>
											</tr>
										</c:forEach>
								</tbody>
							</c:if>
							<c:if test="${empty page.list}">
								<c:if test="${not empty mas}">
									<tr>
										<td>${mas}</td>
									</tr>
								</c:if>
							</c:if>
						</table>
						<!--分页-->
						<div id="paging">
							<p>共计：${page.totalRecords }条 &nbsp;&nbsp;&nbsp;每页显示
							<select name="" id="kuang" class="kuang" onchange="searchdivis(${page.pageNo })">
								<option value="10">10</option>
								<option value="20">20</option>
								<option value="30">30</option>
							</select>条&nbsp;&nbsp;&nbsp;
							    <span id="list">
							    	<span>
								    	<a onclick="searchdivis(1);" class="pointer">首页</a>
								    	<input class="pointer" type="button" value="&lt" onclick="searchdivis(${page.previousPageNo });"/>
					                    <strong>当前页为：${page.pageNo }</strong>
					                    <input class="pointer" type="button" value="&gt" onclick="searchdivis(${page.nextPageNo });" />
					                    <a class="pointer" onclick="searchdivis(${page.totalPages })">末页</a>   
							    	</span>			        
							    </span>         
							   到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;
							<button id="confim" onclick="searchdivis(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：${page.totalPages }页</p>
					    </div>
					</div>
				</div>
				<!--弹出框-->
			    <div id="base2">
			    	<div id="pop-big">
			    		<p id="title-b">新建事业部</p>
			    		<div id="radius-b" class="pointer">
			    			<b>&times;</b>
			    		</div>
			    		<ul id="big-content">
			    			<li id="bottom-b">
			    				<input type="button" id="button-b" value="添加" onclick="addDivisionManage();"/>
			    			</li>
			    			<li id="urname">
			    				<b id="b-b">事业部名称：</b><input type="text" id="text-name" value="" placeholder="请输入事业部名称"/>
			    			</li> 
			    			<br />
			    			<li>
			    				<b id="code-b">客户编码（多个客户编码请用英文逗号隔开）</b>
			    			</li>
			    			<li id="code-c">
			    				<textarea name="bianma" id="inquiry" cols="">
							    </textarea> <br />
							    <div id="result-text">
							    	<span id="diviHasExist"></span>
							    	<span id="customerNotExist"></span>
							    	<span id="hasOtherExistRef"></span>
							    </div>
			    			</li>
			    		</ul>
			    	</div>
    			</div>
			    <div id="base3">
			    	<div id="pop-small">
			    		<p id="title-s">导入平台客户</p>
			    		<div id="radius-s" class="pointer">
			    			<b>&times;</b>
			    		</div>
			    		<ul id="small-content">
			    			<li id="bottom-s">
			    				<input type="button" id="button-s" onclick="leading();" value="确认" />
			    			</li>
			    			<li id="look-s">
			    				<form id="model-lo" action="${staticPath}divisionManage/model.do?type=1" method="post"></form>
				    			<b>请先下载模板：<span id="blue-s" onclick="downmodel();" class="pointer">平台客户导入模板.excel</span>&nbsp;填写内容后进行上传</b>
				    			<b id="red-s">注：导入条数不得超过2000条</b>
			    			</li> <br />
			    			<li>
			    				<b id="upload">上传文件：</b> 
			    				<br />
			    				<form action="">
			    					<input type="file" id="text-b" type="" value="" placeholder="济南邮区中心"/>
			    					<!--<b id="liu-b">浏览</b></p> -->
			    					<!--<input type="text" name="" id="pic" value="浏览" />-->
			    				</form>   				  				
    						</li>
			    		</ul>
			    	</div>
			    </div>
				<!-- 导入计划显示框 
				<div class="modal fade in" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="false">
					<div class="windows-win" id="windows-win">
						<form id="departAndCustomLeading" enctype="multipart/form-data">
							<div class="modal-header">
								<span class="modal-title">导入事业部关联客户</span>
							</div>
							<div class="modal-body">
								<table style="margin-left: 120px; height: 150px;">
									<tr>
										<td style="color: #999999; font-family: 微软雅黑, 宋体;">选择文件：</td>
										<td><input style="width: 200px;" type="file"
											id="leadingFile" name="file"></td>
									</tr>
								</table>
							</div>
							<div class="modal-footer" style="text-align: center;">
								<button type="button" class="button3" data-dismiss="modal" onclick="leading()">确定</button>
								<button type="reset" class="button0" data-dismiss="modal">取消</button>
							</div>
						</form>
					</div>
				</div>-->
			</div>
		</div>
	</body>
</html>