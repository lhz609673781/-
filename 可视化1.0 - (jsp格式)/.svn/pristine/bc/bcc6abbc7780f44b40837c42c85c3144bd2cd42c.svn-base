<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>我的</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath %>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/demos.css?times=<%=times%>">
<link rel="stylesheet" href="<%=basePath %>weixinCss/indexNew.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/mine.css?times=<%=times%>" />
</head>

  <body ontouchstart style="background-color: #f8f8f8;">

  <div class="weui-tab">
      <div class="weui-tab__bd">
		<div id="tab3" class="weui-tab__bd-item mine-part  weui-tab__bd-item--active">
        	<div class="mine-part-photo">
        		<img src="<%=basePath%>images/timg2.png"/>
        	</div>
        	<div class="weui-panel">
		        <div class="weui-panel__bd">
		          <div class="weui-media-box weui-media-box_small-appmsg">
		            <div class="weui-cells">
		              <a class="weui-cell weui-cell_access" href="<%=basePath%>weixin/mine/enterEdit/mineNameEdit.html">
		                <div class="weui-cell__hd">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</div>
		                <div class="weui-cell__bd weui-cell_primary text_right">
		                  <p>${user.uname }</p>
		                </div>
		                <span class="weui-cell__ft"></span>
		              </a>
		              <a class="weui-cell weui-cell_access" href="<%=basePath%>weixin/mine/enterEdit/minePhoneEdit.html">
		                <div class="weui-cell__hd">手机号码</div>
						<div class="weui-cell__bd weui-cell_primary text_right">
		                  <p>${user.mobilephone }</p>
		                </div>
		                <span class="weui-cell__ft"></span>
		              </a>
		            </div>
		          </div>
		        </div>
		    </div>
		    <div class="weui-panel">
		        <div class="weui-panel__bd">
		          <div class="weui-media-box weui-media-box_small-appmsg">
		            <div class="weui-cells">
		              <a class="weui-cell weui-cell_access" href="<%=basePath%>weixin/mine/mineResouce.html">
		                <div class="weui-cell__hd"></div>
		                <div class="weui-cell__bd weui-cell_primary">
		                  <p>我的项目组</p>
		                </div>
		                <span class="weui-cell__ft"></span>
		              </a>
		              <a class="weui-cell weui-cell_access" href="<%=basePath%>weixin/mine/attentionUs.html">
		                <div class="weui-cell__hd"></div>
		                <div class="weui-cell__bd weui-cell_primary">
		                  <p>关注公众号</p>
		                </div>
		                <span class="weui-cell__ft"></span>
		              </a>
		            </div>
		          </div>
		        </div>
		    </div>
        </div>
    </div>
<div style="height: 55px;"></div>
<div class="weui-footer weui-footer_fixed-bottom">
  	<div class="weui-flex">
      	<div class="weui-flex__item">
      		<a href="<%=basePath %>weixin/toHomeWeChat.html">
	      		<div class="weui-grid__icon footer-item">
		          	<img src="<%=basePath %>images/index-new.png" alt="">
		        </div>
		        <p class="footer-item-text">首页</p>
	        </a>
      	</div>
      	<div class="weui-flex__item footer-swap">
      		<div class="footer-swap-circle" onclick="scanQRCode()"></div>
      	</div>
      	<div class="weui-flex__item">
      		<a href="<%=basePath %>weixin/mine.html">
      			<div class="weui-grid__icon footer-item">
		          	<img src="<%=basePath %>images/people-center.png" alt="">
		        </div>
		        <p class="footer-item-text">个人中心</p>
      		</a>
      	</div>
    </div>
</div>


		<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
		<script src="<%=basePath%>js/fastclick.js"></script>
		<script src="<%=basePath%>js/jquery-weui.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
		<script>
			var appId = '${appId}'; // 必填，公众号的唯一标识
		    var timestamp = '${timestamp}'; // 必填，生成签名的时间戳
		    var nonceStr = '${nonceStr}'; // 必填，生成签名的随机串
		    var signature = '${signature}';
		    var basePath = '<%=basePath%>';
		  $(function() {
		    FastClick.attach(document.body);
		  });
		</script>
		<script src="<%=basePath%>js/weixin.js?times=<%=times%>"></script>
  </body>
</html>


