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
<title>定位失败</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/demos.css"/>
<link rel="stylesheet" href="<%=basePath %>weixinCss/locationErr.css" />
</head>
<body ontouchstart style="background-color: #fafafa;">
	<div class="err_con">
		<img src="<%=basePath %>images/location_err.png" alt="" />
		<p>定位失败，请检查GPS是否开启！</p>
		<a href="javascript:;" class="swap">请重新扫码</a>
	</div>
	
<script src="<%=basePath %>js/jquery-2.1.4.js" ></script>
<script src="<%=basePath %>js/jquery-weui.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript">
wx.config({
    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    appId:'${appId}', // 必填，公众号的唯一标识
    timestamp:'${timestamp}', // 必填，生成签名的时间戳
    nonceStr: '${nonceStr }', // 必填，生成签名的随机串
    signature:'${signature}',// 必填，签名，见附录1
    jsApiList: [
				'checkJsApi',
                'scanQRCode'
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
}); 
$('.swap').click(function() {  
    wx.scanQRCode({  
	     needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，  
	     scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有  
	     success : function(res) { 
	     	 var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果  
		     //document.getElementById("wm_id").value = result;//将扫描的结果赋予到jsp对应值上  
		     //var res = result.split('=');
		     if(result.indexOf('weixin')>=0){
			    location.href=result;
	         }else{
	         	$.toptip('无效条码');
	         }
	     }  
   });  
})
</script>
</body>
</html>