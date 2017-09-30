//$(document).ready(function(){  
//    alert($.cookie("rmbUser"));  
//    if ($.cookie("rmbUser") == "true") {  
//    $("#chkRememberPwd").attr("checked", true);  
//    $("#username").val($.cookie("username"));  
//    $("#password").val($.cookie("password"));  
//    }  
//});  
   



// 验证输入框为空
function vidate(obj) {
	if (obj.val() == "" || obj.val() == null || obj.val() == undefined) {
		return false;
	}
	return true;
}

function dataValidate() {
	if (!vidate($("#username"))) {
		alert("请输入用户名");
		return false;
	}
//	else{
//		var phone =$("#username").val();
//		if(!(/^1[34578]\d{9}$/.test(phone))){ 
//	        alert("手机号码有误，请重填");  
//	        return false; 
//	    }
//	}
	
	if (!vidate($("#password"))) {
		alert("请输入密码");
		return false;
	}
	return true;
}




//自动添加用户名密码  
//function rememberPwd() { 
//    if ($.cookie("rmbUser") == "true") {  
//        var username=$("#username").val();  
//        if(username==$.cookie("username")){  
//            $("#chkRememberPwd").attr("checked", true);  
//            $("#password").val($.cookie("password"));  
//        }  
//    }  
//}  


function getUser() {
	if (dataValidate()) {
		var user = {
			username:$("#username").val(),
			password:$("#password").val()
	    };
//		document.cookie="username="+$("#username").val();  
//		var date=new Date();
//		var expireDays=10;
//		//将date设置为10天以后的时间
//		date.setTime(date.getTime()+expireDays*24*3600*1000);
//		//将userId和userName两个cookie设置为10天后过期
//		document.cookie="username="+$("#username").val()+"expire="+date.toGMTString();
		$('#login').submit();
	} else {
		return;
	}
}