function searPay(currPage){
	var pageing = $("#pageing").val();
	if (pageing != undefined) {
		pageing = pageing.trim();
		if (currPage==0 && pageing != "") {
			currPage = pageing;
		}
	}
	var pageSize = $("#kuang").val();
	if (pageSize==undefined) {
		pageSize = 10;
	}
	var beginTime = $("#beginTime").val();
	var endTime = $("#endTime").val();
	if (!validate(beginTime,endTime)) {
		return;
	}
	$.ajax({
		url : basePath + "financial/searchFinancial.do",
		type : 'POST',
		data : {
			beginTime:$("#beginTime").val().trim(),
			endTime:$("#endTime").val().trim(),	
			pageSize:pageSize,
			pageNo:currPage
		},
		success : function(map) {
			var mas = map.mas;
			var ht='';
			var htm = '';
			if (mas=="success") {
				var page = map.page;
				var totalRecords = page.totalRecords;
				pageTotalRecords = (typeof(totalRecords) == "undefined" ? 0 : totalRecords);
				var pfList = page.list;
				var j = pfList.length;
				if (j>0) {
					if (pfList[0].actualPayMoneySum != undefined ) {
						ht+='<caption id="captionMon"><span>当前筛选条件下：实付金额合计<b id="actualPayMoneySum">￥'+pfList[0].actualPayMoneySum.toFixed(2)+'</b>元</span></caption>';
					}else{
						ht+='<caption id="captionMon">暂无合计</caption>';
					}
					ht+='<thead><tr>';
						ht+='<th width="10%">序号</th>';
						ht+='<th width="15%">录入公司</th>';
						ht+='<th width="45%">摘要</td>';
						ht+='<th width="15%">实付金额（元）</th>';
						ht+='<th width="15%">提交时间</th>';
					ht+='</tr>';
					ht+='</thead><tbody>';
					for (var i = 0; i < j; i++) {
						ht+='<tr>';
							ht+='<td>'+(i+1)+'</td>';
							ht+='<td>'+pfList[i].groupName+'</td>';
							if (pfList[i].description == undefined) {
								ht+='<td></td>';
							}else{
								ht+='<td><div style="width:86%;margin-left:7%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="'+pfList[i].description+'">'+pfList[i].description+'</div></td>';
							}
							ht+='<td>'+pfList[i].actualPayMoney.toFixed(2)+'</td>';
							ht+='<td>'+pfList[i].submitTime+'</td>';
						ht+='</tr>';
					}
					ht+='</tbody>';
				}else{
					ht = '<tr><td colspan="8">没有查询到匹配的数据..</td></tr>';
				}
				htm +='<p>共计：'+page.totalRecords+'条 &nbsp;&nbsp;&nbsp;每页显示';
				htm +='<select name="" id="kuang" class="kuang" onchange="searPay('+page.pageNo+')">';
					htm +='<option value="10">10</option>';
					htm +='<option value="20">20</option>';
					htm +='<option value="30">30</option>';
					htm +='</select>条&nbsp;&nbsp;&nbsp<span id="list"><span>';
					htm +='<a onclick="searPay(1);" class="pointer">首页</a>';
					htm +='<input class="pointer" type="button" value="&lt" onclick="searPay('+page.previousPageNo+');"/>';
					htm +='<strong>当前页为：'+page.pageNo+'</strong>';
					htm +='<input class="pointer" type="button" value="&gt" onclick="searPay('+page.nextPageNo+');" />';
					htm +='<a class="pointer" onclick="searPay('+page.totalPages+')">末页</a></span></span>';
					htm +='到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;';
					htm +='<button id="confim" onclick="searPay(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：'+page.totalPages+'页</p>';
					$("#paging").html(htm);
					$("#kuang").val(page.pageSize);
			}else{
				ht = '<tr><td colspan="8">数据加载失败..</td></tr>';
				$("#paging").html(htm);
			}
			$("#payTable").html(ht);
		},
		error : function(data) {
			alert("对不起，查询失败！");
		}
	});
}

/**
 * 付款单导出
 * 
 */
function exportPay(){
	if (pageTotalRecords == 0 || pageTotalRecords == null || pageTotalRecords=="" || pageTotalRecords == undefined ) {
		alert("暂无数据，无法导出");
	}else{
		var beginTime = $("#beginTime").val();
		var endTime = $("#endTime").val();
		if (validate(beginTime,endTime)) {
			window.location.href = basePath+'financial/exportFinancial.do?beginTime='+beginTime+'&endTime='+endTime+'&pageSize='+pageTotalRecords+'&pageNo=1';
		}
	}
}

