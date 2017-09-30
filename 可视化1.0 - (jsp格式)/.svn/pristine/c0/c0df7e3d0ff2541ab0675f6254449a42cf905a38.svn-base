<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <%@include file="../resourcesweb.jsp" %>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>送货单列表</title>

</head>
<body>
<div class="custom-content">
		<form id="searchOutBillForm"
			action="<%=basePath%>outBill/getListByGroupId.html" method="post">
			<input type="hidden" id="param" name="param" value="">
			<div class="content-search">
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">项目组:</label>
						<select id="select_group" class="tex_t selec_t"
							name="customerGroup.groupid">
							<option value="">全部</option>
							<c:forEach items="${groupList }" var="groupMember">
								<option value="${groupMember.groupid}"> ${groupMember.group.groupName }</option>
							</c:forEach>
						</select>
					</div>
					<!-- ajax 搜索查询 -->
					<div class="fl col-min">
						<label class="labe_l">收货客户:</label>
						<input type="text" class="tex_t"
							name="customerid" value="" onchange="">
					</div>
					<div class="fl col-min">
						<label class="labe_l">送货单号:</label>
						<input type="text" class="tex_t" id="billno" name="billno">
					</div>
				</div>
				<%-- <div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">手机号码:</label>
						<input type="text" class="tex_t"
							name="customerGroup.customer.contactNumber"
							value="${customerGroup.customer.contactNumber }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">收货地址:</label>
						<input type="text" class="tex_t" name="customerGroup.customer.address"
							value="${customerGroup.customer.address }">
					</div>
				</div>	 --%>
				<div>
					<a href="javascript:;" class="content-search-btn"
						onclick="searchOutBill()">查询</a>
				</div>
			</div>
		</form>
		<div class="edit">
			<a href="javascript:;" class="add-edit" onclick="impExcel();">导入</a>
			<a href="javascript:;" class="add-edit" data-toggle="modal" data-target="#myModalAdd" onclick="addOutBill()">添加</a>
		</div>
		<div data-userId="${userId}" id="userId" class="table-style">
			<table>
				<tr>
					<th>交货单号</th>
					<th>收货客户</th>
					<th>联系人</th>
					<th>联系电话</th>
					<th>所属组名称</th>
					<th>牌号</th>
					<th>发货数量</th>
					<th>创建时间</th>
					<th>要求发货时间</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${pageInfo.list }" var="outBill">
					<tr>
						<td>${outBill.billno}</td>
						<td>${outBill.customer.companyName}</td>
						<td>${outBill.customer.contacts}</td>
						<td>${outBill.customer.contactNumber}</td>
						<td>${outBill.group.groupName}</td>
						<td>${outBill.brandno}</td>
						<td>${outBill.outqty}</td>
						<td>${outBill.createTime}</td>
						<td>${outBill.delDate}</td>
						<td>
							<a href="javascript:;" class="add-info"
								onclick="editOutBill('${outBill.id}')"><span></span></a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<c:if test="${not empty page.list}">
				<div class="pages clearfix">
					<div class="pageCenter">
						<c:choose>
							<c:when test="${page.pageNum != 1}">
								<a onclick="searchCustomer(1)">首页</a>
								<a onclick="searchCustomer(${page.prePage })">上一页 </a>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>

						<c:forEach var="ye" begin="1" end="${page.pages }"
							varStatus="status">
							<c:if test="${status.count==page.pageNum }">
								<a
									style="color: #fff; background: #428bca; border-color: #428bca;"
									onclick="searchCustomer(${status.count})">${status.count}</a>
							</c:if>
							<c:if test="${status.count!=page.pageNum }">
								<a onclick="searchCustomer(${status.count})">${status.count}</a>
							</c:if>
						</c:forEach>

						<c:choose>
							<c:when test="${page.pageNum != page.pages}">
								<a onclick="searchCustomer(${page.nextPage })">下一页</a>
								<a onclick="searchCustomer(${page.pages })">末页</a>
							</c:when>
							<c:otherwise>

							</c:otherwise>
						</c:choose>
						<span class="page-sum">共${page.total }个</span>
					</div>
				</div>
			</c:if>
		</div>
	</div>

	<!--弹出框-->
	<div class="model">
		<div class="model-box">
			<span class="close">x</span>
			<div class="model-head">送货单数据excel导入</div>
			<div class="model-body" style="margin:10px 50px;">
				<form id="uploadForm" action="" method="post" enctype="multipart/form-data">
					<div class="model-form">
						<label for="">项目组:</label>
						<select id="select_group2" class="tex_t selec_t" name="groupId">
						</select>
					</div>
					<div class="model-form">
						<input type="file" name="impExcel" id="impExcel" />
					</div>
				</form>
			</div>
			<div class="model-foot">
				<a href="javascript:;" class="btn-save" onclick="saveImpOutBill()">确定</a>
			</div>
		</div>
	</div>
	<!-- 新增送货单 -->
	<div class="modal fade" id="myModalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="">关联收货客户</h4>
				</div>
				<div class="modal-body">
					<div class="mbody-content">
						<form id="customerForm" action="" method="post">
						<input type="hidden" name="userid" />
						<div class="model-form">
							<label for="">项目组:</label>
							<select id="select_group2" class="tex_t selec_t" name="groupid">
							</select>
						</div>
						<div class="model-form">
							<label for="">收货客户:</label>
							<input type="text" name="customer.companyName" id="companyName" />
						</div>
						<div class="model-form">
							<label for="">联系人:</label>
							<input type="text" name="customer.contacts" id="contacts" />
						</div>
						<div class="model-form">
							<label for="">手机号码:</label>
							<input type="tel" name="customer.contactNumber" id="contactNumber" />
						</div>
						<div class="model-form">
							<label for="">座机号码:</label>
							<input type="text" name="customer.tel" id="tel" />
						</div>
						<div class="model-form">
							<label for="">收货地址:</label>
							<input type="text" name="customer.address" id="address" />
						</div>
						</form>
					</div>
				</div>
				<!--end -->
				<div class="modal-footer">
				</div>
			</div>
		</div>
	</div>
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
			    
			    //导入送货单数据
			   function saveImpOutBill(){
			    if($("#select_group2").val()==null ||$("#select_group2").val()==''){
	        	    	EFTP.alert("请选择一个项目组！"); 
	        	    	return;
	        	 }
	        	 var imexcel = $("#impExcel").val();
	        	 if(imexcel==null ||imexcel==''){
	        	    	EFTP.alert("需要导入的excel文件！"); 
	        	    	return;
	        	 }
	        	 //校验文件格式
	        	var fileType = imexcel.substring(imexcel.indexOf(".")+1);
	        	if(fileType!="xlsx" && fileType!="xls"){
	        		EFTP.alert("需要导入的excel文件！"); 
	        	    return;
	        	}
	        	EFTP.h5UploadForm("<%=basePath%>outBill/saveImpExcel.html",function(result){
	        		if(result.success && result.code==RIGHT_CODE){
	        			EFTP.alert(result.msg,function(){
	        				modelClose();
	        				//涮新当前界面
	        				location.href ="<%=basePath%>outBill/outbill.html";
	        				return;
	        			});
	        		}else{
	        			EFTP.alert(result.msg);
	        			return;
	        		}
	        	});
	        	
			   }
			   
			   //搜索客户
			   function searchOutBill(){
				   	var map = {};
				   	var groupId = $('#select_group').val();
				   	var billno = $('#billno').val();
				   	var userId = $('#userId').attr('data-userId');
				   	map['pageNum'] = 1;
				   	map['pageSize'] = 10;
				   	if("" == groupId && "" !=  userId){
					   	map['userId'] = parseInt(userId);
				   	}
				   	if("" != groupId){
					   	map['groupid'] = parseInt(groupId);
				   	}
				   	if("" !== billno){
					   	map['billno'] = billno;
				   	}
				   	var param = JSON.stringify(map);
				    $("#param").val(param);
				    console.log(param);
			        $("#searchOutBillForm").submit();
			   }
			   
			   //导入数据
			   function impExcel(){
			   		doGroupData();
			   		modelShow();
			   }
			   //新增功能
			   function addOutBill() {
				}
			   //编辑功能
			   function editOutBill(id){
				   
			   }
        </script>
</body>
</html>