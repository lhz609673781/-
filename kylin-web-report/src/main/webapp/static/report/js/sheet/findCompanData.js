/***
 * 获取当前日期的前一天，如果后台返回时间有问题，就用这个时间
 */
var dd = new Date();
dd.setDate(dd.getDate()-1);
var year = dd.getFullYear();
var month = dd.getMonth()+1;
var day = dd.getDate();

var months = [1,3,5,7,8,10,12];
var firstWeek = [1,2,3,4,5,6,7];
var secondWeek = [8,9,10,11,12,13,14];
var thirdWeek = [15,16,17,18,19,20,21];


/**
 * 加载年份下拉框
 * */
function addYearselect(){
	var minyear = 2017;
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

/*function search(){
	var seayear = parseInt($("#year").val());
	var seamonth = parseInt($("#month").val());
	var seaweek = parseInt($("#week").val());
	var seaday = parseInt($("#day").val());
	var datemodel = {year:seayear,month:seamonth,week:seaweek,day:seaday};
	if (seaday!=-1 && seamonth==-1) {
		alert("请选择月份！");
	}else if (seamonth==-1) {
		searchajaxcp(datemodel);
		$("#seadate").html(""+seayear+"年1月1日-"+seayear+"年12月31日");
	}else if (seaweek==-1) {
		var days = getDay(seayear,seamonth);
		searchajaxcp(datemodel);
		$("#seadate").html(""+seayear+"年"+seamonth+"月1日-"+seayear+"年"+seamonth+"月"+days+"日");
	}else if(seaday==-1){
		if (seaweek==1) {
			searchajaxcp(datemodel);
			$("#seadate").html(""+seayear+"年"+seamonth+"月1日-"+seayear+"年"+seamonth+"月7日");
		}else if(seaweek==2){
			searchajaxcp(datemodel);
			$("#seadate").html(""+seayear+"年"+seamonth+"月8日-"+seayear+"年"+seamonth+"月14日");
		}else if(seaweek==3){
			searchajaxcp(datemodel);
			$("#seadate").html(""+seayear+"年"+seamonth+"月15日-"+seayear+"年"+seamonth+"月21日");
		}else{
			searchajaxcp(datemodel);
			var days = getDay(seayear,seamonth);
			$("#seadate").html(""+seayear+"年"+seamonth+"月22日-"+seayear+"年"+seamonth+"月"+days+"日");
		}
	}else{
		searchajaxcp(datemodel);
		$("#seadate").html(""+seayear+"年"+seamonth+"月"+seaday+"日-"+seayear+"年"+seamonth+"月"+seaday+"日");
	}
}**/
function searchajaxcp(){
	var seayear = parseInt($("#year").val());
	var seamonth = parseInt($("#month").val());
	var seaweek = parseInt($("#week").val());
	var seaday = parseInt($("#day").val());
	var datemodel = {year:seayear,month:seamonth,week:seaweek,day:seaday};
	if (seaday!=-1 && seamonth==-1) {
		alert("请选择月份！");
	}else{
		$.ajax({
			url:basePath+'branchData/searchfilialeachievement.do',
			type:"POST",
			contentType:"application/json",
			dataType:"json",
			data:JSON.stringify(datemodel),
			success:function suc(map){
				var mas = map.mas;
				if (mas=="success") {
					var resultsSummaryls = map.resultsSummaryls;
					if (resultsSummaryls.length>0) {
						var sumsalesIndicators = 0;
						var sumdifference = 0;
						var sumcompletion = 0;
						var sumsales = 0;
						var ht='<table><caption><span id="seadate"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="seaindex"></span></caption><thead>'
						+'<tr>'
							+'<th width="5%">排名</th>'
							+'<th width="18%">分公司名称</th>'
							+'<th width="13%"><span class="rstitle"></span>销售指标</th>'
							+'<th width="13%"><span class="rstitle"></span>销售额</th>'
							+'<th width="13%"><span class="rstitle"></span>差额</th>'
							+'<th width="13%"><span class="rstitle"></span>完成率</th>'
							+'</tr></thead><tbody>';
						var j = resultsSummaryls.length;
						for (var i = 0; i < j; i++) {
								ht+='<tr>'
									+'<td>'+(i+1)+'</td>'
									+'<td>'+resultsSummaryls[i].divisionName+'</td>'
									+'<td>'+resultsSummaryls[i].salesIndicators.toFixed(0)+'</td>'
									+'<td>'+resultsSummaryls[i].sales.toFixed(0)+'</td>'
									+'<td>'+resultsSummaryls[i].difference.toFixed(0)+'</td>'
									+'<td>'+(resultsSummaryls[i].completion*100).toFixed(0)+'%</td>'
									+'</tr>'
									sumsalesIndicators += resultsSummaryls[i].salesIndicators;
									sumdifference += resultsSummaryls[i].difference;
									sumsales += resultsSummaryls[i].sales;
//									sumcompletion += resultsSummaryls[i].completion;
						}		
						ht += '</tbody></table>';
						$("#company-info").html(ht);
						$("#seaindex").html("销售业绩汇总：销售指标共计"+sumsalesIndicators.toFixed(0)+"，共计差额"+sumdifference.toFixed(0)+"，共计完成"+(sumsales/sumsalesIndicators*100).toFixed(0)+"%");
						if (seamonth==-1) {
							$("#seadate").html(""+seayear+"年1月1日-"+seayear+"年12月31日");
							$(".rstitle").html(""+seayear+"年");
						}else if (seaweek==-1) {
							var days = getDay(seayear,seamonth);
//							if (seamonth==month) {
//								days = day - 1;
//							}
							$("#seadate").html(""+seayear+"年"+seamonth+"月1日-"+seayear+"年"+seamonth+"月"+days+"日");
							$(".rstitle").html(""+seamonth+"月");
						}else if(seaday==-1){
							if (seaweek==1) {
								$("#seadate").html(""+seayear+"年"+seamonth+"月1日-"+seayear+"年"+seamonth+"月7日");
								$(".rstitle").html("第一周");
							}else if(seaweek==2){
								$("#seadate").html(""+seayear+"年"+seamonth+"月8日-"+seayear+"年"+seamonth+"月14日");
								$(".rstitle").html("第二周");
							}else if(seaweek==3){
								$("#seadate").html(""+seayear+"年"+seamonth+"月15日-"+seayear+"年"+seamonth+"月21日");
								$(".rstitle").html("第三周");
							}else{
								var days = getDay(seayear,seamonth);
								$("#seadate").html(""+seayear+"年"+seamonth+"月22日-"+seayear+"年"+seamonth+"月"+days+"日");
								$(".rstitle").html("第四周");
								
							}
						}else{
							$("#seadate").html(""+seayear+"年"+seamonth+"月"+seaday+"日-"+seayear+"年"+seamonth+"月"+seaday+"日");
							$(".rstitle").html(""+seaday+"日");
						}
					}else{
						alert("对不起，查询失败");
					}
				}else if(mas=="error"){
					alert("对不起，查询失败");
		    	}else if(mas=="unlogin"){
		    		window.parent.location.href=basePath+"view/login.jsp";
		    	}else {
		    		window.location.href=basePath+"view/error.jsp";
				}
			},
			error:function err(map){
				alert("对不起，查询失败");
			}
		});
	}
}


//导出
function downLoad(){
	
		var year=$("#year").val();
		var month=$("#month").val();
		var week=$("#week").val();
		var day=$("#day").val();
		window.location.href = basePath+"branchData/exportSerachResultsSummary.do?year="+year+"&month="+month+"&week="+week+"&day="+day;
}









