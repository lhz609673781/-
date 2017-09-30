$(function(){
//	$("#Modal").hide();
	$("#titleYear").html($("#year").val());
});

//function showRevenueLeading() {
//	var w = $("#windows-win").width();
//	var h = $("#windows-win").height();
//
//	var t = scrollY() + (windowHeight() / 2) - (h / 2);
//	if (t < 0)
//		t = 0;
//
//	var l = scrollX() + (windowWidth() / 2) - (w / 2);
//	if (l < 0)
//		l = 0;
//	$("#windows-win").css("margin-left", l + "px");
//	$("#windows-win").css("margin-top", t + "px");
//	
//}

function leading() {
	var file =$("#text-b").val();
	var extStart = file.lastIndexOf(".");
    var ext = file.substring(extStart, file.length).toUpperCase();
	if(ext==".XLS"){
		var map = {};
		var myForm = $('#revenueLeading');
		var formdata = new FormData();
		formdata.append('file', $('#text-b')[0].files[0]);
//		formdata.append('params', JSON.stringify(map));
		$.ajax({
			url : basePath + "targetManage/revenueLeading.do",
			type: 'POST',
		    cache: false,
		    data: formdata,
		    processData: false,
		    contentType: false,
		    success : function(json) {
				var mas = json.mas;
		    	if(mas=="success"){
		    		alert("导入成功！");
		    		//getCompany();
		    	}else if(mas=="error"){
		    		alert("得不到导入文件，请重试！");
		    	}else if(mas=="login"){
		    		window.location.href=staticPath+"index.jsp";
		    	}else{
		    		alert(mas);
		    	}
			},
			error : function(data) {
				alert("连接失败！");
			}
		});
	}else{
		alert("文件类型错误，必须是以xls文件");
	}
	
}
function search(){
//	if ($("#year").val() == "" || $("#year").val() == null || $("#year").val() == undefined||$("#year").val()==-1) {
//		alert("请选择年份");
//		return ;
//	}else{
		var year=$("#year").val();
		$.ajax({
			url : basePath + "targetManage/revenueSearch.do",
			type : 'POST',
			data : {
				year:year
			},
			success : function(map) {
				var mas = map.mas;
				if (mas=="success") {
					var turnoverList = map.turnoverList;
					if (turnoverList.length>0) {
						$("#turnoverList").html("");
						var ht="";
						ht+="<caption><span id='titleYear'></span>"+$("#year").val()+"年销售指标汇总</caption>";
						ht+="<thead><tr><th width='4%'>序号</th><th width='9%'>分公司/事业部名称</th><th width='8%'>年度指标(万元)</th><th width='6%'>1月指标</th><th width='6%'>2月指标</th><th width='6%'>3月指标</th><th width='6%'>4月指标</th><th width='6%'>5月指标</th><th width='6%'>6月指标</th><th width='6%'>7月指标</th><th width='6%'>8月指标</th><th width='6%'>9月指标</th><th width='6%'>10月指标</th><th width='6%'>11月指标</th><th width='6%'>12月指标</th></tr></thead><tbody>";
						for (var i = 0; i < turnoverList.length; i++) {
							ht+="<tr><td>"+(i+1)+"</td>";
							ht+="<td>"+turnoverList[i].name+"</td>";
							ht+="<td>"+turnoverList[i].totalIndex+"</td>";
							ht+="<td>"+turnoverList[i].oneMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].twoMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].threeMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].fourMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].fiveMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].sixMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].sevenMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].eightMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].nineMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].tenMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].elevenMonthIndex+"</td>";
							ht+="<td>"+turnoverList[i].twelveMonthIndex+"</td></tr>";							
						}
						ht+="</tbody>";
						$("#turnoverList").html(ht);
					}else{
						alert("搜索失败！");
					}
				}else if(mas=="lost"){
					alert("对不起，没有符合条件的数据");
				}else if(mas=="error"){
					alert("对不起，查询失败");
		    	}else if(mas=="login"){
		    		window.parent.location.href=basePath+"view/index.jsp";
		    	}else {
		    		window.location.href=basePath+"view/error.jsp";
				}
			},
			error : function(data) {
				alert("搜索失败！");
			}
		});
//	}
}
function downmodel(){
	$("#model-lo").submit();
}
//function setfilename(){
//	var file =$("#pic").val();
//	$("#text-b").val(file);
//}