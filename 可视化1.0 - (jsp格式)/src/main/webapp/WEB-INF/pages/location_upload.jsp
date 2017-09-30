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
<link rel="stylesheet" href="<%=basePath%>weixinCss/mine.css?times=<%=times%>" />
</head>

  <body ontouchstart style="background-color: #f8f8f8;">

  <div class="weui-tab">
      <div class="weui-tab__bd">
		<div id="tab3" class="weui-tab__bd-item mine-part  weui-tab__bd-item--active">
        	<div class="mine-part-photo">
        		<img src="<%=basePath%>images/icon.png"/>
        	</div>
        	<div class="weui-panel">
		        <div class="weui-panel__bd">
		          <div class="weui-media-box weui-media-box_small-appmsg">
		            <div class="weui-cells">
		            	<div class="weui-cell weui-cell_access">
			                <div class="weui-cell__hd">任务单号</div>
			                <div class="weui-cell__bd weui-cell_primary text_right">
			                  <p id="waybillid" data-waybillId="${waybillid}">${barCode}</p>
			                 </div> 
		            	</div>
		            	<div class="weui-cell">
				            <div class="weui-cell__hd">任务单摘要</div>
							<div class="weui-cell__bd weui-cell_primary text_right">
			                  <p id ="orderSummary" data-uid="${userId}">${orderSummary}</p>
			                </div>
		            	</div>
		            	<div class="weui-cell">
			                <div class="weui-cell__hd">定位地址</div>
							<div class="weui-cell__bd weui-cell_primary text_right">
			                  <p id="address">普陀区真南路2339号</p>
			                </div>
		                </div>
		            </div>
		          </div>
		        </div>
		    </div>
		    <div class="weui-panel">
		        <div class="weui-panel__bd">
		          <div class="weui-media-box weui-media-box_small-appmsg">
		            <div class="weui-cells">
		                <div class="weui-cell__hd"></div>
		                <div class="weui-cell__bd weui-cell_primary">
		                  <p>确认按钮</p>
		                </div>
		            </div>
		          </div>
		        </div>
		    </div>
        </div>
    </div>

</div>

<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script>
  $(function() {
    FastClick.attach(document.body);
  });
</script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/picker.js" ></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript">
wx.config({
    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    appId:'${appId}', // 必填，公众号的唯一标识
    timestamp:'${timestamp}', // 必填，生成签名的时间戳
    nonceStr: '${nonceStr }', // 必填，生成签名的随机串
    signature:'${signature}',// 必填，签名，见附录1
    jsApiList: [
                'checkJsApi',
                'getNetworkType',
                'openLocation',
                'getLocation'
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
});
wx.ready(function () {
	wx.getLocation({
	    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
	        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	        var speed = res.speed; // 速度，以米/每秒计
	        var accuracy = res.accuracy; // 位置精度
	        $.toast(latitude+","+longitude,"text");
	    	}
		}); 
});
</script>
  </body>
</html>