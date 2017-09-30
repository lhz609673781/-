function checkUser() {
	return true;
}

$(function() {
	$('.weui-vcode-btn').click(function() {
		sendCode(this);
	});

	$("#showTooltips").click(function() {
		var tel = $('#tel').val();
		var code = $('#code').val();
		if (!tel || !/1[3|4|5|7|8]\d{9}/.test(tel)) {
			$.toptip('请输入正确的手机号');
		} else if (!code||!/\d{6}/.test(code)) {
			$.toptip('短信验证码有误');
		} else {
			var id = $("#tel").attr("data-id");
			var url = basePath + "user/register_weixin.html";
			var map = {};
			map["id"] = id;
			map["mobilephone"] = tel;
			map["code"] = code;
			console.log(JSON.stringify(map));
			$.ajax({
				url : url, // 请求的url地址
				timeout : 5000,
				dataType : "json",
				data : "param=" + JSON.stringify(map), // 参数值
				type : "POST", // 请求方式
				success : function(data) {
					var $data = JSON.parse(data);
					// 请求成功时处理
					if ($data.resultCode == 200) {
						// 注册成功提示
						$.toast($data.reason);
						var type = $('#type').val();
						if(type!=null&&type!=''){
							var state = $('#state').val();
							if(type==2){
								window.location.href = basePath + 'weixin/myTask.html';
							}else if(type==3){
								window.location.href = basePath + 'weixin/mine/mineResouce.html';
							}else if(type==4){
								var groupId = $('#groupId').val();
								window.location.href = basePath + 'weixin/weixinAuth.html?type='+type+"&groupId="+groupId;
							}else if(type==5){//跳转逻辑修改。
								//window.location.href = basePath + 'weixin/weixinAuth.html?type='+type+"&code="+state;
								window.location.href = basePath + 'weixin/internalScan.html?barCode=' + state;
							}else if(type==6){
								var wayBillId = state.split("-")[0];
								var userId = state.split("-")[1];
								window.location.href = basePath + 'weixin/ToWaybillDetail.html?wayBillId='+wayBillId+"&userId="+userId+"&from=singlemessage";
							}else{
								window.location.href = basePath + 'weixin/toHome.html';
							}
						}else{
							window.location.href = basePath + 'weixin/toHome.html';
						}
					} else if ($data.resultCode == 9999) {
						// 注册失败提示
						$.toast($data.reason,"cancel");
					} else if ($data.resultCode == 400) {
						// 注册失败提示
						$.toast($data.reason,"cancel");
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$.toptip("网络异常，请求失败！","text");
				}
			});

		}
	});
});

var countdown = 60;

function settime(obj) {
	if (countdown == 0) {
		obj.removeAttribute("disabled");
		obj.innerHTML = "获取验证码";
		countdown = 60;
		return;
	} else {
		obj.setAttribute("disabled", true);
		obj.innerHTML = "重新获取(" + countdown + ")";
		countdown--;
	}
	setTimeout(function() {
		settime(obj)
	}, 1000)
}

//发送验证码
function sendCode(obj){
    var phonenum = $("#tel").val();
    var result = isPhoneNum();
    if(result){
    	settime(obj);//开始倒计时
        doPostBack(basePath + 'user/sendSMS.html',backFunc1,{"mobile":phonenum});
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
        	countdown = 0;
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

