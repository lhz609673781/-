<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="./resourceswx.jsp"%>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="<%=basePath%>css/reset.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/map.css" />
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

#container {
	height: 100%
}
</style>
</head>
<body>
	<div class="map-content" id="main">
		<div id="container">
			<!--这里放置百度地图-->
		</div>
	</div>
	<script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=IstixtPwG9M3fL5G545WGG0I283NyDbQ"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
	<script type="text/javascript">
	//格式化时间
    function datetimeFormat(longTypeDate){  
   	    var datetimeType = "";  
   	    var date = new Date();  
   	    date.setTime(longTypeDate);  
   	    datetimeType+= date.getFullYear();   //年  
   	    datetimeType+= "年" + getMonth(date); //月   
   	    datetimeType += "月" + getDay(date);   //日  
   	    datetimeType+= "日&nbsp;" + getHours(date);   //时  
   	    datetimeType+= ":" + getMinutes(date);      //分
   	    datetimeType+= ":" + getSeconds(date);      //分
   	    return datetimeType;
   	} 
   	//返回 01-12 的月份值   
   	function getMonth(date){  
   	    var month = "";  
   	    month = date.getMonth() + 1; //getMonth()得到的月份是0-11  
   	    if(month<10){  
   	        month = "0" + month;  
   	    }  
   	    return month;  
   	}  
   	//返回01-30的日期  
   	function getDay(date){  
   	    var day = "";  
   	    day = date.getDate();  
   	    if(day<10){  
   	        day = "0" + day;  
   	    }  
   	    return day;  
   	}
   	//返回小时
   	function getHours(date){
   	    var hours = "";
   	    hours = date.getHours();
   	    if(hours<10){  
   	        hours = "0" + hours;  
   	    }  
   	    return hours;  
   	}
   	//返回分
   	function getMinutes(date){
   	    var minute = "";
   	    minute = date.getMinutes();
   	    if(minute<10){  
   	        minute = "0" + minute;  
   	    }  
   	    return minute;  
   	}
   	//返回秒
   	function getSeconds(date){
   	    var second = "";
   	    second = date.getSeconds();
   	    if(second<10){  
   	        second = "0" + second;  
   	    }  
   	    return second;  
   	}
			var map = new BMap.Map("container"); // 创建地图实例 
			var point = new BMap.Point(${track.longitude},${track.latitude});
		    var opts = {
			title : '<span style="font-size:14px;color:#0A8021"></span>' }
			var html = "<div style='line-height:1.8em;font-size:12px;'><b>地址:</b>"
									+ '${track.locations }'
									+ "</br><b>日期:</b>"
									+ datetimeFormat('${track.createtime }')
									+ "</br><b>联系人：</b>"
									+ '${track.user.mobilephone }'
							html += "</div>"
		   var infoWindow = new BMap.InfoWindow(html, opts);
		   map.openInfoWindow(infoWindow,point); // 打开信息窗口
		   var myIcon = new BMap.Icon("<%=basePath%>images/newcar.png",
									new BMap.Size(32, 70), {
										offset : new BMap.Size(0, -5),
										imageOffset : new BMap.Size(0, 0)
									});
							// 创建标注对象并添加到地图     
			var marker = new BMap.Marker(point, {
								icon : myIcon
							});
			map.addOverlay(marker);
		    marker.addEventListener("click",function() {
			       this.openInfoWindow(infoWindow); // 打开信息窗口
						});
        //设置覆盖物的参数，中心坐标，半径，颜色
		var circle = new BMap.Circle(point, 6000, {
			fillColor : "black",
			strokeWeight : 1,
			fillOpacity : 0.3,
			strokeOpacity : 0.3
		});
		map.addOverlay(circle);//在地图上显示圆形覆盖物
		map.centerAndZoom(point, 12); // 初始化地图，设置中心点坐标和地图级别
		map.enableScrollWheelZoom(); //启用地图滚轮放大缩小
		map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl()); //添加缩略地图控件
	</script>

</body>
</html>
