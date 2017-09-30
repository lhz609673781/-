<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<title>任务单</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath %>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/positionList.css?times=<%=times%>" />
</head>

  <body ontouchstart style="background-color: #f8f8f8;">
        <div id="positionList" class="weui-tab__bd-item">
			<!--选择+搜索-->
    		<div class="f_search">
				<form id="search_form" action="<%=basePath%>weixin/moreLocationList.html" method="post" onsubmit="return moreList();">
					<div class="weui-flex">
				      <div class="weui-flex__item">
				      	<div class="t_date">
			        		<%-- <font color="#ffffff">始运日：</font><input class="" type="date" id="timedate" value="${createtime}"> --%>
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
				      	<div class="weui-search-bar" id="searchBar" >
				      		<i class="weui-icon-search" onclick="doSubmit()"></i>	
							<div class="weui-search-bar__form">
						        <div class="weui-search-bar__box">
						            <input id="searchParam" type="hidden" name="param">
						            <input type="search" class="weui-search-bar__input" id="searchData" name="searchData" placeholder="搜索" 
						            	required="" value="${searchData}">
						            <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
						        </div>
					        </div>    
						</div>
				      </div>
				    </div>	
				</form>
			</div>
			<div class="tabBtn">
				<form id="status_form" action="<%=basePath%>weixin/moreLocationList.html" method="post">
					<input id="param" type="hidden" name="param">
					<input id="curIndex" type="hidden" name="curIndex" value="${status}">
				</form>	
				<div class="weui-flex tab_ul">
					<div id="all" class="weui-flex__item itemTab current" data-param="">全部</div>
					<!-- <div id="bind" class="weui-flex__item tabbtn" data-param="20">已绑定</div> -->
					<div id="way" class="weui-flex__item itemTab" data-param="1">运输中</div>
					<div id= "end" class="weui-flex__item itemTab" data-param="2">已卸货</div>
				</div>
			</div>
		    <!--状态改变，数据放在这个box中-->
		    <div class="tabCon">
		    	<!--一天的任务单-->
		    	<div class="barCode-list">			    	
				   <!--多条任务单-->
				   <c:forEach items="${items}" var="itemMap" varStatus="status">
				    	<div class="barCode-title">
				    		<p class="text_center">${itemMap.key}</p>
					    </div>
					    <c:forEach items="${itemMap.value}" var="item">
				      			<div class="barCode-list-part">
				      			    <a href="<%=basePath%>weixin/ToWaybillDetail.html?wayBillId=${item.id}">
					      				<div class="weui-flex big_size">
									      	<div>任务单号 :</div>
									      	<div class="weui-flex__item pad_left">${item.barcode.barcode }</div>
									    </div>
									    <div class="weui-flex part_bottom">
									      	<div>任务摘要 :</div>
									      	<div class="weui-flex__item pad_left">${item.orderSummary }</div>
									    </div>
									    <div class="weui-flex part_bottom">
											<div>收货客户 :</div>
											<div class="weui-flex__item">${item.customer.companyName }</div>
										</div>
										<div class="weui-flex part_bottom">
											<div>收货地址 :</div>
											<div class="weui-flex__item">${item.customer.address }</div>
										</div>
									    <div class="weui-flex">
									      	<div class="weui-flex__item">已上报次数 :<span class="pad_left">${item.numOfREPORT }</span></div>
									      	<c:if test="${unloadingMap[item.id]==null}">
									      		<div class="weui-flex__item text_right">已运<span>${item.totalTime }</span>天</div>
									      	</c:if>
									    </div>
								    </a>
								    <c:if test="${unloadingMap[item.id]!=null}">
								        <span class="pl_outed">已卸货</span>
								    </c:if>
								    <c:if test="${unloadingMap[item.id]==null}">
								        <span data-waillId="${item.id}" data-userId="${item.userid }" data-path="<%=basePath %>" data-datetime="${item.createtime}" class="pl_out">卸货</span>	
								    </c:if>
				      			</div>
		      			</c:forEach>
				   </c:forEach>
	      		</div>
		    </div>
        </div>
	<script src="<%=basePath %>js/jquery-2.1.4.js"></script>
	<script src="<%=basePath %>js/fastclick.js"></script>
	<script src="<%=basePath %>js/jquery-weui.js"></script>
	<script src="<%=basePath %>plugin/picker.js" ></script>
	<script src="<%=basePath %>js/home.js?times=<%=times%>" ></script>
	<script>
		$(function() {
		    FastClick.attach(document.body);
		    var curIndex = $('#curIndex').val();
			$('.itemTab').eq(curIndex).addClass("current").siblings().removeClass('current');
			
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
		});
		
		$("#searchData").keydown(function(evt){
			if(evt.keyCode==13){
				var data = $("#searchData").val().replace(/(^\s*)|(\s*$)/g, "");
				$("#searchData").val(data);
				$('#search_form').submit();
			}
		});
		
		function doSubmit(){
			var data = $("#searchData").val().replace(/(^\s*)|(\s*$)/g, "");
			$("#searchData").val(data);
			$('#search_form').submit();
		}
	</script>
  </body>
</html>