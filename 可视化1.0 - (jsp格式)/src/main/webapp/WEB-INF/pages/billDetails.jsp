<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	// 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="./resourceswx.jsp"%>
<meta charset="UTF-8">
<title>任务单详情</title>
<link rel="stylesheet" href="<%=basePath%>css/reset.css" />
<link rel="stylesheet" href="<%=basePath%>css/layout.css" />
<link rel="stylesheet" href="<%=basePath%>css/billDetails.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>css/imgShowBig.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>css/viewer.css" />
<style type="text/css">
html {
	height: 100%
}

body {
	height: 100%;
	margin: 0px;
	padding: 0px
}

#main {
	height: 100%
}

#part {
	height: 60%
}

#container {
	height: 90%
}
.closes{
	position: absolute;
	top: -40px;
	right: -40px;
	background-color:rgba(0, 0, 0, .5);
	width: 80px;
	height: 80px;
	border-radius: 50%;
	overflow:hidden;
	cursor:pointer;
}
.closes>span{
	position: absolute;
	top: 42px;
	right: 45px;
	color: #fff;
	font-size: 20px;
	font-family:"微软雅黑";
	z-index: 1;
	width: 22px;
	height: 22px;
	border-radius: 50%;
} 

</style>
</head>
<body>
	<div class="detail-content" id="main">
		<div class="dcontent-part" id="part">
			<h2>
				任务轨迹
				<c:if
					test="${waybill.barcode.bindstatus==10 || waybill.barcode.bindstatus==20}">
					<span class="fr">确认到货</span>
				</c:if>
				<c:if test="${waybill.barcode.bindstatus==30 }">
					<a id="onSureArrive" href="javascript:;" class="fr dc_btn dc_sure"
						onclick="confirmArrive()">确认到货</a>
						<span id="sureArrive" class="fr" style="display: none;">已到货</span>
				</c:if>
				<c:if test="${waybill.barcode.bindstatus==40 }">
					<span class="fr">已到货</span>
				</c:if>
			</h2>
			<!-- 这里放百度地图 -->
			<div id="container"></div>
			<!-- <div class="track-con-btn">
				<div class="clearfix">
					<span>备注 :</span>
					<a href="javascript:;" class="fr dc_btn">保存备注</a>
				</div>
				<textarea name="" id=""></textarea>
			</div> -->
		</div>
		<!-- 任务单详情 -->
		<div class="dcontent-part">
			<h2>任务单详情</h2>
			<div class="track-con track-con-bg">
				<div class="clearfix">
					<div class="fl">
						<span class="spa_n">送货单号:</span>
						<p class="text_p">${waybill.deliveryNumber }</p>
					</div>
					<div class="fl">
						<span class="spa_n">任务摘要:</span>
						<p class="text_p">${waybill.orderSummary }</p>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl">
						<span class="spa_n">任务单号:</span>
						<p class="text_p">${waybill.barcode.barcode }</p>
					</div>
					<div class="fl">
						<span class="spa_n">联系人:</span>
						<p class="text_p">${waybill.customer.contactNumber }</p>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl">
						<span class="spa_n">公司名称:</span>
						<p class="text_p">${waybill.customer.companyName }</p>
					</div>
					<div class="fl">
						<span class="spa_n">收货地址:</span>
						<p class="text_p">${waybill.customer.address }</p>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl">
						<span class="spa_n">收货人:</span>
						<p class="text_p">${waybill.companyName }</p>
					</div>
					<div class="fl">
						<span class="spa_n">要求到货时间:</span>
						<p class="text_p">
						<c:if test="${waybill.arrivaltime != null}">
							<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.arrivaltime }" />
						</c:if>
						</p>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl">
						<span class="spa_n">数量:</span>
						<p class="text_p">${waybill.number }</p>
					</div>
					<div class="fl">
						<span class="spa_n">座机:</span>
						<p class="text_p">
						${waybill.customer.tel }
						</p>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl">
						<span class="spa_n">重量:</span>
						<p class="text_p">${waybill.weight }</p>
					</div>
					<div class="fl">
						<span class="spa_n">发货时间:</span>
						<p class="text_p">
						<c:if test="${waybill.createtime != null}">
							<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.createtime }" />
						</c:if>
						</p>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl">
						<span class="spa_n">体积:</span>
						<p class="text_p">${waybill.volume }</p>
					</div>
					<div class="fl">
						<span class="spa_n">到货时间:</span>
						<p class="text_p">
						<c:if test="${waybill.actualArrivalTime != null}">
							<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.actualArrivalTime }" />
						</c:if>
						</p>
					</div>
				</div>
			</div>
		</div>
		<!-- 异常情况 -->
		<div class="dcontent-part">
			<h2>异常情况</h2>
			<div class="track-con">
				<c:forEach items="${waybill.exceptionRepor}" var="exceptionRepor">
					<div class="track-sub-part track-con-bg">
						<div class="clearfix">
							<div class="fl">
								<span class="spa_n">异常情况:</span>
								<p class="text_p">${exceptionRepor.content }</p>
							</div>
							<div class="fl">
								<span class="spa_n">任务摘要:</span>
								<p class="text_p">${waybill.orderSummary }</p>
							</div>
						</div>
						<div class="clearfix">
							<div class="fl">
								<span class="spa_n">上报时间:</span>
								<p class="text_p">
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
										value="${exceptionRepor.createtime }" />
								</p>
							</div>
							<div class="fl">
								<span class="spa_n">上报人:</span>
								<p class="text_p">${exceptionRepor.user.mobilephone}</p>
							</div>
						</div>
						<div class="bill_test">
							<ul class="clearfix paddin_g docs-pictures">
								<c:forEach items="${exceptionRepor.list}" var="address">
									<li><img src="${imagePath}${address.path }" alt="异常上传图片"></li>	
								</c:forEach>
							</ul>
						</div>
						
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- 回单信息 -->
		<div class="dcontent-part">
			<h2>回单信息</h2>
			<div class="track-con">
				<c:forEach items="${waybill.receipts}" var="receipt">
					<div class="track-sub-part track-con-bg">
						<div class="clearfix">
							<div class="fl">
								<span class="spa_n">上传时间:</span>
								<p class="text_p">
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
										value="${receipt.createtime }" />
								</p>
							</div>
							<div class="fl">
								<span class="spa_n">上传人:</span>
								<p class="text_p">${receipt.user.mobilephone }</p>
							</div>
						</div>
						<div class="bill_test">
							<ul class="clearfix paddin_g docs-pictures">
								<c:forEach items="${receipt.list}" var="address">
									<li><img src="${imagePath}${address.path }" alt="回单上传图片"></li>	
								</c:forEach>
							</ul>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div id="popup">
		<div class="closes">
		<span onclick="closediv();">x</span></div>
		<div class="bg" id="bg">
				<img src="" id="targetObj" class="imgrotate" onclick="rotateImg()"/>
		</div>
	</div>
	<script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=IstixtPwG9M3fL5G545WGG0I283NyDbQ"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/Date.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/viewer.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/main.js"></script>
	<script type="text/javascript">
	var longitude,latitude;
    
	//弹出框
	function confirmArrive(){
	var r = confirm('是否确认到货？');
	if(r){
	 //确认删除后的操作
	   $.post('<%=basePath%>trace/confirmArrive.html',{id:${waybill.id}},function(data){
	             alert(data);
	             if (data == "操作成功") {
	            	 $("#onSureArrive").css('display','none');
	            	 $("#sureArrive").css('display','block'); 
				}
	   },'json'); 
	}
	}
    //处理微信坐标
    function bd_encrypt(gg_lat, gg_lon)
    {
        var x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        var x = gg_lon; var y = gg_lat;
        var z = Math.sqrt(x * x + y * y) + 0.00002 * Math.sin(y * x_pi);
        var theta = Math.atan2(y, x) + 0.000003 * Math.cos(x * x_pi);
        longitude = z * Math.cos(theta) + 0.0065;
        latitude = z * Math.sin(theta) + 0.006;
    }
    //格式化时间
    function datetimeFormat(longTypeDate){  
   	    return new Date(longTypeDate).Format("yyyy年MM月dd日 hh:mm:ss");
    } 

   function fnWheel(obj,fncc){
		obj.onmousewheel = fn;
		if(obj.addEventListener)
		{
			obj.addEventListener('DOMMouseScroll',fn,false);
		}
   }
	function fn(ev)
	{
		var oEvent = ev || window.event;
		var down = true;

		if(oEvent.detail)
		{
			down = oEvent.detail>0
		}
		else
		{
			down = oEvent.wheelDelta<0
		}
		if(fncc)
		{
			fncc.call(this,down,oEvent);
		}
		if(oEvent.preventDefault)
		{
			oEvent.preventDefault();
		}
		return false;
	} 
	$(function(){
			$.post('<%=basePath%>trace/enterBillDetail.html',{id:${waybill.id}},function(data){
			var map = new BMap.Map("container"); // 创建地图实例 
			var points = []; 
			$.each(data,function(i,item){
			bd_encrypt(item.latitude, item.longitude)
			var point = new BMap.Point(longitude,latitude);
			points.push(point);
		    var opts = {
							title : '<span style="font-size:14px;color:#0A8021"></span>'
						   }
			var html = "<div style='line-height:1.8em;font-size:12px;'><b>地址:</b>"
							+ item.locations
							+ "</br><b>日期:</b>"
							+ datetimeFormat(item.createtime)
						    + "</br><b>联系人：</b>"
					    	+ item.user.mobilephone
			   html += "</div>"
			   var infoWindow = new BMap.InfoWindow(html, opts);
			   if(i==0){
			   bd_encrypt(data[0].latitude, data[0].longitude)
			   var lastPoint = new BMap.Point(longitude,latitude);
			   map.openInfoWindow(infoWindow,lastPoint); // 打开信息窗口
			   }	
			   var myIcon = new BMap.Icon("<%=basePath%>images/newcar.png", new BMap.Size(32, 70), {
							            	offset : new BMap.Size(0, -5),imageOffset : new BMap.Size(0, 0)
										});
								// 创建标注对象并添加到地图
				var	marker = new BMap.Marker(point, {icon : myIcon });	
			    map.addOverlay(marker);
			   
			    marker
				.addEventListener(
						"click",
						function() {
							this.openInfoWindow(infoWindow); // 打开信息窗口
						});
			   
		});
		
	    var view = map.getViewport(eval(points));  
		var mapZoom = view.zoom;   
		var centerPoint = view.center;   
		map.centerAndZoom(centerPoint,mapZoom);  	
			
		map.enableScrollWheelZoom(); //启用地图滚轮放大缩小
		map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl()); //添加缩略地图控件

		var polyline = new BMap.Polyline(points, {
			strokeColor : "black",
			strokeWeight : 6,
			strokeOpacity : 0.8
		});
		map.addOverlay(polyline);
		},'json');
		});
	</script>
</body>
</html>