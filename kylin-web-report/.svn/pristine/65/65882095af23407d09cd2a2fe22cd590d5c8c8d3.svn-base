function searchKeyIndicator(){
	var beginTime = $("#beginTime_id").val();
	var endTime = $("#endTime_id").val();
		if (!valiTime(beginTime,endTime)) {
			alert("起始时间不能大于截至时间");
			return;
		}
		var date = new Date();
		$.ajax({
			url:basePath+'operationKeyIndicator/keyIndicatorAjax.do?date='+date,
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
					ht+='<th width="">提货及时率</th><th width="">到货及时率</th><th width="">返单合格及时率</th><th width="">';
					ht+='签收完好率</th></tr></thead><tbody>';	
					for (var i = 0; i < len; i++) {
							ht+='<tr>';
								ht+='<td>'+(i+1)+'</td>';
								ht+='<td>'+list[i].companyName+'分公司</td>';
								ht+='<td>'+list[i].timelyRate+'%</td>';
								ht+='<td>'+list[i].noTimeoutRate+'%</td>';
								ht+='<td>'+list[i].returnRate+'%</td>';
								ht+='<td>'+list[i].goodSignRate+'%</td>';
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

function exportKeyIndicator(){
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
	window.location.href = basePath+'operationKeyIndicator/exportKeyIndicator.do?beginTime='+beginTime+"&endTime="+endTime;
}
