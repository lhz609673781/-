function searchMon(currPage){
	var pageing = $("#pageing").val();
	if (pageing != undefined) {
		pageing = pageing.trim();
		if (currPage==0 && pageing != "") {
			currPage = pageing;
		}
	}
	var pageSize = $("#kuang").val();
	var incomeSum = $("#incomeSum").val();
	var grossProfitRate = $("#grossProfitRate").val();
	var beginTime = $("#beginTime").val().trim();
	var endTime = $("#endTime").val().trim();
	if (!validate(beginTime,endTime)) {
		return;
	}
	var b1 = isNaN(incomeSum);
	var b2 = isNaN(grossProfitRate);
	if (b1 || b2) {
		alert("输入参数不合法");
		return;
	}
	$.ajax({
		url : basePath + "companyCompare/searchMonitorMajor.do",
		type : 'POST',
		data : {
			beginTime:$("#beginTime").val().trim(),
			endTime:$("#endTime").val().trim(),	
			platformType:$("#platformType").val().trim(),
			incomeSum:$("#incomeSum").val().trim(),
			grossProfitRate:$("#grossProfitRate").val().trim(),
			pageSize:pageSize,
			pageNo:currPage
		},
		success : function(map) {
			var mas = map.mas;
			var ht='';
			var htm = "";
			if (mas=="success") {
				var page = map.page;
				var totalRecords = page.totalRecords;
				pageTotalRecords = (typeof(totalRecords) == "undefined" ? 0 : totalRecords);
				var osList = page.list;
				var j = osList.length;
				if (j>0) {
					if (osList[0].incomeTotal != undefined && osList[0].grossProfitTotal != undefined && osList[0].costTotal != undefined) {
						ht+='<caption id="captionMon"><span>当前筛选条件下：<span class="montype"></span>收入总合计<b id="incomesum">￥'+osList[0].incomeTotal.toFixed(2)+'</b>元，<span class="montype"></span>成本总合计<b id="costsum">￥'+osList[0].costTotal.toFixed(2)+'</b>元，<span class="montype"></span>毛利总合计<b id="grossProfitsum">￥'+osList[0].grossProfitTotal.toFixed(2)+'</b>元</span></caption>';
					}else{
						ht+='<caption id="captionMon">暂无合计</caption>';
					}
					ht+='<thead><tr>';
						ht+='<th width="10%">序号</th>';
						ht+='<th width="10%">分公司名称</th>';
						ht+='<th width="10%">客户编号</th>';
						ht+='<th width="30%">客户名称</th>';
						ht+='<th width="10%"><span class="montype1"></span>收入（元）</th>';
						ht+='<th width="10%"><span class="montype1"></span>成本（元）</th>';
						ht+='<th width="10%"><span class="montype1"></span>毛利（元）</th>';
						ht+='<th width="10%"><span class="montype1"></span>毛利率</th>';
					ht+='</tr>';
					ht+='</thead><tbody>';
					for (var i = 0; i < j; i++) {
						ht+='<tr>';
							ht+='<td>'+(i+1)+'</td>';
							ht+='<td>'+osList[i].groupName+'</td>';
							if (osList[i].customerCode==undefined || osList[i].customerCode == null) {
								ht+='<td></td>';
							}else{
								ht+='<td>'+osList[i].customerCode+'</td>';
							}
							ht+='<td>'+osList[i].customerName+'</td>';
							ht+='<td>'+osList[i].incomeSum.toFixed(2)+'</td>';
							ht+='<td>'+osList[i].costSum.toFixed(2)+'</td>';
							ht+='<td>'+osList[i].grossProfit.toFixed(2)+'</td>';
							ht+='<td>'+(osList[i].grossProfitRate*100).toFixed(2)+'%</td>';
						ht+='</tr>';
					}
					ht+='</tbody>';
					$("#monTable").html(ht);
					var type = osList[0].platformType;
					var typeName;
					var typename;
					if (type == "pingtai") {
						typeName = "平台";
						typename = "平台";
					}else if(type == "shiti"){
						typename = "实体";
						typeName = "实体";
					}else{
						typeName = "运输";
						typename = "合计";
					}
					$(".montype").html(typeName);
					$(".montype1").html(typename);
				}else{
					ht = '<tr><td colspan="8">没有查询到匹配的数据..</td></tr>';
				}
				htm +='<p>共计：'+page.totalRecords+'条 &nbsp;&nbsp;&nbsp;每页显示';
				htm +='<select name="" id="kuang" class="kuang" onchange="searchMon('+page.pageNo+')">';
					htm +='<option value="10">10</option>';
					htm +='<option value="20">20</option>';
					htm +='<option value="30">30</option>';
					htm +='</select>条&nbsp;&nbsp;&nbsp<span id="list"><span>';
					htm +='<a onclick="searchMon(1);" class="pointer">首页</a>';
					htm +='<input class="pointer" type="button" value="&lt" onclick="searchMon('+page.previousPageNo+');"/>';
					htm +='<strong>当前页为：'+page.pageNo+'</strong>';
					htm +='<input class="pointer" type="button" value="&gt" onclick="searchMon('+page.nextPageNo+');" />';
					htm +='<a class="pointer" onclick="searchMon('+page.totalPages+')">末页</a></span></span>';
					htm +='到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;';
					htm +='<button id="confim" onclick="searchMon(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：'+page.totalPages+'页</p>';
					$("#paging").html(htm);
					$("#kuang").val(page.pageSize);
			}else{
				ht = '<tr><td colspan="8">数据加载失败..</td></tr>';
				$("#paging").html(htm);
			}
			$("#monTable").html(ht);
		},
		error : function(data) {
			alert("对不起，查询失败！");
		}
	});
}

/**
 * 重点项目监控导出
 * 
 */
function monitorExport(){
	if (pageTotalRecords == 0 || pageTotalRecords == null || pageTotalRecords=="" || pageTotalRecords == undefined ) {
		alert("暂无数据，无法导出");
	}else{
		var beginTime = $("#beginTime").val().trim();
		var endTime = $("#endTime").val().trim();
		var platformType = $("#platformType").val().trim();
		var incomeSum = $("#incomeSum").val().trim();
		var grossProfitRate = $("#grossProfitRate").val().trim();
		
		var b1 = isNaN(incomeSum);
		var b2 = isNaN(grossProfitRate);
		if (b1 || b2) {
			alert("输入参数不合法");
			return;
		}
		if (validate(beginTime,endTime)) {
			window.location.href = basePath+'companyCompare/monitorExport.do?beginTime='+beginTime+'&endTime='+endTime+'&platformType='+platformType+'&incomeSum='+incomeSum+'&grossProfitRate='+grossProfitRate+'&pageSize='+pageTotalRecords+'&pageNo=1';
		}
	}
}

$(function (){
	/**
	 * 选择下拉框时改变查询条件的类型
	 */
	$("#platformType").change(function (){
		var type = $(this).val();
		var serType;
		if (type=="pingtai") {
			serType = "平台";
		}else if(type=="shiti"){
			serType = "实体";
		}else{
			serType = "合计";
		}
		$(".montypesear").html(serType);
	});
	
	
})
