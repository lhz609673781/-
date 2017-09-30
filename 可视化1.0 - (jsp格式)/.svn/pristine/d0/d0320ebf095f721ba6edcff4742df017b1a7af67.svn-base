<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    // 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    // 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。 
    pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>	
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<meta http-equiv="content-type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,mininum-scale=1.0 maximum-scale=1.0,user-scalable=no">
<title>物流跟踪</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reset.css">
<style>
        .wrap{
            width:100%;
            padding-top:80px;
            text-align:center;
        }
        .wrap h3{
            margin-bottom:40px;
        }
        .wrap2{
            width:100%;
            text-align:center;
            display: none;
        }
    </style>
</head>
<body>
    <div class="wrap">
        <h3 id="info"></h3>
        <div class="div_img">
            <img id="img" alt="" src="">
        </div>
    </div>
    <div id="enter" class="wrap2">
     <a href="<%=basePath%>view/index.html">进入公众号</a>
    </div>
</body>
<script type="text/javascript">

   var x=document.getElementById("info");
   var img = document.getElementById("img"); 
   (function(){
       getLocation();
    })();
    function getLocation(){
        if (navigator.geolocation){
            navigator.geolocation.getCurrentPosition(showPosition,showError);
        }else{
            x.innerHTML="您的浏览器不支持地理定位.";
            img.src = "<%=basePath%>images/cry.png";
            document.getElementById("enter").style.display="block";
        }
    }
    function showPosition(position){
        if(position){
            window.location.href = "<%=basePath%>trace/traceLoc.do?longitude=" + 
            position.coords.longitude + "&latitude="+ position.coords.latitude;
        }else{
             x.innerHTML = "定位失败"+"<br/>"+"请重新扫描";
             img.src = "<%=basePath%>images/cry.png";
             document.getElementById("enter").style.display="block";
        }
    }
    function showError(error){
	    switch(error.code) 
	    {
		case error.PERMISSION_DENIED:
			x.innerHTML="定位失败，您拒绝了对获取地理位置的请求"
			break;
		case error.POSITION_UNAVAILABLE:
			x.innerHTML="定位失败，您的位置信息暂不可获取"
			break;
		case error.TIMEOUT:
			x.innerHTML="定位失败，请求您的地理位置超时"
			break;
		case error.UNKNOWN_ERROR:
			x.innerHTML="定位失败，未知的错误"
			break;
	    }
        img.src = "<%=basePath%>images/cry.png";
        document.getElementById("enter").style.display="block";
    }
 </script>
</html>
