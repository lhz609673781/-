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
<link rel="stylesheet" href="<%=basePath%>weixinCss/mineProjectTeam.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
</head>
<body  ontouchstart style="background-color: #f8f8f8;">
	
    <div class="weui-cells people_list">
    	<div class="weui-cell">
    	    <c:forEach items="${group.list }" var="groupmember">
		    <a href="<%=basePath%>weixin/mine/groupUserDetail.html?userid=${groupmember.user.id}&groupid=${group.id}&guserid=${group.userid}&roleName=${roleMap[groupmember.user.id].role.roleName}&roleid=${roleMap[groupmember.user.id].role.id}" 
		    	class="weui-grid js_grid">
		        <div class="weui-grid__icon">
		          <img src="<%=basePath%>images/timg2.png" alt="">
		        </div>
		        <p class="weui-grid__label">${groupmember.user.uname}</p>
		        <p class="weui-grid__label"><font color='#31aafb'>${roleMap[groupmember.user.id].role.roleName}</font></p>
		    </a>
		    </c:forEach>
		    <c:if test="${group.userid==user.id}">
		    <a href="<%=basePath%>weixin/mine/enterDeleteGroupUser.html?id=${group.id }" class="weui-grid js_grid">
		        <div class="weui-grid__icon deleteP"></div>
		    </a>
		    </c:if>
		</div>
    </div>   

    <div class="weui-cells pl_part2">
		<a class="weui-cell weui-cell_access limitWidth" href="<%=basePath%>weixin/mine/enterEditResGroupName.html?id=${group.id }">
			<div class="weui-cell__hd">
			  <p>项目组名称</p>
			</div>
			<div class="weui-cell__ft">${group.groupName }</div>
		</a>
		<a class="weui-cell weui-cell_access" href="<%=basePath%>weixin/mine/entermMineCard.html?id=${group.id }">
            <div class="weui-cell__hd"></div>
        	<div class="weui-cell__bd">
              <p>组二维码</p>
            </div>
            <div class="weui-cell__ft">
            	<span class="script">分享组二维码邀请组员加入</span>
            	<img src="<%=basePath%>images/icon_erweima.png" alt="" />
			</div>
        </a>
    </div>
    <div class="weui-cells">
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>二维码</p>
            </div>
            <div class="weui-cell__ft"><span>${group.number }</span>/<span>${group.totalNum }</span></div>
          </div>
        </div>
    
    <div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="<%=basePath%>weixin/mine/enterMineResApply.html?type=2&groupId=${group.id }">
            <div class="weui-cell__bd">
              <p>申请二维码</p>
            </div>
            <div class="weui-cell__ft">
            </div>
        </a>
    </div>
     <c:if test="${group.userid!=user.id}">
    <div class='demos-content-padded btn_mbottom'>
			<a href="javascript:;" onclick="delGroup()" class="weui-btn weui-btn_warn">删除并退出</a>
	</div>
	</c:if>
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
  </body>
  <script src="<%=basePath%>js/jquery-2.1.4.js"></script>
 <script src="<%=basePath%>js/jquery-weui.js"></script>
  <script type="text/javascript">
	function delGroup(){
		var memid = ${membersId};
		$.confirm({
		  	title: '确认要删除并退出该组吗',
		  	onOK: function () {
		  	//qingqiu
		     $.post('<%=basePath%>weixin/mine/deleteGroupUser.html',{id:memid},function(data){
		            $.toast(data,"text");
		            location.href = "<%=basePath%>weixin/mine/mineResouce.html";
            },'json');   
		  }
		});
	}
</script>
</html>
