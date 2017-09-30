<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>扫码定位</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/position.css?version=1.2.3" />
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=a4e0b28c9ca0d166b8872fc3823dbb8a"></script>
</head>
<body ontouchstart style="background:#f8f8f8;">
	<div class="position_head clearfix">
		<div class="fl">
			<a href="#">
				<img src="<%=basePath%>images/swap_big.png" id="scan_position" alt="" />
			</a>	
			<p>点击进行扫码</p>
			<p style="font-size: 15px;"><a href="<%=basePath%>weixin/toPage.html?page=positionEditInfo">手动输入</a></p>
		</div>
		<div class="fr">
			<a href="#">
				<img src="<%=basePath%>images/location.png" id="position" alt="" />
			</a>
			<p>上报位置</p>
		</div>
	</div>
    <div class="weui-cells weui-cells_checkbox">
    	<!--全选-->
    	<div class="position_title">
    		<div class="weui-cell weui-check__label p_allcheck" for="">
		        <div class="weui-cell__hd input_all">
		            <input type="checkbox" name="checkbox1" class="weui-check all_check" id="">
		            <i class="weui-icon-checked"></i>
		            <span>全选</span>
		        </div>
		        <div class="weui-cell__bd">
		          	<div class="weui-flex">
		          		<div><img src="<%=basePath%>images/car.png" /></div>
				      	<div class="pt_margin_left">运输中<span>${count}</span></div> 	
				    </div>
		        </div>
		    </div>
		    <form id="more_form" action="<%=basePath%>weixin/moreLocationList.html" method="post">
			    <input id="param" type="hidden" name="param">
			    <div class="pt_more">更多<span class="s_more"> >> </span></div>
		    </form>
    	</div>
    	
	    
	    <!--列表-->
	    <div class="position_list">
	    	<c:forEach items="${list}" var="item">
		    	<div class="position_list_part" style="border-bottom:2px solid #F5F5F5;">
			    	<div class="weui-cell weui-check__label sin_check_p">
			    	    <c:if test="${item.status==1}">
					        <div class="weui-cell__hd input_one">
					            <input type="checkbox" class="weui-check sin_check" name="checkbox1" id="${item.id }">
					            <i class="weui-icon-checked"></i>
					        </div>
				        </c:if>
				        <c:if test="${item.status!=1}">
					        <div class="weui-cell__hd input_one">
					            <i class="weui-icon-checked"></i>
					        </div>
				        </c:if>
				        <div class="weui-cell__bd"> <!--放内容-->
				            <div onclick="Wailldeail(${item.id })">
					          	<div class="weui-flex big_size">
							      	<div>任务单号 :</div>
							      	<div class="weui-flex__item pad_left">${item.barcode.barcode }</div>
							    </div>
							    <div class="weui-flex">
							      	<div>任务摘要 :</div>
							      	<div class="weui-flex__item pad_left">${item.orderSummary }</div>
							    </div>
							    <div class="weui-flex">
									<div>收货客户 :</div>
									<div class="weui-flex__item pad_left">${item.customer.companyName }</div>
								</div>
								<div class="weui-flex">
									<div>收货地址 :</div>
									<div class="weui-flex__item pad_left">${item.customer.address }</div>
								</div>
							    <div class="weui-flex">
							      	<div class="weui-flex__item">
							      		已上报次数 :<span class="pad_left"><font color='#31aafb'>${item.numOfREPORT }</font></span>
							      	</div>
							    </div>
						    </div>
						    <div class="weui-flex" onclick="doUpLoadReceipt(${item.id})">
						         <div class="weui-flex__item">
						      		已运<span class="pad_left"><font color='#31aafb'>${item.totalTime }</font></span>天
						      	 </div>
							     <div class="weui-flex__item text_right">
						      	    <form id="form${item.id}" action="<%=basePath%>weixin/ReceiptUp.html" method="post">
						      		    <font color='#31aafb'>点击上传回单</font>
						      		    <input name="wayBillId" type="hidden" value="${item.id}"/>
						      	    </form>
						      	</div>
							</div>
				        </div>   
				    </div>
				    <%-- <div class="weui-flex" style="border-bottom:5px solid #f8f8f8">
				      	<div class="weui-flex__item text_right" style="margin-bottom:10px;margin-right:10px;">
				      		<a href="<%=basePath%>weixin/ToWaybillDetail.html?wayBillId=${item.id}" style="color:#000000">
				      			查看详情<span class="s_more"> >> </span>
				      		</a>
				      	</div>
				    </div> --%>
				    <c:if test="${item.status==2}">
				        <span class="pl_outed" style="margin-right:10px;">已卸货</span>
				    </c:if>
				    <c:if test="${item.status==1}">
				        <span data-waillId="${item.id}" data-userId="${item.userid }" data-path="<%=basePath %>" data-datetime="${item.createtime}" class="pl_out">卸货</span>	
				    </c:if>
				    <c:if test="${item.status==20}">
				        <span class="pl_outed btn_yellow" style="margin-right:10px;color:#fa7532">已到货</span>
				    </c:if>
			    </div>
	    	</c:forEach>
	    </div>
    </div>
    <input type="hidden" id="userid" name="userid" value="${user.id}"/>
<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script src="<%=basePath%>js/home.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/coordtransform-master/index.js" ></script>
<script type="text/javascript">
function isCheck(){
	var $sinCheck = $('.sin_check');
	if($sinCheck.filter(':checked').length>0){
		return true;
	}else{
		return false;
	}
}
function Wailldeail(id){
	window.location.href='<%=basePath%>weixin/ToWaybillDetail.html?wayBillId='+id;
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
                'getNetworkType',
                'openLocation',
                'getLocation'
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
});
    //扫描二维码  
	//location.href="<%=basePath%>weixin/toPage.html?page=barCodeAfter&bindCode="+res[2]
$('#scan_position').click(function() {  
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
});//end_document_scanQRCode  
//使用微信内置地图查看位置接口
$('#position').click(function(){
	if(isCheck()){
		wx.getLocation({
	    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
		        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
		        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
		        var speed = res.speed; // 速度，以米/每秒计
		        var accuracy = res.accuracy; // 位置精度
		        //alert(latitude+","+longitude);
		        geocoder(longitude, latitude);
	    	}
		});
	}else{
		$.toptip('请选择要上报位置的任务单')
	}
});

//反向地理编码
function geocoder(longitude, latitude) {
	//wgs84转国测局坐标
    var wgs84togcj02 = coordtransform.wgs84togcj02(longitude, latitude);
    wgs84togcj02 = wgs84togcj02+"";
    wgs84togcj02 = wgs84togcj02.split(",");
    longitude=wgs84togcj02[0];
    latitude=wgs84togcj02[1];
     AMap.service('AMap.Geocoder',function(){//回调函数
        //逆地理编码
		var lnglatXY=[longitude, latitude];//地图上所标点的坐标
		var geocoder = new AMap.Geocoder();
		geocoder.getAddress(lnglatXY, function(status, result) {
		    if (status === 'complete' && result.info === 'OK') {
		       //获得了有效的地址信息:
		        //alert(result.regeocode.formattedAddress);
		        uploadPositionList(longitude,latitude,result.regeocode.formattedAddress+"("+result.regeocode.addressComponent.district+result.regeocode.addressComponent.township+result.regeocode.addressComponent.street+result.regeocode.addressComponent.streetNumber+")");
		    }else{
		       //获取地址失败
		      $.toast("获取地址失败",'cancel');
		    }
		});  
	});
	
	// 创建地理编码实例     
	/* var geocoder = new qq.maps.Geocoder({
        complete : function(result){
        	uploadPositionList(longitude,latitude,result.detail.address);
        }
    });
    
	//获取经纬度数值   按照,分割字符串 取出前两位 解析成浮点数
    var lng = longitude;
    var lat = latitude;
    var latLng = new qq.maps.LatLng(lat, lng);
    // 根据坐标得到地址描述   
    geocoder.getAddress(latLng); */
}
//批量上传位置
function uploadPositionList(longitude,latitude,address) {
	var url = '<%=basePath%>weixin/batchUploadPosition.html';
	var arr = new Array();
	var chk_waybillid = [];// 定义一个数组
	var chk_userid =[]; 
	var userid = $('#userid').val();
	$('.pl_out').each(function() {// 遍历每一个名字为interest的复选框，其中选中的执行函数
		var $ckBox = $(this).parent().find('.sin_check');
		if($ckBox.is(':checked')){
			chk_userid.push($(this).attr('data-userId'));// 将选中的值添加到数组chk_value中 
			chk_waybillid.push($(this).attr('data-waillId'));// 将选中的值添加到数组chk_value中 
		} 
	});
	$.each(chk_waybillid,function(index,value){
		var map = {};
		map['waybillid'] = value;
		map['userid'] = userid;//chk_userid[index];
		map['latitude']=latitude;
		map['longitude']=longitude;
		map['locations']=address;
		arr[index]=map;
	});
	$.ajax({
				url : url, // 请求的url地址
				timeout : 5000,
				dataType : "json",
				data : 'param='+JSON.stringify(arr), // 参数值
				type : "POST", // 请求方式
				success : function(data) {
					// 请求成功时处理
					if (data.resultCode == 200) {
							$.alert("操作成功，共定位任务单<font color='#31aafb'>"+arr.length+"</font>个",function(){
								window.location.href = '<%=basePath%>weixin/myTask.html';
							});
						} else {
							$.toast(data.reason, 'cancel');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						$.toast("网络异常，请求失败！","text");
					}
				});
	}
function doUpLoadReceipt(formid){
	formid="#form"+formid;
	$(formid).submit();
}
</script>
</body>
</html>