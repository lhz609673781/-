function serachidentical(){
		var beginTime = $("#beginTime").val().trim();
		var endTime = $("#endTime").val().trim();
		if (!validate(beginTime,endTime)) {
			return;
		}
		$.ajax({
			url:basePath+'companyCompare/searchIdentical.do',
			type:"POST",
			dataType:"json",
			data:$('#serachIdentical').serialize(),
			success:function suc(map){
				var mas = map.mas;
				var ht = '';
				if (mas=="success") {
					var osList = map.data;
					var j = osList.length;
					if (j>0) {
						var incomeSum = 0;
						var costSum = 0;
						var grossProfitSum = 0;
						ht+='<caption id="captionMon"><span>当前筛选条件下：实体收入总合计<b id="incomesum"></b>元，实体成本总合计<b id="costsum"></b>元，实体毛利总合计<b id="grossProfitsum"></b>元</span></caption><thead>';
						ht+='<tr><th width="">序号</th><th width="">起始时间</th><th width="">结束时间</th><th width="">实体收入合计（元）</th><th width="">实体成本合计（元）</th><th width="">实体毛利合计（元）</th><th width="">实体毛利率</th><th width="">同比增长率</th></tr></thead><tbody>';
						for (var i = 0; i < j; i++) {
								ht+='<tr>';
									ht+='<td>'+(i+1)+'</td>';
									ht+='<td>'+osList[i].beginTime+'</td>';
									ht+='<td>'+osList[i].endTime+'</td>';
									ht+='<td>'+osList[i].income.toFixed(2)+'</td>';
									ht+='<td>'+osList[i].cost.toFixed(2)+'</td>';
									ht+='<td>'+osList[i].grossProfit.toFixed(2)+'</td>';
									ht+='<td>'+(osList[i].grossProfitRate*100).toFixed(2)+'%</td>';
									if (osList[i].riseIndex == '/') {
										ht+='<td>'+osList[i].riseIndex+'</td>';
									}else{
										ht+='<td>'+(osList[i].riseIndex*100).toFixed(2)+'%</td>';
									}
								ht+='</tr>';
								incomeSum += osList[i].income;
								costSum += osList[i].cost;
								grossProfitSum += osList[i].grossProfit;
						}
						ht+='</tbody>';
					}else{
						ht = '<tr><td  colspan="7">没有查询到匹配的数据..</td></tr>';
					}
				}else{
					ht = '<tr><td  colspan="7">数据加载失败..</td></tr>';
				}
				$("#companyIdentical").html(ht);
				$("#incomesum").html("￥"+incomeSum.toFixed(2));
				$("#costsum").html("￥"+costSum.toFixed(2));
				$("#grossProfitsum").html("￥"+grossProfitSum.toFixed(2));
			},
			error:function err(map){
				alert("对不起，查询失败");
			}
		});
}
function identicalExport(){
	var beginTime = $("#beginTime").val().trim();
	var endTime = $("#endTime").val().trim();
	var groupName = encodeURI($("#groupName").val(),"UTF-8");
	groupName = encodeURI(groupName,"UTF-8");
	if (validate(beginTime,endTime)) {
		window.location.href = basePath+'companyCompare/identicalExport.do?groupName='+groupName+'&endTime='+endTime+'&beginTime='+beginTime;
	}
}


