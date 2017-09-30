<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="./resourceswx.jsp"%>
<meta charset="UTF-8">
<title>选择成员角色</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet"
	href="<%=basePath%>weixinCss/mineProjectTeam.css?times=<%=times%>" />
<link rel="stylesheet"
	href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
</head>
<body style="background-color: #f8f8f8;">
	<div class="weui-cells pl_part2" style="margin-top: -10px;">
		<form id="addRoleForm" action="<%=basePath%>weixin/mine/addUserRole.html" method="post">
			<div class="weui-cells weui-cells_radio">
				<c:forEach items="${rolePermissionList}" var="item">
					<div class="weui-cell weui-check__label" for="${item.role.id}">
						<div class="weui-cell__bd">
						    <label for="${item.role.id}">
								<input type="radio" name="roleid" id="${item.role.id}" value="${item.role.id}" style="margin-right:5px;"/>
								${item.role.roleName}
							</label>
						</div>
						<div class="weui-cell__ft" onclick="Fade(${item.role.id})" id="click${item.role.id}">
							<font size="2px;">查看权限   ＞</font>
						</div>
					</div>
					<div class="weui-cell weui-check__label" id="Permission${item.role.id}" style="display: none;">
						<div class="weui-cell__bd">
						           包含权限：
						    <c:forEach items="${item.permissionList}" var="pItem" varStatus="status">
						        <font color='#31aafb'>${pItem.permissionName}</font>
						        <c:if test="${!empty item.permissionList[status.index+1]}">,</c:if>
						    </c:forEach>
						    <input type="hidden" id="Fade${item.role.id}" value="1"/>
						</div>
					</div>
				</c:forEach>
			</div>

			<input type="hidden" value="${userid}" id="userid" name="userid"> 
			<input type="hidden" value="${roleid}" id="preRoleid" name="preRoleid"> 
			<input type="hidden" value="${groupid}" id="groupid" name="groupid">

			<div class="weui-btn-area">
				<a id="formSubmitBtn" href="javascript:"
					class="weui-btn weui-btn_primary" onclick="submitRole();">提交</a>
			</div>
		</form>
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
</body>
<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script type="text/javascript">
    var groupid = $('#groupid').val();
    var preRoleid = $('#preRoleid').val();
    $('#'+preRoleid).attr("checked", "checked");//默认选中修改前的角色
    
    function Fade(id){
    	var FadeStatus=$('#Fade'+id).val();
    	if(FadeStatus=='1'){
    		$('#click'+id).html("<font size='2px;'>查看权限  ∨</font>");
    		$("#Permission"+id).removeAttr('display');
    		$('#Fade'+id).val('2');
    		$("#Permission"+id).slideDown("normal"); //滑入 
    	}else{
    		$('#click'+id).html("<font size='2px;'>查看权限  ＞</font>");
    		$('#Fade'+id).val('1');
    		$("#Permission"+id).slideUp("normal"); //滑出 
    	}
    }
    
	function submitRole() {
		$('#addRoleForm').submit();
	}
</script>
</html>
