<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    String path = request.getContextPath();
    // 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    //String app = request.getAttribute("appId")+"";
%>
<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
<base href="<%=basePath%>">
<title>二维码绑定</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath%>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/demos.css">
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
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
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
          <div class="barCode">
                <div class="click-scan">
                    <div class="click-scan-con">
                        <img src="<%=basePath%>images/swap.png" alt="" />
                    </div>
                    <p>点击扫描&nbsp;&nbsp;二维码进行绑定</p>
                    <p style="font-size: 15px;">扫描不上？点击<a href="<%=basePath%>weixin/toAddBarCode.html">手动输入</a></p>
                </div>
                <div class="barCode-title weui-flex ">
                  <div><div class="placeholder"><fmt:formatDate pattern="yyyy-MM-dd" value="${newCreatetime}" /></div></div>
                  <div class="weui-flex__item">已绑定任务单<span class="c_orange">${count} </span></div>
                  <div><a href="<%=basePath%>weixin/waybill.html" style="color:#000000"><i>更多</i></a><span class="s_more"> >> </span></div>
                </div>
                <div class="barCode-list">
                    <c:forEach items="${list}" var="item">
                        <div class="barCode-list-part" onclick="itemDetail(${item.id})">
                            <div class="bc_part_link">
                                <div class="weui-flex part_top">
                                    <div>任务单号 :</div>
                                    <div class="weui-flex__item">${item.barcode.barcode }</div>
                                </div>
                                <div class="weui-flex part_bottom">
                                    <div>任务摘要 :</div>
                                    <div class="weui-flex__item">${item.orderSummary }</div>
                                </div>
                                <div class="weui-flex part_bottom">
									<div>收货客户 :</div>
									<div class="weui-flex__item">${item.customer.companyName }</div>
								</div>
								<div class="weui-flex part_bottom">
									<div>收货地址 :</div>
									<div class="weui-flex__item">${item.customer.address }</div>
								</div>
                            </div>
                            <i class="listpart_share" onclick="shareMsg('${item.barcode.barcode}','${item.orderSummary}',${item.id},${user.id},'${item.createtime}')"></i>
                        	<c:if test="${item.barcode.bindstatus==20}">
							    <span class="btn_mark btn_blue">已绑定</span>
							</c:if>
							<c:if test="${item.barcode.bindstatus==30}">
							    <span class="btn_mark btn_green">运输中</span>
							</c:if>
							<c:if test="${item.barcode.bindstatus==40}">
							    <span class="btn_mark btn_yellow">已到货</span>
							</c:if> 
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    </div>
	<%@include file="/floor.jsp" %>

<script src="<%=basePath%>js/fastclick.js"></script>
  </body>
</html>