function searchMoneyFlushInfo(){
	var beginTime = $("#beginTime_id").val();
	var endTime = $("#endTime_id").val();
		if (!valiTime(beginTime,endTime)) {
			alert("起始时间不能大于截至时间");
			return;
		}
		var date = new Date();
		$.ajax({
			url:basePath+'operationMoneyFlushInfo/moneyFlushInfoAjax.do?date='+date,
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
					ht+='<caption id="captionMon"><span>当前筛选条件下：办单票数合计</span><b>'+(len>0?list[0].totalCountSum:0)+'</b>票，30分钟内冲红票数合计<b>'+(len>0?list[0].totalInThirtySum:0)+'</b>票，30分钟外冲红票数合计<b>'+(len>0?list[0].totalOutThirtySum:0)+'</b>票</span></caption>';
					ht+='<thead><tr><th width="">序号</th><th width="">分公司</th>';
					ht+='<th width="">办单票数</th><th width="">票数（30分钟内）</th><th width="">占比（30分钟内）</th><th width="">';
					ht+='票数（30分钟外）</th><th width="">占比（30分钟外）</th><th width="">综合占比</th><th width="">奖惩明细</th></tr></thead><tbody>';	
					for (var i = 0; i < len; i++) {
								ht+='<tr>';
								ht+='<td>'+(i+1)+'</td>';
								ht+='<td>'+list[i].companyName+'分公司</td>';
								ht+='<td>'+list[i].countSum+'</td>';
								ht+='<td>'+list[i].flushInThirtyMinuteSum+'</td>';
								ht+='<td>'+list[i].flushInThirtyMinuteRate+'%</td>';
								ht+='<td>'+list[i].flushOutThirtyMinuteSum+'</td>';
								ht+='<td>'+list[i].flushOutThirtyMinuteRate+'%</td>';
								ht+='<td>'+list[i].totalRate+'%</td>';
								ht+='<td>'+list[i].awardDetail+'</td>';
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

function exportMoneyFlushInfo(){
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
	window.location.href = basePath+'operationMoneyFlushInfo/exportMoneyFlushInfo.do?beginTime='+beginTime+"&endTime="+endTime;
}
