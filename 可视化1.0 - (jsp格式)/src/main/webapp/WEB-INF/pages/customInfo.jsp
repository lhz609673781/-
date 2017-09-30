<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/XX/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="./resourceswx.jsp"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>客户管理</title>
<link rel="stylesheet" href="<%=basePath%>css/reset.css" />
<link rel="stylesheet" href="<%=basePath%>css/layout.css" />
<link rel="stylesheet" href="<%=basePath%>css/page.css" />
<link rel="stylesheet" href="<%=basePath%>css/customInfo.css?times=<%=times%>" />
</head>
<body>
	<div class="custom-content">
		<form id="searchCustomerForm" action="<%=basePath%>customer.html"
			method="post">
			<input type="hidden" id="pageNo_" name="pageNo" value=""> 
			<input type="hidden" id="pageSize_" name="pageSize" value="">
			<div class="content-search">
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">项目组:</label> <select id="select_group"
							class="tex_t selec_t" name="customerGroup.groupid">
							<option value="">全部</option>
							<c:forEach items="${groups }" var="group">
								<option value="${ group.id}"
									<c:if test="${customerGroup.groupid == group.id }">selected</c:if>>
									${group.groupName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="fl col-min">
						<label class="labe_l">收货客户:</label> <input type="text"
							class="tex_t" name="customerGroup.customer.companyName"
							value="${customerGroup.customer.companyName }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">联系人:</label> <input type="text"
							class="tex_t" name="customerGroup.customer.contacts"
							value="${customerGroup.customer.contacts }">
					</div>
				</div>
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">手机号码:</label> <input type="text"
							class="tex_t" name="customerGroup.customer.contactNumber"
							value="${customerGroup.customer.contactNumber }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">收货地址:</label> <input type="text"
							class="tex_t" name="customerGroup.customer.address"
							value="${customerGroup.customer.address }">
					</div>
				</div>
				<div>
					<a href="javascript:;" class="content-search-btn"
						onclick="searchCustomer(1)">查询</a>
				</div>
			</div>
		</form>
		<div class="edit">
			<a href="javascript:;" class="add-edit" onclick="addCustomer()">添加</a>
		</div>
		<div class="table-style">
			<table>
				<thead>
					<tr>
						<th>项目组名</th>
						<th>收货客户</th>
						<th>联系人</th>
						<th>手机号码</th>
						<th>座机号码</th>
						<th>收货地址</th>
						<th>要求到货时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list }" var="customerGroup">
					<tr>
						<td>${customerGroup.group.groupName}</td>
						<td>${customerGroup.customer.companyName}</td>
						<td>${customerGroup.customer.contacts}</td>
						<td>${customerGroup.customer.contactNumber}</td>
						<td>${customerGroup.customer.tel}</td>
						<td>${customerGroup.customer.address}</td>
						<td>
						<c:if test="${empty customerGroup.customer.arriveDay || empty customerGroup.customer.arriveHour}">
						</c:if>
						<c:if test="${not empty customerGroup.customer.arriveDay && not empty customerGroup.customer.arriveHour}">
						发货后的第${customerGroup.customer.arriveDay}天${customerGroup.customer.arriveHour}点前
						</c:if>
						</td>
						<td><a href="javascript:;" class="add-info"
							onclick="editCustomer('${customerGroup.id}')"><span></span></a></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			</div>
			<c:if test="${not empty page.list}">
				<div class="pages clearfix">
					<div class="pageCenter">
					<select
							id="pageSize" onchange="searchCustomer(1)">
							<option value="10"
								<c:if test="${page.pageSize==10 }">selected</c:if>>10条/页</option>
							<option value="20"
								<c:if test="${page.pageSize==20 }">selected</c:if>>20条/页</option>
							<option value="50"
								<c:if test="${page.pageSize==50 }">selected</c:if>>50条/页</option>
						</select>
						<span class="page-sum">第${page.pageNum }/${page.pages }页(共${page.total }条)</span>
						<c:choose>
							<c:when test="${page.pageNum != 1}">
								<a href="javascript:;" onclick="searchCustomer(1)">首页</a>
								<a href="javascript:;" onclick="searchCustomer(${page.prePage })">上一页 </a>
							</c:when>
							<c:otherwise>
                                <span>首页</span>
								<span>上一页 </span>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.pageNum != page.pages}">
								<a href="javascript:;" onclick="searchCustomer(${page.nextPage })">下一页</a>
								<a href="javascript:;" onclick="searchCustomer(${page.pages })">末页</a>
							</c:when>
							<c:otherwise>
                                <span>下一页</span>
								<span>末页 </span>
							</c:otherwise>
						</c:choose>
						<input id="jumpPageNo" type="text" class="enterNum" value="${page.pageNum }">
						<a href="javascript:;" onclick="jump2Page()">跳转</a>
					</div>
				</div>
			</c:if>
		
	</div>

	<!--弹出框-->
	<div class="model">
		<div class="model-box">
			<span class="close">x</span>
			<div class="model-head"></div>
			<div class="model-body" style="margin: 10px 50px;">
				<form id="customerForm" action="" method="post">
					<input type="hidden" name="customerid" id="cus_id" /> 
					<!-- 
					<input type="hidden" name="customer.userId" id="userId"/>
					<input type="hidden" name="customer.createtime" id="createtime" value=""/>
					-->
					<div class="model-form">
						<label for="">项目组:</label> <select id="select_group2"
							class="tex_t selec_t" name="groupid">
						</select>
					</div>
					<div class="model-form">
						<label for="">收货客户:</label> <input type="text"
							name="customer.companyName" id="companyName" />
					</div>
					<div class="model-form">
						<label for="">联系人:</label> <input type="text"
							name="customer.contacts" id="contacts" />
					</div>
					<div class="model-form">
						<label for="">手机号码:</label> <input type="tel"
							name="customer.contactNumber" id="contactNumber" />
					</div>
					<div class="model-form">
						<label for="">座机号码:</label> <input type="text" name="customer.tel"
							id="tel" />
					</div>
					<div class="model-form">
						<label for="">收货地址:</label> <input type="text"
							name="customer.address" id="address" />
					</div>
					<div class="model-form p-relative">
						<span class="position-before">要求到货时间：发货后</span>
						<select id="selectDay" class="s-left" name="customer.arriveDay">
							<option value="">请选择第几天</option>
							<option value="0">当天</option>
							<option value="1">第1天</option>
							<option value="2">第2天</option>
							<option value="3">第3天</option>
							<option value="4">第4天</option>
							<option value="5">第5天</option>
							<option value="6">第6天</option>
							<option value="7">第7天</option>
							<option value="8">第8天</option>
							<option value="9">第9天</option>
							<option value="10">第10天</option>
							<option value="11">第11天</option>
							<option value="12">第12天</option>
							<option value="13">第13天</option>
							<option value="14">第14天</option>
							<option value="15">第15天</option>
							<option value="16">第16天</option>
							<option value="17">第17天</option>
							<option value="18">第18天</option>
							<option value="19">第19天</option>
							<option value="20">第20天</option>
							<option value="21">第21天</option>
							<option value="22">第22天</option>
							<option value="23">第23天</option>
							<option value="24">第24天</option>
							<option value="25">第25天</option>
							<option value="26">第26天</option>
							<option value="27">第27天</option>
							<option value="28">第28天</option>
							<option value="29">第29天</option>
							<option value="30">第30天</option>
							<option value="31">第31天</option>
						</select>
						
						<select id="selectHour" name="customer.arriveHour">
							<option value="">请选择时间点</option>
							<option value="1">凌晨1点</option>
							<option value="2">2点</option>
							<option value="3">3点</option>
							<option value="4">4点</option>
							<option value="5">5点</option>
							<option value="6">6点</option>
							<option value="7">7点</option>
							<option value="8">8点</option>
							<option value="9">9点</option>
							<option value="10">10点</option>
							<option value="11">11点</option>
							<option value="12">12点</option>
							<option value="13">13点</option>
							<option value="14">14点</option>
							<option value="15">15点</option>
							<option value="16">16点</option>
							<option value="17">17点</option>
							<option value="18">18点</option>
							<option value="19">19点</option>
							<option value="20">20点</option>
							<option value="21">21点</option>
							<option value="22">22点</option>
							<option value="23">23点</option>
							<option value="24">24点</option>
						</select>
						<span class="position-after">之前</span>
					</div>
				</form>
			</div>
			<div class="model-foot">
				<a href="javascript:;" class="btn-save" onclick="saveCustomer()">保存</a>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/nav.js"></script>
	<script>
       
        function doGroupData(){
        	//ajax请求加载项目组
        	$.post('<%=basePath%>customer/findGroups.html',function(data){
        	 	    if(data!=null && data.length>0){
        		    	$("#select_group2").empty();
        		    	$("#select_group2").append("<option value=''>全部</option>");
        		    	$.each(data,function(i,item){
        		    		var option = "<option value="+item.id+">"+item.groupName+"</option>";
        		    		$("#select_group2").append(option);
        		    	});
        		    }
        	},'json');
        }
        </script>
	<script>
			    
			    //提交新增和修改客户
			   function saveCustomer(){
			    if($("#select_group2").val()==null 
			    		 ||$("#select_group2").val()==''){
	        	    	alert("请选择一个项目组！"); 
	        	    	return;
	        	 }else if($("#companyName").val()==null
        	    		 ||$("#companyName").val()==''){
        	    	alert("收货客户信息不能为空！"); 
        	    	return;
        	     }else if($("#contactNumber").val()!=null && $("#contactNumber").val()!=''){
        	     	//手机号码不为空时进行校验
        	     	var phonenum=$("#contactNumber").val();
        	     	if(!/1[3|4|5|7|8]\d{9}$/.test(phonenum)){ 
				    	alert('手机号码格式有误！');
				    	return false;
				    }
        	     }else if($("#contacts").val()==null
        	    		 ||$("#contacts").val()==''){
        	    	alert("联系人信息不能为空！"); 
        	    	return;
        	     }else if($("#address").val()==null
        	    		 ||$("#address").val()==''){
        	    	alert("收货地址信息不能为空！"); 
        	    	return;
        	     }
        	     var cust_id = $("#cus_id").val();
        	     if(cust_id==null || cust_id==""){
        	     //新增
        	     $("#customerForm").attr("action","<%=basePath%>customer/add.html");
        	     }else{
        	     //修改
        	     $("#customerForm").attr("action","<%=basePath%>customer/update.html");
        	     }
        	     //提交表单
			     $("#customerForm").submit();
			   }
			   
			   //编辑客户
			   function editCustomer(id){
			      $.post('<%=basePath%>customer/findById.html',{id:id},function(data){
			          //获取返回结果
			          $("#cus_id").val(data.customerid);
			          //$("#userId").val(data.customer.userId);
			          //$("#createtime").val(data.customer.createtime == undefined ? '' : new Date(data.customer.createtime));
			          $("#select_group2").empty();
			          $("#select_group2").append("<option value="+data.groupid+">"+data.group.groupName+"</option>");
			          $("#select_group2").attr("disabled",true);
			          $("#companyName").val(data.customer.companyName);
			          $("#contacts").val(data.customer.contacts);
			          $("#contactNumber").val(data.customer.contactNumber);
			          $("#tel").val(data.customer.tel);
			          $("#address").val(data.customer.address);
			          $("#selectDay").val(data.customer.arriveDay);
			          $("#selectHour").val(data.customer.arriveHour);
			          modelShow();
			          divCenter('.model-box');
			      },'json');
			   }
			   
			   //搜索客户
			   function searchCustomer(pageNum){
				     $("#pageNo_").val(pageNum);
				     var pageSize = $("#pageSize").val();
				     $("#pageSize_").val(pageSize);
			         $("#searchCustomerForm").submit();
			   }
			   
			 //新增客户
			   function addCustomer(){
				      doGroupData();
				      $("#select_group2").attr("disabled",false);
				      $("#cus_id").val('');
			          $("#companyName").val('');
			          $("#contacts").val('');
			          $("#contactNumber").val('');
			          $("#tel").val('');
			          $("#address").val('');
			          $("#selectDay").val('');
			          $("#selectHour").val('');
				      modelShow();
				      divCenter('.model-box');
			   }
			 
			 //弹出框居中
			 function divCenter(obj){
			    var obj = $(''+obj);
			    var width = obj.outerWidth();
			    var height = obj.outerHeight();
			    obj.css({
			        'position':'absolute',
			        'top':'50%',
			        'left':'50%',
			        'margin-top':-(height/2),
			        'margin-left':-(width/2)
			    })
			}
			 
			//页面跳转
		    function jump2Page(){
			  	var pageNo = $("#jumpPageNo").val();
			  	searchCustomer(pageNo);
			}
        </script>
</body>
</html>