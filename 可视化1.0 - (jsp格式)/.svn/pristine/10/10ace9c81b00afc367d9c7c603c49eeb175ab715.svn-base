<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
  <%@include file="./resourceswx.jsp" %>
    <title></title>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/reset.css?times=<%=times%>">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bindphonePc.css?times=<%=times%>">
</head>	
<body>
    <div id="loginBox"  data-id="${id}">
        <h1>绑定手机号</h1>
            <div class="control">
                <input type="text" id="tel" name="username" placeholder="请输入手机号" />
                <span class="tips phonetips">手机号有误</span>
            </div>
            <div class="control">
                <input type="password" id="code" name="password" placeholder="请输入验证码" />
                <button class="getcode">获取验证码</button>
                <span class="tips codetips">验证码有误</span>
            </div>
            <input type="button" value="确 定" class="btn-login">
    </div>
    <script type="text/javascript" src="<%=basePath%>js/jquery-2.1.4.js"></script>
    <script>
    var countdown=60;
    $(function(){
    	$('.getcode').click(function(){
    	    sendCode(this);
        });
    	
        $('#tel').blur(function(){
            var tel = $(this).val()
            if(!tel || !/1[3|4|5|7|8]\d{9}/.test(tel)){
               $('.phonetips').show();
               $('#tel').focus();
               return;
           } else{
               $('.phonetips').hide();
         }
    });
    $('.btn-login').click(function(){
        showtips();
    });
    });  
    
    function showtips(){
    	var result = true;
        var tel = $('#tel').val();
        var code = $('#code').val();
        if(!tel || !/1[3|4|5|7|8]\d{9}/.test(tel)){
            $('.phonetips').show();
            $('#tel').focus();
            result = false;
        } else{
            $('.phonetips').hide();
        }
        if(!code || !/\d{6}/.test(code)){
            $('.codetips').show();
            result = false;
        }else{
            $('.codetips').hide();
        }
        if(result){
        //处理注册逻辑 
        var id = $("#loginBox").attr("data-id");
        var map = {};
		map["id"] = id;
		map["mobilephone"] = tel;
		map["code"] = code;
		console.log(JSON.stringify(map));
		var url = "<%=basePath%>user/register_weixin.html";
		doPost(url,map);
        }
    }
    //确定按钮逻辑
    function doPost(url,param) {
    	$.ajax({
			url : url, // 请求的url地址
			timeout : 5000,
			dataType : "json",
			data : "param=" + JSON.stringify(param), // 参数值
			type : "POST", // 请求方式
			success : function(data) {
				var $data = JSON.parse(data);
				// 请求成功时处理
				if ($data.resultCode == 200) {
					// 注册成功提示
					window.location.href = '<%=basePath%>index.html';
				} else if ($data.resultCode == 9999) {
					// 注册失败提示
					alert($data.reason);
				} else if ($data.resultCode == 400) {
					// 注册失败提示
					alert($data.reason);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("网络异常，请求失败！");
			}
		});
    }
    
    function settime(obj) { 
        if (countdown == 0) { 
            obj.removeAttribute("disabled");    
            obj.innerHTML="获取验证码"; 
            countdown = 60; 
            return;
        } else { 
            obj.setAttribute("disabled", true); 
            obj.innerHTML= "重新获取("+countdown+"s)"; 
            countdown--; 
        } 
        setTimeout(function() { 
                settime(obj) 
        },1000)
    }
    
  //发送验证码
    function sendCode(obj){
        var phonenum = $("#tel").val();
        if(phonenum == "" || !(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phonenum))){ 
        	alert('请输入有效的手机号码！');
        	return false;
        }else{
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
        	alert('请输入有效的手机号码！');
        	return false;
        }else{
            return true;
        }
    }

</script>
</body>
</html>