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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=9ZQIqbGfMnbch4DLAMGk98YwIRgruIpi"></script>
<!--<link rel="stylesheet" href="css/mine.css" />-->
<style>
   .weui-cell{
   	    -webkit-align-items: flex-start;
    	align-items: flex-start;
   }
   .weui-panel:before{border-top:none;}
   .weui-panel__hd{font-size:17px;color:#000;}
    .weui-cell__bd>p{
    	color: #999999;
    	font-size: 16px;
    	line-height: 1.2;
    	padding-left:15px;
    }
    .weui-cell.weui-cell_access{
    	padding:15px;
    }
</style>
</head>

<body ontouchstart style="background-color: #f8f8f8;">
    <input type="hidden" name="userid" id="userid" value="${user.id}"/>
	<div class="weui-panel">
	    <div class="weui-panel__bd">
	      <div class="weui-media-box weui-media-box_small-appmsg">
	        <div class="weui-cells">
	          <div class="weui-cell weui-cell_access" style="text-align: center;">
	            <div class="weui-cell__hd">条 码</div>
	            <div class="weui-cell__bd weui-cell_primary text_right">
	              <input type="text" name="barCode" id="barCode" style="width:250px;height:30px;font-size:20px;"/>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	</div>
    <div class='demos-content-padded'>
		<a href="javascript:void(0);" onclick="toUploadPosition()" id="showTooltips" class="weui-btn weui-btn_primary">确定</a>
	</div>


<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/picker.js" ></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script type="text/javascript">
//跳转上传位置页面
function toUploadPosition() {
	if($('#barCode').val()==null||$('#barCode').val()==''){
		$.toptip("请输入条码号");
		return;
	}
	var barcode=$('#barCode').val();
	$.ajax({
		type : 'POST',
		async: false,  
		url : "<%=basePath%>weixin/barcodeVerifyAjax.html?barcode="+ barcode,
		success : function(data) {
			var flag=true;
			if (data == "500" || data == "400") {
				$.toptip("无效的任务单号");
				flag=false;
			}
			if (data == "9999") {
				$.toptip("系统错误");
				flag=false;
			}
			if (data == "405") {
				$.toptip("权限不足");
				flag=false;
			}
			if(flag){
				window.location.href = '<%=basePath%>weixin/weixinAuth.html?code='+barcode+'&type=5';	
			}
		}
    });
}					
</script>
</body>
</html>


