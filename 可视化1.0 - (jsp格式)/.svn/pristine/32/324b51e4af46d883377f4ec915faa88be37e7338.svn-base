<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <%@include file="./resourceswx.jsp" %>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>任务单管理</title>
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/reset.css" />
<link rel="stylesheet" href="<%=basePath%>css/layout.css" />
<link rel="stylesheet" href="<%=basePath%>css/page.css" />
<link rel="stylesheet" href="<%=basePath%>css/track.css?times=<%=times%>" />
<link rel="stylesheet" href="<%=basePath%>plugin/css/bootstrap-datetimepicker.css" />
<link rel="stylesheet" href="<%=basePath%>font-awesome/css/font-awesome.css" />
<link rel="stylesheet" href="<%=basePath%>plugin/css/BeAlert.css" />
<link rel="stylesheet" href="<%=basePath%>plugin/css/hcheckbox.css" />
</head>
<body>
	<div class="track-content">
		<form id="searchWaybillForm" action="<%=basePath%>trace.html" method="post">
			<input type="hidden" id="pageNo_" name="pageNo" value=""> 
			<input type="hidden" id="pageSize_" name="pageSize" value="">
			<div class="content-search">
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">任务单号:</label>
						<input type="text" class="tex_t" name="waybill.barcode.barcode" value="${waybill.barcode.barcode }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">送货单号:</label>
						<input type="text" class="tex_t" name="waybill.deliveryNumber" value="${waybill.deliveryNumber }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">收货客户:</label>
						<input type="text" class="tex_t" name="waybill.customer.companyName"
							value="${waybill.customer.companyName }">
					</div>
				</div>
				<div class="clearfix">
					<div class="fl col-min">
						<label class="labe_l">任务摘要:</label>
						<input type="text" class="tex_t" name="waybill.orderSummary" value="${waybill.orderSummary }">
					</div>
					<div class="fl col-min">
						<label class="labe_l">项目组:</label> 
						<select class="tex_t selec_t" name="waybill.groupid">
						   <option value="">全部</option>
							<c:forEach items="${groups }" var="group">
								<option value="${ group.id}" <c:if test="${waybill.groupid == group.id }">selected</c:if>>${group.groupName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="fl col-min">
						<label class="labe_l">状态:</label>
						<select class="tex_t selec_t" name="waybill.barcode.bindstatus">
							<option value="">全部</option>
							<option value="20" <c:if test="${'20' eq waybill.barcode.bindstatus}">selected</c:if>>已绑定</option>
							<option value="30" <c:if test="${'30' eq waybill.barcode.bindstatus}">selected</c:if>>运输中</option>
							<option value="40" <c:if test="${'40' eq waybill.barcode.bindstatus}">selected</c:if>>已到货</option>
						</select>
					</div>
				</div>
				<div class="clearfix">
					<div class="fl col-min input-append date">
						<label class="labe_l">绑定时间:</label>
						<div class="input-append date" id="datetimeStart">
							<input type="text" class="tex_t z_index" readonly id="bindStartTime" name="waybill.bindStartTime"
								value="${waybill.bindStartTime }">
							<span class="add-on">
								<i class="icon-th"></i>
							</span>
						</div> 
					</div>
					<div class="fl col-min">
					    <label class="labe_l">至</label>
						<div class="input-append date" id="datetimeEnd">
							<input type="text" class="tex_t z_index" readonly id="bindEndTime" name="waybill.bindEndTime"
								value="${waybill.bindEndTime }">
							<span class="add-on">
								<i class="icon-th"></i>
							</span>
						</div> 
					</div>
				</div>
				<div>
					<a href="javascript:;" class="content-search-btn" onclick="searchTrack(1)">查询</a>
				</div>
			</div>
		</form>
		<div class="content_btn">
			<a href="javascript:;" class="sendMsg" onclick="sendSMS()">发送通知短信</a>
			<a href="javascript:dowloadImagePl();" class="dowloadImage" id="dowloadImage">下载回单</a>
		</div>
		<div class="table-style">
			<table class="dtable" id="trackTable">
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="checkAll">
							全选
						</th>
						<th>任务单号</th>
						<th>送货单号</th>
						<th>任务摘要</th>
						<th>收货客户</th>
						<th>联系人</th>
						<th>联系电话</th>
						<th>收货地址</th>
						<th>要求到货时间</th>
						<th>绑定时间</th>
						<th>最新位置</th>
						<th>回单数量</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list }" var="waybill">
					<tr>
						<td class="chklist">
							<input type="checkbox" name="checksingle" value="${waybill.id}">
						</td>
						<td style="word-break:break-all">
							<a href="<%=basePath%>trace/findById.html?id=${waybill.id }">${waybill.barcode.barcode }</a>
						</td>
						<td>${waybill.deliveryNumber }</td>
						<td>${waybill.orderSummary }</td>
						<td>${waybill.customer.companyName }</td>
						<td>${waybill.customer.contacts }</td>
						<td>${waybill.customer.contactNumber }</td>
						<td>${waybill.customer.address }</td>
                        <td>${waybill.arrivaltimeStr}</td>
						<td>${waybill.bindtime}</td>
						<td>
							<strong><a href="<%=basePath%>trace/gomap.html?id=${waybill.id }">${waybill.address }</a></strong>
						</td>
						<td>${waybill.receiptNumber }</td>
						<td>
							<c:if test="${waybill.barcode.bindstatus==10 }">
		    			已分配
		    			</c:if>
							<c:if test="${waybill.barcode.bindstatus==20 }">
		    			已绑定
		    			</c:if>
							<c:if test="${waybill.barcode.bindstatus==30 }">
		    			运输中
		    			</c:if>
							<c:if test="${waybill.barcode.bindstatus==40 }">
		    			已到货
		    			</c:if>
						</td>
						<td>
							<a href="<%=basePath%>trace/findById.html?id=${waybill.id }" class="a_link">查看</a>
							<br />
							<a href="javascript:;" class="a_link a_model" data-toggle="modal" data-target="#myModal"
								onclick="showModal('${waybill.id}','${waybill.groupid}')">关联客户</a>
							<br />
							<c:if test="${waybill.barcode.bindstatus==10 || waybill.barcode.bindstatus==20}">
								<span>确认到货</span>
							</c:if>
							<c:if test="${waybill.barcode.bindstatus==30 }">
								<a href="javascript:;" class="a_link a_sure" onclick="confirmArrive('${waybill.id }',this)">确认到货</a>
								<span style="display: none;" class="sureArrive">已到货</span>
							</c:if>
							<c:if test="${waybill.barcode.bindstatus==40 }">
								<span>已到货</span>
							</c:if>
							<br />
							<a href="" class="a_link" data-toggle="modal" data-target="#modalEdit"
							onclick="showEditModal('${waybill.id }','${waybill.barcode.barcode }',
						    '${waybill.orderSummary }','${waybill.arrivaltimeStr}')" >编辑</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:if test="${not empty page.list}">
				<div class="pages clearfix">
					<div class="pageCenter">
					<select
							id="pageSize" onchange="searchTrack(1)">
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
								<a href="javascript:;" onclick="searchTrack(1)">首页</a>
								<a href="javascript:;" onclick="searchTrack(${page.prePage })">上一页 </a>
							</c:when>
							<c:otherwise>
                                <span>首页</span>
								<span>上一页 </span>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.pageNum != page.pages}">
								<a href="javascript:;" onclick="searchTrack(${page.nextPage })">下一页</a>
								<a href="javascript:;" onclick="searchTrack(${page.pages })">末页</a>
							</c:when>
							<c:otherwise>
                                <span>下一页</span>
								<span>末页 </span>
							</c:otherwise>
						</c:choose>
						<input id="jumpPageNo" type="text" class="enterNum" value="${page.pageNum }">
						<a href="javascript:;" onclick="jump2Page()" >跳转</a>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<!-- 收货客户弹出框 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="">关联收货客户</h4>
				</div>
				<div class="modal-body">
					<div class="mbody-content">
						<div class="clearfix">
							<div class="fl col_middle">
								<label class="labe_l">收货客户:</label>
								<input type="text" class="tex_t" id="companyName">
							</div>
							<div class="fl col_middle">
								<label class="labe_l">联系人:</label>
								<input type="text" class="tex_t" id="contacts">
							</div>
						</div>
						<div class="clearfix text_center">
							<button type="button" class="btn btn-primary" onclick="queryCustomer()">查询</button>
						</div>
					</div>
				</div>
				<!--收货客户维护  -->
				<div class="modal-footer table-style">
					<table class="wtable">
						<thead>
							<tr>
								<th>收货客户</th>
								<th width="15%">联系人</th>
								<th width="18%">联系电话</th>
								<th>收货地址</th>
								<th width="8%">添加</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="btn-contain">
						<button type="button" class="btn btn-primary" onclick="doBindCustomer()">确定</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 编辑弹出框 -->
    <div class="modal fade" id="modalEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="">编 辑</h4>
                </div>
                <div class="modal-body">
                        <div class="clearfix body_group">
                            <label class="fl">任务单号 :</label>
                            <input id="editBarcode" type="text" class="fr" readonly>
                        </div>
                        <div class="clearfix body_group">
                            <label class="fl">任务摘要 :</label>
                            <textarea id="editSummary" class="fr t_area"></textarea>
                        </div>
                        <div class="clearfix body_group">
                            <label class="fl">要求到货时间 :</label>
                             <div class="input-append date fr"  id="deadlineTime">
                                <input id="editArriveTime" type="text" class="tex_t z_index" readonly>
                                <span class="add-on"><i class="icon-th"></i></span> 
                            </div>
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="editWaybill()">确定</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
	<script src="<%=basePath%>js/jquery.min.js"></script>
	<script src="<%=basePath%>js/bootstrap.min.js"></script>
	<script src="<%=basePath%>js/nav.js"></script>
	<script src="<%=basePath%>plugin/js/bootstrap-datetimepicker.js"></script>
	<script src="<%=basePath%>plugin/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script src="<%=basePath%>plugin/js/BeAlert.js"></script>
	<script src="<%=basePath%>plugin/js/jquery-hcheckbox.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/baseweb.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/commons/datetimepicker.js"></script>
	<script>
            //搜索查询
            function searchTrack(pageNum){
            	$("#pageNo_").val(pageNum);
            	var pageSize = $("#pageSize").val();
				$("#pageSize_").val(pageSize);
                $("#searchWaybillForm").submit();
             }
             
            //弹出框
            function confirmArrive(id,obj){
            	var $this = $(obj);
            	console.log($this);
                EFTP.confirm('是否确认到货？',function(isConfirm){
                    if(isConfirm){
                        //确认删除后的操作
                        $.post('<%=basePath%>trace/confirmArrive.html',{id:id},function(data){
                         EFTP.alert(data);
                         if(data=="操作成功"){
                        	 $this.css('display','none');
                        	 $this.siblings('.sureArrive').css('display','block');
                         }
                        },'json');
                    }else{
                        closeTipBox();
                    }
                },{height:140})
            }
            
            function closeTipBox(){
                $('.BeAlert_box').hide();
                $('.BeAlert_overlay').hide();
            }

            
             $(function(){
            //复选框
            $('.dtable').hcheckbox();
            $('#myModal .wtable').hradio();
             //全选
		    $('#checkAll').click(function() {
			      $("input[name='checksingle']").prop('checked', this.checked); 
			});
			
			$("input[name='checksingle']").click(function () {
			       /*获取当前选中的个数，判断是否跟全部复选框的个数是否相等*/  
                  isall = $("input[name='checksingle']").length == $("input[name='checksingle']:checked").length;  
                  $('#checkAll').prop('checked', isall);  
            }); 
           		 //日期插件初始化
         		$('#deadlineTime').datetimepicker({
         			language : 'zh-CN',
         			format : 'yyyy-mm-dd hh:ii',
         			weekStart : 1, /*以星期一为一星期开始*/
         			todayBtn : true,
         			autoclose : true,
         			pickerPosition : "bottom-left"
         		});
       });
            
            //发送通知短信
            function sendSMS(){
             var count = $("input[name='checksingle']:checked").length;
             if(count==0){
               EFTP.alert("选择一个要发送短信的收货人");
             }else{
                var ids = new Array();
                var flag = true;
                $("input[name='checksingle']:checked").each(function() {
                var waybill_id = $(this).val();
		           var customertel = $(this).parent().parent().children("td").eq(6).text();
		           if(customertel==""){
		        	   flag = false;
		           }else{
		        	  flag = true;
			          ids.push(waybill_id); 
		           }
	             });
                if(flag){
			     sendData(ids);
                }else{
                 EFTP.alert("联系电话不能为空!");
                }
               }
            } 
            
            function sendData(ids){
            	 var vo = {ids : ids };
            	 $.ajax({
			         type:'post',
			         url:'<%=basePath%>trace/sendSMS.html',
			         data:JSON.stringify(vo),
			         dataType:'json',
			         contentType:'application/json',
			         success:function(data){
			                 EFTP.alert(data);
			         }
			     }); 
            }
            
            //任务单bind收货人
            function showModal(id,groupid){
                $("#myModal").attr("data-list",id);
                $("#myModal").attr("data-group",groupid);
                $.post('<%=basePath%>trace/customer.html',{groupid:groupid},function(data){
			          //处理返回结果
			         loadResultData(data,id);
			      },'json');
            }
            
            function loadResultData(data,waybill_id){
            $('#myModal table tbody').html('');
	        $.each(data,function(i, item) {
						var tag = '</td><td>'
						var tr = "<tr><td>"
								+ (item.companyName != null ? item.companyName : "")
								+ tag
								+ (item.contacts != null ? item.contacts : "")
								+ tag
								+ (item.contactNumber != null ? item.contactNumber : "")
								+ tag
								+ (item.address != null ? item.address : "")
								+ tag
								+ "<input type='radio' name='about' value='"+waybill_id+","+item.id+"'/>"
								+ "</td></tr>";
						$('#myModal table tbody').append(tr);
					});
            }
            
            //绑定
            function doBindCustomer(){
              var value = $('input:radio[name="about"]:checked').val();
              if(value==null|| value ==""){
                 EFTP.alert("请选择一位要关联的客户");
                 return;
              }
              var arr = value.split(",");
              var waybill_id = arr[0];
              var customer_id = arr[1];
              $.post('<%=basePath%>trace/bindCustomer.html',{id:waybill_id,customerid:customer_id},function(data){
			          //处理返回结果
			         if(data=='操作成功'){
			        	 $('#myModal').hide();
			        	 setTimeout(function () {
			        	            location.href = "<%=basePath%>trace.html";
			              }, 500);
			         }else{
			        	 alert(data);
			         }
			      },'json');
            }
            
            //查询客户
            function queryCustomer(){
             var companyName = $("#companyName").val();
             var contacts = $("#contacts").val();
             var groupid = $("#myModal").attr("data-group");
             $.post('<%=basePath%>trace/customer.html',{groupid:groupid,companyName:companyName,contacts:contacts},function(data){
			          //处理返回结果
                     var id = $("#myModal").attr("data-list");
			         loadResultData(data,id);
			      },'json');
            }
            
            //图片批量下载
           function dowloadImagePl(){
            var count = $("input[name='checksingle']:checked").length;
             if(count==0){
               EFTP.alert("请勾选需下载回单的任务单！");
                return;
             }else{
                var ids=[];
                $("input[name='checksingle']:checked").each(function() {
		           var id = $(this).val();
			        ids.push('ids='+id); 
	             });
	             var data = ids.join("&");
	             window.location.href="<%=basePath%>trace/dowloadImage.html?"+data;
	             return ;
            }}
            
            
          //编辑运单
           function showEditModal(id,barcode,orderSummary,arrivetime){
        	  //数据回显
        	  $("#modalEdit").attr("data-id",id);
        	  $("#editBarcode").val(barcode);
        	  $("#editSummary").val(orderSummary);
        	  $("#editArriveTime").val(arrivetime);
           }
          
          function editWaybill(){
        	  var id = $("#modalEdit").attr("data-id");
        	  var summary = $("#editSummary").val();
        	  var arrivetime = $("#editArriveTime").val();
        	  /* if(summary==''){
        		  alert('订单摘要不能为空');
        		  return;
        	  }else if(arrivetime==''){
        		  alert('要求到货时间不能为空');
        		  return; 
        	  } */
        	  //请求
        	  $.post('<%=basePath%>trace/editWaybill.html',
        			{id:id,orderSummary:summary,arrivetime:arrivetime},
        			function(data){
		             //处理返回结果
   			         if(data=='操作成功'){
   			        	 $('#myModal').hide();
   			        	 setTimeout(function () {
   			        	            location.href = "<%=basePath%>trace.html";
   			              }, 500);
   			         }else{
   			        	 alert(data);
   			         }
		      },'json');
          }
          
          //页面跳转
          function jump2Page(){
        	  var pageNo = $("#jumpPageNo").val();
        	  searchTrack(pageNo);
          }
          
          
        </script>

</body>
</html>