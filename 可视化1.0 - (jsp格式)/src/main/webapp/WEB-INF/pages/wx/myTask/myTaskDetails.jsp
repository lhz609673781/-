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
    <%@include file="../../resourceswx.jsp" %>
  <base href="<%=basePath%>">
    <title>任务详情</title>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/myTaskDetails.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>css/imgShowBig.css?times=<%=times%>" />
<style type="text/css">
	*{margin:0; padding:0;}
	a{text-decoration: none;}
	img{max-width: 100%; height: auto;}
	.weixin-tip{-webkit-touch-callout:default;display: none; position: fixed; left:0; top:0; bottom:0; background: rgba(0,0,0,0.8); filter:alpha(opacity=80);  height: 100%; width: 100%; z-index: 100;}
	.weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}
</style>
</head>

<body ontouchstart style="background:#fafafa;">
	<div class="weixin-tip" onclick="hideMask()">
		<p>
			<img src="<%=basePath%>images/live_weixin.png" alt="微信打开"/>
		</p>
	</div>
	<!--导航-->
	<div class="weui-tab">
		<!--导航条-->
	    <div class="weui-navbar">
	        <a class="weui-navbar__item weui-bar__item--on" href="#task-tab1">
	          	任务详情
	        </a>
	        <a class="weui-navbar__item " href="#task-tab2" onclick="init();">
	          	查看轨迹
	        </a>
	        <a class="weui-navbar__item" href="#task-tab3">
	         	查看回单
	        </a>
	        <a class="weui-navbar__item" href="#task-tab4">
	         	异常信息
	        </a>
	    </div>
	    <!--导航内容-->
	    <div class="weui-tab__bd">
	    	<!--任务详情-->
	        <div id="task-tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
	        	<!--提示信息-->
	        	<div class="task-detail-tips">
	        		<div class="weui-flex">
						<div class="weui-flex__item">
							 <c:if test="${barCodeEntity.bindstatus==20}">
								<p>绑定中<span style="color: #f00"><c:if test="${waybill.delay==true}">（延迟）</c:if></span></p>
							</c:if>
							<c:if test="${barCodeEntity.bindstatus==30}">
							    <p>运输中<span style="color: #f00"><c:if test="${waybill.delay==true}">（延迟）</c:if></span></p>
							</c:if>
							<c:if test="${barCodeEntity.bindstatus==40}">
								<p>已到货<span style="color: #f00"><c:if test="${waybill.delay==true}">（延迟）</c:if></span></p>
							</c:if>
							<span>
								<c:if test="${waybill.type == 1}">
									<span class="span-info">来源：<em class="color-mark">扫码</em></span>
								</c:if>
								<c:if test="${waybill.type == 2}">
									<span class="span-info">来源：<em class="color-mark">分享</em></span>
								</c:if>
								<c:if test="${waybill.type == 3}">
									<span class="span-info">来源：<em class="color-mark">${groupName}</em></span>
								</c:if>
							</span>
						</div>
						<div class="weui-flex__item">
							<p class="color-mark">${waybill.totalTime}</p>
							<span>已运天数</span>
						</div>
						<div class="weui-flex__item">
							<p class="color-mark">
								<c:if test="${waybill.numOfREPORT>999}">999+</c:if>
								<c:if test="${waybill.numOfREPORT<=999}">${waybill.numOfREPORT}</c:if>
							</p>
							<span>定位次数</span>
						</div>
					</div>
	        	</div>
	        	<!--任务详情内容-->
	          	<div class="task-list-item-con">
					<div class="task-list-item-part">
						<div class="weui-flex">
							<div class="task-con-title"><span class="w4">送货单号</span> :</div>
							<div class="weui-flex__item wrap-line">${waybill.deliveryNumber}</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w4">收货客户</span> :</div>
							<div class="weui-flex__item">${customer.companyName }</div>
						</div>
						<div class="weui-flex"> 
							<div class="task-con-title"><span class="w4">收货地址</span> :</div>
							<div class="weui-flex__item">${customer.address}</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w4">任务摘要</span> :</div>
							<div class="weui-flex__item" id="orderSummary">${waybill.orderSummary}</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w2">重量</span> :</div>
							<div class="weui-flex__item">${waybill.weight }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w2">体积</span> :</div>
							<div class="weui-flex__item">${waybill.volume }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w2">数量</span> :</div>
							<div class="weui-flex__item">${waybill.number }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w3">收货人</span> :</div>
							<div class="weui-flex__item">${customer.contacts }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w2">手机</span> :</div>
							<div class="weui-flex__item">${customer.contactNumber}</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w2">座机</span> :</div>
							<div class="weui-flex__item">${customer.tel}</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w4">任务单号</span> :</div>
							<div class="weui-flex__item">${barCodeEntity.barcode}</div>
						</div>
						<div class="weui-flex">
							<div class="light-color"><span class="w5">要求到货时间</span> :</div>
							<div class="weui-flex__item"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.arrivaltime}" /></div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w4">发货时间</span> :</div>
							<div class="weui-flex__item"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.createtime}" /></div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title"><span class="w4">到货时间</span> :<br />(回单时间)</div>
							<div class="weui-flex__item"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.actualArrivalTime}" /></div>
						</div>	
					</div>
				</div>
	        </div>
	        <!--查看轨迹-->
	        <div id="task-tab2" class="weui-tab__bd-item">
	          	<!--这里放地图-->
	          	<div class="transport-map"  id="mapContainer">
	          		
	          	</div>
	        </div>
	        <!--查看回单-->
	        <div id="task-tab3" class="weui-tab__bd-item">
	          	<div class="check-waybill">
	          		<div class="task-list-item-con">
	          		<c:if test="${receipts == null}">
	          			<div class="task-project-tips" style="text-align: center;">
							<p>
								<span><em class="color-mark">暂无数据</em></span>
							</p>
						</div>
	          		</c:if>
	          		<c:if test="${receipts != null}">
	          		<c:forEach items="${receipts}" var="receipt">
	          			<!--回单循环开始-->
	          			<div class="task-list-item-part">
						    <div class="weui-flex">
						      	<div class="task-con-title"><span class="w4">上传时间</span> :</div>
						      	<div class="weui-flex__item part_right"><fmt:formatDate pattern="yyyy年MM月dd日  HH:mm" value="${receipt.createtime}" /></div>
						    </div>
						    <div class="weui-flex">
						      	<div class="task-con-title"><span class="w3">上传人</span> :</div>
						      	<div class="weui-flex__item part_right"><span style='color:#30aafa' onclick="EFTPWX.phone('${receipt.user.mobilephone}')">${receipt.user.mobilephone}</span></div>
						    </div> 
						    <ul class="waybill-img clearfix">
						    	<c:forEach items="${receipt.list}" var="address">
						    		<li><img src="${imagePath}${address.path}" alt=""/></li>
						    	</c:forEach>
						    </ul>
			          		</div> <!--回单循环结束-->
			          	</c:forEach>
	          		</c:if>
	          		</div>
	          	</div>
	        </div>
	        <!--异常信息-->
	        <div id="task-tab4" class="weui-tab__bd-item">
	          	<div class="check-waybill">
	          		<div class="task-list-item-con">
	          		<c:if test="${exceptionRepor == null}">
	          			<div class="task-project-tips" style="text-align: center;">
							<p>
								<span><em class="color-mark">暂无数据</em></span>
							</p>
						</div>
	          		</c:if>
	          		<c:if test="${exceptionRepor != null}">
	          			<c:forEach items="${exceptionRepor}" var="execepor">
	          			<!--回单循环开始-->
	          				<div class="task-list-item-part">
		          				<div class="weui-flex">
							      	<div class="task-con-title"><span class="w4">异常情况</span> :</div>
							      	<div class="weui-flex__item">${execepor.content}</div>
							    </div>
							    <div class="weui-flex">
							      	<div class="task-con-title"><span class="w4">上报时间</span> :</div>
							      	<div class="weui-flex__item part_right"><fmt:formatDate pattern="yyyy年MM月dd日  HH:mm" value="${execepor.createtime}" /></div>
							    </div>
							    <div class="weui-flex">
							      	<div class="task-con-title"><span class="w3">上报人</span> :</div>
							      	<div class="weui-flex__item part_right"><span style='color:#30aafa' onclick='EFTPWX.phone("${execepor.user.mobilephone}")'>${execepor.user.mobilephone}</span></div>
							    </div> 
							    <ul class="waybill-img clearfix">
								    <c:forEach items="${execepor.list}" var="address">
								    		<li><img src="${imagePath}${address.path}" alt="" /></li>
							    	</c:forEach>
							    </ul>
			          		</div> <!--回单循环结束-->
			          	</c:forEach>
	          		</c:if>
	          		</div>
	          	</div>
	        </div>
	    </div>
    </div>
	<!--底部导航-->
	<div class="weui-footer weui-footer_fixed-bottom">
	  	<div class="weui-flex">
	      	<div class="weui-flex__item">
	      		<a href="javascript:shareMsg('${barCodeEntity.barcode}','${waybill.orderSummary}','${waybill.id}','${userId}','${createtimestr}');">
		      		<div class="weui-grid__icon footer-item">
			          	<img src="images/f-share-icon.png" alt="">
			        </div>
			        <p class="footer-item-text color-share">分享</p>
		        </a>
	      	</div>
	     
	      	<div class="weui-flex__item">
	      		<form id="ReceiptUpForm" class="color_green" action="weixin/ReceiptUp.html" method="post">
	      			<input type="hidden" name="wayBillId" value="${wayBillId}"/>
				    <input type="hidden" name="shareId"  value="${shareId}"/>
		      		<a href="javascript:void(0);"  onclick="doSubmit('ReceiptUp')">
		      			<div class="weui-grid__icon footer-item">
				          	<img src="images/f-upload-icon.png" alt="">
				        </div>
				        <p class="footer-item-text color-orange">上传回单</p>
		      		</a>
	      		 </form>
	      	</div>
	      	<div class="weui-flex__item">
	      		<form id="ExceptionUpForm" class="color_red" action="weixin/ExceptionUp.html" method="post">
			        <input type="hidden" name="wayBillId" value="${wayBillId}"/>
			        <input type="hidden" name="shareId"  value="${shareId}"/>
		      		<a href="javascript:void(0);"  onclick="doSubmit('ExceptionUp');">
		      			<div class="weui-grid__icon footer-item">
				          	<img src="images/f-abnormal-icon.png" alt="">
				        </div>
				        <p class="footer-item-text color-red">异常上报</p>
		      		</a>
	      		</form>
	      	</div>
	      	<c:if test="${isGroupMermer==true}">
			    <c:if test="${barCodeEntity.bindstatus!=40}">
				    <div class="weui-flex__item" onclick="confirmArrive()">
			      		<a href="javascript:void(0);">
			      			<div class="weui-grid__icon footer-item">
					          	<img src="images/f-sure-cion.png" alt="">
					        </div>
					        <p class="footer-item-text color-blue" id="ArriveConfirm">确认到货</p>
			      		</a>
			      	</div>
				</c:if>
				<c:if test="${barCodeEntity.bindstatus==40}">
				    <div class="weui-flex__item">
			      		<a href="javascript:void(0);">
			      			<div class="weui-grid__icon footer-item">
					          	<img src="images/f-sure-cion.png" alt="">
					        </div>
					        <p class="footer-item-text color-blue">已到货</p>
			      		</a>
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
<script type="text/javascript" src="<%=basePath%>js/commons/Date.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/commons/basewx.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/commons/wxImage.js" ></script>

<script>
	var appId='${appId}';
	var timestamp='${timestamp}';
	var nonceStr='${nonceStr }';
	var signature='${signature}';
	var canConfirm=true;
	var global_barcode='${barCodeEntity.barcode}';
	var global_orderSummary=$("#orderSummary").val();
	var global_waybillId='${wayBillId}';
	var global_createtime=FormatDate('${createtime}');
	var global_userId='${userId}'

	$('.dl_part_show').click(function(){
		var $parent = $(this).parent('.yb_detail_list');
		 if($parent.hasClass('js_show')){
            $parent.removeClass('js_show');
        }else{
            $parent.addClass('js_show');
        }
	})
	
	
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
	  		  	EFTPWX.getListById('<%=basePath%>weixin/CheckRolePermission.html',{wayBillId:global_waybillId,checkURI:'confirmArrive'},function(data){
  					   var resultInfo = eval('(' + data + ')');
  					   if(resultInfo.havePermission==true){
  						  //确认收货后的操作
  			              EFTPWX.getListById('<%=basePath%>trace/confirmArrive.html',{id:global_waybillId},function(data){
  			               $.toast(data,"text");
  			               if(data=='操作成功'){
  			            	   $('#ArriveConfirm').text('已到货'); 
  			            	   $(".weui-flex__item").removeAttr("onclick");
  			            	   canConfirm=false;
  			               }
  			              });
  					   }else{
  						   $.toast("您没有权限对此任务单进行确认到货操作");
  					   }
  				   })
	  		  }
	  		});
	    }
     }
	
	function doSubmit(type){
		EFTPWX.getListById('<%=basePath%>weixin/CheckRolePermission.html',{wayBillId:global_waybillId,checkURI:type},function(data){
			   var resultInfo = eval('(' + data + ')');
			   if(resultInfo.havePermission==true){
				   if(type=='ExceptionUp'){
					   $("#ExceptionUpForm").submit();
				   }else{
					   $("#ReceiptUpForm").submit();
				   }
			   }else{
				  $.toast("您没有此权限");
			   }
		   });
	}
	//动态获得放地图div的高度
	var _height = document.documentElement.clientHeight-105;
	$('.transport-map').height(_height);
	
	//阻止a链接冒泡事件
	$('.weui-navbar__item').click(function(event){
		 event.preventDefault();
	})
	$(function() {
		FastClick.attach(document.body);
	});
	
</script>
<script type="text/javascript" src="<%=basePath%>js/weixin.js?times=<%=times%>" ></script>
<script type="text/javascript" src="<%=basePath%>js/commons/wxMap.js" ></script>
<script type="text/javascript">
	wx.ready(function() {
	    wx.checkJsApi({  
	        jsApiList : [
	                     'checkJsApi',
	                     'onMenuShareAppMessage'],  
	        success : function(res) {
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
</script>
</body>
</html>
    