//验证输入框为空
function vidate(obj) {
	if (obj.val() == "" || obj.val() == null || obj.val() == undefined) {
		return false;
	}
	return true;
}
function dataValidate() {
	if (!vidate($("#accountid"))) {
		alert("请输入账号");
		return false;
	}
	if (!vidate($("#accountpass"))) {
		alert("请输入密码");
		return false;
	}
	if (!vidate($("#phone"))) {
		alert("请输入托运人手机");
		return false;
	}else{
		var phone =$("#phone").val();
		if(!(/^1[34578]\d{9}$/.test(phone))){ 
	        alert("托运人手机有误，请重填");  
	        return false; 
	    }
	}
	if (!vidate($("#name"))) {
		alert("请输入姓名");
		return false;
	}
	return true;
}
function add() {
	if (dataValidate()==true) {
		var b = confirm("您确定创建该账号？")
		if (b) {
			$.ajax({    
			    url:basePath+'customer/register.do',// 跳转到 action
			    type:'POST',
			    dataType:"json",
			    data:$('#addCustomer').serialize(),
			    success:function(json) {
			    	var mas = json.mas;
			    	if(mas=="success"){
			    		alert("添加成功！");
				    	window.location.href=basePath+"customer/look.do?pageNo=1&&pageSize=10";
			    	}else if(mas=="error"){
			    		alert("添加失败！");
			    	}else if(mas=="unlogin"){
			    		window.parent.location.href=basePath+"view/login.jsp";
			    	}else {
			    		window.location.href=basePath+"view/error.jsp";
					}
			     },    
			     error:function() {   
			         window.location.href=basePath+'view/error.jsp';    
			     }    
			}); 
		}
	} else {
		return;
	}
}
function edit() {
	if (dataValidate()==true) {
		var b = confirm("您确定修改该账号？")
		if (b) {
			$.ajax({    
			    url:basePath+'customer/revise.do',// 跳转到 action
			    type:'POST',
			    dataType:"json",
			    data:$('#editCustomer').serialize(),
			    success:function(json) {
			    	var mas = json.mas;
			    	if(mas=="success"){
			    		alert("修改成功！");
				    	window.location.href=basePath+"customer/look.do?pageNo=1&&pageSize=10";
			    	}else if(mas=="error"){
			    		alert("修改失败！");
			    	}else if(mas=="unlogin"){
			    		window.parent.location.href=basePath+"view/login.jsp";
			    	}else {
			    		window.location.href=basePath+"view/error.jsp";
					}
			     },    
			     error:function() {   
			         window.location.href=basePath+'view/error.jsp';    
			     }    
			}); 
		}
	} else {
		return;
	}
}




//// 这里使用最原始的js语法实现，可对应换成jquery语法进行逻辑控制  
//var visible=document.getElementById('psw_visible');//text block  
//var invisible=document.getElementById('psw_invisible');//password block  
//var inputVisible = document.getElementById('input_visible');  
//var inputInVisible = document.getElementById('input_invisible');  
////隐藏text block，显示password block  
//function showPsw(){  
//    var val = inputInVisible.value;//将password的值传给text  
//    inputVisible.value = val;  
//    invisible.style.display = "none";    
//    visible.style.display = "";    
//}  
////隐藏password，显示text    
//function hidePsw(){  
//    var val=inputVisible.value;//将text的值传给password    
//    inputInVisible.value = val;   
//    invisible.style.display = "";    
//    visible.style.display = "none";    
//}  