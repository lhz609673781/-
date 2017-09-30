<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>项目组任务</title>
	<meta charset="utf-8">
	<%@include file="./resourceswx.jsp" %>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<meta name="description" content="">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/weui.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/jquery-weui.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>weixinCss/demos.css?times=<%=times%>" />
	<link rel="stylesheet" href="<%=basePath %>weixinCss/projectTeamTask.css?times=<%=times%>" />
	<script src="<%=basePath %>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath %>js/fastclick.js"></script>
	<script src="<%=basePath %>js/jquery-weui.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugin/touch.js" ></script>
	<script type="text/javascript" src="<%=basePath%>plugin/touch.min.js" ></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/status.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/Date.js?times=<%=times%>"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/basewx.js"></script>
</head>

<body style="background:#fafafa;">
	<!--搜索-->
	<form id="searchWayBillForm" action="<%=basePath%>weixin/waybill.html" method="post">
		<div class="check-task-search">
				<div class="weui-flex">
					<div class="weui-flex__item relative">
						<i class="weui-icon-search"></i>
						<input class="task-search-input" type="text" id="searchData" name="searchData" value="${searchData}" />
						<a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
					</div>
					<div class="task-search-btn">
						<a href="javascript:;" onclick="onSubmit()" class="weui-btn weui-btn_mini weui-btn_primary">搜索</a>
					</div>
				</div>
		</div>
		<!--状态筛选-->
		<div class="task-status">
		<div class="task-status-con weui-flex">
			<div class="task-status-item task-project weui-flex__item">
					<select name="groupid" onchange="onSubmit()" class="change-value" id="groupid">
		      			<c:forEach items="${groupMembersList}" var="groupMembers">
		      				<option value="${groupMembers.group.id }"<c:if test="${groupid == groupMembers.group.id}">selected</c:if> >${groupMembers.group.groupName }</option>
		      			</c:forEach>
		      		</select>
				<span class="select-down"></span>
			</div>
	      	<div class="task-status-item deliver-time">
	      		发货时间
	      		<input name="createtime" type="text" id="createtime" class="task-s-time" value="${createtime}"/>
	      		<span class="select-down"></span>
	      		<span class="select-del weui-icon-clear"></span>
	      	</div>
	      	<div class="task-status-item task-s">	
	      		<select name="bindstatus" onchange="onSubmit()" class="change-value" id="bindstatus">
	      			<option value="0">全部</option>
	      			<option value="20" <c:if test="${bindstatus==20 }">selected</c:if>>已绑定</option>
	      			<option value="30" <c:if test="${bindstatus==30 }">selected</c:if>>运输中</option>
	      			<option value="40" <c:if test="${bindstatus==40 }">selected</c:if>>已完成</option>
	      		</select>
	      		<!--<input type="text" value="任务状态">-->
	      		<span class="select-down"></span>
	      	</div>
	      	<div class="task-status-item task-s-all">
	      		<select name="delay"  onchange="onSubmit()" class="change-value" id="delay">
	      			<option value="null"  <c:if test="${delay==null}">selected</c:if>>全部</option>
	      			<option value="true" <c:if test="${delay==true }">selected</c:if>>延迟</option>
	      			<option value="false" <c:if test="${delay==false }">selected</c:if>>正常</option>
	      		</select>
	      		<!--<input type="text" value="全部">-->
	      		<span class="select-down"></span>
	      	</div>
	    </div>
	</div>
	</form>
	<!--到达率-->
	<c:if test="${createtime != null }">
		<div class="task-project-tips hide">
			<div class="t-p-tips-con">
				<span>发货任务<em class="color-mark">10</em></span>
				<span>已到<em class="color-mark">8</em></span>
				<span>按时到达率<em class="color-mark del-margin">80%</em></span>
			</div>
		</div>
	</c:if>
	<!--任务单内容-->
	<div id="contentDiv"></div>
    <div id="loadMsg" class="weui-loadmore"><span class="weui-loadmore__tips">上拉加载更多</span></div>
	<%-- <div class="task-list-con">
		<c:if test="${empty waybills}">
			<p class="waybil-no-data">暂无数据</p>
		</c:if>			
	<c:forEach items="${waybills }" var="itemMap">
		<div class="task-list-item">
			<p class="task-list-item-title">${itemMap.key}</p>	
			<div class="task-list-item-con">
				<!--循环从这开始-->
					<c:forEach items="${itemMap.value}" var="waybill">
					<c:if test="${waybill.status==1}">
					<div data-id="${waybill.id}" data-numOfREPORT="${waybill.numOfREPORT }" data-bindstatus="${waybill.barcode.bindstatus}" class="task-list-item-part"   style="background:#f0f9ff"  onclick="goBillDetail('${waybill.id }','${waybill.status }')">
						<div class="weui-flex">
							<div class="task-con-title">送货单号 :</div>
							<div class="weui-flex__item one-line-hide title-right">${waybill.deliveryNumber }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">收货客户 :</div>
							<div class="weui-flex__item one-line-hide">${waybill.customer.companyName }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">收货地址 :</div>
							<div class="weui-flex__item more-line-hide">${waybill.customer.address }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">任务摘要 :</div>
							<div class="weui-flex__item one-line-hide">${waybill.orderSummary }</div>
						</div>
						
						<div class="pbox">发货时间：<span class="upload-task-time1"><fmt:formatDate value="${waybill.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
						<div class="pbox">要求到货时间：<span class="upload-task-time2"><fmt:formatDate value="${waybill.arrivaltime }" pattern="yyyy-MM-dd HH:mm:ss"/> </span></div>
						<div class="pbox">实际到货时间：<span class="upload-task-time2"><fmt:formatDate value="${waybill.actualArrivalTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </span></div>
						<div class="pbox">
							<span class="span-info">已运：<em class="color-mark">${waybill.totalTime }</em>天</span>
							<span class="span-info">定位次数：<em class="color-mark">${waybill.numOfREPORT }</em>次</span>
						</div>
							<span class="upload-task-status waybill-tips color-orange">有新回单</span>
						<c:if test="${waybill.delay == true }">
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
					</div>
					</c:if>
					<c:if test="${waybill.status!=1}">
					<div data-id="${waybill.id}" data-numOfREPORT="${waybill.numOfREPORT }" data-bindstatus="${waybill.barcode.bindstatus}" class="task-list-item-part"  onclick="goBillDetail('${waybill.id }','${waybill.status }')">
						<div class="weui-flex">
							<div class="task-con-title">送货单号 :</div>
							<div class="weui-flex__item one-line-hide title-right">${waybill.deliveryNumber }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">收货客户 :</div>
							<div class="weui-flex__item one-line-hide">${waybill.customer.companyName }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">收货地址 :</div>
							<div class="weui-flex__item more-line-hide">${waybill.customer.address }</div>
						</div>
						<div class="weui-flex">
							<div class="task-con-title">任务摘要 :</div>
							<div class="weui-flex__item one-line-hide">${waybill.orderSummary }</div>
						</div>
						
						<div class="pbox">发货时间：<span class="upload-task-time1"><fmt:formatDate value="${waybill.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
						<div class="pbox">要求到货时间：<span class="upload-task-time2"><fmt:formatDate value="${waybill.arrivaltime }" pattern="yyyy-MM-dd HH:mm:ss"/> </span></div>
						<div class="pbox">实际到货时间：<span class="upload-task-time2"><fmt:formatDate value="${waybill.actualArrivalTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </span></div>
						<div class="pbox">
							<span class="span-info">已运：<em class="color-mark">${waybill.totalTime }</em>天</span>
							<span class="span-info">定位次数：<em class="color-mark">${waybill.numOfREPORT }</em>次</span>
						</div>
						<c:if test="${waybill.delay == true }">
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
					</div>
					</c:if>
					</c:forEach>
				<!--循环在这结束-->
			</div>
		</div>
		</c:forEach>	
	</div> --%>

	
	<script type="text/javascript">
		
		$(function() {
			FastClick.attach(document.body);
			var sendTime = $('.task-s-time').val();
			if("" != sendTime){
				removeCss();
				$('.deliver-time .select-down').hide().siblings('.select-del').show();
			}
		});
		
		//点击添加下划线
		$('.task-status .task-status-item').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
		})
		
		//点击任务列表进入任务详情
		function goBillDetail(id,status){
			if(status==""){
				status=2;
			}
			var groupName= $("#groupid").find("option:selected").text();
			window.location.href = '<%=basePath%>weixin/ToWaybillDetail.html?wayBillId='+id+'&status='+status+'&groupName='+groupName;
		}
			
		//点击发货时间
		$('.task-s-time').calendar({
	        onChange: function (p, values, displayValues) {
	          console.log(values, displayValues);  
	          if(p.opened){
	        	  removeCss();
	        	  $('.task-s-time').val(values);
		          onSubmit();
		          
	          }
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
		
		function onSubmit() {
			$("#searchWayBillForm").submit();
		}
		
		function removeCss(){
			$('.task-s-time').css('background','#fff');
	        $('.task-s-time').css('color','#02afff');
		}
		$('.weui-icon-clear').click(function name() {
			$('.task-search-input').val("")
		});
	var keydate	="";
	var flag=0;//1包含0不包含
	//var pageSizeNum=${waybillcount};
	var url= "<%=basePath%>weixin/waybilldata.html";
	var wpagedata= {"groupid":$("#groupid").val(),"searchData":$("#searchData").val(),"createtime":$("#createtime").val(),"bindstatus":$("#bindstatus").val(),"delay":$("#delay").val()};
	function wxpagedata(dataObj){
		var strsss="";
		strsss += "<div class=\"task-list-con\">";
		for(var key in dataObj){
    		if(key=="key"){
    			 strsss += "<p class=\"waybil-no-data\">暂无数据</p>";
    		}else{
    			if(keydate.indexOf(key)<0){
    				keydate+=key;
    				flag=0;
    				strsss += "<div class=\"task-list-item\"><p class=\"task-list-item-title\">"+key+"</p><div class=\"task-list-item-con\">";
    			}else{
    				flag=1;
    			}
    			 
    			for(var i=0;i<dataObj[key].length;i++){
    				<!-- 消息状态为0时显示背景色和提示信息，否则不返回提示和背景 -->
    				if(dataObj[key][i].status ==1){
    					strsss += "<div data-id="+dataObj[key][i].id+" data-numOfREPORT="+valueIsNull(dataObj[key][i].numOfREPORT)+" data-bindstatus="+valueIsNull(dataObj[key][i].barcode.bindstatus)+" class=\"task-list-item-part\"   style=\"background:#f0f9ff\" onclick=\"goBillDetail('"+dataObj[key][i].id+"','"+valueIsNull(dataObj[key][i].status)+"')\">";
						strsss += "<div class=\"weui-flex\"> <div class=\"task-con-title\">送货单号 :</div><div class=\"weui-flex__item one-line-hide title-right\">"+valueIsNull(dataObj[key][i].deliveryNumber)+"</div> </div>";
						strsss += "<div class=\"weui-flex\"><div class=\"task-con-title\">收货客户 :</div><div class=\"weui-flex__item one-line-hide\">"+valueAttr(dataObj[key][i].customer,"companyName")+"</div></div>";
						strsss += "<div class=\"weui-flex\"> <div class=\"task-con-title\">收货地址 :</div> <div class=\"weui-flex__item more-line-hide\">"+valueAttr(dataObj[key][i].customer,"address")+"</div> </div>";						
						strsss += "<div class=\"weui-flex\"> <div class=\"task-con-title\">任务摘要 :</div> <div class=\"weui-flex__item one-line-hide\">"+dataObj[key][i].orderSummary+"</div> </div>";						
						strsss += "<div class=\"pbox\">发货时间：<span class=\"upload-task-time1\">"+DateTimeToString(dataObj[key][i].createtime)+"</span></div>";
						strsss += "<div class=\"pbox\">要求到货时间：<span class=\"upload-task-time2\">"+DateTimeToString(dataObj[key][i].arrivaltime)+"</span></div>";
						strsss += "<div class=\"pbox\">实际到货时间：<span class=\"upload-task-time2\">"+DateTimeToString(dataObj[key][i].actualArrivalTime)+"</span></div>";
						strsss += "<div class=\"pbox\"><span class=\"span-info\">已运：<em class=\"color-mark\">"+dataObj[key][i].totalTime+"</em>天</span><span class=\"span-info\">定位次数：<em class=\"color-mark\">"+dataObj[key][i].numOfREPORT+"</em>次</span></div>";					
						strsss += "<span class=\"upload-task-status waybill-tips color-orange\">有新回单</span>";			
    					if(dataObj[key][i].delay==true){
							strsss += "<span class=\"upload-task-status status-delay color-red\">已延迟</span>";
						}
						if(dataObj[key][i].barcode.bindstatus==20){
							strsss += "<span class=\"upload-task-status color-green\">已绑定</span>";
						}
						if(dataObj[key][i].barcode.bindstatus==30){
							strsss += "<span class=\"upload-task-status color-blue\">运输中</span>";
						}
						if(dataObj[key][i].barcode.bindstatus==40){
							 strsss += "<span class=\"upload-task-status color-gray\">已完成</span>";
						}
						strsss += "</div>";	
    				}else if(dataObj[key][i].status!=1){
    					strsss += "<div data-id="+dataObj[key][i].id+" data-numOfREPORT="+valueIsNull(dataObj[key][i].numOfREPORT)+" data-bindstatus="+valueIsNull(dataObj[key][i].barcode.bindstatus)+" class=\"task-list-item-part\"  onclick=\"goBillDetail('"+dataObj[key][i].id+"','"+valueIsNull(dataObj[key][i].status)+"')\">";
						strsss += "<div class=\"weui-flex\"> <div class=\"task-con-title\">送货单号 :</div><div class=\"weui-flex__item one-line-hide title-right\">"+valueIsNull(dataObj[key][i].deliveryNumber)+"</div> </div>";
						strsss += "<div class=\"weui-flex\"><div class=\"task-con-title\">收货客户 :</div><div class=\"weui-flex__item one-line-hide\">"+valueAttr(dataObj[key][i].customer,"companyName")+"</div></div>";
						strsss += "<div class=\"weui-flex\"> <div class=\"task-con-title\">收货地址 :</div> <div class=\"weui-flex__item more-line-hide\">"+valueAttr(dataObj[key][i].customer,"address")+"</div> </div>";						
						strsss += "<div class=\"weui-flex\"> <div class=\"task-con-title\">任务摘要 :</div> <div class=\"weui-flex__item one-line-hide\">"+dataObj[key][i].orderSummary+"</div> </div>";						
						strsss += "<div class=\"pbox\">发货时间：<span class=\"upload-task-time1\">"+DateTimeToString(dataObj[key][i].createtime)+"</span></div>";
						strsss += "<div class=\"pbox\">要求到货时间：<span class=\"upload-task-time2\">"+DateTimeToString(dataObj[key][i].arrivaltime)+"</span></div>";
						strsss += "<div class=\"pbox\">实际到货时间：<span class=\"upload-task-time2\">"+DateTimeToString(dataObj[key][i].actualArrivalTime)+"</span></div>";
						strsss += "<div class=\"pbox\"><span class=\"span-info\">已运：<em class=\"color-mark\">"+dataObj[key][i].totalTime+"</em>天</span><span class=\"span-info\">定位次数：<em class=\"color-mark\">"+dataObj[key][i].numOfREPORT+"</em>次</span></div>";					
    					if(dataObj[key][i].delay==true){
							strsss += "<span class=\"upload-task-status status-delay color-red\">已延迟</span>";
						}
						if(dataObj[key][i].barcode.bindstatus==20){
							strsss += "<span class=\"upload-task-status color-green\">已绑定</span>";
						}
						if(dataObj[key][i].barcode.bindstatus==30){
							strsss += "<span class=\"upload-task-status color-blue\">运输中</span>";
						}
						if(dataObj[key][i].barcode.bindstatus==40){
							 strsss += "<span class=\"upload-task-status color-gray\">已完成</span>";
						}
						strsss += "</div>";	
    				}
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