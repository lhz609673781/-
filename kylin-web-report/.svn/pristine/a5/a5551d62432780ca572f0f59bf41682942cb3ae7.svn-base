function searchInfoQuantization(){
	var beginTime = $("#beginTime_id").val();
	var endTime = $("#endTime_id").val();
		if (!valiTime(beginTime,endTime)) {
			alert("起始时间不能大于截至时间");
			return;
		}
		var date = new Date();
		$.ajax({
			url:basePath+'operationCarrier/infoQuantizationAjax.do?date='+date,
			type:"POST",
			dataType:"json",
			type : 'POST',
			data : {
				beginTime:$("#beginTime_id").val(),
				endTime:$("#endTime_id").val()
			},
			success:function suc(map){
				var mas = map.mas;
				var ht = '';
				if (mas=="success") {
					var list = map.list;
					var len = list.length;
					ht+='<thead><tr><th width="">序号</th><th width="">分公司</th>';
					ht+='<th width="">托运票数</th><th width="">未发运</th><th width="">发运完成率</th><th width="">';
					ht+='成本未录入</th><th width="">成本录入完成率</th><th width="">财凭未生成</th><th width="">财凭录入完成率</th>';
					ht+='<th width="">毛利<-5%</th><th width="">差异占比</th></tr></thead><tbody>';	
					for (var i = 0; i < len; i++) {
							ht+='<tr>';
								ht+='<td>'+(i+1)+'</td>';
								ht+='<td>'+list[i].companyName+'分公司</td>';
								ht+='<td>'+list[i].totalSum+'</td>';
								ht+='<td>'+list[i].notDeliveSum+'</td>';
								ht+='<td>'+list[i].deliveFinishRate+'%</td>';
								ht+='<td>'+list[i].notCostSum+'</td>';
								ht+='<td>'+list[i].costFinishRate+'%</td>';
								ht+='<td>'+list[i].notIncomeSum+'</td>';
								ht+='<td>'+list[i].notIncomeFinishRate+'%</td>';
								ht+='<td>'+list[i].grossProfitSum+'</td>';
								ht+='<td>'+list[i].grossProfitRate+'%</td>';
							ht+='</tr>';
					}
					ht+='</tbody>';
				}else{
					ht += '<tr><td  colspan="7">没有符合条件的数据..</td></tr>';
				}
				$("#show_content").html(ht);
			},
			error:function err(statisMap){
				alert("对不起，查询失败");
			}
		});
}

function exportInfoQuantization(){
	var beginTime = $("#beginTime_id").val();
	var endTime = $("#endTime_id").val();
	if (beginTime == "点击添入内容" || beginTime == "") {
		alert("起始时间不能为空");
		return;
	}
	if (endTime == "点击添入内容" || endTime == "") {
		alert("截至时间不能为空");
		return;
	}
	if (!valiTime(beginTime,endTime)) {
		alert("起始时间不能大于截至时间");
		return;
	}
	window.location.href = basePath+'operationCarrier/exportInfoQuantization.do?beginTime='+beginTime+"&endTime="+endTime;
}
