var currPage = 1;
function prevPage() {
	if (currPage > 1) {
		currPage = currPage - 1;
		gotoPage(currPage);
		
	}
}
function nextPage() {
	if (currPage < 3) {
		currPage = currPage + 1;
		gotoPage(currPage);
	}
}
function gotoPage(nextPage) {
	for (var i = 1; i <= 3; i++) {
		$("#month_part_" + i).css("display", "none");
	}
	if (nextPage >= 1 && nextPage <= 3) {
		$("#month_part_" + nextPage).css("display", "block");
		$("#currPageNo").html(nextPage);
		currPage = nextPage;
	}
}
function gotoWhichPage() {
	var pageNo = $("#pageing").val();
	gotoPage(pageNo);
}

function exportGrossProfitCompare() {
	var year = $("#year_id").val();
	var month = $("#month_id").val();
	var platform = $("#platform_id").val();
	window.location.href = basePath
			+ 'operationStatis/exportGrossProfitCompare.do?year=' + year
			+ "&month=" + month + "&platform=" + platform;
}

function getDays(){
// 构造当前日期对象
var date = new Date();
// 获取年份
var year = date.getFullYear();
// 获取当前月份
var mouth = date.getMonth() + 1;
// 定义当月的天数；
var days ;
// 当月份为二月时，根据闰年还是非闰年判断天数
if(mouth == 2){
        days= year % 4 == 0 ? 29 : 28;
    }
    else if(mouth == 1 || mouth == 3 || mouth == 5 || mouth == 7 || mouth == 8 || mouth == 10 || mouth == 12){
        // 月份为：1,3,5,7,8,10,12 时，为大月.则天数为31；
        days= 31;
    }
    else{
        // 其他月份，天数为：30.
        days= 30;
    }
return days;
}
 

function searchGrossProfitCompare() {
	$.ajax({
		url:basePath+'operationStatis/grossProfitCompareAjax.do',
		type:"POST",
		dataType:"json",
		type : 'POST',
		data : {
			platform:$("#platform_id").val(),
			year:$("#year_id").val(),
			month:$("#month_id").val()
		},
		success:function suc(map){
			var mas = map.mas;
			var ht = '';
			var year = $("#year_id").val()*1;
			var month = $("#month_id").val()*1;
			var day = new Date(year,month,0);
	        var daycount = day.getDate();
			if (mas=="success") {
				var list = map.list;
				var len = list.length;
				var min = 0;
				var max = 9;
				var totalDaysCount = 0;
				var totalGrossProfitRate = 0;
				var platform = $("#platform_id").val();
				if(platform=='shiti'){
					platform = '实体';
				}else if(platform=='pingtai'){
					platform = '平台';
				}else{
					platform = '合计';
				}	
				if(len>0){
					totalDaysCount = list[0].grossProfitRateList.length-2;
					totalGrossProfitRate = list[0].grossProfitRateSum;
				}
				$("#month_part_1").css("display", "block");
				$("#month_part_2").css("display", "none");
				$("#month_part_3").css("display", "none");
				for(var page=1;page<=3;page++){
					if(page==2){
						min = 10;
						max = 19;
					}else if(page==3){
						min = 20;
						max = daycount-1;
					}
					ht='';	
				ht+='<table id="show_content"><thead>';
				ht+='<tr><th width="10%">序号</th><th width="10%">分公司名称</th>';			
				for(var i=(min+1);i<=max+1;i++){
					ht+='<th id="day_"'+i+' width="10%">'+(month*1>9?month+'':'0'+month)+'-'+(i>9?'':0)+i+'</th>';
				}		
				ht+='</tr></thead><tbody>';
				for(j=0;j<len;j++){
					ht+='<tr><td width="10%">'+(j+1)+'</td>';
					ht+='<td width="10%">'+(len>0?(list[j].groupName+'分公司'):'')+'</td>';
					if(len>0&&list&&list[j]){
						for(k=min;k<=max&&list[j].grossProfitRateList.length>=max;k++){
							var rate = Math.ceil((list[j].grossProfitRateList[k]*1==0?0.00:list[j].grossProfitRateList[k]*1)*10000)/100;
							ht+='<td class="cnt_'+k+'" width="10%">'+rate+'%</td>';
						}
					}
					ht+='</tr>';
				}
				
				ht+='</tbody></table>';
				$("#month_part_"+page).html(ht);
				}
				gotoPage(1);
			}else{
				ht += '<tr><td  colspan="7">没有符合条件的数据..</td></tr>';
				$("#show_content").html(ht);
			}
		},
		error:function err(map){
			alert("对不起，查询失败");
		}
	});
}
