<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<title>任务单详情</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
<link rel="stylesheet" href="<%=basePath%>weixinCss/waybillDetail.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>css/imgShowBig.css?times=<%=times%>" />
<style type="text/css">
	*{margin:0; padding:0;}
	a{text-decoration: none;}
	img{max-width: 100%; height: auto;}
	.weixin-tip{-webkit-touch-callout:default;display: none; position: fixed; left:0; top:0; bottom:0; background: rgba(0,0,0,0.8); filter:alpha(opacity=80);  height: 100%; width: 100%; z-index: 100;}
	.weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}
</style>
</head>
<body ontouchstart style="background-color: #f8f8f8;" onload="init('${barCodeEntity.barcode}','${orderSummary}','${wayBillId}','${user.id}','${createtime}')">
	<div class="weixin-tip" onclick="hideMask()">
		<p>
			<img src="<%=basePath%>images/live_weixin.png" alt="微信打开"/>
		</p>
	</div>
	<div class="yb_detail_map">
		<div class="detail_map" id="mapContainer">
			<!--这里放地图-->
		</div>
		<div class="a_link clearfix">
			<div class="fl">
				 <form id="ExceptionUpForm" class="color_red" action="weixin/ExceptionUp.html" method="post">
			        <input type="hidden" name="wayBillId" value="${wayBillId}"/>
			        <input type="hidden" name="shareId"  value="${shareId}"/>
					<div class="weui-flex" onclick="doSubmit('ExceptionUp')">
				      	 <div class="weui-flex__item text_center"><img src="images/abnormal.png"/></div>
				         <input class="weui-flex__item" type="button" value="异常上报">
				         <!--<div class="weui-flex__item">异常上报</div>  -->
				    </div>
			 	 </form>
			
			</div>
			<div class="fr">
				<form id="ReceiptUpForm" class="color_green" action="weixin/ReceiptUp.html" method="post">
				    <input type="hidden" name="wayBillId" value="${wayBillId}"/>
				    <input type="hidden" name="shareId"  value="${shareId}"/>
					<div class="weui-flex" onclick="doSubmit('ReceiptUp')">
				      	<div class="weui-flex__item text_center"><img src="images/upload.png"/></div>
				        <input class="weui-flex__item" type="button" value="上传回单"/>
				      	<!--  <div class="weui-flex__item">上传回单</div>-->
				    </div>
			    </form>
			
			</div>
		</div>
	</div>
    
    <div class="yb_detail_con" id="container">
    	<!--任务单详情-->
    	<div class="yb_detail_list">			    	
			<div class="dl_part_show">
				<div class="detail_list_title">
			      	<h4><span>任务单详情</span></h4>
			    </div>
				<div class="weui-flex">
			      	<div>任务单号 :</div>
			      	<div class="weui-flex__item part_right">${barCodeEntity.barcode}</div>
			    </div>
			    <div class="weui-flex">
			      	<div>任务摘要 :</div>
			      	<div class="weui-flex__item part_right">${orderSummary}</div>
			    </div>
			    <i class="listpart_updown"></i>
			</div>
			<div class="dl_part_hide">
				<div class="weui-flex">
			      	<div class="part_left">收货人 :</div>
			      	<div class="weui-flex__item part_right">${customer.contacts}</div>
			    </div>
			    <div class="weui-flex">
			      	<div class="part_left">联系电话 :</div>
			      	<div class="weui-flex__item part_right">${customer.contactNumber}</div>
			    </div>
			    <c:if test="${customer.tel!=null and customer.tel!=''}">
				    <div class="weui-flex">
				      	<div class="part_left">座机:</div>
				      	<div class="weui-flex__item part_right">${customer.tel}</div>
				    </div>
			    </c:if>
			    <div class="weui-flex">
			      	<div class="part_left">公司名称 :</div>
			      	<div class="weui-flex__item part_right">${customer.companyName}</div>
			    </div>
			    <div class="weui-flex">
			      	<div class="part_left">收货地址 :</div>
			      	<div class="weui-flex__item part_right">${customer.address}</div>
			    </div>
			</div>
		</div>
    	
    	<!--异常情况-->
    	<div class="yb_detail_list">			    		
			<div class="dl_part_show">
				<div class="detail_list_title">
			      	<h4><span class="red_color">异常情况</span></h4>
			   </div>
			    <i class="listpart_updown special"></i>
			</div>
			<c:forEach items="${exceptionRepor}" var="execepor">
				<div class="dl_part_hide">
					<div class="dl_sub_part">
						<div class="weui-flex">
					      	<div class="part_left">异常情况 :</div>
					      	<div class="weui-flex__item part_right">${execepor.content}</div>
					    </div>
					    <div class="weui-flex">
					      	<div class="part_left">上报时间 :</div>
					      	<div class="weui-flex__item part_right"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${execepor.createtime}" /></div>
					    </div>
					    <div class="weui-flex">
					      	<div class="part_left">上报人 :</div>
					      	<div class="weui-flex__item part_right"><span style='color:#30aafa' onclick='phone("${execepor.user.mobilephone}")'>${execepor.user.mobilephone}</span></div>
					    </div>
					    <ul class="dl_img clearfix">
					        <c:forEach items="${execepor.list}" var="address">
					    		<li><img src="${imagePath}${address.path}" alt="" /></li>
					    	</c:forEach>
					    </ul>
					</div>
				</div>
			</c:forEach>
		</div>
		<!--回单详情-->
    	<div class="yb_detail_list">			    		
			<div class="dl_part_show">
				<div class="detail_list_title">
			      	<h4><span>回单详情</span></h4>
			   </div>
			    <i class="listpart_updown special"></i>
			</div>
			<c:forEach items="${receipts}" var="receipt">
				<div class="dl_part_hide">
					<div class="dl_sub_part">
					    <div class="weui-flex">
					      	<div class="part_left">上报时间 :</div>
					      	<div class="weui-flex__item part_right"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${receipt.createtime}" /></div>
					    </div>
					    <div class="weui-flex">
					      	<div class="part_left">上报人 :</div>
					      	<div class="weui-flex__item part_right"><span style='color:#30aafa' onclick="phone('${receipt.user.mobilephone}')">${receipt.user.mobilephone}</span></div>
					    </div>
					    <ul class="dl_img clearfix">
					    	<c:forEach items="${receipt.list}" var="address">
					    		<li><img src="${imagePath}${address.path}" alt="" name="targetObj"/></li>
					    	</c:forEach>
					    </ul>
					</div>
				</div>	
			</c:forEach>	
    	</div>
    
    </div>
    
    <!--底部按钮-->
    <div class="yb_footer weui-footer_fixed-bottom clearfix">
		<div class="fl" onclick="shareMsg()">
			<div class="weui-flex">
		      	<div class="text_center"><img src="images/footer_share.png"/></div>
		      	<div class="">分享</div>
		   </div>
		</div>
		<c:if test="${isGroupMermer==true}">
		    <c:if test="${barCodeEntity.bindstatus!=40}">
				<div class="fr" onclick="confirmArrive()">
					<div class="weui-flex">
				      	<div class="text_center"><img src="images/footer_sure.png"/></div>
				      	<div class="" id="ArriveConfirm">确认到货</div>
				   </div>
				</div>
			</c:if>
			<c:if test="${barCodeEntity.bindstatus==40}">
			    <div class="fr">
					<div class="weui-flex">
				      	<div class="text_center"><img src="images/footer_sure.png"/></div>
				      	<div class="">已到货</div>
				   </div>
				</div> 
			</c:if>
		</c:if>
	</div>
    <div id="popup">
    	<div class="bg"><img src="" style="position:relative;transform-origin:center" id="targetObj"/></div>
	</div>
	<input name="shareId" id="shareId" type="hidden" value="${shareId}"/>
	<input name="longitude" id="longitude" type="hidden" value="${track.longitude}"/>
	<input name="latitude" id="latitude" type="hidden" value="${track.latitude}"/>
	<input name="address" id="address" type="hidden" value="${address}"/>
	<input name="driverName" id="driverName" type="hidden" value="${track.user.uname}"/>
	<input name="driverPhone" id="driverPhone" type="hidden" value="${track.user.mobilephone}"/>
	<input name="scanTime" id="scanTime" type="hidden" value="${scanDateTime}"/>
	<input name="createtime" id="createtime" type="hidden" value="${createtime}"/>
	<input name="trackList" id="trackList" type="hidden" value='${trackList}'/>
	<input name="receiptSize" id="receiptSize" type="hidden" value='${receiptNumber}'/>
<script src="<%=basePath%>js/jquery-2.1.4.js" ></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/picker.js" ></script>
<script type="text/javascript" src="<%=basePath%>plugin/touch.js" ></script>
<script type="text/javascript" src="<%=basePath%>plugin/touch.min.js" ></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
<script>
	var geocoder,map,marker,info,content= null;
	var longitude=$('#longitude').val();
	var latitude=$('#latitude').val();
	var address=$('#address').val();
//	var driverName=$('#driverName').val();
	var driverPhone=$('#driverPhone').val();
	var scanTime=$('#scanTime').val();
	var content="定位地址："+address+"</br>定位时间："+scanTime+"</br>联系人：<span style='color:#30aafa' onclick='phone("+driverPhone+")'>"+driverPhone+"</span>";
	content="<div style='text-align: left;'>"+content+"</div>";
		
	var flag=true;
	var isDetail=true;
	var canConfirm=true;
	var createDateTime=$('#createtime').val();
	var pointArray,trackArray  = null;
	var item_contents,locations;
	
	var global_barcode,global_orderSummary,global_waybillId,global_userId;
	
	wx.config({
	    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId:'${appId}', // 必填，公众号的唯一标识
	    timestamp:'${timestamp}', // 必填，生成签名的时间戳
	    nonceStr: '${nonceStr }', // 必填，生成签名的随机串
	    signature:'${signature}',// 必填，签名，见附录1
	    jsApiList: [
	                'checkJsApi',
	                'onMenuShareAppMessage'
	                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	}); 
	
	wx.ready(function() {
	    wx.checkJsApi({  
	        jsApiList : [
	                     'checkJsApi',
	                     'onMenuShareAppMessage'],  
	        success : function(res) {
	            //alert(res);
	            console.log(res);
	        }  
	    }); 
	    
	    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
        var curWwwPath = window.document.location.href;
        //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
        var pathName = window.document.location.pathname;
        var pos = curWwwPath.indexOf(pathName);
        //获取主机地址，如： http://localhost:8083
        var localhostPaht = curWwwPath.substring(0, pos);
        //获取带"/"的项目名，如：/uimcardprj
        //var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
        
	    wx.onMenuShareAppMessage({
			title : '【千里码】'+global_orderSummary+','+global_createtime+'订单', //分享标题
			desc : '任务摘要：'+global_orderSummary, // 分享描述
			link : localhostPaht+'/weixin/ToWaybillDetail.html?wayBillId='+global_waybillId+'&userId='+global_userId, //分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			imgUrl : localhostPaht+'/images/logo.png', // 分享图标
			type : 'link', // 分享类型,music、video或link，不填默认为link
			dataUrl : '', // 如果type是music或video，则要提供数据链接，默认为空
			success : function() {
				// 用户确认分享后执行的回调函数
				$.toast('分享成功');
			},
			cancel : function() {
				// 用户取消分享后执行的回调函数
			}
		});
	});//end_ready
	
	//手机电话
	function phone(xgfPhone){  
        window.location.href = 'tel://' + xgfPhone;  
    } 
	
	var init = function(barcode,orderSummary,waybillId,userId,createtime) {
		
		global_barcode=barcode;global_orderSummary=orderSummary;global_waybillId=waybillId;
		global_userId=userId;global_createtime=FormatDate(createtime);
		
	    var center = new qq.maps.LatLng(latitude,longitude);
	    map = new qq.maps.Map(document.getElementById('mapContainer'),{
	        center: center,
	        zoom: 13
	    });
	    
	    //整理轨迹
	    var trackList=$('#trackList').val();
		if(trackList!=null&&trackList!=''){
			trackList=trackList+"";
			trackArray = eval('(' + trackList + ')');
			pointArray=new Array();
			for(var i=0;i<trackArray.length;i++){
				pointArray[i]=new qq.maps.LatLng(trackArray[i].latitude,trackArray[i].longitude);
			}
		}
	    
	    if(pointArray!=null){
	    	var polyline = new qq.maps.Polyline({
		        path: pointArray,
		        strokeColor: '#000000',
		        strokeWeight: 5,
		        editable:false,
		        map: map
		    });
	    	polyline.setStrokeDashStyle("dash");
	    	polyline.setVisible(true);
	    }
	    
	    var anchor = new qq.maps.Point(6, 6),
        size = new qq.maps.Size(50, 50),
        origin = new qq.maps.Point(0, 0),
        icon = new qq.maps.MarkerImage('images/newcar.png', size, origin, anchor);
		marker = new qq.maps.Marker({
			icon: icon,
	        position: center,
	        map: map
	    });

		item_contents = new Array(trackArray.length);
		locations = new Array(trackArray.length);
		for(var i=1;i<trackArray.length;i++){
			locations[i] =  new qq.maps.LatLng(trackArray[i].latitude,trackArray[i].longitude);
			var item_content="定位地址："+trackArray[i].locations+"</br>定位时间："+timeStamp2String(trackArray[i].createtime)+"</br>联系人：<span style='color:#30aafa' onclick='phone("+trackArray[i].user.mobilephone+")'>"+trackArray[i].user.mobilephone+"</span>";
			item_content="<div style='text-align: left;'>"+item_content+"</div>";
			item_contents[i]=item_content;
		}
		
		//添加到提示窗
	    info = new qq.maps.InfoWindow({
	        map: map
	    });
		
        for(var i = 1;i < locations.length; i++) {
            (function(n){
                var marker = new qq.maps.Marker({
                    position: locations[n],
                    map: map
                });
                qq.maps.event.addListener(marker, 'click', function() {
                	info.open();
                	info.setContent('<div style="text-align:center;width:230px;'+
                            'margin:5px;">'+item_contents[n]+'</div>');
                	info.setPosition(locations[n]);
                });
            })(i);
        }
		
		
	    info.open(); 
        info.setContent('<div style="text-align:center;width:230px;'+
        'margin:5px;">'+content+'</div>');
        info.setPosition(center); 
        
		if(content!=null&&content!=''){
			//获取标记的点击事件
		    qq.maps.event.addListener(marker,'click', function() {
		        info.open(); 
		        info.setContent('<div style="text-align:center;width:230px;'+
		        'margin:5px;">'+content+'</div>');
		        info.setPosition(center); 
		    }); 
		}
		
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
        //初始化旋转手势（不需要就注释掉）
        /* cat.touchjs.rotate($targetObj, function (rotate) {
            $('#rotate').text(rotate);
        }); */

	}

	$('.dl_part_show').click(function(){
		var $parent = $(this).parent('.yb_detail_list');
		 if($parent.hasClass('js_show')){
            $parent.removeClass('js_show');
        }else{
           /* $parent.siblings().removeClass('js_show');*/
            $parent.addClass('js_show');
        }
	})
	
	/*--------图片点击放大的js----------start*/
	var imgs = document.getElementById("container").getElementsByTagName("img");
    var lens = imgs.length;
    var popup = document.getElementById("popup");

    for(var i = 0; i < lens; i++){
        imgs[i].onclick = function (event){
            event = event||window.event;
            var target = document.elementFromPoint(event.clientX, event.clientY);
            showBig(target.src);
        }
    }
    popup.onclick = function (){
        popup.style.display = "none";
    }
    function showBig(src){
    	$("#targetObj").attr("style","position:relative;transform-origin:center");
        popup.getElementsByTagName("img")[0].src = src;
        popup.style.display = "block";
    }
    /*--------图片点击放大的js----------end*/
    
    //分享
    function shareMsg(){
		$(".weixin-tip").css("height",$(window).height());
		$(".weixin-tip").show();
	}
  
	function hideMask(){
        $(".weixin-tip").hide();
	}
	
	//确认到货
	function confirmArrive(){
		
		var receiptSize = $("#receiptSize").val();
		var titleContent='';
		if(receiptSize>0){
			titleContent='是否确认到货？';
		}else{
			titleContent='此任务还没有上传回单，是否确认到货？';
		}

	    if(canConfirm){
	    	$.confirm({
	  		  title:titleContent,
	  		  text: '',
	  		  onOK: function () {
	  			$.post(
  				   '<%=basePath%>weixin/CheckRolePermission.html',
  				   {wayBillId:${wayBillId},checkURI:'confirmArrive'},function(data){
  					   var resultInfo = eval('(' + data + ')');
  					   if(resultInfo.havePermission==true){
  						  //确认删除后的操作
  			              $.post('<%=basePath%>trace/confirmArrive.html',
  			              		{id:${wayBillId}},function(data){
  			               $.toast(data,"text");
  			               if(data=='操作成功'){
  			            	   $('#ArriveConfirm').text('已到货'); 
  			            	   canConfirm=false;
  			               }
  			              },'json').error(
  			                   function(){
  			                	//处理异常
  			                	alert("网络异常");
  			              });
  					   }else{
  						   alert("您没有此权限");
  					   }
  				   },'json');
	  		  }
	  		});
	    }
     }
	
	//timestamp转换成datetime
	function timeStamp2String(time){
        var datetime = new Date();
         datetime.setTime(time);
         var year = datetime.getFullYear();
         var month = datetime.getMonth() + 1;
         var date = datetime.getDate();
         return year + "年" + month + "月" + date + "日";
	};
	
	//格式化日期
	function FormatDate(strTime) {
	    var date = new Date(strTime);
	    return date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日";
	}
	
	function doSubmit(type){
		$.post(
		   '<%=basePath%>weixin/CheckRolePermission.html',
		   {wayBillId:${wayBillId},checkURI:type},function(data){
			   var resultInfo = eval('(' + data + ')');
			   if(resultInfo.havePermission==true){
				   if(type=='ExceptionUp'){
					   $("#ExceptionUpForm").submit();
				   }else{
					   $("#ReceiptUpForm").submit();
				   }
			   }else{
				   alert("您没有此权限");
			   }
		   },'json');
	}
</script>
	
</body>
</html>