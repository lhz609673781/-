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
<title>修改姓名</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css"/>
<link rel="stylesheet" href="<%=basePath%>weixinCss/mineNameEdit.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
</head>
<body ontouchstart style="background-color: #f8f8f8;">
<form id="form">
    <div class="weui-cells margin-top">
      <div class="weui-cell">
        <div class="weui-cell__bd">
          <input class="weui-input" id="inputfocus" type="text" value="${user.uname}">
        </div>
      </div>
    </div>
    <div class='demos-content-padded'>
		<a href="javascript:;" id="" class="weui-btn weui-btn_primary" onclick="editName()">确定</a>
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
<script type="text/javascript">
	//光标显示在value值后面
	var t=$("#inputfocus").val(); 
	$("#inputfocus").val("").focus().val(t); 
	
	
	 function editName(){
         var uname=$("#inputfocus").val(); 
         if(uname==""){
        	 $.toptip('用户昵称必填');
             return ;
         }
         $.post('<%=basePath%>weixin/mine/editName.html',{name:uname},function(data){
                   $.toast(data,"text");
                   location.href="<%=basePath%>weixin/mine.html";
         },'json');    
        }
</script>
	
</body>
</html>