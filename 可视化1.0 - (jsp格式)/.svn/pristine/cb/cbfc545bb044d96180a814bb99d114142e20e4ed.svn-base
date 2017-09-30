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
<html>
<head>
<%@include file="./resourceswx.jsp" %>
<title>修改收货客户</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
<link rel="stylesheet" href="<%=basePath%>weixinCss/addCustom.css?times=<%=times%>" />
</head>
<body ontouchstart style="background-color: #f8f8f8;">
<form id="editform" action="<%=basePath%>weixin/editCustom.html" method="post">
	<div class="weui-cells weui-cells_form margin-top">
		<input name="createtime" type="hidden" value="${customer.createtime }"/>
		<input name="userId" type="hidden" value="${customer.userId }"/>
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label"><span>*</span>项目组名</label>
			</div>
			<div class="weui-cell__bd">
				${group.groupName}
				<input id="groupid" name="groupid" type="hidden" value="${group.id}">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label"><span>*</span>收货客户</label>
			</div>
			<div class="weui-cell__bd">
			  <input class="weui-input" type="text" id="companyName" name="companyName" placeholder="请输入收货客户" value="${customer.companyName}">
			</div>
		</div>	
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label"><span>*</span>联系人</label>
			</div>
			<div class="weui-cell__bd">
			  <input class="weui-input" type="text" id="contacts" name="contacts" placeholder="请输入联系人姓名" value="${customer.contacts}">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label"><span>*</span>联系电话</label>
			</div>
			<div class="weui-cell__bd">
			  <input class="weui-input" type="tel" id="contactNumber" name="contactNumber" placeholder="请输入联系电话" value="${customer.contactNumber}">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label"><span></span>联系座机</label>
			</div>
			<div class="weui-cell__bd">
			  <input class="weui-input" type="tel" id="tel" name="tel" placeholder="请输入座机号码" value="${customer.tel}">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label"><span>*</span>收货地址</label>
			</div>
			<div class="weui-cell__bd">
			  <input class="weui-input" type="text" id="address" name="address" placeholder="请输入收货地址" value="${customer.address}">
			</div>
		</div>
		<div class="weui-cell project-bd">
			<div class="weui-cell__bd">
			 	发货后<select name="arriveDay" id="arriveDay">
			 			<option value="">请选择第几天</option>
							<option value="0">当天</option>
							<option value="1">第1天</option>
							<option value="2">第2天</option>
							<option value="3">第3天</option>
							<option value="4">第4天</option>
							<option value="5">第5天</option>
							<option value="6">第6天</option>
							<option value="7">第7天</option>
							<option value="8">第8天</option>
							<option value="9">第9天</option>
							<option value="10">第10天</option>
							<option value="11">第11天</option>
							<option value="12">第12天</option>
							<option value="13">第13天</option>
							<option value="14">第14天</option>
							<option value="15">第15天</option>
							<option value="16">第16天</option>
							<option value="17">第17天</option>
							<option value="18">第18天</option>
							<option value="19">第19天</option>
							<option value="20">第20天</option>
							<option value="21">第21天</option>
							<option value="22">第22天</option>
							<option value="23">第23天</option>
							<option value="24">第24天</option>
							<option value="25">第25天</option>
							<option value="26">第26天</option>
							<option value="27">第27天</option>
							<option value="28">第28天</option>
							<option value="29">第29天</option>
							<option value="30">第30天</option>
							<option value="31">第31天</option>
			 		</select>
			 		<select class="project-select" id="arriveHour" name="arriveHour">
			 			<option value="">请选择时间点</option>
							<option value="1">凌晨1点</option>
							<option value="2">2点</option>
							<option value="3">3点</option>
							<option value="4">4点</option>
							<option value="5">5点</option>
							<option value="6">6点</option>
							<option value="7">7点</option>
							<option value="8">8点</option>
							<option value="9">9点</option>
							<option value="10">10点</option>
							<option value="11">11点</option>
							<option value="12">12点</option>
							<option value="13">13点</option>
							<option value="14">14点</option>
							<option value="15">15点</option>
							<option value="16">16点</option>
							<option value="17">17点</option>
							<option value="18">18点</option>
							<option value="19">19点</option>
							<option value="20">20点</option>
							<option value="21">21点</option>
							<option value="22">22点</option>
							<option value="23">23点</option>
							<option value="24">24点</option>
			 		</select>之前
			</div>
		</div>
	</div>
	<p class="p_tips">带*为必填项</p>
	<div class='demos-content-padded'>
		<a href="javascript:;" id="showTooltips" class="weui-btn weui-btn_primary">确定</a>
	</div>
	<input name="bindCode" type="hidden" value="${bindCode}"/>
	<input name="id" type="hidden" value="${customer.id}"/>
</form>
<script src="<%=basePath%>js/jquery-2.1.4.js" ></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script>
	$("#arriveDay").val("${customer.arriveDay}");
	$("#arriveHour").val("${customer.arriveHour}");
	$("#showTooltips").click(function() {
        var groupid = $.trim($('#groupid').val());
        var companyName = $.trim($('#companyName').val());
        var contacts = $.trim($('#contacts').val());
        var contactNumber = $.trim($('#contactNumber').val());
        var address = $.trim($('#address').val());
        if(groupid.length == 0){
        	$.toptip('项目组名不能为空');
        	return;
        }
        if(companyName.length == 0){
        	$.toptip('收货客户不能为空');
        	return;
        }
        if(contacts.length == 0){
        	$.toptip('联系人不能为空');
        	return;
        }
        if(contactNumber.length == 0){
        	$.toptip('手机号码不能为空');
        	return;
        }else if(!/1[3|4|5|7|8]\d{9}$/.test(contactNumber)){
        	$.toptip('手机号码不正确');
        	return;
        }
		if(address.length == 0){
        	$.toptip('收货地址不能为空');
        	return;
        }
		/*if($("#arriveDay").val() == ""){
        	$.toptip('请选择第几天到货');
        	return;
        }
		if($("#arriveHour").val() == ""){
        	$.toptip('请选择时间点');
        	return;
        }*/
		$('#editform').submit();
    });
</script>
	
</body>
</html>