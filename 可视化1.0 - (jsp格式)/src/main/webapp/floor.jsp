<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<link rel="stylesheet" href="<%=basePath %>weixinCss/weui.css">
		<link rel="stylesheet" href="<%=basePath %>weixinCss/jquery-weui.css">
		<link rel="stylesheet" href="<%=basePath %>weixinCss/indexNew.css" />
<style type="text/css">
			.weui-btn_primary {
			    background: #31acfa !important;
			}
		</style><div style="height: 55px;"></div>
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
			var appId = '${appId}';
		    var timestamp = '${timestamp}'; 
		    var nonceStr = '${nonceStr}'; 
		    var signature = '${signature}';
		    var basePath = '<%=basePath%>';
		  $(function() {
		    FastClick.attach(document.body);
		  });
		</script>
		<script src="<%=basePath%>js/weixin.js"></script>
