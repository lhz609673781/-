<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>我的任务</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/myTask.css" />
</head>
<body ontouchstart style="background:#fafafa;">
 <form id="searchMyTaskForm" action="<%=basePath%>weixin/myTask.html" method="post">
	<div class="check-task-search">
		<div class="weui-flex">
			<div class="weui-flex__item relative">
				<i class="weui-icon-search"></i>
				<input class="task-search-input" type="text" name="searchData" id="searchData" value="${searchData}" />
				<a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
			</div>
			<div id="search-btn" class="task-search-btn">
				<button onclick="onSubmit()" class="weui-btn weui-btn_mini weui-btn_primary">搜索</button>
			</div>
		</div>	
	</div>
	<div class="task-status">
		<div class="weui-flex">
	      	<div class="weui-flex__item deliver-time">
	      		发货时间
	      		<input id="createtime" name="createtime" type="text" value="${createtime}" class="task-s-time" />
	      		<span class="select-down"></span>
	      		<span class="select-del weui-icon-clear"></span>
	      	</div>
	      	<div class="weui-flex__item task-s">
	      		<select id="bindstatusSear" name="status" class="change-value"  onchange="onSubmit()">
	      			<option value="" selected="selected">任务状态</option>
	      			<option value="0">全部</option>
	      			<option value="20" <c:if test="${bindstatus==20 }">selected</c:if>>已绑定</option>
	      			<option value="30" <c:if test="${bindstatus==30 }">selected</c:if>>运输中</option>
	      			<option value="40" <c:if test="${bindstatus==40 }">selected</c:if>>已完成</option>	      		</select>
	      		<span class="select-down"></span>
	      	</div>
	      	<div class="weui-flex__item task-s-all">
	      		<select id="delaySear" name="delay" class="change-value" onchange="onSubmit()">
					<option value="null"  <c:if test="${delay==null}">selected</c:if>>全部</option>
	      			<option value="true" <c:if test="${delay==true }">selected</c:if>>延迟</option>
	      			<option value="false" <c:if test="${delay==false}">selected</c:if>>正常</option>
	      		</select>
	      		<span class="select-down"></span>
	      	</div>
	    </div>
	</div>
</form>
	<!--任务单内容-->
	<div id="contentDiv"></div>
    <div id="loadMsg" class="weui-loadmore"><span class="weui-loadmore__tips">上拉加载更多</span></div>
	<%-- <div id="showData" class="task-list-con">
		<c:if test="${empty resutl }">
			<p style="text-align:center;">暂无数据。。。</p>
		</c:if>
		<c:if test="${not empty resutl }">
			<!--带日期循环从这开始-->
		<c:forEach items="${resutl}" var="item">
		<div class="task-list-item">
			<p class="task-list-item-title">${item.key}</p>
			<div class="task-list-item-con">
				<!--日期里面内容循环从这开始-->
				<c:forEach items="${item.value}" var="waybill">
				<div class="task-list-item-part">
					<input class="wayId" type="hidden" value="${waybill.id }">
					<input class="shareId" type="hidden" value="${waybill.shareid }">
					<div class="weui-flex">
						<div class="task-con-title">送货单号 :</div>
						<div class="weui-flex__item one-line-hide title-right">${waybill.deliveryNumber }</div>
					</div>
					<div class="weui-flex">
						<div class="task-con-title">收货客户 :</div>
						<div class="weui-flex__item one-line-hide">${waybill.companyName }</div>
					</div>
					<div class="weui-flex">
						<div class="task-con-title">收货地址 :</div>
						<div class="weui-flex__item more-line-hide">${waybill.companyAddress }</div>
					</div>
					<div class="weui-flex">
						<div class="task-con-title">任务摘要 :</div>
						<div class="weui-flex__item one-line-hide">${waybill.orderSummary }</div>
					</div>
					
					<div class="pbox">发货时间：<span class="upload-task-time1">
						<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.createtime }" />
            		</span></div>
					<div class="pbox">要求到货时间：<span class="upload-task-time2">
						<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.arrivaltime }" />
					</span></div>
					<div class="pbox">实际到货时间：<span class="upload-task-time2">
						<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${waybill.actualArrivalTime }" />
					</span></div>
					<div class="pbox">
					<input class="source" type="hidden" value="${waybill.type }">
					<input class="numOfReport" type="hidden" value="${waybill.numOfREPORT }">
					<input class="totalTime" type="hidden" value="${waybill.totalTime }">
					<input class="bindstatus" type="hidden" value="${waybill.bindstatus }">
					<input class="delay" type="hidden" value="${waybill.delay }">
						<c:if test="${waybill.type == 1}">
							<span class="span-info">任务来自：<em class="color-mark">扫码</em></span>
							<span class="span-info">已运：<em class="color-mark">${waybill.totalTime }</em>天</span>
							<span class="span-info">已定位：<em class="color-mark">${waybill.numOfREPORT }</em>次</span>
					</div>
							<a href="<%=basePath%>weixin/ReceiptUp.html?wayBillId=${waybill.id }" class="upload-task-link">上传回单</a>
						</c:if>
						<c:if test="${waybill.type == 2}">
							<span class="span-info">任务来自：<em class="color-mark">${waybill.shareName }</em></span>
							<span class="span-info">共运：<em class="color-mark">${waybill.totalTime }</em>天</span>
							<span class="span-info">共定位：<em class="color-mark">${waybill.numOfREPORT }</em>次</span>
					</div>
							<a href="<%=basePath%>weixin/ReceiptUp.html?wayBillId=${waybill.id }&shareId=${waybill.shareid }" class="upload-task-link">上传回单</a>
						</c:if>
					
					
					<c:if test="${waybill.delay ==true }">
						<span class="upload-task-status status-delay color-red">已延迟</span>
					</c:if>
					<c:if test="${waybill.barcode.bindstatus == 20 }">
						<span class="upload-task-status color-green">已绑定</span>
					</c:if>
					<c:if test="${waybill.barcode.bindstatus == 30 }">
						<span class="upload-task-status color-blue">运输中</span>
					</c:if>
					<c:if test="${waybill.barcode.bindstatus == 40 }">
						<span class="upload-task-status color-gray">已完成</span>
					</c:if>
					<!--运输中 字体颜色color-blue,  已绑定 color-green , 已完成  color-gray-->
				</div><!--日期里面内容循环在这结束-->
				</c:forEach>
			</div>
		</div><!--带日期循环在这结束-->
		</c:forEach>
		</c:if>
	</div> --%>

	<script src="<%=basePath %>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath %>js/fastclick.js"></script>
	<script src="<%=basePath %>js/jquery-weui.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/touch.js" ></script>
	<script type="text/javascript" src="<%=basePath%>plugin/touch.min.js" ></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/status.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/Date.js?times=<%=times%>"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/basewx.js"></script>
	
	<script>
		$(function() {
			FastClick.attach(document.body);
		});
	</script>
	<script type="text/javascript">
		var basePath = '<%=basePath%>';
		
		/* $("#search-btn").click(function (){
			searchMyTask();
		}) */
		//select选择
		/* $("#bindstatusSear,#delaySear").change(function(){
			
			searchMyTask();
		}) */
		//点击添加下划线
		$('.task-status .weui-flex__item').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
		})
		
		//点击任务列表进入任务详情
		$("#contentDiv").delegate('.task-list-item-part','click',function(){
			var id = $(this).find('.wayId').val();
			var shareId = $(this).find('.shareId').val();
			var path=basePath+'weixin/myTaskDetails.html?wayBillId='+id+'&shareId='+shareId;
			window.location.href = path;
		})
		//点击发货时间
		$('.task-s-time').calendar({
			onChange:function(p, values, displayValues){
				$('.task-s-time').css({
					color:'#02afff',
					background:'#fff'
				});
				$('.deliver-time .select-down').hide().siblings('.select-del').show();
			},
			onClose: function (p, values, displayValues) {
	        	onSubmit();
	        }
      	});

		//点击清除发货时间
		$('.deliver-time .select-del').click(function(){
			$('.task-s-time').val('').css({
				color:'transparent',
				background:'transparent'
			});
			$('.deliver-time .select-down').show().siblings('.select-del').hide();
			onSubmit();
		})
		$("#searchClear").click(function (){
			$("#searchData").val('');
		})
		function onSubmit() {
			$("#searchMyTaskForm").submit();
		}
	var keydate	="";
	var flag=0;//1包含0不包含
	//var pageSizeNum=${waybillcount};
	var url= basePath+"weixin/myTaskdata.html";
	var wpagedata= {"searchData":$("#searchData").val(),"createtime":$("#createtime").val(),"status":$("#bindstatusSear").val(),"delay":$("#delaySear").val()};
	function wxpagedata(dataObj){
		var strsss="";
		strsss += "<div class=\"task-list-con\">";
		for(var key in dataObj){
    		if(key=="key"){
    			 strsss += "<p class=\"task-list-item-title\">暂无数据</p>";
    		}else{
    			if(keydate.indexOf(key)<0){
    				keydate+=key;
    				flag=0;
    				strsss += "<div class=\"task-list-item\"><p class=\"task-list-item-title\">"+key+"</p><div class=\"task-list-item-con\">";
    			}else{
    				flag=1;
    			}
    			 var list = dataObj[key];
    			for(var i=0;i<list.length;i++){
						//日期里面内容循环从这开始
						strsss += '<div class="task-list-item-part">'
						strsss +='<input class="wayId" type="hidden" value="'+list[i].id+'">'
						strsss +='<input class="shareId" type="hidden" value="'+list[i].shareid+'">'
						strsss += '<div class="weui-flex">'
						strsss += '<div class="task-con-title">送货单号 :</div>'
						if (list[i].deliveryNumber == null || list[i].deliveryNumber == undefined) {
							strsss += '<div class="weui-flex__item one-line-hide title-right"></div>'
						}else{
							strsss += '<div class="weui-flex__item one-line-hide title-right">'+list[i].deliveryNumber+'</div>'
						}
						strsss += '</div>'
						strsss += '<div class="weui-flex">'
						strsss += '<div class="task-con-title">收货客户 :</div>'
						if (list[i].companyName == null || list[i].companyName == undefined) {
							strsss += '<div class="weui-flex__item one-line-hide"></div>'
						}else{
							strsss += '<div class="weui-flex__item one-line-hide">'+list[i].companyName+'</div>'
						}
						strsss += '</div>'
						strsss += '<div class="weui-flex">'
						strsss += '<div class="task-con-title">收货地址 :</div>'
						if (list[i].companyAddress == null || list[i].companyAddress == undefined) {
							strsss += '<div class="weui-flex__item more-line-hide"></div>'
						}else{
							strsss += '<div class="weui-flex__item more-line-hide">'+list[i].companyAddress+'</div>'
						}
						strsss += '</div>'
						strsss += '<div class="weui-flex">'
						strsss += '<div class="task-con-title">任务摘要 :</div>'
						if (list[i].orderSummary == null || list[i].orderSummary == undefined) {
							strsss += '<div class="weui-flex__item one-line-hide"></div>'
						}else{
							strsss += '<div class="weui-flex__item one-line-hide">'+list[i].orderSummary+'</div>'
						}
						strsss += '</div>'
						strsss += '<div class="pbox">发货时间：<span class="upload-task-time1">'+DateTimeToString(list[i].createtime)+'</span></div>'
						strsss += '<div class="pbox">要求到货时间：<span class="upload-task-time2">'+DateTimeToString(list[i].arrivaltime)+'</span></div>'
						strsss += '<div class="pbox">实际到货时间：<span class="upload-task-time2">'+DateTimeToString(list[i].actualArrivalTime)+'</span></div>'
						strsss += '<div class="pbox">'
						strsss += '<input class="source" type="hidden" value="'+list[i].type+'">'
						strsss += '<input class="numOfReport" type="hidden" value="'+list[i].numOfREPORT+'">'
						strsss += '<input class="totalTime" type="hidden" value="'+list[i].totalTime+'">'
						strsss += '<input class="bindstatus" type="hidden" value="'+list[i].bindstatus+'">'
						strsss += '<input class="delay" type="hidden" value="'+list[i].delay+'">'
						if (list[i].type == 1) {
							strsss += '<span class="span-info">任务来自：<em class="color-mark">扫码</em></span>'
							strsss += '<span class="span-info">已运送：<em class="color-mark">'+list[i].totalTime+'</em>天</span>'
							strsss += '<span class="span-info">已定位：<em class="color-mark">'+list[i].numOfREPORT+'</em>次</span>'
							strsss += '</div>'
							strsss += '<a href="'+basePath+'weixin/ReceiptUp.html?wayBillId='+list[i].id+'" class="upload-task-link">上传回单</a>'
						}
						if (list[i].type == 2) {
							strsss += '<span class="span-info">任务来自：<em class="color-mark">'+list[i].shareName+'</em></span>'
							strsss += '<span class="span-info">总共运送：<em class="color-mark">'+list[i].totalTime+'</em>天</span>'
							strsss += '<span class="span-info">总共定位：<em class="color-mark">'+list[i].numOfREPORT+'</em>次</span>'
							strsss += '</div>'
							strsss += '<a href="'+basePath+'weixin/ReceiptUp.html?wayBillId='+list[i].id+'&shareId='+list[i].shareid+'" class="upload-task-link">上传回单</a>'
						}
						if (list[i].delay == true) {
							strsss += '<span class="upload-task-status status-delay color-red">已延迟</span>'
						}
						if (list[i].barcode.bindstatus == 20) {
							strsss +='<span class="upload-task-status color-green">已绑定</span>'
						}
						if (list[i].barcode.bindstatus == 30) {
							strsss +='<span class="upload-task-status color-blue">运输中</span>'				
						}
						if (list[i].barcode.bindstatus == 40) {
							strsss +='<span class="upload-task-status color-gray">已完成</span>'
						}
						strsss += '</div>';
    			}
    			if(flag==0){
    				strsss +="</div></div>";
    			}
    		}
		}
		strsss +="</div>";
		return strsss;
	}
	</script>
	<script type="text/javascript" src="<%=basePath%>js/commons/pageDateWx.js?times=<%=times%>"></script>
	<%@include file="/floor.jsp" %>
</body>
</html>