
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
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
<title>二维码绑定</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" href="<%=basePath %>weixinCss/weui.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/jquery-weui.css">
<link rel="stylesheet" href="<%=basePath %>weixinCss/demos.css">
<style>
    /*首页部分*/
    #tab1 .click-scan{
        /*margin:auto;*/
        padding:20px 0;
        text-align: center;
        background:#30aafa;
        
    }
    #tab1 .click-scan-con,.mine-part-photo{
        width:90px;
        height:90px;
        /*background:#fff;*/
        /*border-radius: 50%;*/
        margin:0 auto 10px;
        display: -webkit-box;
        display: -webkit-flex;
        display: flex;
    }
    #tab1 .click-scan-con>img,.mine-part-photo>img{
        margin:auto;
        width:70%;
        
    }
    #tab1 .click-scan>p{
        font-size: 18px;
        text-align: center;
        color:#fff;
        
    }
    
    /*公共部分*/
    .text_center{text-align: center;}
    .barCode-title{
        padding:20px 15px;
        color:#636363;
    }
    .barCode-title .weui-flex__item{margin-left:10px;}
    .barCode-title .weui-flex__item .c_orange{color:#ff7f00;margin-left:4px;}
    .barCode-title .s_more{letter-spacing: -4px;}
    .barCode-list{padding:0 15px 10px;}
    .barCode-list{margin-bottom: 60px;}
    .barCode-list-part{
        padding:12px 10px;
        border-radius: 8px;
        background:#fff;
        margin-bottom: 10px;
        border:1px solid #dedede;
        position:relative;
    }
    .barCode-list-part .part_top{margin-bottom: 4px;}
    .barCode-list-part .part_bottom{color:#636363;font-size:15px;}
    .barCode-list-part .weui-flex__item>div{padding-left:4px;}
    .barCode-list-part .listpart_share{
        position:absolute;
        top:12px;
        right:12px;
        width:28px;
        height:26px;
        background:url(images/share.png) no-repeat;
        background-size: 100%;
    }
    .barCode-list-part .listpart_share:active{
        width:28px;
        height:26px;
        background:url(images/share_active.png) no-repeat;
        background-size: 100%;
    }
    /*tab2部分*/
    /*日期+搜索*/
.weui-search-bar{
	border:1px solid #9bdbfd;
	border-right:none;
	border-top-left-radius: 22px;
    border-bottom-left-radius: 22px;
	background:#61c8fc;
	padding:0 10px;	
}
.f_search{
	background:#30aafa;
	padding:20px 0;
}
#tab2 .t_date{/* margin-bottom: 10px;text-align: center; */padding-left:15px;}
#tab2 .t_date>input{background:transparent;outline: none;border:none;font-size:20px;color:#fff;/* padding:8px 0; */}
.weui-search-bar__box .weui-search-bar__input{
	padding:8px 0;
	font-size: 16px;
	text-indent: 4px;
	height:auto;
	line-height: normal;
	color:#fff;
}
.weui-search-bar__label,.weui-search-bar__box{
	background:#61c8fc;
}
.weui-icon-search{
	color: #fff;
	font-size: 20px;
	line-height: 34px;
	padding: 0 4px;
	margin-left:-8px;
}
.weui-search-bar__box{
	padding-left:0;
}
.weui-search-bar__cancel-btn,.weui-search-bar__box .weui-icon-clear{
	line-height:34px;
	color:#fff;
}
.weui-search-bar__box .weui-icon-clear{
	font-size:16px;
	padding:0;
}
.weui-search-bar:before{
	border-top:none;
}
.weui-search-bar:after{
	border-bottom: none;
}
.weui-search-bar__form:after{
	height:0;
	width:0;
}
input::-webkit-input-placeholder {color:#fff;}
input:-ms-input-placeholder {color:#fff;}

/*
  @media all and (max-width:370px){
        #tab2 .tab2_title .fl{float:none;}
        #tab2 .tab2_title .fr{float:none;padding-right:15px;margin-top:10px;}
        #tab2 .t_date,#tab2 .t_search{text-align: center;}
        #tab2 .t_date .t_sel{left:50%;margin-left:80px;}
        #tab2 .t_search{border-right-style:1px solid #9bdbfd;border-radius: 22px;}
        #tab2 .t_search .t_sea{left:16px;}
    }*/
    /*tab2选项卡地址*/
    #tab2 .tabbtn{text-align: center;padding-bottom: 15px;margin-bottom: 10px;}
    #tab2 .tabbtn{padding:10px 0;border-bottom: 2px solid transparent;color:#fff;}
    #tab2 .tabbtn.current{border-bottom: 2px solid #ffff00;}
    
    #tab2 .tabBtn{background:#30aafa;margin-bottom: 10px;}
    #tab2 .tabBtn .tab_ul{padding:0 15px;}
    #tab2 .barCode-title{padding:3px 10px;}
    #tab2 .barCode-list{margin-bottom: 0;padding:5px 15px 0;}
    #tab2 .tabCon{margin-bottom: 80px;}

    
    /*我的部分*/
    #tab3 .mine-part-photo{
        margin:20px auto;
    }
    #tab3.mine-part .weui-panel{border-top:1px solid #e5e5e5;}
    #tab3.mine-part .text_right{text-align: right;padding-right:20px;}
    
    /*导航定位*/
    .weui-footer_fixed-bottom{bottom:0;}
    .weui-tabbar__icon {
        display: inline-block;
        width: 27px;
        height: 27px;
    }
    .weui-tabbar__icon.a_tab1{
        background-image: url(images/icon_nav1.png);    
    }
    .weui-tabbar__icon.a_tab2{
        background-image: url(images/icon_nav2.png);
    }
    .weui-tabbar__icon.a_tab3{
        background-image: url(images/icon_nav3.png);
    }
    .weui-tabbar__icon{
        background-repeat: no-repeat;
        background-position: left bottom;
        background-size:100% auto;
    }
    .weui-tabbar__item.weui-bar__item--on .weui-tabbar__icon{
        background-position: left top;
    }
    .weui-tabbar__item.weui-bar__item--on .weui-tabbar__label{
        color:#31acfa;
    }
</style>
</head>

  <body ontouchstart style="background-color: #f8f8f8;">

    <div class="weui-tab">
      <div class="weui-tab__bd">
        <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
          <div class="barCode">
                <div class="click-scan">
                    <div class="click-scan-con">
                        <img src="images/swap.png" alt="" />
                    </div>

                    <p>点击扫描&nbsp;&nbsp;二维码进行绑定</p>
                </div>
                <div class="barCode-title weui-flex ">
                  <div><div class="placeholder">2017-05-03</div></div>
                  <div class="weui-flex__item"><div class="placeholder">已绑定任务单<span class="c_orange">3</span></div></div>
                  <div class="aLink_more1">更多<span class="s_more"> >> </span></div>
                </div>
                <div class="barCode-list">
                    <c:forEach items="${list}" var="item">
                        <div class="barCode-list-part">
                            <div class="weui-flex part_top">
                                <div><div class="placeholder">任务单号 :</div></div>
                                <div class="weui-flex__item"><div class="placeholder">${item.barcode.bindstatus }</div></div>
                            </div>
                            <div class="weui-flex part_bottom">
                                <div><div class="placeholder">任务摘要 :</div></div>
                                <div class="weui-flex__item"><div class="placeholder">${item.address }</div></div>
                            </div>
                            <i class="listpart_share"></i>
                        </div>
                    </c:forEach>
                </div>
          </div>
        </div>
        <div id="tab2" class="weui-tab__bd-item">
            <!--选择+搜索-->
        	<div class="f_search">
				<form action="">
				    <div class="weui-flex">
				      <div class="weui-flex__item">
				      	<div class="t_date">
							<input class="" type="date" id="timedate" value="2017-4-25">
						</div>
				      </div>
				      <div class="weui-flex__item">
				      	<div class="weui-search-bar" id="searchBar">
				      		<i class="weui-icon-search"></i>
							<div class="weui-search-bar__form">
								<div class="weui-search-bar__box">
									<input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索"
										required="">
									<a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
								</div>
							</div>
						</div>
				      </div>
				    </div>
				</form>
			</div>
            
            <div class="tabBtn">
                <div class="weui-flex tab_ul">
                    <div class="weui-flex__item tabbtn current">全部</div>
                    <div class="weui-flex__item tabbtn">已绑定</div>
                    <div class="weui-flex__item tabbtn">运输中</div>
                    <div class="weui-flex__item tabbtn">已到货</div>
                </div>
            </div>
            <!--状态改变，数据放在这个box中-->
            <div class="tabCon">
                <div class="barCode-list">                  
                    <div class="barCode-title">
                        <p class="text_center">2017-05-03</p>
                    </div>
                    <div class="barCode-list-part">
                        <div class="weui-flex part_top">
                            <div><div class="placeholder">任务单号 :</div></div>
                            <div class="weui-flex__item"><div class="placeholder">12345678901</div></div>
                        </div>
                        <div class="weui-flex part_bottom">
                            <div><div class="placeholder">任务摘要 :</div></div>
                            <div class="weui-flex__item"><div class="placeholder">上海远成物流10吨</div></div>
                        </div>
                        <i class="listpart_share"></i>
                    </div>
                    <div class="barCode-list-part">
                        <div class="weui-flex part_top">
                            <div><div class="placeholder">任务单号 :</div></div>
                            <div class="weui-flex__item"><div class="placeholder">12345678901</div></div>
                        </div>
                        <div class="weui-flex part_bottom">
                            <div><div class="placeholder">任务摘要 :</div></div>
                            <div class="weui-flex__item"><div class="placeholder">上海远成物流10吨</div></div>
                        </div>
                        <i class="listpart_share"></i>
                    </div>
                    <div class="barCode-list-part">
                        <div class="weui-flex part_top">
                            <div><div class="placeholder">任务单号 :</div></div>
                            <div class="weui-flex__item"><div class="placeholder">12345678901</div></div>
                        </div>
                        <div class="weui-flex part_bottom">
                            <div><div class="placeholder">任务摘要 :</div></div>
                            <div class="weui-flex__item"><div class="placeholder">上海远成物流10吨</div></div>
                        </div>
                        <i class="listpart_share"></i>
                    </div> 
                </div>
                <div class="barCode-list">                  
                    <div class="barCode-title">
                        <p class="text_center">2017-02-18</p>
                    </div>
                    <div class="barCode-list-part">
                        <div class="weui-flex part_top">
                            <div><div class="placeholder">任务单号 :</div></div>
                            <div class="weui-flex__item"><div class="placeholder">12345678901</div></div>
                        </div>
                        <div class="weui-flex part_bottom">
                            <div><div class="placeholder">任务摘要 :</div></div>
                            <div class="weui-flex__item"><div class="placeholder">上海远成物流10吨</div></div>
                        </div>
                        <i class="listpart_share"></i>
                    </div>              
                </div>
            </div>
        </div>
        <div id="tab3" class="weui-tab__bd-item mine-part">
            <div class="mine-part-photo">
                <img src="images/icon.png"/>
            </div>
            <div class="weui-panel">
                <div class="weui-panel__bd">
                  <div class="weui-media-box weui-media-box_small-appmsg">
                    <div class="weui-cells">
                      <a class="weui-cell weui-cell_access" href="mineNameEdit.html">
                        <div class="weui-cell__hd">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</div>
                        <div class="weui-cell__bd weui-cell_primary text_right">
                          <p>张三</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                      </a>
                      <a class="weui-cell weui-cell_access" href="minePhoneEdit.html">
                        <div class="weui-cell__hd">手机号码</div>
                        <div class="weui-cell__bd weui-cell_primary text_right">
                          <p>18326137890</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                      </a>
                    </div>
                  </div>
                </div>
            </div>
            <div class="weui-panel">
                <div class="weui-panel__bd">
                  <div class="weui-media-box weui-media-box_small-appmsg">
                    <div class="weui-cells">
                      <a class="weui-cell weui-cell_access" href="mineResouce.html">
                        <div class="weui-cell__hd"></div>
                        <div class="weui-cell__bd weui-cell_primary">
                          <p>我的资源</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                      </a>
                      <a class="weui-cell weui-cell_access" href="mineResouce.html">
                        <div class="weui-cell__hd"></div>
                        <div class="weui-cell__bd weui-cell_primary">
                          <p>关注公众号</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                      </a>
                    </div>
                  </div>
                </div>
            </div>
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
    </div>
	<%@include file="/floor.jsp" %>

<script src="<%=basePath%>js/jquery-2.1.4.js"></script>
<script src="<%=basePath%>js/fastclick.js"></script>
<script src="<%=basePath%>js/jquery-weui.js"></script>
<script type="text/javascript" src="<%=basePath%>js/picker.js?times=<%=times%>" ></script>
<script type="text/javascript" src="<%=basePath%>js/home.js?times=<%=times%>" ></script>
  </body>
</html>
