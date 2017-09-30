<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<base href="<%=basePath%>">
<title>任务单号绑定</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>weixinCss/weui.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>weixinCss/jquery-weui.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>weixinCss/demos.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.4.js"></script>
<link rel="stylesheet" href="<%=basePath%>weixinCss/barCodeAfter.css?times=<%=times%>" />
</head>
<body ontouchstart style="background-color: #f8f8f8;">

	<form id="form" action="<%=basePath%>weixin/addBarCode.html"
		method="post">
		<div data-error="${error }" class="weui-cells weui-cells_form margin-top">
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">任务单号</label>
				</div>
				<div class="weui-cell__bd">
					<c:choose>
						<c:when test="${bindCode!=''}">
							<input class="weui-input" readonly="readonly" id="barcode" value="${bindCode}"
								name="barcode" type="tel" placeholder="请输入任务单号" />
						</c:when>
						<c:otherwise>
							<input class="weui-input" id="barcode" type="tel" name="barcode"
								placeholder="请输入任务单号">
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<!--收货客户部分-->
			<div class="about_custom">
				<a class="weui-cell weui-cell_access cell_link" onclick="toListPage()">
		            <div class="weui-cell__hd">
		              <p>收货客户</p>
		            </div>
		            <div class="weui-cell__bd">
		                <c:if test="${customer==null}">
					  	           请选择收货客户
					  	</c:if>
					  	<c:if test="${customer!=null and customer.id!=null}">
					  	   ${customer.companyName}
					  	</c:if>
					</div>
		            <div class="weui-cell__ft">
		            </div>
		        </a> 
		        <!--收货客户数据-->
		        <c:if test="${customer!=null and customer.id!=null}">
		            <input name="customerid" type="hidden" value="${customer.id}"/>
			        <div class="show_custom">
			        	<div class="weui-flex">
					    	<div class="d_left">项目组名 :</div>
					    	<div class="weui-flex__item d_right">${group.groupName}</div>
					    </div>
					    <div class="weui-flex">
					    	<div class="d_left">收货客户 :</div>
					    	<div class="weui-flex__item d_right">${customer.companyName}</div>
					    </div>
					    <div class="weui-flex">
					    	<div class="d_left">联系人 :</div>
					    	<div class="weui-flex__item d_right">${customer.contacts}</div>
					    </div>
					    <div class="weui-flex">
					    	<div class="d_left">联系电话 :</div>
					    	<div class="weui-flex__item d_right">${customer.contactNumber}</div>
					    </div>
					    <c:if test="${customer.tel!=null}">
						    <div class="weui-flex">
						      	<div class="d_left">座机:</div>
						      	<div class="weui-flex__item d_right">${customer.tel}</div>
						    </div>
					    </c:if>
					    <div class="weui-flex">
					    	<div class="d_left">收货地址 :</div>
					    	<div class="weui-flex__item d_right">${customer.address}</div>
					    </div>
			        </div>
		        </c:if>      
			</div>
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">送货单号 :</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" id="deliveryNumber" value="" name="deliveryNumber" type="text" placeholder="请输入送货单号" />
				</div>
			</div>
			<div class="weui-cell unit-weight">
				<div class="weui-cell__hd">
					<label class="weui-label">重量 :</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" id="weight" value="" name="weight" type="tel" placeholder="请输入重量" />
				</div>
			</div>
			<div class="weui-cell unit-vol">
				<div class="weui-cell__hd">
					<label class="weui-label">体积 :</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" id="volume" value="" name="volume" type="tel" placeholder="请输入体积" />
				</div>
			</div>
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">数量 :</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" id="number" value="" name="number" type="tel" placeholder="请输入数量" />
				</div>
			</div>
			<!-- 订单摘要 -->
			<div class="weui-cell align">
				<div class="weui-cell__hd">
					<label class="weui-label">订单摘要</label>
				</div>
				<div class="weui-cell__bd">
					<textarea class="weui-textarea" name="orderSummary" id="textarea"
						placeholder="请输入订单摘要" rows="4"></textarea>
					<div class="weui-textarea-counter">
						<span id='count'>0</span>/<span id='count_max'>200</span>
					</div>
				</div>
			</div>
			<!-- 要求到货时间 -->
			<!-- <div class="weui-cell no-left">
		        <div class="weui-cell__hd"><label for="time-inline" class="weui-label">要求到货时间</label></div>
		        <div class="weui-cell__bd">
		          <input name="arrivaltimeStr" class="weui-input" id="time-inline" type="text" value="">
		        </div>
		    </div> -->
		</div>
		<div class='demos-content-padded'>
			<a href="javascript:;" id="showTooltips" onclick="add()"
				class="weui-btn weui-btn_primary">确定</a>
		</div>
		<input type="hidden" id="latitude" name="latitude"/>
		<input type="hidden" id="longitude" name="longitude"/>
		<input type="hidden" id="locations" name="locations"/>
	</form>
	<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath%>js/fastclick.js"></script>
	<script src="<%=basePath%>js/jquery-weui.js"></script>
	<script src="<%=basePath%>js/home.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
	<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/coordtransform-master/index.js" ></script>
	<!-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=9ZQIqbGfMnbch4DLAMGk98YwIRgruIpi"></script> -->
	<script>
		var scan_flag = $.trim($("#barcode").val()) != "" ? true : false ;//用来判断是
		$(function() {
			var max = $('#count_max').text();
			$('#textarea')
					.on(
							'input',
							function() {
								var text = $(this).val();
								var len = text.length;
								$('#count').text(len);
								if (len >= max) {
									this.value = this.value.substr(0, max);
									$(this).closest('.weui-cell__bd').addClass(
											'color-danger');
									$(".weui-textarea-counter").css('color',
											'#f6383a');
									$('#count').text(max);
								} else {
									$(this).closest('.weui-cell__bd')
											.removeClass('color-danger');
									$(".weui-textarea-counter").css('color',
											'#B2B2B2');
								}
						});
		})
		
		wx.config({
		    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端$.toast出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		    appId:'${appId}', // 必填，公众号的唯一标识
		    timestamp:'${timestamp}', // 必填，生成签名的时间戳
		    nonceStr: '${nonceStr }', // 必填，生成签名的随机串
		    signature:'${signature}',// 必填，签名，见附录1
		    jsApiList: [
		                'checkJsApi',
		                'scanQRCode',
		                'getNetworkType',
		                'openLocation',
		                'getLocation'
		                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	   });
		
		function add() {
			/* var arrivaltime = $("#time-inline").val(); */
			var v = $("#textarea").val();
			var barcode = $.trim($("#barcode").val());
			if (v != "" && v.length > 200) {
				$.toptip("任务摘要长度不能大于200");                                                                                                                                                                            
				return;
			}
			if (barcode == '') {
				$.toptip("任务单号不能为空");
				return;
			}
			if (isNaN($("#weight").val()) || $("#weight").val().length > 8) {
				$.toptip("重量应为数字或小数且长度不能大于8位");
				return;
			}
			if (isNaN($("#volume").val()) || $("#volume").val().length > 8) {
				$.toptip("体积应为数字或小数且长度不能大于8位");
				return;
			}
			if (isNaN($("#number").val()) || $("#number").val().length > 8) {
				$.toptip("数量应为数字且长度不能大于8位");
				return;
			}
			var str=$('#deliveryNumber').val().trim();
			if (str == '') {
				$.toptip("送货单号不能为空");
				return;
			}
			var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
			if(reg.test(str)){
				$.toptip("送货单号不能包含汉字！");
				return;
			}   
			var re =/[`~!@#$%^&*_+<>{}\/'[\]]/im;
			if (re.test(str) || str.length > 30)
			{
				$.toptip("送货单号应为数字加英文，且长度不能大于30");
			    return;
			}
			if(scan_flag){
				position();
			}else{
				ajaxPost(barcode);
			}		
		} 
		
		showCustom();
		/* 收货客户样式 */
		function showCustom(){
			var len = $('.show_custom').children().length;
			if(len > 0){
				$('.cell_link').addClass('add_after');
			}else{
				$('.cell_link').removeClass('add_after');
			}
		}
		
		function barcodeVerify(){
			var barcode = $.trim($("#barcode").val());
			if(barcode != ''){
				
		  }
	   }
		
		function toListPage(){
			var barcode = $.trim($("#barcode").val());
			if (barcode != '') {
				$.ajax({
					type : 'POST',
					async: false,  
					url : "<%=basePath%>weixin/barcodeVerifyAjax.html?barcode="+ barcode,
					success : function(data) {
						if (data == "200") {
							window.location.href="<%=basePath%>weixin/customerList.html?bindCode="+barcode
						}
						if (data == "400"|| data == "202") {
							$.toast("该任务单号已被绑定","forbidden");
						}
						if (data == "500") {
							$.toast("无效的任务单号","forbidden");
						}
						if (data == "9999") {
							$.toast("系统错误","forbidden");
						}
						if (data == "405") {
							$.toast("权限不足","forbidden");
						}
					}
			    });
			}else{
				$.toptip("请先输入任务单号");
			}
		}
		
		//获取当前坐标 并提交
		function position(){
			 wx.getLocation({
			    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
			    success: function (res) {
			        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
			        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
			        var speed = res.speed; // 速度，以米/每秒计
			        var accuracy = res.accuracy; // 位置精度 
			        
			        //wgs84转国测局坐标
			        var wgs84togcj02 = coordtransform.wgs84togcj02(longitude, latitude);
			        wgs84togcj02 = wgs84togcj02+"";
			        wgs84togcj02 = wgs84togcj02.split(",");
			        longitude=wgs84togcj02[0];
			        latitude=wgs84togcj02[1];
			    	
			        $("#latitude").val(latitude);
			        $("#longitude").val(longitude);
			    	// 创建地理编码实例     
			    	var geocoder = new qq.maps.Geocoder({
			            complete : function(result){
			            	$("#locations").val(result.detail.address);
   							$("#form").submit();
			            	$.toast("绑定成功！");
			            }
			        });
			    	//获取经纬度数值   按照,分割字符串 取出前两位 解析成浮点数
			        var lng = parseFloat(longitude);
			        var lat = parseFloat(latitude);
			        var latLng = new qq.maps.LatLng(lat, lng);
			        // 根据坐标得到地址描述   
			        geocoder.getAddress(latLng);
			    }
			});
		}
		//异步请求条码
		function ajaxPost(barcode){
			$.ajax({
				type : 'POST',
				async: false,  
				url : "<%=basePath%>weixin/barcodeVerifyAjax.html?barcode="+ barcode,
				success : function(data) {
					if (data == "200") {
						position();
					}
					if (data == "400"||data == "202") {
						$.toast("该任务单号已被绑定","forbidden");
					}
					if (data == "500") {
						$.toast("无效的任务单号","forbidden");
					}
					if (data == "9999") {
						$.toast("系统错误","forbidden");
					}
					if (data == "405") {
						$.toast("权限不足","forbidden");
					}
				}
		    });
		}
		//错误提示
		$(function() {
			var error = $(".weui-cells").attr("data-error");
			if(null != error && "" != error){
				$.toast(error,"forbidden")
			}
		})
	</script>

</body>
</html>