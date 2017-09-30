<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        <%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="./resourceswx.jsp" %>
<title>选择收货客户</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">

<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script type="text/javascript" src="<%=basePath%>plugin/touch.js" ></script>
<script type="text/javascript" src="<%=basePath%>plugin/touch.min.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/commons/status.js"></script>
<script type="text/javascript" src="<%=basePath%>js/commons/basewx.js"></script>
<script type="text/javascript" src="<%=basePath%>js/commons/pageWx.js?times=<%=times%>"></script>
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">


<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/chooseCustom.css?times=<%=times%>" />

</head>
<body ontouchstart style="background:#f8f8f8;">
    	<!--搜索框-->
    <div class="weui-search-bar" id="searchBar">
      <form id="searchForm" class="weui-search-bar__form" action="<%=basePath%>weixin/customerList.html" method="post">
      	<div class="weui-flex">
      		<div class="weui-flex__item">
		      	<div class="weui-search-bar__box">
		          <i class="weui-icon-search" onclick="onSearch()"></i>
		          <input type="search" class="weui-search-bar__input" id="searchInput" name="companyName" placeholder="输入收货客户名称搜索" value="${companyName}"/>
		          <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
		        </div>
		      </div>
		      <div class=""><a href="<%=basePath%>weixin/toAddCustom.html?bindCode=${bindCode}" class="add_cus weui-btn weui-btn_mini weui-btn_primary">新增客户</a></div>
      	</div>
      	<input name="bindCode" type="hidden" value="${bindCode}"/>
      </form>
    </div>
    <input id="bindCode" name="bindCode" type="hidden" value="${bindCode}"/>
    <script>
	//单选
	$('.position_list').delegate('.sin_check_p','click',function(){
		var $input = $(this).find('.sin_check');
		if($input.is(':checked')){
			$input.attr("checked", false);
			var formid = '#'+$input.val();
			$(formid).submit();
		}else{
			$input.attr("checked", true);
		}
	})

	function doSubmit(){
		var formid = obj.attr("data-id");
		document.getElementById(formid).submit();
	}
	
	$("#searchInput").keydown(function(evt){
		if(evt.keyCode==13){
			onSearch();
		}
	});
	
	function onSearch(){
		$("#searchForm").submit();
	}
	
	var bindCode=$('#bindCode').val();
	var companyName=$('#searchInput').val();
	var url= "<%=basePath%>weixin/pageCustomer.html";
	var wpagedata=  {"bindCode":bindCode,"companyName":companyName};
	function wxpagedata(dataObj){
		var strsss="";
		for(var i=0;i<dataObj.length;i++){
	    			 strsss += "<div class='position_list_part'>"+
		        		    "<a href='<%=basePath%>weixin/chooseCustom.html?bindCode="+bindCode+"&&customerId="+dataObj[i].id+"'>"+
		      		    	"<div class='weui-cell weui-check__label sin_check_p'>"+
		      		        "<div class='weui-cell__hd'>"+
		      		            "<input type='radio' class='weui-check sin_check' name='checkbox1' value='"+dataObj[i].id+"'}'>"+
		      		            "<input name='id' type='hidden' value='"+dataObj[i].id+"'/>"+
		      		            "<i class='weui-icon-checked'></i>"+
		      		        "</div>"+
		      		        "<div class='weui-cell__bd' onclick='doSubmit(this)' data-id='"+dataObj[i].id+"'>"+
		      		          	"<div class='weui-flex big_size'>"+
		      				      	"<div class='cus_left'>收货客户 :</div>"+
		      				      	"<div class='weui-flex__item pad_left'>"+dataObj[i].companyName+"</div>"+
		      				      	"<input name='companyName' type='hidden' value='"+dataObj[i].companyName+"'/>"+
		      				    "</div>"+
		      				    "<div class='weui-flex'>"+
		      				      	"<div class='cus_left'>联系人 :</div>"+
		      				      	"<div class='weui-flex__item pad_left'>"+dataObj[i].contacts+"</div>"+
		      				      	"<input name='contacts' type='hidden' value='"+dataObj[i].contacts+"'/>"+
		      				    "</div>"+
		      				    "<div class='weui-flex'>"+
		      				      	"<div class='cus_left'>联系电话 :</div>"+
		      				      	"<div class='weui-flex__item pad_left'>"+valueIsNull(dataObj[i].contactNumber)+"</div>"+
		      				      	"<input name='contactNumber' type='hidden' value='"+valueIsNull(dataObj[i].contactNumber)+"'/>"+
		      				    "</div>"+
		      				    "<div class='weui-flex'>"+
		      					    "<div class='cus_left'>座机:</div>"+
		      					    "<div class='weui-flex__item pad_left'>"+valueIsNull(dataObj[i].tel)+"</div>"+
		      					    "<input name='tel' type='hidden' value='"+valueIsNull(dataObj[i].tel)+"'/>"+
		      					"</div>"+
		      				    "<div class='weui-flex'>"+
		      				      	"<div class='cus_left'>收货地址 :</div>"+
		      				      	"<div class='weui-flex__item pad_left'>"+dataObj[i].address+"</div>"+
		      				      	"<input name='address' type='hidden' value='"+dataObj[i].address+"'/>"+
		      				    "</div>"+
		      		        "</div>"+   
		      		    "</div>"+
		      	    	"<a href='<%=basePath%>weixin/toEditCustom.html?bindCode="+bindCode+"&&customerId="+dataObj[i].id+"'>"+
		      	    		"<span class='cus_edit'></span>"+
		      	    	"</a>"+	
		      	       "</div>";
		}
		return strsss;
	}
</script>

</body>
</html>
