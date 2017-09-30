<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
			// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
			String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="./resourceswx.jsp"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>任务单管理</title>
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/reset.css" />
<link rel="stylesheet" href="<%=basePath%>css/layout.css" />
<link rel="stylesheet" href="<%=basePath%>css/page.css" />
<link rel="stylesheet"
	href="<%=basePath%>css/track.css?times=<%=times%>" />
<link rel="stylesheet"
	href="<%=basePath%>plugin/css/bootstrap-datetimepicker.css" />
<link rel="stylesheet"
	href="<%=basePath%>font-awesome/css/font-awesome.css" />
<link rel="stylesheet" href="<%=basePath%>plugin/css/BeAlert.css" />
<link rel="stylesheet" href="<%=basePath%>plugin/css/hcheckbox.css" />
</head>
<body>
	<div class="track-content">
		<form id="searchWaybillForm" action="<%=basePath%>MyAccountBook.html"
			method="post">
			<input type="hidden" id="pageNo_" name="pageNo" value=""> <input
				type="hidden" id="pageSize_" name="pageSize" value="">
			<div class="content-search">
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">任务单号:</label> <input type="text" id="wbarcode"
							class="tex_t" name="waybill.barcode.barcode"
							value="${waybill.barcode.barcode }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">送货单号:</label> <input type="text" id="deliveryNumber"
							class="tex_t" name="waybill.deliveryNumber"
							value="${waybill.deliveryNumber }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">收货客户:</label> <input type="text" id="companyName"
							class="tex_t" name="waybill.customer.companyName"
							value="${waybill.customer.companyName }">
					</div>
				</div>
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">项目组:</label> <select class="tex_t selec_t" id="groupid"
							name="waybill.groupid">
							<option value="">全部</option>
							<c:forEach items="${groups }" var="group">
								<option value="${ group.id}"
									<c:if test="${waybill.groupid == group.id }">selected</c:if>>${group.groupName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="fl col-min">
						<label class="labe_l">任务摘要:</label> <input type="text" id="orderSummary"
							class="tex_t" name="waybill.orderSummary"
							value="${waybill.orderSummary }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">状态:</label> <select class="tex_t selec_t" id="bindstatus"
							name="waybill.barcode.bindstatus">
							<option value="">全部</option>
							<option value="20"
								<c:if test="${'20' eq waybill.barcode.bindstatus}">selected</c:if>>已绑定</option>
							<option value="30"
								<c:if test="${'30' eq waybill.barcode.bindstatus}">selected</c:if>>运输中</option>
							<option value="40"
								<c:if test="${'40' eq waybill.barcode.bindstatus}">selected</c:if>>已到货</option>
						</select>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl col-min input-append date">
						<label class="labe_l">绑定时间:</label>
						<div class="input-append date" id="datetimeStart">
							<input type="text" class="tex_t z_index" readonly
								id="bindStartTime" name="waybill.bindStartTime"
								value="${waybill.bindStartTime }"> <span class="add-on">
								<i class="icon-th"></i>
							</span>
						</div>
					</div>
					<div class="fl col-min">
						<label class="labe_l">至</label>
						<div class="input-append date" id="datetimeEnd">
							<input type="text" class="tex_t z_index" readonly
								id="bindEndTime" name="waybill.bindEndTime"
								value="${waybill.bindEndTime }"> <span class="add-on">
								<i class="icon-th"></i>
							</span>
						</div>
					</div>
				</div>
				<div>
					<a href="javascript:;" class="content-search-btn"
						onclick="searchTrack(1)">查询</a>
				</div>
			</div>
		</form>
		<div class="content_btn">
			<a href="javascript:;" class="dowloadImage" onclick="modelToShow(2)">下载对账单</a>
		</div>
		<div class="table-style">
			<table class="dtable" id="trackTable">
				<thead>
					<tr>
						<th>任务单号</th>
						<th>送货单号</th>
						<th>任务摘要</th>
						<th>收货客户</th>
						<th>联系人</th>
						<th>联系电话</th>
						<th>收货地址</th>
						<th>要求到达时间</th>
						<th>绑定时间</th>
						<th>实际到货时间</th>
						<th>回单数量</th>
						<th>状态</th>
						<th>收入</th>
						<th>收入备注</th>
						<th>支出</th>
						<th>支出备注</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${page.list }" var="waybill">
						<tr>
							<td style="word-break:break-all"><a
								href="<%=basePath%>trace/findById.html?id=${waybill.id }">${waybill.barcode.barcode }</a>
							</td>
							<td>${waybill.deliveryNumber }</td>
							<td>${waybill.orderSummary }</td>
							<td>${waybill.customer.companyName }</td>
							<td>${waybill.customer.contacts }</td>
							<td>${waybill.customer.contactNumber}</td>
							<td>${waybill.customer.address }</td>
							<td>${waybill.arrivaltimeStr}</td>
							<td>${waybill.bindtime}</td>
							<td>${waybill.arriveTime}</td>
							<td>${waybill.receiptNumber }</td>
							<td><c:if test="${waybill.barcode.bindstatus==10 }">
		    			已分配
		    			</c:if> <c:if test="${waybill.barcode.bindstatus==20 }">
		    			已绑定
		    			</c:if> <c:if test="${waybill.barcode.bindstatus==30 }">
		    			运输中
		    			</c:if> <c:if test="${waybill.barcode.bindstatus==40 }">
		    			已到货
		    			</c:if></td>
							<td>${accountMap[waybill.id].income}</td>
							<td>${accountMap[waybill.id].incomeRemark}</td>
							<td>${accountMap[waybill.id].expenditure}</td>
							<td>${accountMap[waybill.id].expenditureRemark}</td>
							<td><a href="javascript:;"
								style="padding: 5px 5px;color: #fff;border-radius: 3px;
							background: #31acfa;font-size: 14px;"
								onclick="editAccount(${waybill.id})">记账</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${not empty page.list}">
				<div class="pages clearfix">
					<div class="pageCenter">
						<select id="pageSize" onchange="searchTrack(1)">
							<option value="10"
								<c:if test="${page.pageSize==10 }">selected</c:if>>10条/页</option>
							<option value="20"
								<c:if test="${page.pageSize==20 }">selected</c:if>>20条/页</option>
							<option value="50"
								<c:if test="${page.pageSize==50 }">selected</c:if>>50条/页</option>
						</select> <span class="page-sum">第${page.pageNum }/${page.pages }页(共${page.total }条)</span>
						<c:choose>
							<c:when test="${page.pageNum != 1}">
								<a href="javascript:;" onclick="searchTrack(1)">首页</a>
								<a href="javascript:;" onclick="searchTrack(${page.prePage })">上一页
								</a>
							</c:when>
							<c:otherwise>
								<span>首页</span>
								<span>上一页 </span>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.pageNum != page.pages}">
								<a href="javascript:;" onclick="searchTrack(${page.nextPage })">下一页</a>
								<a href="javascript:;" onclick="searchTrack(${page.pages })">末页</a>
							</c:when>
							<c:otherwise>
								<span>下一页</span>
								<span>末页 </span>
							</c:otherwise>
						</c:choose>
						<input id="jumpPageNo" type="text" class="enterNum"
							value="${page.pageNum }"> <a href="javascript:;"
							onclick="jump2Page()">跳转</a>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<!-- 编辑弹出框 -->
	<div class="model" id="model1">
		<div class="model-box">
			<span class="close" onclick="modelToClose(1)">x</span>
			<div class="model-head"></div>
			<div class="model-body" style="margin: 10px 50px;">
				<form id="addAccountFrom" action="<%=basePath%>trace/addAccountInfo.html" method="post">
					<input id="model_waybillid" name="waybillid" type="hidden"
						class="fr" value="">
					<div class="model-form">
						<label class="fl">收入 :</label> 
						<input class="textchange" id="income" name="income" type="number" min="0" max="999999.99" style="margin:0px 0px 0px 30px">
						<label style="width: 20px;" class="fr">元</label>
						
					</div>
					<br />
					<br />
					<div class="model-form" style="height:80px;">
						<label class="fl">收入备注 :</label>
						<textarea class="textchange" id="incomeRemark" name="incomeRemark"
							style="width:200px;border: 1px solid #ddd;border-radius: 3px;text-indent: 6px;margin:0px 0px 0px 30px;"
							rows="5" class="fl"></textarea>
					</div>
					<br />
					<div class="model-form">
						<label class="fl">支出 :</label> 
						<input class="textchange" id="expenditure" name="expenditure" type="number"  min="0" max="999999.99" style="margin:0px 0px 0px 30px">
						<label style="width: 20px;" class="fr">元</label>
					</div>
					<br />
					<div class="model-form" style="height:80px;">
						<label class="fl">支出备注 :</label>
						<textarea class="textchange" id="expenditureRemark" name="expenditureRemark"
							style="width:200px;border: 1px solid #ddd;border-radius: 3px;text-indent: 6px;margin:0px 0px 0px 30px;"
							rows="5" class="fl"></textarea>
					</div>
				</form>
			</div>
			<div class="model-foot">
				<button id="btn-save" class="btn-save" disabled="disabled" onclick="editAccountInfo()" style="background:#e1e5ed;color: #fff;padding: 6px 20px;border-radius: 3px;">保存</button>    
			</div>
		</div>
	</div>
	<div class="model" id="model2">
		<div class="model-box">
			<span class="close" onclick="modelToClose(2)">x</span>
			<div class="model-head"></div>
			<div class="model-body" style="margin: 10px 50px;">
				<form id="dowloadAccountFrom" action="<%=basePath%>trace/dowloadAccountFile.html" method="post">
					<div class="model-form">
						<input type="text" name="wbarcode" hidden="hidden">
						<input type="text" name="orderSummary" hidden="hidden">
						<input type="text" name="groupid"  hidden="hidden">
						<input type="text" name="companyName"  hidden="hidden">
						<input type="text" name="bindstatus"  hidden="hidden">
						<input type="text" name="bindStartTime"  hidden="hidden">
						<input type="text" name="bindEndTime"  hidden="hidden">
						<label class="fl">请选择账单的类型 :</label> <input id="incomeCheck"
							name="accountType" type="checkbox"
							style="width:15px;height:15px;" value="income">收入账单 <input
							id="expenditureCheck" name="accountType" type="checkbox"
							style="width:15px;height:15px;" value="expenditure">支出账单
					</div>
				</form>
			</div>
			<div class="model-foot">
				<a href="javascript:;" class="btn-save" onclick="dowloadFile()">下载</a>
			</div>
		</div>
	</div>
	<script src="<%=basePath%>js/jquery.min.js"></script>
	<script src="<%=basePath%>js/bootstrap.min.js"></script>
	<script src="<%=basePath%>js/nav.js"></script>
	<script src="<%=basePath%>plugin/js/bootstrap-datetimepicker.js"></script>
	<script src="<%=basePath%>plugin/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script src="<%=basePath%>plugin/js/BeAlert.js"></script>
	<script src="<%=basePath%>plugin/js/jquery-hcheckbox.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/baseweb.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/datetimepicker.js"></script>
	<script>
		var flag = true;
	    var income = '';
	    var incomeRemark = '';
	    var expenditure = '';
		var expenditureRemark = '';
		//搜索查询
		function searchTrack(pageNum) {
			$("#pageNo_").val(pageNum);
			var pageSize = $("#pageSize").val();
			$("#pageSize_").val(pageSize);
			$("#searchWaybillForm").submit();
		}
	
		function closeTipBox() {
			$('.BeAlert_box').hide();
			$('.BeAlert_overlay').hide();
		}
	
		$(function() {
			//复选框
			$('.dtable').hcheckbox();
			$('#myModal .wtable').hradio();
			//全选
			$('#checkAll').click(function() {
				$("input[name='checksingle']").prop('checked', this.checked);
			});
	
			$("input[name='checksingle']").click(function() {
				/*获取当前选中的个数，判断是否跟全部复选框的个数是否相等*/
				isall = $("input[name='checksingle']").length == $("input[name='checksingle']:checked").length;
				$('#checkAll').prop('checked', isall);
			});
		});
	
		//编辑账单
		function editAccount(id) {
			//先清空数据
			$("#income").val('');
			$("#incomeRemark").val('');
			$("#expenditure").val('');
			$("#expenditureRemark").val('');
			$.post('<%=basePath%>trace/findAccountByWayBillId.html', {
				id : id
			}, function(data) {
				$("#model_waybillid").val(id);
				if (data != null && data != '' && data != 'null') {
					//获取返回结果
					var result = eval('(' + data + ')');
					$("#income").val(result.income == undefined ? '' : result.income);
					$("#incomeRemark").val(result.incomeRemark == undefined ? '' : result.incomeRemark);
					$("#expenditure").val(result.expenditure == undefined ? '' : result.expenditure);
					$("#expenditureRemark").val(result.expenditureRemark == undefined ? '' : result.expenditureRemark);
			        income = $("#income").val();
			        incomeRemark = $("#incomeRemark").val();
			        expenditure = $("#expenditure").val();
					expenditureRemark = $("#expenditureRemark").val();
				}
				modelToShow(1);
			}, 'json');
		}
		
        $('.textchange').bind('input propertychange', function() { 
            var incomeText = $('#income').val();
            var incomeRemarkText = $('#incomeRemark').val();
            var expenditureText = $('#expenditure').val();
            var expenditureRemarkText = $('#expenditureRemark').val();
            if(incomeText !== income){
                flag = false;
            }
            else if(incomeRemarkText !== incomeRemark){
                flag = false;
            }
            else if(expenditureText !== expenditure){
                flag = false;
            }
            else if(expenditureRemarkText !== expenditureRemark){
                flag = false;
            }else{
                flag = true;
            }
            console.log('flag' + flag);
            if(!flag){
                $('#btn-save').css({
                    background:'#31acfa'
                })
                $("#btn-save").removeAttr("disabled");
            }else{
                $('#btn-save').css({
                    background:'#e1e5ed'
                })
                $("#btn-save").attr({"disabled":"disabled"});
            }
        });
		
		
		function editAccountInfo() {
			
			var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,2}$");
			/*if ($("#expenditure").val() == '' && $("#income").val() == '' && $("#expenditure").val() == '' && $("#expenditureRemark").val() == '') {
			
				return;
			}
			 else if ($("#expenditure").val() == null || $("#expenditure").val() == '') {
				EFTP.alert("支出请输入正确数字！");
				return;
			} else 
			if ($("#income").val() != '' && !reg.test($("#income").val())) {
				EFTP.alert("收入请输入正确数字(允许整数或保留两位小数)!");
				return;
			} else if ($("#expenditure").val() != '' && !reg.test($("#expenditure").val())) {
				EFTP.alert("支出请输入正确数字(允许整数或保留两位小数)!");
				return;
			}else */
			if($("#income").val()>999999.99){
				EFTP.alert("收入金额不能大于999999.99元!");
				return;
			}else if($("#expenditure").val()>999999.99){
				EFTP.alert("支出金额不能大于999999.99元!");
				return;
			}
			$("#addAccountFrom").submit();
		}
	
		//对账单下载
		function dowloadFile() {
			var count = $("input[name='accountType']:checked").length;
			if (count == 0) {
				EFTP.alert("请勾选需下载对账单的类型！");
				return;
			} 
			$("#dowloadAccountFrom").submit();
		}
	
		//页面跳转
		function jump2Page() {
			var pageNo = $("#jumpPageNo").val();
			searchTrack(pageNo);
		}
	
		function modelToClose(type) {
			if (type == 1) {
				$('#model1').css('display', 'none');
			} else {
				$('#model2').css('display', 'none');
			}
		}
		function modelToShow(type) {
			if (type == 1) {
				$('#model1').css('display', 'block');
			} else {
				$(":input[name='wbarcode']").val($("#wbarcode").val());
				$(":input[name='orderSummary']").val($("#orderSummary").val());
				$(":input[name='groupid']").val($("#groupid").val());
				$(":input[name='companyName']").val($("#companyName").val());
				$(":input[name='bindstatus']").val($("#bindstatus").val());
				$(":input[name='bindStartTime']").val($("#bindStartTime").val());
				$(":input[name='bindEndTime']").val($("#bindEndTime").val());
				$('#model2').css('display', 'block');
			}
		}
	</script>

</body>
</html>