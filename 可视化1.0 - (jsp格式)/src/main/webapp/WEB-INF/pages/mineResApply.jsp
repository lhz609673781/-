<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
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
<title>申请二维码</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/mineResApply.css?times=<%=times%>" />
</head>
<body ontouchstart style="background-color: #f8f8f8;">
<form id="resForm" action="<%=basePath%>weixin/mine/mineResApply.html" method="post">
 <input type="hidden" name="userid" value="${user.id }">
 
	<div class="weui-cells weui-cells_form margin-top">
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label">项目组</label>
			</div>
			<div class="weui-cell__bd">
			  	<select class="weui-select" name="groupid" id="groupid">
			  	   <c:if test="${type==1 }">
			  	   <option value="">--请选择--</option>
			  	   </c:if>
			  	   <c:forEach items="${groupList }" var="group">
		            <option value="${ group.id}">${ group.groupName}</option>
		           </c:forEach>
		        </select>
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label">二维码数</label>
			</div>
			<div class="weui-cell__bd">
			  <input id="number" name="number" class="weui-input" type="number" placeholder="请输入申请条码数量">
			</div>
		</div>	
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label">邮寄地址</label>
			</div>
			<div class="weui-cell__bd">
			  <input id="address" name="address" class="weui-input" type="text" placeholder="请输入邮寄地址">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label">联系人</label>
			</div>
			<div class="weui-cell__bd">
			  <input id="contacts" name="contacts" maxlength="10" class="weui-input" type="text" placeholder="请输入联系人姓名">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
			  <label class="weui-label">联系电话</label>
			</div>
			<div class="weui-cell__bd">
			  <input name="contactNumber" id="contactNumber" class="weui-input" type="tel" placeholder="请输入联系电话">
			</div>
		</div>	
	</div>
	<div class='demos-content-padded'>
		<a href="javascript:;" id="showTooltips" class="weui-btn weui-btn_primary" onclick="sendResourceApp()">确定</a>
	</div>
</form>	<!-- 
    <div class="weui-tabbar weui-footer_fixed-bottom">
        <a href="<%=basePath%>weixin/toHomeWeChat.html" class="weui-tabbar__item">
          <div class="weui-tabbar__icon a_tab1">   
          </div>
          <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="<%=basePath%>weixin/waybill.html" class="weui-tabbar__item">
          <div class="weui-tabbar__icon  a_tab2">
          </div>
          <p class="weui-tabbar__label">任务单</p>
        </a>
        <a href="<%=basePath%>weixin/mine.html" class="weui-tabbar__item weui-bar__item--on">
          <div class="weui-tabbar__icon  a_tab3">
          </div>
          <p class="weui-tabbar__label">我的</p>
        </a>
    </div>
    -->
	<%@include file="/floor.jsp" %>
<script src="<%=basePath%>js/jquery-2.1.4.js" ></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script>
             //提交申请
             function sendResourceApp(){
            
                if(checkResourceApp()==true) {
                     $("#resForm").submit();
                  }
             }    
             
             function checkResourceApp(){
                 
                  var groupid = $("#groupid").val();
                  if(groupid==""){
                	  $.toptip("项目组必选");
                	  return false;
                  }
                  var number = $("#number").val();
                  if(number==""){
                	  $.toptip("二维码数量必填");
                	  return false;
                  }else if(parseInt(number)<1||parseInt(number)>1000){
                	  $.toptip("二维码数量范围1-1000");
                	  return false;
                  }
                  
                  var address = $("#address").val();
                  if(address==""){
                	  $.toptip("邮寄地址必填");
                	  return false;
                  }
                  var contacts = $("#contacts").val();
                  if(contacts==""){
                	  $.toptip("联系人必填");
                	  return false;
                  }
                  var phonenum = $("#contactNumber").val();
                  if(phonenum==""){
                	  $.toptip("手机号码必填");
                	  return false;
                  } else if(!/1[3|4|5|7|8]\d{9}$/.test(phonenum)){
                	  $.toptip("手机号码格式不正确");
                	  return false;
                  }
                  
                  return true;
             }
</script>
</body>
</html>