<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>异常上报</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/abnormal.css?times=<%=times%>"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/imgShowBig.css?times=<%=times%>" />
</head>

  <body ontouchstart style="background:#f8f8f8;">
        <input type="hidden" id="wayBillId" name="wayBillId" value="${wayBillId}"/>
	    <div class="weui-cells weui-cells_form upload">
	    	<div class="weui-cell txtarea">
		        <div class="weui-cell__bd">
		          <textarea id="abNormalInfo" name="abNormalInfo" class="weui-textarea" placeholder="请输入异常情况，500字以内"></textarea>
		        </div>
		    </div>
	    	
		    <div class="weui-cell">
		        <div class="weui-cell__bd">
		          <div class="weui-uploader">
		            <div class="weui-uploader__hd">
		              <p class="weui-uploader__title">上传异常照片(可不选)</p>
		            </div>
		            <div class="weui-uploader__bd">
		              <ul class="weui-uploader__files z_photo clearfix" id="uploaderFiles">
		                <li class="weui-uploader__input-box" id="uploaderInput">
			                <!-- <input id="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" multiple> -->
			            </li>
		              </ul>
		            </div>
		          </div>
		        </div>
		  	</div>
	    </div>
	    <div class='demos-content-padded'>
			<button id="exceptionUploadImage" class="weui-btn weui-btn_primary">确定上传</button>
		</div>
        <div id="popup">
    	    <div class="bg"><img src="" style="position:relative;transform-origin:center" id="targetObj"/></div>
	    </div>
	    <input name="shareId" id="shareId" type="hidden" value="${shareId}"/>
    
    
<script src="js/jquery-2.1.4.js"></script>
<script src="js/fastclick.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/touch.js" ></script>
<script type="text/javascript" src="<%=basePath%>plugin/touch.min.js" ></script>
<script>
	var appId = '${appId}'; // 必填，公众号的唯一标识
    var timestamp = '${timestamp}'; // 必填，生成签名的时间戳
    var nonceStr = '${nonceStr}'; // 必填，生成签名的随机串
    var signature = '${signature}';
    var basePath = '<%=basePath%>';
  $(function() {
    FastClick.attach(document.body);
    
    /*--------图片点击放大的js----------start*/
    var popup = document.getElementById("popup");
    popup.onclick = function (){
        popup.style.display = "none";
    }
    /*--------图片点击放大的js----------end*/
    
    /*--------图片缩放的js----------start*/
    var $targetObj = $('#targetObj');
    //初始化设置
    cat.touchjs.init($targetObj, function (left, top, scale, rotate) {
        $('#left').text(left);
        $('#top').text(top);
        $('#scale').text(scale);
        $('#rotate').text(rotate);
        $targetObj.css({
            left: left,
            top: top,
            'transform': 'scale(' + scale + ') rotate(' + rotate + 'deg)',
            '-webkit-transform': 'scale(' + scale + ') rotate(' + rotate + 'deg)'
        });
    });
    //初始化拖动手势（不需要就注释掉）
    cat.touchjs.drag($targetObj, function (left, top) {
        $('#left').text(left);
        $('#top').text(top);
    });
    //初始化缩放手势（不需要就注释掉）
    cat.touchjs.scale($targetObj, function (scale) {
        $('#scale').text(scale);
    });
    /*--------图片缩放的js----------end*/
  });
</script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script src="<%=basePath%>js/weixin.js?times=<%=times%>"></script>

</body>
</html>
    