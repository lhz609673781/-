<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<base href="<%=basePath%>">
<title>任务单</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/waybill.css?times=<%=times%>" />
<style type="text/css">
	*{margin:0; padding:0;}
	a{text-decoration: none;}
	img{max-width: 100%; height: auto;}
	.weixin-tip{display: none; position: fixed; left:0; top:0; bottom:0; background: rgba(0,0,0,0.8); filter:alpha(opacity=80);  height: 100%; width: 100%; z-index: 100;}
	.weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}
</style>
</head>

<body ontouchstart style="background-color: #f8f8f8;">
    <div class="weixin-tip" onclick="hideMask()">
		<p>
			<img src="<%=basePath%>images/live_weixin.png" alt="微信打开"/>
		</p>
	</div>
	<div class="weui-tab">
		<div class="weui-tab__bd">
			<div id="tab2" class="weui-tab__bd-item weui-tab__bd-item--active">
				<!-- 搜索 -->
				<div class="f_search">
					<form id="searchWayBillForm" action="<%=basePath%>weixin/searchWayBill.html" method="post" onsubmit="changeDate()">
					    <div class="weui-flex">
					      <div class="weui-flex__item">
					      	<div class="t_date">
					      		<div class="t_date_hd">
					      			<label for="timedate" class="weui-label">日期</label>
					      		</div>
					      		<div class="t_date_bd">
					      		    <c:if test="${createtime==null}">
					      			    <input class="weui-input" type="text" id="timedate" readonly value="">
					      			</c:if>
					      			<c:if test="${createtime!=null}">
					      			    <input class="weui-input" type="text" id="timedate" readonly value="${createtime}">
					      			</c:if>
					      		</div>
								<p class="t_date_ft weui-icon-clear"></p>
							</div>
					      </div>
					      <div class="weui-flex__item">
					      	<div class="weui-search-bar" id="searchBar">
					      		<i class="weui-icon-search" onclick="doSubmit()"></i>
								<div class="weui-search-bar__form">
									<div class="weui-search-bar__box">
										<input type="search" class="weui-search-bar__input" name="searchData" id="searchData" placeholder="搜索"
											required="" value="${searchData}">
										<input type="hidden" name="createtime" id="time" value="${createtime}">
										<input type="hidden" name="status" id="status" value="${customerid}">
										<a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
									</div>
								</div>
							</div>
					      </div>
					    </div>
					</form>
				</div>
				<!-- tab标签 -->
				<form id="queryStatusForm" action="<%=basePath%>weixin/waybill.html" method="get">
				<input type="hidden" name="customerid" id="customerid" value="${customerid}">
				<input type="hidden" name="createtime" id="createtime">
				</form>
				<div class="tabBtn">
					<div class="weui-flex tab_ul">
						<div class="weui-flex__item tabbtn current">全部</div>
						<div class="weui-flex__item tabbtn">已绑定</div>
						<div class="weui-flex__item tabbtn">运输中</div>
						<div class="weui-flex__item tabbtn">已到货</div>
					</div>
				</div>
				<!--状态改变，数据放在这个box中-->
				<div class="tabCon">
					<c:if test="${empty waybills}">
						<p style="text-align: center;padding:6px 0">未找到相关任务单</p>
    				</c:if>
					<c:forEach items="${waybills }" var="itemMap">
						<div class="barCode-list">
							<div class="barCode-title">
								<p class="text_center">
									${itemMap.key}
								</p>
							</div>
					 		<c:forEach items="${itemMap.value}" var="waybill">
					 		<!-- 消息状态为0时显示背景色和提示信息，否则不返回提示和背景 -->
					 		<c:if test="${waybill.status ==1}">
									<div class="barCode-list-part" style="background:#f0f9ff">
										<div class="bc_part_link" onclick="goBillDetail('${waybill.id }','${waybill.status }')">
											<div class="weui-flex part_top">
												<div>任务单号 :</div>
												<div class="weui-flex__item">${waybill.barcode.barcode }</div>
											</div>
											<div class="weui-flex part_bottom">
												<div>任务摘要 :</div>
												<div class="weui-flex__item">${waybill.orderSummary }</div>
											</div>
											<div class="weui-flex part_bottom">
												<div>收货客户 :</div>
												<div class="weui-flex__item">${waybill.customer.companyName }</div>
											</div>
											<div class="weui-flex part_bottom">
												<div>收货地址 :</div>
												<div class="weui-flex__item">${waybill.customer.address }</div>
											</div>
											<div class="weui-flex last_bottom">有新回单！</div>
										</div>
									<i class="listpart_share" onclick="shareMsg('${waybill.barcode.barcode}','${waybill.orderSummary}',${waybill.id},${user.id},'${itemMap.key}')"></i>
									<c:if test="${waybill.barcode.bindstatus==20}">
									    <span class="btn_mark btn_blue">已绑定</span>
									</c:if>
									<c:if test="${waybill.barcode.bindstatus==30}">
									    <span class="btn_mark btn_green">运输中</span>
									</c:if>
									<c:if test="${waybill.barcode.bindstatus==40}">
									    <span class="btn_mark btn_yellow">已到货</span>
									</c:if> 
								</div>
								</c:if>
								<c:if test="${waybill.status!=1}">
									<div class="barCode-list-part">
										<div class="bc_part_link" onclick="goBillDetail('${waybill.id }','${waybill.status }')">
											<div class="weui-flex part_top">
												<div>任务单号 :</div>
												<div class="weui-flex__item">${waybill.barcode.barcode }</div>
											</div>
											<div class="weui-flex part_bottom">
												<div>任务摘要 :</div>
												<div class="weui-flex__item">${waybill.orderSummary }</div>
											</div>
											<div class="weui-flex part_bottom">
												<div>收货客户 :</div>
												<div class="weui-flex__item">${waybill.customer.companyName }</div>
											</div>
											<div class="weui-flex part_bottom">
												<div>收货地址 :</div>
												<div class="weui-flex__item">${waybill.customer.address }</div>
											</div>
										</div>
									<i class="listpart_share" onclick="shareMsg('${waybill.barcode.barcode}','${waybill.orderSummary}',${waybill.id},${user.id},'${itemMap.key}')"></i>
									<c:if test="${waybill.barcode.bindstatus==20}">
									    <span class="btn_mark btn_blue">已绑定</span>
									</c:if>
									<c:if test="${waybill.barcode.bindstatus==30}">
									    <span class="btn_mark btn_green">运输中</span>
									</c:if>
									<c:if test="${waybill.barcode.bindstatus==40}">
									    <span class="btn_mark btn_yellow">已到货</span>
									</c:if> 
								</div>
							</c:if>
							</c:forEach>
						</div>
					</c:forEach>
				</div>
				<!--tabcon结束-->
			</div>
			<!--tab2结束-->
		</div>
		<!--weui-tab__bd结束-->

		<div class="weui-tabbar weui-footer_fixed-bottom">
			<a href="<%=basePath%>weixin/toHomeWeChat.html" class="weui-tabbar__item">
	          <div class="weui-tabbar__icon a_tab1">   
	          </div>
	          <p class="weui-tabbar__label">首页</p>
	        </a>
	        <a href="<%=basePath%>weixin/waybill.html" class="weui-tabbar__item weui-bar__item--on">
	          <div class="weui-tabbar__icon  a_tab2">
	          </div>
	          <p class="weui-tabbar__label">任务单</p>
	        </a>
	        <a href="<%=basePath%>weixin/mine.html" class="weui-tabbar__item">
	          <div class="weui-tabbar__icon  a_tab3">
	          </div>
	          <p class="weui-tabbar__label">我的</p>
	        </a>
		</div>
	</div>

	<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath%>js/fastclick.js"></script>
	<script src="<%=basePath%>js/jquery-weui.js"></script>
	<script>
	  $(function() {
	         FastClick.attach(document.body);
	         var curIndex = 0;
	         var customerid = ${customerid};
	         if(customerid==20){
			    //已绑定
			    curIndex = 1;
			 }else if(customerid==30){
			   //运输中
			   curIndex = 2;
			}else if(customerid==40){
			  //已到货
			  curIndex = 3;
			 }
	    $('.tabbtn').eq(curIndex).addClass("current").siblings().removeClass('current');
	  });
	</script>
	<script type="text/javascript" src="<%=basePath%>plugin/picker.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
	<script>
	var isDetail=true;
	var global_barcode,global_orderSummary,global_waybillId,global_userId;
	//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    //var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    
    
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
        
        wx.onMenuShareAppMessage({
	   		title : '【千里码】'+global_orderSummary+','+global_createtime+'订单', //分享标题
	   		desc : '任务摘要：'+global_orderSummary, // 分享描述
	   		link : localhostPaht+'/weixin/ToWaybillDetail.html?wayBillId='+global_waybillId+'&userId='+global_userId, //分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
	   		imgUrl : localhostPaht+'/images/logo.png', // 分享图标
	   		type : 'link', // 分享类型,music、video或link，不填默认为link
	   		dataUrl : '', // 如果type是music或video，则要提供数据链接，默认为空
	   		success : function() {
	   			// 用户确认分享后执行的回调函数
	   			$.toptip('分享成功', 'success');
	   		},
	   		cancel : function() {
	   			// 用户取消分享后执行的回调函数
	   		}
   	    });
    });//end_ready
    
    //日期控件
    function changeDate(obj){
    	$("#createtime").val($("#timedate").val());
	    $("#time").val($("#timedate").val());
    }
    
    //选项卡
    $('.tabbtn').click(function() {
        var curIndex = $(this).index();
		$('.tabbtn').eq(curIndex).addClass("current").siblings().removeClass('current');
		/*$('.tabCon .barCode-list').hide().eq($(this).index()).show();*/
		if(curIndex==1){
		 //已绑定
		  $("#customerid").val(20);
		}else if(curIndex==2){
		//任务中
		  $("#customerid").val(30);
		}else if(curIndex==3){
		//已到货
		  $("#customerid").val(40);
		}else{
		//全部
		  $("#customerid").val('');	
		}
		 $("#status").val($("#customerid").val());
		 $("#createtime").val($("#timedate").val());
		 $("#time").val($("#createtime").val());
		 $("#queryStatusForm").submit();
	});
    
    
    //点击x清空日期
     $('.t_date_ft').click(function(){
    	$('#timedate').val('').attr('placeholder','--请选择--');
    	$(this).hide();
    })
	
    //点击x初始化
    closeinit();
    function closeinit(){
    	if($("#timedate").val() == ''){
    		$('.t_date_ft').hide();
    		$("#timedate").attr('placeholder','--请选择--');
    	}else{
    		$('.t_date_ft').show();
    		$("#timedate").attr('placeholder','')
    	}
    }
    
    //日期控件初始化
    $("#timedate").calendar({
        onChange: function (p, values, displayValues) {
          console.log(values, displayValues); 
          $('.t_date_ft').show();
        },
        onClose:function(){
        	doSubmit();
        }
      });
    
    function shareMsg(barcode,orderSummary,waybillId,userId,createtime){
		isDetail=false;//防双click影响
		if(createtime.indexOf('-')>0){//看是时间戳类型还是Date类型
			var srtArray=createtime.split('-');
			createtime=srtArray[0]+"年"+srtArray[1]+"月"+srtArray[2]+"日";
		}else{
			createtime=timeStamp2String(createtime);
		}
		global_createtime=createtime;
		global_barcode=barcode;
		global_orderSummary=orderSummary;
		global_waybillId=waybillId;
		global_userId=userId;

        wx.onMenuShareAppMessage({
	   		title : '【千里码】'+global_orderSummary+','+global_createtime+'订单', //分享标题
	   		desc : '任务摘要：'+global_orderSummary, // 分享描述
	   		link : localhostPaht+'/weixin/ToWaybillDetail.html?wayBillId='+global_waybillId+'&userId='+global_userId, //分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
	   		imgUrl : localhostPaht+'/images/logo.png', // 分享图标
	   		type : 'link', // 分享类型,music、video或link，不填默认为link
	   		dataUrl : '', // 如果type是music或video，则要提供数据链接，默认为空
	   		success : function() {
	   			// 用户确认分享后执行的回调函数
	   			$.toptip('分享成功', 'success');
	   		},
	   		cancel : function() {
	   			// 用户取消分享后执行的回调函数
	   		}
   	    });
        $(".weixin-tip").css("height",$(window).height());
        $(".weixin-tip").show();
	}
    
	//任务单详情
	function goBillDetail(id,status){
		if(isDetail){//防双click影响
			window.location.href = '<%=basePath%>weixin/ToWaybillDetail.html?wayBillId='+id+'&status='+status;
		}
	}
		
	function hideMask(){
		isDetail=true;
        $(".weixin-tip").hide();
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
	
	$("#searchData").keydown(function(evt){
		if(evt.keyCode==13){
			doSubmit();
		}
	});
	
	function doSubmit(){
		if($("#customerid").val()==10){
			$("#customerid").val("");
			$("#status").val("");
		}else{
			$("#status").val($("#customerid").val());
		}
		var data = $("#searchData").val().replace(/(^\s*)|(\s*$)/g, "");
		$("#searchData").val(data);
		if(data!=null&&data!=""){
			$('#searchWayBillForm').submit();
		}else{
			$("#createtime").val($("#timedate").val());
			$("#time").val($("#createtime").val());
			$("#queryStatusForm").submit();
		}
	}
</script>
</body>
</html>


