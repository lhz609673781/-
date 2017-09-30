function customerEdit(id){
	window.location.href=basePath+"/customer/loadByIdEdit.do?id="+id;
}
/**
 * 启用
 * **/
function adopt(id){
	var b = confirm("您确定启用该账号？")
	if (b) {
		var currentPage=$("#currentPage").text();
		var pageSize=$("#pageSize").val();
		if (currentPage == "" || currentPage == undefined || null == currentPage) {
			alert("启用失败");
			return;
		}
		$.ajax({    
		    url:basePath+'customer/adopt.do',// 跳转到 action
		    type:'POST',
		    dataType:"json",
		    data:{id:id},
		    success:function(json) {
		    	var mas = json.mas;
		    	if(mas=="success"){
		    		alert("启用成功");
			    	window.location.href=basePath+"customer/look.do?pageNo="+currentPage+"&&pageSize="+pageSize;
		    	}else if(mas=="error"){
		    		alert("启用失败");
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
}
function detailsCustomer(id){
	window.location.href=basePath+"/customer/findByIdDetails.do?id="+id;
}
function searchCustomer(pageNo){
	var pageSize=$("#pageSize").val();
		$.ajax({    
		    url:basePath+'customer/searchCustomer.do',// 跳转到 action
		    type:'post',    
		    dataType:'html',
			data:{
		    	name:$("#serachname").val(),
		    	phone:$("#serachphone").val(),
		    	status:$("#serachstatus").val(),
		    	pageNo:pageNo,
		    	pageSize:pageSize
			},
		    success:function(html) {
		    	$("#orderlist").html("");
				$("#orderlist").html(html);	 
				$("#pageSize").val(pageSize);
		     },    
		     error : function(data) {    
		          alert("搜索失败！");    
		     }    
		});
}
