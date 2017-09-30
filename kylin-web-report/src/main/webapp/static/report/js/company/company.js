function showEdit(){
	$('#bakDiv').show();
	$('#buttons').show();
}

function vidate(obj) {
	if (obj.val() == "" || obj.val() == null || obj.val() == undefined) {
		return false;
	}
	return true;
}

function dataValidate(){
	if (!vidate($("#name"))) {
		alert("公司名称不能为空");
		return false;
	}
	
	if (!vidate($("#contacts"))) {
		alert("联系人不能为空");
		return false;
	}
	
	if (!vidate($("#phone"))) {
		alert("电话不能为空");
		return false;
	}else{
		var phone =$("#phone").val();
		if(!(/^1[34578]\d{9}$/.test(phone))){ 
	        alert("手机有误，请重填");  
	        return false; 
	    }
	}
	
	if (!vidate($("#accountid"))) {
		alert("承运商账号不能为空");
		return false;
	}else{
		var accountid =$("#accountid").val();
		if(!(/^1[34578]\d{9}$/.test(accountid))){ 
	        alert("账号有误，请重填");  
	        return false; 
	    }
	}
	return true;
}

function edit(){
	if (dataValidate()==true) {
		$.ajax({    
		    url:basePath+'company/edit.do',// 跳转到 action
		    type:'POST',
		    dataType:"json",
		    data:$('#editOrder').serialize(),
		    success:function(json) {
		    	var mas = json.mas;
		    	if(mas=="success"){
		    		alert("修改成功！");
			    	window.location.href=basePath+"company/detial.do?id="+$('#id').val();
		    	}else if(mas=="error"){
		    		alert("修改失败！");
		    	}else{
		    		window.location.href=basePath+"view/login.jsp";
		    	}
		     },    
		     error:function() {   
		         alert("连接失败！");    
		     }    
		}); 
	} else {
		return;
	}
}
