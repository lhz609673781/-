$(function(){
	$("#searchBut").click(function (){
		var beginTime = $("#beginTime").val();
		var endTime = $("#endTime").val();
		var groupName = $("#groupName").val();
		if (!validate(beginTime,endTime)) {
			return;
		}
		$.ajax({
			url : basePath + "financial/searchCarrierIncome.do",
			type : 'POST',
			data : {
				beginTime:beginTime,
				endTime:endTime,
				companyName:groupName
			},
			success : function(map) {
				var mas = map.mas;
				var ht='';
				if (mas=="success") {
					var ociList = map.lsOci;
					var j = ociList.length;
					if (j>0) {
						if (ociList[0].incomeSum != undefined ) {
							ht+='<caption id="captionMon"><span>当前筛选条件下：综合收入合计<b id="actualPayMoneySum">￥'+ociList[0].incomeSum.toFixed(2)+'</b>元</span></caption>';
						}else{
							ht+='<caption id="captionMon">暂无合计</caption>';
						}
						ht+='<thead><tr>';
							ht+='<th>序号</th>';
							ht+='<th>分公司</th>';
							ht+='<th>行包收入</th>';
							ht+='<th>行邮收入</th>';
							ht+='<th>五定收入</th>';
							ht+='<th>新干线收入</th>';
							ht+='<th>集装箱收入</th>';
							ht+='<th>综合收入</th>';
						ht+='</tr>';
						ht+='</thead><tbody>';
						for (var i = 0; i < j; i++) {
							ht+='<tr>';
								ht+='<td>'+(i+1)+'</td>';
								ht+='<td>'+ociList[i].companyName+'</td>';
								ht+='<td>'+ociList[i].xingbaoIncome.toFixed(2)+'</td>';
								ht+='<td>'+ociList[i].xingyouIncome.toFixed(2)+'</td>';
								ht+='<td>'+ociList[i].wudingIncome.toFixed(2)+'</td>';
								ht+='<td>'+ociList[i].xinganxianIncome.toFixed(2)+'</td>';
								ht+='<td>'+ociList[i].jizhuangxiangIncome.toFixed(2)+'</td>';
								ht+='<td>'+ociList[i].totalIncome.toFixed(2)+'</td>';
							ht+='</tr>';
						}
						ht+='</tbody>';
					}else{
						ht = '<tr><td colspan="8">没有查询到匹配的数据..</td></tr>';
					}
				}else{
					ht = '<tr><td colspan="8">数据加载失败..</td></tr>';
				}
				$("#carrReveTable").html(ht);
			},
			error : function(data) {
				alert("对不起，查询失败！");
			}
		});
	});

	/**
	 * 载体营业收入导出
	 * 
	 */
	$("#importBut").click(function(){
		if (pageTotalRecords) {
			var beginTime = $("#beginTime").val();
			var endTime = $("#endTime").val();
			var groupName = encodeURI($("#groupName").val(),"UTF-8");
			groupName = encodeURI(groupName,"UTF-8");
			if (validate(beginTime,endTime)) {
				window.location.href = basePath+'financial/exportCarrierIncome.do?beginTime='+beginTime+'&endTime='+endTime+'&companyName='+groupName;
			}
		}else{
			alert("暂无数据，无法导出");
		}
	});

});
