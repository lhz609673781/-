function searchClaimDetail(currPage){
	var pageNo = 1;
	var pageing = $("#pageing").val();
	if(currPage){
		pageNo = currPage;
	}else if(typeof(pageing) != "undefined"){
		pageing = pageing.trim();
		if (currPage==0 && pageing != "") {
			pageNo = pageing;
		}
	}
	var pageSize = $("#kuang").val();
	if (typeof(pageSize)=="undefined") {
		pageSize = 10;
	}
	var beginTime = $("#beginTime_id").val();
	var endTime = $("#endTime_id").val();
	if (!validate(beginTime,endTime)) {
		return;
	}
	$.ajax({
		url : basePath + "claimDetail/claimDetailAjax.do",
		type : 'POST',
		data : {
			beginTime:$("#beginTime_id").val(),
			endTime:$("#endTime_id").val(),
			customerName:$("#customerName").val(),
			groupName:$("#groupName").val(),
			pageSize:pageSize,
			pageNo:pageNo
		},
		success : function(map) {
			var mas = map.mas;
			var ht='';
			var htm = "";
			if (mas=="success") {
				var page = map.page;
				var list = page.list;
				var len = list.length;
				if (len>0) {
					if($("#customerName").val()=='' && $("#groupName").val()==1){
						ht+='<caption id="captionMon"><span>当前筛选条件下：赔付金额合计<b>￥'+(len>0?list[0].payAmountSum:0)+'</b>元</span></caption>';
						ht+='<thead><tr>';
							ht+='<th width="10%">序号</th>';
							ht+='<th width="10%">分公司</th>';
							ht+='<th width="10%">赔付金额（元）</th>';
							ht+='<th width="10%">运输收入合计</th>';
							ht+='<th width="10%">理赔占比</th>';
						ht+='</tr>';
						ht+='</thead><tbody>';
						for (var i = 0; i < len; i++) {
							ht+='<tr>';
								ht+='<td>'+(i+1)+'</td>';
								ht+='<td>'+list[i].companyName+'分公司</td>';
								ht+='<td>'+list[i].payAmount+'</td>';
								ht+='<td>'+list[i].businIncome+'</td>';
								ht+='<td>'+list[i].claimRate+'%</td>';
							ht+='</tr>';
						}
						ht+='</tbody>';
					}else{
						ht+='<caption id="captionMon"><span>当前筛选条件下：赔付金额合计<b>￥'+(len>0?list[0].payAmountSum:0)+'</b>元</span></caption>';
						ht+='<thead><tr>';
							ht+='<th width="10%">序号</th>';
							ht+='<th width="10%">分公司</th>';
							ht+='<th width="30%">客户名称</th>';
							ht+='<th width="10%">赔付金额（元）</th>';
							ht+='<th width="10%">运输收入合计</th>';
							ht+='<th width="10%">理赔占比</th>';
						ht+='</tr>';
						ht+='</thead><tbody>';
						for (var i = 0; i < len; i++) {
							ht+='<tr>';
								ht+='<td>'+(i+1)+'</td>';
								ht+='<td>'+list[i].companyName+'分公司</td>';
								ht+='<td>'+list[i].customerName+'</td>';
								ht+='<td>'+list[i].payAmount+'</td>';
								ht+='<td>'+list[i].businIncome+'</td>';
								ht+='<td>'+list[i].claimRate+'%</td>';
							ht+='</tr>';
						}
						ht+='</tbody>';
					}
				}else{
					ht = '<tr><td colspan="8">没有查询到匹配的数据..</td></tr>';
				}
				htm +='<p>共计：'+page.totalRecords+'条 &nbsp;&nbsp;&nbsp;每页显示';
				htm +='<select name="" id="kuang" class="kuang" onchange="searchClaimDetail('+page.pageNo+')">';
					htm +='<option value="10">10</option>';
					htm +='<option value="20">20</option>';
					htm +='<option value="30">30</option>';
					htm +='</select>条&nbsp;&nbsp;&nbsp<span id="list"><span>';
					htm +='<a onclick="searchClaimDetail(1);" class="pointer">首页</a>';
					htm +='<input class="pointer" type="button" value="&lt" onclick="searchClaimDetail('+page.previousPageNo+');"/>';
					htm +='<strong>当前页为：'+page.pageNo+'</strong>';
					htm +='<input class="pointer" type="button" value="&gt" onclick="searchClaimDetail('+page.nextPageNo+');" />';
					htm +='<a class="pointer" onclick="searchClaimDetail('+page.totalPages+')">末页</a></span></span>';
					htm +='到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;';
					htm +='<button id="confim" onclick="searchClaimDetail(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：'+page.totalPages+'页</p>';
					$("#paging").html(htm);
					$("#kuang").val(page.pageSize);
					pageTotalRecords = page.totalRecords;
			}else{
				ht = '<tr><td colspan="8">数据加载失败..</td></tr>';
				$("#paging").html(htm);
			}
			$("#show_content").html(ht);
		},
		error : function(data) {
			alert("对不起，查询失败！");
		}
	});
}

/**
 * 导出
 */
function exportClaimDetail(){
	
	if (pageTotalRecords == 0 || pageTotalRecords == null || pageTotalRecords == "" || pageTotalRecords == undefined ) {
		alert("暂无数据，无法导出");
	}else{
		var beginTime = $("#beginTime_id").val();
		var endTime = $("#endTime_id").val();
		var customerName = $("#customerName").val();
		var groupName = encodeURI($("#groupName").val(),"UTF-8");
		groupName = encodeURI(groupName,"UTF-8");
		if (validate(beginTime,endTime)) {
			window.location.href = basePath+'claimDetail/exportClaimDetail.do?beginTime='+beginTime+'&endTime='+endTime+'&customerName='+customerName+'&pageSize='+pageTotalRecords+'&pageNo=1'+'&groupName='+groupName;
		}
	}
}

