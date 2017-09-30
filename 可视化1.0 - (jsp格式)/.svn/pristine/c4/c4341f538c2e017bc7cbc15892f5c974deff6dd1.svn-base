<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/waybillDetailNew.css?time=<%=times %>" />
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=a4e0b28c9ca0d166b8872fc3823dbb8a"></script>
</head>
<body ontouchstart style="background-color: #fafafa;">
	<!--定位+扫码提示-->
	<div class="weui-flex head-tips head-location-success">
      <div class="success-tip">恭喜您！扫码成功</div>
      <div id="address" data-latitude="" data-longitude="" class="weui-flex__item location-tip"><span  class="loc-icon"></span></div>
    </div>
	<!--扫二维码图片-->
	<c:if test="${subscribe == 0}">
		<div class="public_wechat">
			<img src="<%=basePath%>images/public_img.png" alt="" />
		</div>
	</c:if>
	<!--任务详情-->
	<div class="bill-detail-con">
		<div class="weui-flex detail-con-title">
	      <div class="txt_left" onclick="goBillDetail(${waybill.id},${waybill.barcode.bindstatus})"><span>任务详情</span></div>
	      <div class="weui-flex__item"><a href="javascript:;" onclick="toMoreList()">查看其它任务</a></div>
	    </div>
	    <div class="weui-flex">
	      <div class="txt_left">任务单号：</div>
	      <div id="barCode" data-waybillId="${waybill.id}" data-barcode="${waybill.barcode.barcode}" class="weui-flex__item txt_right">${waybill.barcode.barcode}</div>
	    </div>
	    <div class="weui-flex">
	      <div class="txt_left">收货客户：</div>
	      <div class="weui-flex__item txt_right">${waybill.customer.companyName}</div>
	    </div>
	    <div class="weui-flex">
	      <div class="txt_left add_space">联系人：</div>
	      <div class="weui-flex__item txt_right">${waybill.customer.contacts}</div>
	    </div>
	    <div class="weui-flex">
	      <div class="txt_left">联系电话：</div>
	      <c:choose>
	      	<c:when test="${waybill.customer.contactNumber != null && waybill.customer.contactNumber != ''}">
		      	<div class="weui-flex__item txt_right">${waybill.customer.contactNumber}</div>
	      	</c:when>
	      	<c:otherwise>
		      	<div class="weui-flex__item txt_right">${waybill.customer.tel}</div>
	      	</c:otherwise>
	      </c:choose>
	    </div>
	    <div class="weui-flex">
	      <div class="txt_left">收货地址：</div>
	      <div class="weui-flex__item txt_right">${waybill.customer.address}</div>
	    </div>
	    <div class="weui-flex">
	      <div class="txt_left">任务摘要：</div>
	      <div id ="orderSummary" data-uId="${userId}" class="weui-flex__item txt_right">
	      	${waybill.orderSummary}
	      </div>
	    </div>
	</div>
	
	<!--底部操作-->
	<div class="weui-footer weui-footer_fixed-bottom">
	  	<div class="footer-con clearfix">
	      	<div id="exception_reporting" class="footer-con-handle">
	      		<img src="<%=basePath%>images/abnormal_icon.png" alt="" />
	      		<p class="txt_highlight">异常上报</p>
	      	</div>
	      	<div id="receipt" class="footer-con-handle">
	      		<img src="<%=basePath%>images/upload_icon.png" alt="" />
	      		<p>上传回单</p>
	      	</div>
	      	<div id="scan_code" class="footer-con-handle">
	      		<img src="<%=basePath%>images/sao_icon.png" alt="" />
	      		<p>继续扫码</p>
	      	</div>
	      	<div class="footer-con-handle con-large">
	      		<div id="unloading">卸货</div>
	      	</div>
	    </div>
	</div>
<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/picker.js" ></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/coordtransform-master/index.js" ></script>
<script type="text/javascript">
$(function(){
	showLoading();
	$('.weui-toast_content').text('定位获取中...');
})

//数据加载中
function showLoading(){
	$.showLoading();

    setTimeout(function() {
      $.hideLoading();
    }, 5000)
}

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
	    },
		fail: function (res) {
			window.location.href = '<%=basePath%>weixin/toPage.html?page=locationErr';
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
    $('#address').attr('data-latitude',latitude);
    $('#address').attr('data-longitude',longitude);
	 AMap.service('AMap.Geocoder',function(){//回调函数
	        //逆地理编码
			var lnglatXY=[longitude, latitude];//地图上所标点的坐标
			var geocoder = new AMap.Geocoder();
			geocoder.getAddress(lnglatXY, function(status, result) {
			    if (status === 'complete' && result.info === 'OK') {
			       //获得了有效的地址信息:
			       $('#address').text(result.regeocode.formattedAddress+"("+result.regeocode.addressComponent.district+result.regeocode.addressComponent.township+result.regeocode.addressComponent.street+result.regeocode.addressComponent.streetNumber+")");
			       //定位完成后自动上报位置
			       uploadPosition();
			    }else{
			       //获取地址失败
			      $.toast("获取地址失败",'cancel');
			      window.location.href = '<%=basePath%>weixin/toPage.html?page=locationErr';
			    }
			});  
		});
}	
//扫描上传位置
function uploadPosition() {
	var url = '<%=basePath%>weixin/uploadPosition.html';
	var address = $('#address').text();
	if(address == ""){
		$.toptip("定位地址不能为空", 'error');
		return;
	}
	var map = {};
	map['barCode'] = $('#barCode').attr('data-barcode');
	map['waybillid'] = $('#barCode').attr('data-waybillId');
	map['userid'] = $('#orderSummary').attr('data-uId');
	map['latitude']=$('#address').attr('data-latitude');
	map['longitude']=$('#address').attr('data-longitude');
	map['locations']=address;
	
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
						$.hideLoading()
				  		$('.head-tips').removeClass('head-location-success');
						$.toptip(data.reason, 'success');
						//window.location.href = '<%=basePath%>weixin/myTask.html';
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
	//更多定位列表
	function toMoreList(){
		window.location.href = '<%=basePath%>weixin/myTask.html';
	}
	//任务单详情
	function goBillDetail(id,status){
		window.location.href = '<%=basePath%>weixin/myTaskDetails.html?wayBillId='+id+'&status='+status;
	}
	//底部继续扫描按钮
	$('#scan_code').click(function() {  
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
	//异常上报跳转
	$('#exception_reporting').click(function() {
		var waybillId = ${waybill.id};
		window.location.href = "<%=basePath%>weixin/ExceptionUp.html?wayBillId=" + waybillId;
	})
	//上传回单跳转
	$('#receipt').click(function() {
		var waybillId = ${waybill.id};
		window.location.href = "<%=basePath%>weixin/ReceiptUp.html?wayBillId=" + waybillId;
	})
	//ajax获取该用户第一次上传位置时间
	$('#unloading').click(function() {
		showDialogBox();
	});
	//计算出时间差，比较卸货时间是否与第一次上报时间差小于指定值
	function compareTime(createtime){
		var nowDate = new Date();//获取当前时间
		var dateCompare=nowDate.getTime()-createtime;  //时间差的毫秒数 
		var days=Math.floor(dateCompare/(24*3600*1000))//计算出相差天数
		var leave=dateCompare%(24*3600*1000)    //计算天数后剩余的毫秒数
		var hours=Math.floor(leave/(3600*1000)) //计算出小时数
		//不准删除此注释，以后要用
		if(hours>1){
			return true;
		}else{
			return false;
		}
	}
	//弹出是否卸货对话框
	function showDialogBox(){
		$.confirm({
			title: '是否卸货',
			text: '',
			onOK: function () {
			    //点击确认
				var waybillid = $("#barCode").attr('data-waybillId');
				var userid = $('#orderSummary').attr('data-uId');
				unload(waybillid,userid)
			},
			onCancel: function () {
				//点击取消
			}
		});
	}
	
	//卸货功能	
	function unload(waybillid,userid) {
		var url = '<%=basePath%>weixin/toUpload.html';
		var map = {};
		map['waybillid'] = waybillid;
		map['userid'] = userid;
		console.log(JSON.stringify(map));
		$.ajax({
					url : url, // 请求的url地址
					timeout : 5000,
					dataType : "json",
					data : "param=" + JSON.stringify(map), // 参数值
					type : "POST", // 请求方式
					success : function(data) {
						// 请求成功时处理
						if (data.resultCode == 200) {
							$.toast(data.reason);
							window.location.href = path+"weixin/myTask.html";
						} else {
							// 注册失败提示
							$.toast(data.reason);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						$.toptip("网络异常，请求失败！");
					}
				});
	}	
//格式化日期
function FormatDate (strTime) {
    var date = new Date(strTime);
    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()
    				+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
}

//timestamp转换成datetime
function timeStamp2String(time){
     var datetime = new Date();
     datetime.setTime(time);
     var year = datetime.getFullYear();
     var month = datetime.getMonth() + 1;
     var date = datetime.getDate();
     var hours = datetime.getHours();
     var minutes = datetime.getMinutes();
     var seconds = datetime.getSeconds();
     return year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds;
}
//公共ajax
function doPostBack(url,backSuccess,param) {
    $.ajax({
        async : false,
        cache : false,
        dataType:"JSON",
        type : 'POST',
        url : url,
        data:param,
        error : function() {// 请求失败处理函数
        	$.toptip("请求失败！");
        },
        success : backSuccess
    });
}
//成功返回
function backSuccess(data){
	if (data.resultCode == 200) {
		$.toast(data.reason);
		window.location.href = path+"weixin/myTask.html";
	} else {
		// 注册失败提示
		$.toast(data.reason);
	}
}
/* var url = "http://ksh.ycgwl.com:21888/track/getFirstCretetime"
$.ajax({
	url : url, // 请求的url地址
	timeout : 5000,
	dataType : "json",
	data : JSON.stringify(map), // 参数值
	type : "POST", // 请求方式
	success : function(data) {
		// 请求成功时处理
		if (data.resultCode == 200) {
				var createtime = data.createtime;
				if(compareTime(createtime)){
					showDialogBox();
				}
			} else {
				// 注册失败提示
				$.toptip(data.reason, 'error');
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$.toptip("网络异常，请求失败！");
		}
	}); */
</script>
	
</body>
</html>