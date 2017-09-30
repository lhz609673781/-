/**
 * 获取当前日期的前一天，加载日期下拉框
 */
//var dd = new Date();
//dd.setDate(dd.getDate()-1);
//var year = dd.getFullYear();
//var month = dd.getMonth()+1;
//var day = dd.getDate();
var months = [1,3,5,7,8,10,12];
var firstWeek = [1,2,3,4,5,6,7];
var secondWeek = [8,9,10,11,12,13,14];
var thirdWeek = [15,16,17,18,19,20,21];

/**
 * 加载年份下拉框
 * */
function addYearselect(){
	var minyear = 2016;
	var v = year-minyear;
	var yearing = year;
	var ht = "<option value='"+yearing+"' selected='selected'>"+yearing+"</option>";
	for (var i = 0; i < v; i++) {
		yearing = yearing-1;
		ht += "<option value='"+yearing+"'>"+yearing+"</option>";
	}
	$("#year").html(ht);
}
/**
 * 判断是否是闰年
 * */
function isyear(isyear){
	var b = false;
	if ((isyear%4==0&&isyear%100!=0)||isyear%400==0) {
		b = true;
	}
	return b;
}

/**
 * 获取天数
 * */
function getDay(sedyear,sedmonth){
	var m = -1;
	m = months.indexOf(sedmonth);
	if (sedmonth==2) {
		if (isyear(sedyear)) {
			return 29;
		}else{
			return 28;
		}
	}else if(m>-1){
		return 31;
	}else {
		return 30;
	}
}
/**
 * 根据天数加载天数下拉框
 * */
function addDayselectByDay(days){
	var ht = "<option value='-1'>全部</option>";
	for (var int = 1; int < days+1; int++) {
		ht += "<option value='"+int+"'>"+int+"</option>";
	}
	$("#day").html(ht);
}
/**
 * 根据周加载天数下拉框
 * */
function addDayselectByWeek(arrDay){
	var ht ="<option value='-1'>全部</option>";
	for (var i = 0; i < arrDay.length; i++) {
		ht += "<option value='"+arrDay[i]+"'>"+arrDay[i]+"</option>";
	}
	$("#day").html(ht);
}
/***
 * 根据天判断是哪一周
 * */
function getWeekByDay(pamday){
	var d = -1;
	var pam = parseInt(pamday);
	if (pam!=-1) {
		d = firstWeek.indexOf(pam);
		if (d>-1) {
			return 1;
		}else{
			 d = secondWeek.indexOf(pam);
			if (d>-1) {
				return 2;
			}else{
				d = thirdWeek.indexOf(pam);
				if (d>-1) {
					return 3;
					
				}else{
					return 4;
				}
			}
		}
	}else{
		return -1;
	}
}
/**
 * 选中年份
 * */
function sedyear(){
	$("#quarter").val(-1);
	$("#month").val(-1);
	$("#week").val(-1);
	$("#day").val(-1);
}
/**
 * 选中季度
 * */
function sedquarter(){
	$("#month").val(-1);
	$("#week").val(-1);
	$("#day").val(-1);
}
/**
 * 选中月份
 * */
function sedmonth(){
	var sedy = parseInt($("#year").val());
	var sedm = parseInt($("#month").val());
	if (sedm!=-1) {
		if (sedm == 1 || sedm == 2 || sedm == 3) {
			$("#quarter").val(1);
		}else if (sedm == 4 || sedm == 5 || sedm == 6) {
			$("#quarter").val(2);
		}else if (sedm == 7 || sedm == 8 || sedm == 9) {
			$("#quarter").val(3);
		}else if (sedm == 10 || sedm == 11 || sedm == 12) {
			$("#quarter").val(4);
		}
		var days = getDay(sedy,sedm);
		addDayselectByDay(days);//根据天数加载下拉框
	}
	$("#week").val(-1);
	$("#day").val(-1);
}
/**
 * 选中周
 * */
function sedweek(){
	var sedw = parseInt($("#week").val());
	if (sedw==1) {
		addDayselectByWeek(firstWeek);
	}else if(sedw==2){
		addDayselectByWeek(secondWeek);
	}else if(sedw==3){
		addDayselectByWeek(thirdWeek);
	}else if(sedw==4){
		var sedy = parseInt($("#year").val());
		var sedm = parseInt($("#month").val());
		var days = getDay(sedy,sedm);
		var sur = days-21; //计算剩余天数
		var ht = "<option value='-1'>全部</option>";
		for (var int = 22; int < 22+sur; int++) {
			ht += "<option value='"+int+"'>"+int+"</option>";
		}
		$("#day").html(ht);
	}else{
		$("#week").val(-1);
		$("#day").val(-1);
	}
	$("#day").val(-1);
}
/**
 * 选中某一天
 * **/
function sedWeekByDays(){
	var sedday = parseInt($("#day").val());
	var we = getWeekByDay(sedday);
	if (we!=-1) {
		$("#week").val(we);
	}
}

function seracharound(){
	var seamonth = parseInt($("#month").val());
	var seaday = parseInt($("#day").val());
	var seaweek = parseInt($("#week").val());
	if ((seaday!=-1 && seamonth==-1) || (seaweek!=-1 && seamonth==-1)) {
		alert("请选择月份！");
	}else{
		$.ajax({
			url:basePath+'companyCompare/searchAround.do',
			type:"POST",
			dataType:"json",
			data:$('#serachAround').serialize(),
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
						ht+='<tr><th width="">序号</th><th width="">发运日期</th><th width="">实体收入合计（元）</th><th width="">实体成本合计（元）</th><th width="">实体毛利合计（元）</th><th width="">实体毛利率</th><th width="">环比增长率</th></tr></thead><tbody>';
						for (var i = 0; i < j; i++) {
								ht+='<tr>';
									ht+='<td>'+(i+1)+'</td>';
									ht+='<td>'+osList[i].date+'</td>';
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
				$("#companyAround").html(ht);
				$("#incomesum").html("￥"+incomeSum.toFixed(2));
				$("#costsum").html("￥"+costSum.toFixed(2));
				$("#grossProfitsum").html("￥"+grossProfitSum.toFixed(2));
			},
			error:function err(map){
				alert("对不起，查询失败");
			}
		});
	}
}
function aroundExport(){
	var seamonth = parseInt($("#month").val());
	var seaday = parseInt($("#day").val());
	var seaweek = parseInt($("#week").val());
	var seayear = parseInt($("#year").val());
	var seaquarter = parseInt($("#quarter").val());
	var groupName = encodeURI($("#groupName").val(),"UTF-8");
	groupName = encodeURI(groupName,"UTF-8");
	if ((seaday!=-1 && seamonth==-1) || (seaweek!=-1 && seamonth==-1)) {
		alert("请选择月份！");
	}else{
		window.location.href = basePath+'companyCompare/aroundExport.do?yearParam='+seayear+'&monthParam='+seamonth+'&weekParam='+seaweek+'&quarterParam='+seaquarter+'&dayParam='+seaday+'&groupName='+groupName;
	}
} 
function vidate(obj) {
	if (obj == "" || obj == null || obj == undefined) {
		return false;
	}
	return true;
}










