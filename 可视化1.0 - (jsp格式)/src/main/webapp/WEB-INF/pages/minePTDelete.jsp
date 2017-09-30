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
<meta charset="UTF-8">
<title></title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/minePTDelete.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
</head>
<body  ontouchstart style="background-color: #f8f8f8;">
	
    <div class="weui-cells people_list">
    	<div class="weui-cell">
		    <c:forEach items="${group.list }" var="groupmember" varStatus="vs">
			    <div class="weui-grid js_grid">
			        <div class="weui-grid__icon">
			          <img src="<%=basePath%>images/timg2.png" alt="">
			          <c:if test="${vs.count!=1}">
			          	<i class="delP" onclick="deleteItem(this)"></i>
			          </c:if>
			          <input class="userid" type="hidden" value="${groupmember.id }">
			        </div>
			        <p class="weui-grid__label">${groupmember.user.uname }</p>
			    </div>
		    </c:forEach>
		</div>
    </div>  
	<!-- 
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
<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script>
  $(function() {
    FastClick.attach(document.body);
  });
</script>
<script type="text/javascript">
	function deleteItem(obj){
		var memid = $(obj).next().val();
		var $parent = $(obj).parents('.js_grid');
		$.confirm({
		  	title: '确认删除吗',
		  	onOK: function () {
		  	//qingqiu
		     $.post('<%=basePath%>weixin/mine/deleteGroupUser.html',{id:memid},function(data){
		           if(data=="success"){
		            $parent.remove();
		           }else{
		            $.toast(data,"text");
		           }	
            },'json');   
		  }
		});
	}
</script>
</body>
</html>
