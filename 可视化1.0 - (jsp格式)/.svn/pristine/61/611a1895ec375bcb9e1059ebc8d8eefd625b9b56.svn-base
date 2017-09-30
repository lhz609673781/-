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
<title>修改手机号</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/weui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/jquery-weui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>weixinCss/demos.css" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/minePhoneEdit.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>weixinCss/index.css?times=<%=times%>" />
</head>
<body ontouchstart style="background-color: #f8f8f8;">
		<div class="weui-cells weui-cells_form margin-top">
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">原手机号</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" id="old-tel" type="tel" value="${user.mobilephone}" readonly>
				</div>
			</div>
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">新手机号</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" id="tel" type="tel" placeholder="请输入新手机号">
				</div>
			</div>
			<div class="weui-cell weui-cell_vcode">
				<div class="weui-cell__hd">
					<label class="weui-label">验证码</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" id="code" type="number" placeholder="请输入验证码">
				</div>
				<div class="weui-cell__ft">
					<button class="weui-vcode-btn" id="getCode" style="cursor: pointer">获取验证码</button>
				</div>
			</div>
		</div>
		<div class='demos-content-padded'>
			<a href="javascript:;" id="showTooltips" class="weui-btn weui-btn_primary">确定</a>
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
	<script>
	
    $(function(){
    	 $('#getCode').click(function(){
    	    	sendCode(this);
    	    });
    	 
	$("#showTooltips").click(function() {
		var tel = $('#tel').val();
		var code = $('#code').val();
		if(!tel || !/1[3|4|5|7|8]\d{9}$/.test(tel)){
			$.toptip('请输入正确的手机号');
		} else if(!code){
			$.toptip('请输入短信验证码');
		} else{
		 $.post('<%=basePath%>weixin/mine/editPhone.html',{phone:tel,code:code},function(data){
			    var $data = JSON.parse(data);
			    if($data.resultCode==200){
			    	$.toast($data.reason,"info");
			    	setTimeout(function() {
			    		location.href="<%=basePath%>weixin/mine.html";
			    	}, 3000);
			    }else{
			    	$.toast($data.reason,"text");
			    }
         },'json');  
			
		}
	 });
    });
	//光标显示在value值后面
	var t=$("#old-tel").val(); 
	$("#old-tel").val("").focus().val(t);
	
    var countdown=60;
    
    function settime(obj) {
        if (countdown == 0) { 
            obj.removeAttribute("disabled");    
            obj.innerHTML="获取验证码"; 
            countdown = 60; 
            return;
        } else { 
            obj.setAttribute("disabled", true); 
            obj.innerHTML= "重新获取("+countdown+")"; 
            countdown--; 
        } 
        setTimeout(function() { 
                settime(obj) 
        },1000)
    }

  //发送验证码
    function sendCode(obj){
        var phonenum = $("#tel").val();
        var result = isPhoneNum();
        if(result){
            doPostBack('<%=basePath%>/user/sendSMS.html',backFunc1,{"mobile":phonenum});
            settime(obj);//开始倒计时
        }
    }
    //将手机利用ajax提交到后台的发短信接口
    function doPostBack(url,backFunc,queryParam) {
        $.ajax({
            async : false,
            cache : false,
            type : 'POST',
            url : url,// 请求的action路径
            data:queryParam,
            error : function() {// 请求失败处理函数
            },
            success : backFunc
        });
    }
    function backFunc1(data){
    	//不做处理
    	console.log(data);
    }

    //校验手机号是否合法
    function isPhoneNum(){
        var phonenum = $("#tel").val();
        if(phonenum=="" || !/1[3|4|5|7|8]\d{9}$/.test(phonenum)){ 
        	$.toptip('请输入正确的手机号');
        	return false;
        }else{
            return true;
        }
    }

</script>
</body>
</html>
