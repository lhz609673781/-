function companySearch(pageNo){
	var pageSize=$("#pageSize").val();
	var currentPage=$("#currentPage").text();
	$.ajax({    
	    url:basePath+'company/search.do',// 跳转到 action
	    type:'get',    
	    dataType:'html',
		data:{
	    	name:encodeURI($("#name").val(),"UTF-8"),
	    	contacts:encodeURI($("#contacts").val(),"UTF-8"),
	    	phone:encodeURI($("#phone").val(),"UTF-8"),
	    	status:encodeURI($("#status").val(),"UTF-8"),
	    	pageNo:pageNo,
	    	pageSize:pageSize
		},
	    success:function(msg) {
	    	$("#orderlist").html("");
			$("#orderlist").html(msg);
			$("#pageSize").val(pageSize);
	     },    
	     error : function() {    
	          alert("搜索失败！");
	          window.location.href=basePath+"company/all.do?status=-1&&pageNo="+currentPage+"&&pageSize="+pageSize;
	     }    
	});  
}

function disable(id){
	var currentPage=$("#currentPage").text();
	var pageSize=$("#pageSize").val();
	$.ajax({    
	    url:basePath+'company/disableCompany.do',// 跳转到 action
	    type:'POST',    
	    dataType:'html',
		data:{
	    	id:id
		},
	    success:function(json) {
	    	var ajaxobj=eval("("+json+")");  
	    	var mas = ajaxobj.mas;
	    	if(mas=="success"){
	    		alert("停用成功！");
		    	window.location.href=basePath+"company/all.do?status=-1&&pageNo="+currentPage+"&&pageSize="+pageSize;
	    	}else if(mas=="error"){
	    		alert("停用失败！");
	    	}else{
	    		window.location.href=basePath+"view/login.jsp";
	    	}
	     },    
	     error : function(data) {    
	          alert("停用失败！");    
	     }    
	}); 
}

function able(id){
	var currentPage=$("#currentPage").text();
	var pageSize=$("#pageSize").val();
	$.ajax({    
	    url:basePath+'company/ableCompany.do',// 跳转到 action
	    type:'POST',    
	    dataType:'html',
		data:{
	    	id:id
		},
	    success:function(json) {
	    	var ajaxobj=eval("("+json+")");  
	    	var mas = ajaxobj.mas;
	    	if(mas=="success"){
	    		alert("启用成功！");
		    	window.location.href=basePath+"company/all.do?status=-1&&pageNo="+currentPage+"&&pageSize="+pageSize;
	    	}else if(mas=="error"){
	    		alert("启用失败！");
	    	}else{
	    		window.location.href=basePath+"view/login.jsp";
	    	}
	     },    
	     error : function() {    
	          alert("启用失败！");    
	     }    
	}); 
}

function look(id){
	window.location.href=basePath+'company/detial.do?id='+id;
}

function addCompany(){
	window.location.href=basePath+"view/companyView/addCompany.jsp";
}