function searchGrossProfitStatis(){
	var beginTime = $("#beginTime_id").val();
	var endTime = $("#endTime_id").val();
		if (!valiTime(beginTime,endTime)) {
			alert("起始时间不能大于截至时间");
			return;
		}
		var date = new Date();
		$.ajax({
			url:basePath+'operationStatis/grossProfitStatisAjax.do?date='+date,
			type:"POST",
			dataType:"json",
			type : 'POST',
			data : {
				beginTime:$("#beginTime_id").val(),
				endTime:$("#endTime_id").val(),
				platform:$("#platform_id").val()
			},
			success:function suc(statisMap){
				var mas = statisMap.mas;
				var ht = '';
				if (mas=="success") {
					var list = statisMap.statisPage.list;
					var len = list.length;
					platform = $("#platform_id").val();
					if(platform=='shiti'){
						platform = '实体';
					}else if(platform=='pingtai'){
						platform = '平台';
					}else{
						platform = '合计';
					}	
					ht+='<caption id="captionMon">当前筛选条件下：'+platform+'总收入<span><b>￥';
					ht+=(len>0?list[0].incomeSum:0)+'</b></span>元，'+platform+'总成本<span><b>￥'+(len>0?list[0].costSum:0)+'</b></span>元，'+platform+'总毛利<span><b>￥'+(len>0?list[0].grossProfitSum:0)+'</b></span>元</caption>';
					ht+='<thead><tr><th width="">序号</th><th width="">分公司名称</th><th width="">'+platform+'收入（元）</th><th width="">'+platform+'成本（元）</th><th width="">'+platform+'毛利（元）</th><th width="">'+platform+'毛利率</th></tr></thead><tbody>';
					for (var i = 0; i < len; i++) {
							ht+='<tr>';
								ht+='<td>'+(i+1)+'</td>';
								ht+='<td>'+list[i].groupName+'分公司</td>';
								ht+='<td>'+list[i].income.toFixed(2)+'</td>';
								ht+='<td>'+list[i].cost.toFixed(2)+'</td>';
								ht+='<td>'+list[i].grossProfit.toFixed(2)+'</td>';
								ht+='<td>'+(list[i].grossProfitRate*100).toFixed(2)+'%</td>';
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

function exportGrossProfitStatis(){
	var beginTime = $("#beginTime_id").val();
	var endTime = $("#endTime_id").val();
	var platform = $("#platform_id").val();
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
	window.location.href = basePath+'operationStatis/exportGrossProfitStatis.do?beginTime='+beginTime+"&endTime="+endTime+"&platform="+platform;
}
