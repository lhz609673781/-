<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<title>上报位置</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=a4e0b28c9ca0d166b8872fc3823dbb8a"></script>
<style>
   .weui-cell{
   	    -webkit-align-items: flex-start;
    	align-items: flex-start;
   }
   .weui-panel:before{border-top:none;}
   .weui-panel__hd{font-size:17px;color:#000;}
    .weui-cell__bd>p{
    	color: #999999;
    	font-size: 16px;
    	line-height: 1.2;
    	padding-left:15px;
    }
    .weui-cell.weui-cell_access{
    	padding:15px;
    }
</style>
</head>

<body ontouchstart style="background-color: #f8f8f8;">
	<div class="weui-panel">
		<div data-latitude="" data-longitude="" class="weui-panel__hd">定位信息</div>
	    <div class="weui-panel__bd">
	      <div class="weui-media-box weui-media-box_small-appmsg">
	        <div class="weui-cells">
	          <div class="weui-cell weui-cell_access">
	            <div class="weui-cell__hd">条 码</div>
	            <div class="weui-cell__bd weui-cell_primary text_right">
	              <p id="barCode" data-waybillId="${waybillid}" data-barcode="${barCode}">${barCode}</p>
	            </div>
	          </div>
	          <div class="weui-cell weui-cell_access">
	            <div class="weui-cell__hd">摘 要</div>
				<div class="weui-cell__bd weui-cell_primary text_right">
	              <p id ="orderSummary" data-uId="${userId}">${orderSummary}</p>
	           </div>
	          </div>
	          <div class="weui-cell weui-cell_access">
	            <div class="weui-cell__hd">地 址</div>
				<div class="weui-cell__bd weui-cell_primary text_right">
	              <p id="address"><img src="<%=basePath%>images/loading.gif" style="display:block;float: left"/>
	              	<span style="display:block;float: left;margin-top:8px;margin-left:10px;">定位中，请稍后...</span></p>
	           </div>
	          </div>
	        </div>
	      </div>
	    </div>
	</div>
    <div class='demos-content-padded'>
		<a href="javascript:void(0);" onclick="uploadPosition()" id="showTooltips" class="weui-btn weui-btn_primary">确定</a>
	</div>

<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/picker.js" ></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/coordtransform-master/index.js" ></script>
<script type="text/javascript">
wx.config({
    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    appId:'${appId}', // 必填，公众号的唯一标识
    timestamp:'${timestamp}', // 必填，生成签名的时间戳
    nonceStr: '${nonceStr }', // 必填，生成签名的随机串
    signature:'${signature}',// 必填，签名，见附录1
    jsApiList: [
                'checkJsApi',
                'scanQRCode',
                'chooseImage',
                'previewImage',
                'uploadImage',
                'downloadImage',
                'getNetworkType',
                'openLocation',
                'getLocation',
                'onMenuShareTimeline',
                'onMenuShareAppMessage'
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
}); 

wx.ready(function() {
    wx.getLocation({
	    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
		        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
		        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
		        var speed = res.speed; // 速度，以米/每秒计
		        var accuracy = res.accuracy; // 位置精度
	        	geocoder(latitude,longitude);
	    	}
		});  
});//end_ready

//反向地理编码
function geocoder(latitude, longitude) {
    var wgs84togcj02 = coordtransform.wgs84togcj02(longitude, latitude);
    wgs84togcj02 = wgs84togcj02+"";
    wgs84togcj02 = wgs84togcj02.split(",");
    longitude=wgs84togcj02[0];
    latitude=wgs84togcj02[1];
    $('.weui-panel__hd').attr('data-latitude',latitude);
    $('.weui-panel__hd').attr('data-longitude',longitude);
	 AMap.service('AMap.Geocoder',function(){//回调函数
	        //逆地理编码
			var lnglatXY=[longitude, latitude];//地图上所标点的坐标
			var geocoder = new AMap.Geocoder();
			geocoder.getAddress(lnglatXY, function(status, result) {
			    if (status === 'complete' && result.info === 'OK') {
			       //获得了有效的地址信息:
			       $('#address').text(result.regeocode.formattedAddress+"("+result.regeocode.addressComponent.district+result.regeocode.addressComponent.township+result.regeocode.addressComponent.street+result.regeocode.addressComponent.streetNumber+")");
			    }else{
			       //获取地址失败
			      $.toast("获取地址失败",'cancel');
			    }
			});  
		});
}	
//扫描上传位置
function uploadPosition() {
	var url = '<%=basePath%>weixin/uploadPosition.html';
	var address = $('#address').text();
	var map = {};
	map['barCode'] = $('#barCode').attr('data-barcode');
	map['waybillid'] = $('#barCode').attr('data-waybillId');
	map['userid'] = $('#orderSummary').attr('data-uId');
	map['latitude']=$('.weui-panel__hd').attr('data-latitude');
	map['longitude']=$('.weui-panel__hd').attr('data-longitude');
	map['locations']=$('#address').text();
	
	if(address.indexOf('定位中，请稍后...')>=0){
		$.toptip("定位地址不能为空", 'error');
		return;
	}
	
	console.log(JSON.stringify(map));
	$
			.ajax({
				url : url, // 请求的url地址
				timeout : 5000,
				dataType : "json",
				data : "param=" + JSON.stringify(map), // 参数值
				type : "POST", // 请求方式
				success : function(data) {
					// 请求成功时处理
					if (data.resultCode == 200) {
						$.toptip(data.reason, 'success');
						window.location.href = '<%=basePath%>weixin/myTask.html';
						} else {
							// 注册失败提示
							$.toptip(data.reason, 'error');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						$.toptip("网络异常，请求失败！");
					}
				});
	}
</script>
</body>
</html>


