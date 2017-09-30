<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html>
<html>
  <head>
    <%@include file="./resourceswx.jsp" %>
    <base href="<%=basePath%>">
    <title>上传回单</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
<link rel="stylesheet" href="<%=basePath%>weixinCss/uploadReceipt.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>css/imgShowBig.css?times=<%=times%>" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/uploadTaskForm.css?times=<%=times%>" />
</head>

  <body ontouchstart style="background:#f8f8f8;">
        <input type="hidden" id="wayBillId" name="wayBillId" value="${wayBillId}"/>
        <input type="hidden" id="abNormalInfo" />
        <div class="upload-task">
        	<form id="search_form" action="<%=basePath%>weixin/searchmoreLocationList.html" method="get">
				<div class="upload-task-title" id="uploadrecipt">
					<a class="up-task-check" href="javascript:void(0)" onclick="doSubmit()">点击选中需要上传回单的任务</a>
					<span class="up-task-icon" onclick="scanQRCodeupload();"></span>
				</div>
			</form>
			<!--选中回单后内容展示部分，用 hide 隐藏了，去掉hide即可-->
			<div class="upload-task-content" id="reciptBill">
				<div class="weui-flex">
					<div class="task-con-title">任务单号:</div>
					<div class="weui-flex__item" id="barcode">${barcode}</div>
				</div>
				<div class="weui-flex">
					<div class="task-con-title">送货单号:</div>
					<div class="weui-flex__item">${deliveryNumber}</div>
				</div>
				<div class="weui-flex">
					<div class="task-con-title">收货客户:</div>
					<div class="weui-flex__item one-line-hide">${companyName}</div>
				</div>
				<div class="weui-flex">
					<div class="task-con-title">收货地址:</div>
					<div class="weui-flex__item more-line-hide">${address}</div>
				</div>
				<div class="weui-flex">
					<div class="task-con-title">任务摘要:</div>
					<div class="weui-flex__item one-line-hide">${orderSummary}</div>
				</div>
				<p>发货时间：<span class="upload-task-time1">${bindtime}</span></p>
				<p>要求到货：<span class="upload-task-time2">${arrivaltimeStr}</span></p>
				<p>实际到货：<span class="upload-task-time2">${receiptstimeStr}</span></p>
				<span class="upload-task-close" onclick="uploadclose()">X</span>	
			</div>
		</div>
        
        <!-- <input name="file_item" type="file" accept="image/*" multiple>
        <input name="file_item" type="file" accept="image/*" multiple> -->
	    <div class="weui-cells weui-cells_form upload">
	      <div class="weui-cell">
	        <div class="weui-cell__bd">
	          <div class="weui-uploader">
	            <div class="weui-uploader__hd">
	              <p class="weui-uploader__title">添加回单照片</p>
	            </div>
	            <div class="weui-uploader__bd">
	              <ul class="weui-uploader__files z_photo clearfix" id="uploaderFiles">
	                <li class="weui-uploader__input-box" id="uploaderRecipt">
		                <!-- <input id="uploaderReciptInput" class="weui-uploader__input" type="file" accept="image/*" multiple> -->
		            </li>
	              </ul>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	    <div class='demos-content-padded'>
			<button id="receiptUploadImage" class="weui-btn weui-btn_primary" onclick="receiptImage()">确定上传</button>
		</div>
		<div id="popup">
    	    <div class="bg"><img src="" style="position:relative;transform-origin:center" id="targetObj"/></div>
	    </div>
	    <input name="shareId" id="shareId" type="hidden" value="${shareId}"/>
	    
	    <div class="img_tips">
			<p><b>范例：</b>回单照片端正居中，字体清晰可见</p>
			<img src="<%=basePath%>images/img-tip.png" alt="" />
		</div>
    
    
    
<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
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
  });
  
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
  
  var barcode="${barcode}"
  if(barcode!=""){
  	$("#uploadrecipt").hide();
  	$("#reciptBill").show();
  }else{
  	$("#uploadrecipt").show();
  	$("#reciptBill").hide();
  }
  
  function uploadclose(){
  	barcode='';
  	$("#uploadrecipt").show();
  	$("#reciptBill").hide();
  	$("#barcode").text('');
  }
  
  function doSubmit(){
	$('#search_form').submit();
  }
  var type='${type}';
  if(type!="" && type==1){
  	$(".upload-task-close").show();
  }else{
  	$(".upload-task-close").hide();
  }
  //=================校验=============start
	document.querySelector('#uploaderRecipt').onclick = function () {
  		if(barcode!="" && barcode!="null" && barcode!="undefined"){
		  	chooseImage();
		  }else{
			 $.toast("请选择任务单！","text");
		  	return;
		}
	}
	function receiptImage(){
		var barcode = $("#barcode").text();
		if(barcode!="" && barcode!="null" && barcode!="undefined"){
			receiptUploadImage();
		}else{
			$.toast("请选择任务单！","text");
		  	return;
		}
	}
	
	 //=================校验=============end
</script>
<script src="js/jquery-weui.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script src="<%=basePath%>js/weixin.js?times=<%=times%>"></script>
	<%@include file="/floor.jsp" %>
</body>
</html>
    