//var dd = new Date();
//var year = dd.getFullYear();
//var month = dd.getMonth()+1;
$(function(){
	$("#searchBut").click(function (){
		var beginYear = $("#beginYear").val();
		var beginMonth = $("#beginMonth").val();
		var endYear = $("#endYear").val();
		var endMonth = $("#endMonth").val();
		
		//验证
		var beginTime = ""+beginYear+"-"+(beginMonth < 10 ? "0"+beginMonth:beginMonth)+"-01";
		var endTime = ""+endYear+"-"+(endMonth < 10 ? "0"+endMonth:endMonth)+"-01";
		if (!valiTime(beginTime,endTime)) {
			alert("起始时间不能大于截至时间");
			return false;
		}
		if (!valiTime2(beginTime,endTime)) {
			alert("一次最多查询12个月的数据");
			return false;
		}
		$.ajax({
			url : basePath + "operationReturn/searchOperationReturn.do",
			type : 'POST',
			data : {
				beginYear:beginYear,
				beginMonth:beginMonth,
				endYear:endYear,
				endMonth:endMonth
			},
			success : function(map) {
				var mas = map.mas;
				var ht='';
				if (mas=="success") {
					var orList = map.data;
					var j = orList.length;
					if (j>0) {
						pageTotalRecords = true;
						ht+='<thead><tr>';
						ht+='<th>序号</th>';
						ht+='<th>分公司</th>';
						var result = orList[0].list;
						for (var t = 0; t < result.length; t++) {
							ht+='<th>'+result[t].keyName+'</th>';
						}
						ht+='<th>合计</th>';
						ht+='</tr>';
						ht+='</thead><tbody>';
						for (var i = 0; i < j; i++) {
							ht+='<tr>';
								ht+='<td>'+(i+1)+'</td>';
								ht+='<td>'+orList[i].companyName+'分公司</td>';
								for (var o = 0; o < result.length; o++) {
									ht+='<td>'+orList[i].list[o].objValue+'</td>';
								}
								ht+='<td>'+orList[i].totalSum+'</td>';
							ht+='</tr>';
						}
						ht+='</tbody>';
					}else{
						ht = '<tr><td>没有查询到匹配的数据..</td></tr>';
					}
				}else{
					ht = '<tr><td>数据加载失败..</td></tr>';
				}
				$("#returnasingleTab").html(ht);
			},
			error : function(data) {
				alert("对不起，查询失败！");
			}
		});
	});

	/**
	 * 返单统计导出
	 * 
	 */
	$("#importBut").click(function(){
		if (pageTotalRecords) {
			var beginYear = $("#beginYear").val();
			var beginMonth = $("#beginMonth").val();
			var endYear = $("#endYear").val();
			var endMonth = $("#endMonth").val();
			var beginTime = ""+beginYear+"-"+(beginMonth < 10 ? "0"+beginMonth:beginMonth)+"-01";
			var endTime = ""+endYear+"-"+(endMonth < 10 ? "0"+endMonth:endMonth)+"-01";
			if (!valiTime(beginTime,endTime)) {
				alert("起始时间不能大于截至时间");
				return false;
			}
			if (!valiTime2(beginTime,endTime)) {
				alert("查询时间跨度不能超过一年");
				return false;
			}
			window.location.href = basePath+'operationReturn/exportOperationReturn.do?beginYear='+beginYear+'&beginMonth='+beginMonth+'&endYear='+endYear+'&endMonth='+endMonth;
		}else{
			alert("暂无数据，无法导出");
		}
	});

});
