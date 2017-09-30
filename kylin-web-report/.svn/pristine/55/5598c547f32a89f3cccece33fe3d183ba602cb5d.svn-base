var ht='';
var htm = '';
var colors = ['#33c2ff','#fa6e69','#faca1b'];
var colors1 = ['#6373b5','#33c2ff','#faca1b'];
var beginTime,endTime;
//var searchBoolean = true;
$(document).ready(function () {
	ajaxOperationReport("");
	getCompanyName();
	initDateHandler ();
//	$('#customerName').bind('input propertychange', function() {
//		searchBoolean = false;
//		if ($('#customerName').val() == '') {
//			searchBoolean = true;
//		};
//	});
});

//格式化日期
function formatDate(date){
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var day=date.getDate()-1;
	var hour=date.getHours();
	var minute=date.getMinutes();
    var lastMonthday = new Date(year,month,0);
    	lastMonthday = lastMonthday.getDate();//获取上月最后一天
	if(minute<10){
		minute="0"+minute;
	}
	var second=date.getSeconds();
	var lastMonth = month - 1,
		lastyear  = year;
		if(lastMonth == 0){
			lastMonth = 12;
			lastyear = lastyear--;
		}
	var lastDay = day <= lastMonthday ? day : lastMonthday;
		month = month<10 ? "0"+month : month;
		lastMonth = lastMonth<10 ? "0"+lastMonth : lastMonth;
		day = day<10 ? "0"+day : day;
		lastDay = lastDay<10 ? "0"+lastDay : lastDay;
		
    // return year+"/"+month+"/"+day+" "+hour+":"+minute+":"+second;
	return [[year+"-"+month+"-"+day],[lastyear+"-"+lastMonth+"-"+lastDay]];
}

//初始化日期
function initDateHandler () {
	var _$beginTime = $('#beginTime'),
		_$endTime = $('#endTime'),
		newDate = new Date();
		var dateArr = formatDate(newDate);
		_$beginTime.attr('placeholder',dateArr[1]);
		_$endTime.attr('placeholder',dateArr[0]);
		if(_$beginTime.attr('placeholder') == dateArr[1]){
			beginTime = dateArr[1];
			endTime = dateArr[0];
		}
		$('#beginTime,#endTime').on('focus',function(){
			_$beginTime.attr('placeholder','请输入开始日期');
			_$endTime.attr('placeholder','请输入结束日期');
			beginTime = endTime = null;
		})
}
function getCompanyName(){
	$.ajax({
		url:basePath+'operationClaimReport/companyList.do',
		type:"POST",
		dataType:"json",
		data:'',
		success:function suc(json){
			var code = json.resultCode;
			var resultInfo = json.resultInfo;
			var companyList = JSON.parse(resultInfo);
//			alert(companyList.length);
			var ht = '';
			for (var i = 0; i < companyList.length; i++) {
				ht += '<option value="'+companyList[i].companyName+'">'+companyList[i].companyName+'</option>';
			}
			$("#companyName").append(ht);
		},error:function err(map){
//			alert("对不起，查询失败");
		}
	});
}
function getCustomer(){
	var companyName = $("#companyName").val().trim();
	var customerName = $("#customerName").val().trim();
	var beginTime = $("#beginTime").val().trim();
	var endTime = $("#endTime").val().trim();
	data = {companyName:companyName,beginTime:beginTime,endTime:endTime,customerName:customerName};
	$.ajax({
		url:basePath+'operationClaimReport/customerList.do',
		type:"POST",
		dataType:"json",
		data:data,
		success:function suc(json){
			var code = json.resultCode;
			var resultInfo = json.resultInfo;
			var customerList = JSON.parse(resultInfo);
//			alert(customerList.length);
			var ht = '<select class="searchText" id="customerName" onclick="changInput();" style="width: 130px;"><option value="">所有客户</option><option value="搜索">点击搜索...</option>';
			for (var i = 0; i < customerList.length; i++) {
				ht += '<option value="'+customerList[i].customerName+'">'+customerList[i].customerName+'</option>';
			}
			ht += '</select>';
			$("#selCompany").html(ht);
//			searchBoolean = true;
//			$("#serachIcon").css("display","none");
		},error:function err(map){
//			alert("对不起，查询失败");
		}
	});
}

function changInput(){
	var value = $("#customerName").val().trim();
	if (value == '搜索') {
		var htInput = '<span id="isCustomerText"><input class="searchText" id="customerName" type="text" style="border: 0;width: 130px;"/></span>'
			+'<span onclick="getCustomer()" style="cursor: pointer;color: #358ff0;" class="serachIcon" id="serachIcon"></span>';
			$("#selCompany").html(htInput);
//			$('#customerName').bind('input propertychange', function() {
//				searchBoolean = false;
//				if ($('#customerName').val() == '') {
//					searchBoolean = true;
//				};
//			});
//			$("#isCustomerText").html('');
	}
}

function searchOperationReport(currPage){
//	if (!searchBoolean) {
//		alert("请在选择客户后进行查询");
//		return;
//	}
	if(beginTime == null || endTime == null){
		beginTime = $("#beginTime").val();
		endTime = $("#endTime").val();
		if (!validate(beginTime,endTime)) {
			return;
		}
	}
	
	var maxPage = parseInt($("#maxPage").html());
	var pageing = $("#pageing").val();
	if (pageing != undefined) {
		pageing = pageing.trim();
		if (currPage==0 && pageing != "") {
			currPage = pageing;
		}
	}
	if (currPage>maxPage) {
		alert("输入页数过大");
		return;
	}
	console.log(beginTime+"========"+endTime);
	var pageSize = $("#kuang").val();
	if (pageSize==undefined) {
		pageSize = 10;
	}
	var companyName = $("#companyName").val().trim();
	var customerName = $("#customerName").val().trim();
	var param = {beginTime:beginTime,endTime:endTime,pageSize:pageSize,pageNo:currPage,customerName:customerName,companyName:companyName};
	ajaxOperationReport(param);
}

function ajaxOperationReport(param){
	var paramJson = '';
	if (null != param && param != '' && param != undefined) {
		paramJson = param;
	}
	$.ajax({
		url:basePath+'operationClaimReport/findList.do',
		type:"POST",
		dataType:"json",
		data:paramJson,
		success:function suc(json){
			var code = json.resultCode;
			var resultInfo = json.resultInfo;
			var companyName = $("#companyName").val().trim();
			var customerName = $("#customerName").val().trim();
			//判断用户输入那种查询
			if (code==200) {
				var resultInfoJson = JSON.parse(resultInfo);
				var ocr = resultInfoJson.operationClaimReportResult;
				var columnResultList = resultInfoJson.columnResultList;
				var otherResultList = resultInfoJson.otherResultList;
				var htPie2 = '<div class="graphPie" id="graphPie1">'
						+'<span class="pie1-data" id="pie1-data"></span>'
						+'<div id="container1" style="height: 350px;width: 100%; margin: 0 auto"></div></div>'
						+'<div class="graphPie" id="graphPie2">'
						+'<span class="pie1-data" id="pie2-data"></span>'
						+'<div id="container2" style="height: 350px;width: 100%; margin: 0 auto"></div></div>'
						+'<div class="graphPie" id="graphPie3">'
						+'<div id="container3" style="height: 350px;width: 100%; margin: 0 auto"></div></div>'
						+'<div class="graphPie" id="graphPie4">'
						+'<div id="container4" style="height: 350px;width: 100%; margin: 0 auto"></div></div>'
						+'<div class="graphPie" id="graphPie5">'
						+'<div id="container5" style=" height: 350px;width: 100%; margin: 0 auto"></div></div>';
				var htgraphDescribe = '<div id="graphDescribe">'
				+'<p style="margin-top: 30px;">（汇总信息描述）从<span class="spanText" id="serBeginTimeText"></span>到<span class="spanText" id="serEndTimeText"></span>的汇总信息如下</p>'
				+'<p>1：赔付金额共：<span class="spanText" id="spanText1"></span></p>'
				+'<p>2：当前赔付票数：<span class="spanText" id="spanText2"></span></p>'
				+'<p>3：整体赔付占营业额的百分比：<span class="spanText" id="spanText3"></span></p>'
				+'<p>4：异常签收占比：<span class="spanText" id="spanText4"></span></p>'
				+'<p>5：风险转移比例：需承运商承担<span  class="spanText" id="spanText5"></span>，需保险公司承担<span  class="spanText" id="spanText6"></span>，自留风险<span  class="spanText" id="spanText7"></span></p></div>'
				+'<div id="graphRight" style="height: 280px"></div>';
				$("#graphTop").html(htPie2);
				$("#graphCentre").html(htgraphDescribe);
				if (vidate(customerName)) {
					if (vidate(companyName)) {
						//第一种情况：查询某个分公司下的某个客户
						$("#graphTop").html('<div class="graphPie" id="graphPie1"><div id="container1" style="height: 350px;width: 100%; margin: 0 auto"></div></div><div id="graphTop2" style="width:70%;display:inline-block;"><div>');
						serachFirst(resultInfoJson);
					}else{
						//第二种情况：查询某个客户所在的所有分公司
						searchSecond(resultInfoJson);
						loadGraphPie(ocr);//加载图表
						$("#graphRight").html("");
					}
				}else{
					if (vidate(companyName)) {
						//第三种情况：查询某个分公司下的所有客户
						searchThirdly(resultInfoJson)
						loadGraphPie(ocr);//加载图表
						loadRight(columnResultList);//柱状图
					}else{
						//第四种情况：查询所有分公司和所有客户
						searchFourthly(resultInfoJson)
						loadGraphPie(ocr);//加载图表
						loadRight(columnResultList);//柱状图
					}
				}
				$("#operationReportTable").html(ht);
			}else if(code==400){
				alert("暂无数据");
			}else{
				alert("查询异常");
			}
			
//			loadTable(resultInfo,code);//加载表格
//			loadGraphPie(resultInfo,code);//加载图表
//			//loadGraphOther();//加载柱状图与折线图
//			loadRight();
		},error:function err(map){
			alert("对不起，查询失败");
		}
	});
}
/***
   * 第一种查询
   */
function serachFirst(resultInfoJson){
		ht='';
		htm='';
		var otherResultList = resultInfoJson.otherResultList;
		var ocr = resultInfoJson.operationClaimReportResult;
		var page = ocr.pageModel;
		if (page == undefined) {
			alert("暂无数据");
			return;
		}
		var list = page.list;
		var j = list.length;
		if (j>1) {
			var ocr = resultInfoJson.operationClaimReportResult;
			var columnResultList = resultInfoJson.columnResultList;
			searchFourthly(resultInfoJson)
			loadGraphPie(ocr);//加载图表
			loadRight(columnResultList);//柱状图
		}else if (j>0) {
			
			ht+='<thead><tr>';
			ht+='<th width="">序号</th>';
			ht+='<th width="">赔付额（万元）</th>';
			ht+='<th width="">赔付票数</th>';
			ht+='<th width="">赔付占比</th>';
			ht+='<th width="">异常理赔占比</th>';
			ht+='<th width="">需供应商承担</th>';
			ht+='<th width="">需保险公司承担</th>';
			ht+='<th width="">自留风险</th>';
			ht+='</tr>';
			ht+='</thead><tbody>';
			ht+='<tr>';
			ht+='<td>1</td>';
			ht+='<td>'+(list[0].payAmount/10000).toFixed(2)+'</td>';//赔付额
			ht+='<td>'+list[0].paymentSum+'</td>';//赔付票数
			if(list[0].businIncome == 0){
				ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="营业额暂无，无法计算">营业额暂无，无法计算</div></td>';
			}else{
				ht+='<td>'+(list[0].payAmount/list[0].businIncome*100).toFixed(2)+'%</td>';//赔付占比
			}
//			var ss = list[0].abnormalSum/list[0].paymentSum;
			if (list[0].totalSum == 0) {
				ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="总票数暂无，无法计算">总票数暂无，无法计算</div></td>';      
			}else if(list[0].abnormalSum == undefined){
				ht+='<td>0.00%</td>'; 
			}else{
				ht+='<td>'+(list[0].abnormalSum/list[0].totalSum*100).toFixed(2)+'%</td>';//异常理赔占比   
			}
			var paySum = list[0].carrierPay+list[0].insurancePay+list[0].companyPay;
			ht+='<td>'+(list[0].carrierPay/paySum*100).toFixed(2)+'%</td>';//承运商承担
			ht+='<td>'+(list[0].insurancePay/paySum*100).toFixed(2)+'%</td>';//需保险公司承担
			ht+='<td>'+(list[0].companyPay/paySum*100).toFixed(2)+'%</td>';//自留风险
			ht+='</tr>';
			ht+='</tbody>';
		}else{
			ht = '<tr><td colspan="8">没有查询到匹配的数据..</td></tr>';
			alert("没有查询到匹配的数据");
		}
		
		var otherResultList = resultInfoJson.otherResultList;
		var z = otherResultList.length;
		if (z>0) {
			
			var payAmountSum = 0.0;//赔付额
			var paymentSums = 0;//赔付票数
			var businIncomeSum = 0.0;//营业额
			var abnormalSums = 0;//异常签收票数
			var carrierPaySum = 0.0;//承运商承担
			var insurancePaySum = 0.0;//需保险公司承担
			var companyPaySum = 0.0;//自留风险
			for (var v = 0; v < z; v++) {
					payAmountSum += otherResultList[v].payAmount;
					paymentSums += otherResultList[v].paymentSum;
					businIncomeSum += otherResultList[v].businIncome;
					abnormalSums += otherResultList[v].abnormalSum;
					carrierPaySum += otherResultList[v].carrierPay;
					insurancePaySum += otherResultList[v].insurancePay;
					companyPaySum += otherResultList[v].companyPay;
			}
			
			
			/************加载图表start****************/
			var payAmountCompletion = parseFloat((list[0].businIncome == 0 ? 0 : list[0].payAmount/list[0].businIncome));
			var notPayAmountCompletion = parseFloat((list[0].businIncome == 0 ? 1 : (list[0].businIncome-list[0].payAmount)/list[0].businIncome).toFixed(2));
			var data1 = [
				            {
				                name: '理赔金额',
				                y: payAmountCompletion,
				                sliced: true,
				                selected: true
				            },
				            ['非理赔金额', notPayAmountCompletion]
				        ]//第一张饼图数据
			var paySum = carrierPaySum+insurancePaySum+companyPaySum;
			var carrierPaySumCompletion = parseFloat((paySum == 0 ? 0 : carrierPaySum/paySum));
			var insurancePayCompletion = parseFloat((paySum == 0 ? 0 : insurancePaySum/paySum));
			var companyPayCompletion = parseFloat((paySum == 0 ? 0 : companyPaySum/paySum));
			var data2 = [
				            {
				                name: '承运商',
				                y: carrierPaySumCompletion,
				                sliced: true,
				                selected: true
				            },
				            ['保险公司', insurancePayCompletion],
				            ['远成', companyPayCompletion]
				        ]//第二张饼图数据
			
			/***
			 * 第一张饼图
			 * */
			Highcharts.chart('container1', {
				navigation: {
		            buttonOptions: {
		                enabled: false
		            }
		        },
				credits :{
					enabled:false
				},
				colors: colors1,
			    chart: {
			        type: 'pie',
			        options3d: {
			            enabled: true,
			            alpha: 45,
			            beta: 0
			        }
			    },
//			    chart: {
//		            plotBackgroundColor: null,
//		            plotBorderWidth: null,
//		            plotShadow: false,
//		            type: 'pie'
//		        },
			    title: {
			        text: '理赔整体占比',
			        style:{
			        	"color":"#358ff0",
			        	"font-size": "16px"
			        }
			    },
			    tooltip: {
			        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
			    },
			    plotOptions: {
//			        pie: {
//			            allowPointSelect: true,
//			            cursor: 'pointer',
//			            depth: 35,
//			            dataLabels: {
//			                enabled: true,
//			                format: '{point.name}'
//			            }
//			        }
			    
			    pie: {
			    	size:"50%",
		            allowPointSelect: true,
		            cursor: 'pointer',
		            depth: 25,
		            dataLabels: {
		            	distance:0,
		                enabled: true,
		                format: '{percentage:.2f}'+'%'
		            },
		            
//		            formatter:function (){
//		            	return this.percentage+"%";
//		            },
		            showInLegend: true
		        }
			    },
			    series: [{
			        type: 'pie',
			        name: '理赔整体占比',
			        data: data1
			    }],
//			    legend:{
//			    	labelFormatter:function (){
//			    		return '('+this.percentage+')';
//			    	}
//			    }
			});
			
			/******折线图*****/
			var years = [otherResultList[0].year];
			var categories = [];
			var data = [];
			var maxData = otherResultList[0].payAmount/10000;
//			/*********处理Y轴坐标start**********/
//			if (!vidate(columnResultList[0].payAmount)) {
//				columnResultList[0].payAmount = 0;
//			}
//			if (!vidate(columnResultList[0].businIncome)) {
//				columnResultList[0].businIncome = 0;
//			}
//			var maxData =  parseFloat((columnResultList[0].payAmount/columnResultList[0].businIncome*100).toFixed(0))+1;
//			/*********处理Y轴坐标end**********/
//			var bYear = true;
//			var relativelyMonth = otherResultList[0].month;
//			if (otherResultList[0].year != otherResultList[z-1].year) {
//				bYear = false;
//			}
			for (var i = 0; i < z; i++) {
//				if (!vidate(otherResultList[i].month)) {
//					otherResultList[i].month = '';
//				}
				var iYear = otherResultList[i].year;
				if (years[0] != iYear) {
					if (years[0] < iYear) {
						years[1] = iYear;
					}else{
						var y = years[0];
						years[0] = iYear;
						years[1] = y;
					}
				}
				/**获取最大值*/
				if ((otherResultList[i].payAmount/10000)>maxData) {
					maxData = (otherResultList[i].payAmount/10000)
				}
				categories[i] = otherResultList[i].year+"年"+otherResultList[i].month;
				data[i] = parseFloat((otherResultList[i].payAmount/10000).toFixed(2));
			}
			maxData = parseFloat(maxData);
			var textYear = "";
			if (years.length>1) {
				textYear = years[0]+"年-"+years[1]+"年";
			}else{
				textYear = years[0]+"年";
			}
			Highcharts.chart('graphTop2', {
				navigation: {
		            buttonOptions: {
		                enabled: false
		            }
		        },
		        credits :{
					enabled:false
				},
			    xAxis: {
			        categories: categories,
			        labels: {
		                style: { 
		                    color: '#4572A7' //设置标签颜色 
		                } 
		            },
		            title: {
		                text: '月份'
		            },
			    }, 
			    yAxis: {
		            allowDecimals: false,
		            max:maxData,
		            min: 0,
		            title: {
		                text: '赔付金额'
		            },
		        	labels: { 
		                formatter: function() {//格式化标签名称 
		                    return this.value + '万元'; 
		                }, 
		                style: { 
		                    color: '#4572A7' //设置标签颜色 
		                } 
		            }
		        },
			    plotOptions: {
			        series: {
			            dataLabels: {
			                enabled: true,
			                format: '{y} 万元'
			            }
			        }
			    },
			    title: {
			        text: ''+textYear+'理赔金额走势图',
			        style:{
			        	"color":"#358ff0",
			        	"font-size": "16px"
			        }
			    },
			    series: [{
			    	name: '赔付金额',
			        data: data
			    }]
			});
			
			/**
			 * 第二张饼图
			 */
			$("#graphDescribe").css("width","259px");
			Highcharts.chart('graphDescribe', {
				navigation: {
		            buttonOptions: {
		                enabled: false
		            }
		        },
				credits :{
					enabled:false
				},
				colors: colors1,
			    chart: {
			        type: 'pie',
			        options3d: {
			            enabled: true,
			            alpha: 45,
			            beta: 0
			        },
			        spacingLeft:0
			    },
//			    chart: {
//		            plotBackgroundColor: null,
//		            plotBorderWidth: null,
//		            plotShadow: false,
//		            type: 'pie'
//		        },
			    title: {
			        text: '风险转移占比',
			        style:{
			        	"color":"#358ff0",
			        	"font-size": "16px"
			        }
			    },
			    tooltip: {
			        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
			    },
			    plotOptions: {
//			        pie: {
//			            allowPointSelect: true,
//			            cursor: 'pointer',
//			            depth: 35,
//			            dataLabels: {
//			                enabled: true,
//			                format: '{point.name}'
//			            }
//			        }
			    pie: {
			    	size:"50%",
		            allowPointSelect: true,
		            cursor: 'pointer',
		            depth: 25,
		            dataLabels: {
		            	distance:0,
		                enabled: true,
		                format: '{percentage:.2f}'+'%'
		            },
		            showInLegend: true
		        }
			    },
			    series: [{
			        type: 'pie',
			        name: '风险转移占比',
			        data: data2
			    }],
			    legend:{
			    	width:"100%"
			    }
			});
			/**********加载柱状图*********/
			var data1 = [];
			var data2 = [];
			var data3 = [];
			var categories = [];
			for (var i = 0; i < z; i++) {
				var paySum = otherResultList[i].carrierPay+otherResultList[i].insurancePay+otherResultList[i].companyPay;
				var carrierPaySumCompletion = parseFloat((paySum == 0 ? 0 : otherResultList[i].carrierPay/paySum).toFixed(2));
				var insurancePayCompletion = parseFloat((paySum == 0 ? 0 : otherResultList[i].insurancePay/paySum).toFixed(2));
				var companyPayCompletion = parseFloat((paySum == 0 ? 0 : otherResultList[i].companyPay/paySum).toFixed(2));
				data1[i] = carrierPaySumCompletion*100;
				data2[i] = insurancePayCompletion*100;
				data3[i] = companyPayCompletion*100;
				categories[i] = otherResultList[i].year+"年"+otherResultList[i].month;
			}
			var data1 = {name:"承运商",data:data1};
			var data2 = {name:"保险公司",data:data2};
			var data3 = {name:"远成",data:data3};
			var datas = [data1,data2,data3];
			$('#graphRight').highcharts({
				navigation: {
		            buttonOptions: {
		                enabled: false
		            }
		        },
		        credits :{
					enabled:false
				},
				colors: colors1,
		        chart: {
		            type: 'column',
		            options3d: {
		            	enabled: true,
			            alpha: 0,
			            beta: 25,
			            depth: 70
		            },
//		            marginTop: 80,
//		            marginRight: 40,
		            height:380
		        },
		        title: {
		            text: '三方占比',
		            style:{
		            	"color":"#358ff0",
			        	"font-size": "16px"
			        }
		        },
		        xAxis: {
//		            categories: ['苹果', '橘子', '梨', '葡萄', '香蕉'],
		        	categories:categories,
		        	text:"月份",
		            labels: {
		                style: { 
		                    color: '#4572A7' //设置标签颜色 
		                } 
		            }
		        },
		        yAxis: {
		            allowDecimals: false,
		            min: 0,
		            max:100,
		            title: {
		                text: '三方占比'
		            },
		        	labels: { 
		                formatter: function() {//格式化标签名称 
		                    return this.value + '%'; 
		                }, 
		                style: { 
		                    color: '#4572A7' //设置标签颜色 
		                } 
		            }
		        },
		        tooltip: {
		            headerFormat: '<b>{point.key}</b><br>',
		            pointFormat: '<span style="color:{series.color}">\u25CF</span> {series.name}: {point.y:.0f}%'
		        },
		        plotOptions: {
		        column: {
	                stacking: 'normal',
	                depth: 40,
	                maxPointWidth:60, //柱子宽度
	                dataLabels: {
	                    enabled: true,
	                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
	                    style: {
	                        textShadow: '0 0 3px black'
	                    },
	                    format: '{percentage:.0f}'+'%'
	                    
	                }
	            }
		        },
		        series:datas
		    });
			
			
			
		/************加载图表end****************/
			
		}
		$("#paging").html(htm);
}

/**
 * 第二种查询
 */
function searchSecond(resultInfoJson){
	ht='';
	htm = '';
	var ocr = resultInfoJson.operationClaimReportResult;
	var page = ocr.pageModel;
	var list = page.list;
	var j = list.length;
	$("#serBeginTimeText").html($("#beginTime").val());
	$("#serEndTimeText").html($("#endTime").val());
	$("#spanText1").html(""+(ocr.payAmountSum/10000).toFixed(2)+"万元");
	$("#spanText2").html(""+ocr.paymentSums+"票");
	$("#spanText3").html(""+(ocr.payAmountSum/ocr.businIncomeSum*100).toFixed(2)+"%");
	$("#spanText4").html(""+(ocr.abnormalSums/ocr.paymentSums*100).toFixed(2)+"%");
	ocr.carrierPaySum = (ocr.carrierPaySum == undefined ? 0 : ocr.carrierPaySum);
	ocr.insurancePaySum = (ocr.insurancePaySum == undefined ? 0 : ocr.insurancePaySum);
	ocr.companyPaySum = (ocr.companyPaySum == undefined ? 0 : ocr.companyPaySum);
	PaySums = ocr.carrierPaySum + ocr.insurancePaySum + ocr.companyPaySum;
	$("#spanText5").html((ocr.carrierPaySum/PaySums*100).toFixed(2)+"%");
	$("#spanText6").html((ocr.insurancePaySum/PaySums*100).toFixed(2)+"%");
	$("#spanText7").html((ocr.companyPaySum/PaySums*100).toFixed(2)+"%");
	if (j>0) {
			ht+='<thead><tr>';
				ht+='<th width="3%">序号</th>';
				ht+='<th width="">远成公司</td>';
				ht+='<th width="">赔付额（万元）</th>';
				ht+='<th width="">赔付票数</th>';
				ht+='<th width="">赔付占比</th>';
				ht+='<th width="">异常理赔占比</th>';
				ht+='<th width="">需供应商承担</th>';
				ht+='<th width="">需保险公司承担</th>';
				ht+='<th width="">自留风险</th>';
			ht+='</tr>';
			ht+='</thead><tbody>';
			for (var i = 0; i < j; i++) {
				ht+='<tr>';
					ht+='<td>'+(i+1)+'</td>';
					if (list[i].companyName == undefined) {
						ht+='<td></td>';
					}else{
						ht+='<td><div style="width:86%;margin-left:7%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="'+list[i].companyName+'">'+list[i].companyName+'</div></td>';
					}
					ht+='<td>'+(list[i].payAmount/10000).toFixed(2)+'</td>';
					ht+='<td>'+list[i].paymentSum+'</td>';
					if (!isFinite(list[i].payAmount/list[i].businIncome)) {
						ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="营业额暂无，无法计算">营业额暂无，无法计算</div></td>';
					}else{
						ht+='<td>'+((list[i].payAmount/list[i].businIncome)*100).toFixed(2)+'%</td>';
					}
					if (list[i].totalSum == 0) {
						ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="总票数暂无，无法计算">总票数暂无，无法计算</div></td>';
					}else if(list[i].abnormalSum == undefined){
						ht+='<td>0.00%</td>';
					}else{
						ht+='<td>'+((list[i].abnormalSum/list[i].totalSum)*100).toFixed(2)+'%</td>';
					}
					var paySum = list[i].carrierPay+list[i].insurancePay+list[i].companyPay;
					ht+='<td>'+((list[i].carrierPay/paySum)*100).toFixed(2)+'%</td>';
					ht+='<td>'+((list[i].insurancePay/paySum)*100).toFixed(2)+'%</td>';
					ht+='<td>'+((list[i].companyPay/paySum)*100).toFixed(2)+'%</td>';
				ht+='</tr>';
			}
			ht+='</tbody>';
	}else{
			ht = '<tr><td colspan="9">没有查询到匹配的数据..</td></tr>';
	}
	htm +='<p>共计：'+page.totalRecords+'条 &nbsp;&nbsp;&nbsp;每页显示';
	htm +='<select name="" id="kuang" class="kuang" onchange="searchOperationReport('+page.pageNo+')">';
	htm +='<option value="10">10</option>';
	htm +='<option value="20">20</option>';
	htm +='<option value="30">30</option>';
	htm +='</select>条&nbsp;&nbsp;&nbsp<span id="list"><span>';
	htm +='<a onclick="searchOperationReport(1);" class="pointer">首页</a>';
	htm +='<input class="pointer" type="button" value="&lt" onclick="searchOperationReport('+page.previousPageNo+');"/>';
	htm +='<strong>当前页为：'+page.pageNo+'</strong>';
	htm +='<input class="pointer" type="button" value="&gt" onclick="searchOperationReport('+page.nextPageNo+');" />';
	htm +='<a class="pointer" onclick="searchOperationReport('+page.totalPages+')">末页</a></span></span>';
	htm +='到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;';
	htm +='<button id="confim" onclick="searchOperationReport(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：<span id="maxPage">'+page.totalPages+'</span>页</p>';
	$("#paging").html(htm);
	$("#kuang").val(page.pageSize);
}

/**
 * 第三种查询
 */
function searchThirdly(resultInfoJson){
	ht='';
	htm = '';
	var ocr = resultInfoJson.operationClaimReportResult;
	var columnResultList = resultInfoJson.columnResultList;
	var page = ocr.pageModel;
	var list = page.list;
	var j = list.length;
	$("#serBeginTimeText").html($("#beginTime").val());
	$("#serEndTimeText").html($("#endTime").val());
	$("#spanText1").html(""+(ocr.payAmountSum/10000).toFixed(2)+"万元");
	$("#spanText2").html(""+ocr.paymentSums+"票");
	$("#spanText3").html(""+(ocr.payAmountSum/ocr.businIncomeSum*100).toFixed(2)+"%");
	$("#spanText4").html(""+(ocr.abnormalSums/ocr.paymentSums*100).toFixed(2)+"%");
	ocr.carrierPaySum = (ocr.carrierPaySum == undefined ? 0 : ocr.carrierPaySum);
	ocr.insurancePaySum = (ocr.insurancePaySum == undefined ? 0 : ocr.insurancePaySum);
	ocr.companyPaySum = (ocr.companyPaySum == undefined ? 0 : ocr.companyPaySum);
	PaySums = ocr.carrierPaySum + ocr.insurancePaySum + ocr.companyPaySum;
	$("#spanText5").html((ocr.carrierPaySum/PaySums*100).toFixed(2)+"%");
	$("#spanText6").html((ocr.insurancePaySum/PaySums*100).toFixed(2)+"%");
	$("#spanText7").html((ocr.companyPaySum/PaySums*100).toFixed(2)+"%");
	if (j>0) {
			ht+='<thead><tr>';
				ht+='<th width="3%">序号</th>';
				ht+='<th width="25%">客户公司名称</th>';
				ht+='<th width="">赔付额（万元）</th>';
				ht+='<th width="">赔付票数</th>';
				ht+='<th width="">赔付占比</th>';
				ht+='<th width="">异常理赔占比</th>';
				ht+='<th width="">需供应商承担</th>';
				ht+='<th width="">需保险公司承担</th>';
				ht+='<th width="">自留风险</th>';
				ht+='<th width="">客户行业</th>';
			ht+='</tr>';
			ht+='</thead><tbody>';
			for (var i = 0; i < j; i++) {
				ht+='<tr>';
					ht+='<td>'+(i+1)+'</td>';
					if (list[i].customerName == undefined) {
						ht+='<td></td>';
					}else{
						ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="'+list[i].customerName+'">'+list[i].customerName+'</div></td>';
					}
					ht+='<td>'+(list[i].payAmount/10000).toFixed(2)+'</td>';
					ht+='<td>'+list[i].paymentSum+'</td>';
					if (!isFinite(list[i].payAmount/list[i].businIncome)) {
						ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="营业额暂无，无法计算">营业额暂无，无法计算</div></td>';
					}else{
						ht+='<td>'+((list[i].payAmount/list[i].businIncome)*100).toFixed(2)+'%</td>';
					}
					if (list[i].totalSum == 0) {
						ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="总票数暂无，无法计算">总票数暂无，无法计算</div></td>';
					}else if(list[i].abnormalSum == undefined){
						ht+='<td>0.00%</td>'; 
					}else{
						ht+='<td>'+((list[i].abnormalSum/list[i].totalSum)*100).toFixed(2)+'%</td>';
					}
					var paySum = list[i].carrierPay+list[i].insurancePay+list[i].companyPay;
					ht+='<td>'+((list[i].carrierPay/paySum)*100).toFixed(2)+'%</td>';
					ht+='<td>'+((list[i].insurancePay/paySum)*100).toFixed(2)+'%</td>';
					ht+='<td>'+((list[i].companyPay/paySum)*100).toFixed(2)+'%</td>';
					if (list[i].guestType==undefined) {
						list[i].guestType = '';
					}
					ht+='<td>'+list[i].guestType+'</td>';
				ht+='</tr>';
			}
			ht+='</tbody>';
	}else{
			ht = '<tr><td colspan="11">没有查询到匹配的数据..</td></tr>';
	}
	htm +='<p>共计：'+page.totalRecords+'条 &nbsp;&nbsp;&nbsp;每页显示';
	htm +='<select name="" id="kuang" class="kuang" onchange="searchOperationReport('+page.pageNo+')">';
	htm +='<option value="10">10</option>';
	htm +='<option value="20">20</option>';
	htm +='<option value="30">30</option>';
	htm +='</select>条&nbsp;&nbsp;&nbsp<span id="list"><span>';
	htm +='<a onclick="searchOperationReport(1);" class="pointer">首页</a>';
	htm +='<input class="pointer" type="button" value="&lt" onclick="searchOperationReport('+page.previousPageNo+');"/>';
	htm +='<strong>当前页为：'+page.pageNo+'</strong>';
	htm +='<input class="pointer" type="button" value="&gt" onclick="searchOperationReport('+page.nextPageNo+');" />';
	htm +='<a class="pointer" onclick="searchOperationReport('+page.totalPages+')">末页</a></span></span>';
	htm +='到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;';
	htm +='<button id="confim" onclick="searchOperationReport(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：<span id="maxPage">'+page.totalPages+'</span>页</p>';
	$("#paging").html(htm);
	$("#kuang").val(page.pageSize);
}


/**
 * 第四种查询
 */
function searchFourthly(resultInfoJson){
	ht='';
	htm = '';
	var ocr = resultInfoJson.operationClaimReportResult;
	var columnResultList = resultInfoJson.columnResultList;
	var page = ocr.pageModel;
	if (page==undefined) {
		alert("暂无数据");
	}else{
		var list = page.list;
		var j = list.length;
		$("#serBeginTimeText").html($("#beginTime").val());
		$("#serEndTimeText").html($("#endTime").val());
		$("#spanText1").html(""+(ocr.payAmountSum/10000).toFixed(2)+"万元");
		$("#spanText2").html(""+ocr.paymentSums+"票");
		$("#spanText3").html(""+(ocr.payAmountSum/ocr.businIncomeSum*100).toFixed(2)+"%");
		$("#spanText4").html(""+(ocr.abnormalSums/ocr.paymentSums*100).toFixed(2)+"%");
		ocr.carrierPaySum = (ocr.carrierPaySum == undefined ? 0 : ocr.carrierPaySum);
		ocr.insurancePaySum = (ocr.insurancePaySum == undefined ? 0 : ocr.insurancePaySum);
		ocr.companyPaySum = (ocr.companyPaySum == undefined ? 0 : ocr.companyPaySum);
		PaySums = ocr.carrierPaySum + ocr.insurancePaySum + ocr.companyPaySum;
		$("#spanText5").html((ocr.carrierPaySum/PaySums*100).toFixed(2)+"%");
		$("#spanText6").html((ocr.insurancePaySum/PaySums*100).toFixed(2)+"%");
		$("#spanText7").html((ocr.companyPaySum/PaySums*100).toFixed(2)+"%");
		if (j>0) {
				ht+='<thead><tr>';
					ht+='<th width="3%">序号</th>';
					ht+='<th width="25%">客户公司名称</th>';
					ht+='<th width="">远成公司</td>';
					ht+='<th width="">赔付额（万元）</th>';
					ht+='<th width="">赔付票数</th>';
					ht+='<th width="">赔付占比</th>';
					ht+='<th width="">异常理赔占比</th>';
					ht+='<th width="">需供应商承担</th>';
					ht+='<th width="">需保险公司承担</th>';
					ht+='<th width="">自留风险</th>';
					ht+='<th width="">客户行业</th>';
				ht+='</tr>';
				ht+='</thead><tbody>';
				for (var i = 0; i < j; i++) {
					ht+='<tr>';
						ht+='<td>'+(i+1)+'</td>';
						if (list[i].customerName == undefined) {
							ht+='<td></td>';
						}else{
							ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="'+list[i].customerName+'">'+list[i].customerName+'</div></td>';
						}
						if (list[i].companyName == undefined) {
							ht+='<td></td>';
						}else{
							ht+='<td><div style="width:86%;margin-left:7%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="'+list[i].companyName+'">'+list[i].companyName+'</div></td>';
						}
						ht+='<td>'+(list[i].payAmount/10000).toFixed(2)+'</td>';
						ht+='<td>'+list[i].paymentSum+'</td>';
						if (!isFinite(list[i].payAmount/list[i].businIncome)) {
							ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="营业额暂无，无法计算">营业额暂无，无法计算</div></td>';
						}else{
							ht+='<td>'+((list[i].payAmount/list[i].businIncome)*100).toFixed(2)+'%</td>';
						}
						if (list[i].totalSum == 0) {
							ht+='<td><div style="width:95%;margin-left:2%;float: left;text-align: left;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="总票数暂无，无法计算">总票数暂无，无法计算</div></td>';
						}else if(list[i].abnormalSum == undefined){
							ht+='<td>0.00%</td>'; 
						}else{
							ht+='<td>'+((list[i].abnormalSum/list[i].totalSum)*100).toFixed(2)+'%</td>';
						}
						var paySum = list[i].carrierPay+list[i].insurancePay+list[i].companyPay;
						ht+='<td>'+((list[i].carrierPay/paySum)*100).toFixed(2)+'%</td>';
						ht+='<td>'+((list[i].insurancePay/paySum)*100).toFixed(2)+'%</td>';
						ht+='<td>'+((list[i].companyPay/paySum)*100).toFixed(2)+'%</td>';
						if (list[i].guestType==undefined) {
							list[i].guestType = '';
						}
						ht+='<td>'+list[i].guestType+'</td>';
					ht+='</tr>';
				}
				ht+='</tbody>';
		}else{
				ht = '<tr><td colspan="11">没有查询到匹配的数据..</td></tr>';
		}
		htm +='<p>共计：'+page.totalRecords+'条 &nbsp;&nbsp;&nbsp;每页显示';
		htm +='<select name="" id="kuang" class="kuang" onchange="searchOperationReport('+page.pageNo+')">';
		htm +='<option value="10">10</option>';
		htm +='<option value="20">20</option>';
		htm +='<option value="30">30</option>';
		htm +='</select>条&nbsp;&nbsp;&nbsp<span id="list"><span>';
		htm +='<a onclick="searchOperationReport(1);" class="pointer">首页</a>';
		htm +='<input class="pointer" type="button" value="&lt" onclick="searchOperationReport('+page.previousPageNo+');"/>';
		htm +='<strong>当前页为：'+page.pageNo+'</strong>';
		htm +='<input class="pointer" type="button" value="&gt" onclick="searchOperationReport('+page.nextPageNo+');" />';
		htm +='<a class="pointer" onclick="searchOperationReport('+page.totalPages+')">末页</a></span></span>';
		htm +='到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;';
		htm +='<button id="confim" onclick="searchOperationReport(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：<span id="maxPage">'+page.totalPages+'</span>页</p>';
		$("#paging").html(htm);
		$("#kuang").val(page.pageSize);
	}
}
	
	
	
	/***
	 * 加载图表
	 */
	function loadGraphPie(orc){
		if (orc.pageModel==undefined) {
			return;
		}
		var payAmountSum = (!vidate(orc.payAmountSum) ? 0 : parseFloat((orc.payAmountSum/10000).toFixed(2)));//总理赔金额
		var businIncomeSum = (!vidate(orc.businIncomeSum) ? 0 : parseFloat((orc.businIncomeSum/10000)));//总营业额
		var paymentSums = (!vidate(orc.paymentSums) ? 0 : orc.paymentSums);//总理赔票数
		var abnormalSums = (!vidate(orc.abnormalSums) ? 0 : orc.abnormalSums);//总异常签收票数
		var totalSums = (!vidate(orc.totalSums) ? 0 : orc.totalSums);//总票数
		var carrierPaySum = (!vidate(orc.carrierPaySum) ? 0 : orc.carrierPaySum);//总承运商赔付
		var insurancePaySum = (!vidate(orc.insurancePaySum) ? 0 : orc.insurancePaySum);//总保险公司赔付
		var companyPaySum = (!vidate(orc.companyPaySum) ? 0 : orc.companyPaySum);//总公司赔付
		var paySum = carrierPaySum+insurancePaySum+companyPaySum;//三家总赔付
		
		var data1 = [payAmountSum+"万元",payAmountSum]//第一张饼图数据
		
		var data2 = [paymentSums+"票",paymentSums]//第二张饼图数据
		
		var abnormalCompletion = parseFloat((abnormalSums/totalSums < 0 ? 0 : abnormalSums/totalSums));
		var notAbnormalCompletion = parseFloat(((totalSums-abnormalSums)/totalSums < 0 ? 0 : (totalSums-abnormalSums)/totalSums));
		var data3 =  [
		              ['非异常', notAbnormalCompletion],
		          		{
			                name: '异常',
			                y: abnormalCompletion,
			                sliced: false,
			                selected: true
		          		}
            		]//第三张饼图数据
            		
		var carrierPaySumCompletion = parseFloat((paySum == 0 ? 0 : carrierPaySum/paySum));
		var insurancePayCompletion = parseFloat((paySum == 0 ? 0 : insurancePaySum/paySum));
		var companyPayCompletion = parseFloat((paySum == 0 ? 0 : companyPaySum/paySum));
		var data4 = [
			            {
			                name: '承运商',
			                y: carrierPaySumCompletion,
			                sliced: true,
			                selected: true
			            },
			            ['保险公司', insurancePayCompletion],
			            ['远成', companyPayCompletion]
			        ]//第四张饼图数据
		
		var payAmountCompletion = parseFloat((businIncomeSum == 0 ? 0 : payAmountSum/businIncomeSum));
		var notPayAmountCompletion = parseFloat((businIncomeSum == 0 ? 1 : (businIncomeSum-payAmountSum)/businIncomeSum));
		var data5 = [
			            {
			                name: '理赔金额',
			                y: payAmountCompletion,
			                sliced: false,
			                selected: true
			            },
			            ['非理赔金额', notPayAmountCompletion]
			        ]//第五张饼图数据
		
		$("#pie1-data").html(payAmountSum+"万元");
		$("#pie2-data").html(paymentSums+"票");
		/***
		 * 第一张饼图
		 * */
		var titieName1 = "总理赔金额";
		Highcharts.chart('container1', {
			navigation: {
	            buttonOptions: {
	                enabled: false
	            }
	        },
			credits :{
				enabled:false
			},
			colors:colors,
			chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		        
		    },
		    title: {
		        text: '当前理赔汇总',
		        style:{
		        	"color":"#358ff0",
		        	"font-size": "16px"
		        }
		    },
		    tooltip: {
		    	enable:false
		        //pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
		    },
		    plotOptions: {
		        pie: {
		        	size:"50%",
		            allowPointSelect: true,
		            cursor: 'pointer',
		            depth: 25,
		            dataLabels: {
		            	distance:"-30%",
		                enabled: false,
		                format: '{point.name}',
		                style:{
		                	"color": "green", "fontSize": "20px", "fontWeight": "bold"
		                }
		            },
		            showInLegend: true
		        }
		    },
		    series: [{
		        type: 'pie',
		        name:"总理赔金额",
		        data: [
		            data1
		        ]
		    }],
		    legend:{
		    	labelFormat: ''+titieName1
		    }
		});
		
		/**
		 * 第二张饼图
		 */
		var titieName2 = "赔付票数";
		Highcharts.chart('container2', {
			navigation: {
	            buttonOptions: {
	                enabled: false
	            }
	        },
			credits :{
				enabled:false
			},
			colors: colors,
			chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		    },
//			 chart: {
//			        type: 'pie',
//			        options3d: {
//			            enabled: true,
//			            alpha: 45,
//			            beta: 0
//			        }
//			    },
		    title: {
		        text: '当前赔付票数',
		        style:{
		        	"color":"#358ff0",
		        	"font-size": "16px"
			    }
		    },
		    tooltip: {
		    	enable:false
		        //pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
		    },
		    plotOptions: {
		        pie: {
		        	size:"50%",
		            allowPointSelect: true,
		            cursor: 'pointer',
		            depth: 25,
		            dataLabels: {
		            	distance:-67,
		                enabled: false,
		                format: '{point.name}',
		                style:{
		                	"color": "green", "fontSize": "20px", "fontWeight": "bold"
		                }
		            },
		            showInLegend: true
		        }
		    },
		    series: [{
		        type: 'pie',
		        name:"赔付票数",
		        data: [
		               data2
		        ]
		    }],
		    legend:{
		    	labelFormat: ''+titieName2,
		    }
		});
		
		
		/**
		 * 第三张饼图
		 */
		Highcharts.chart('container3', {
			navigation: {
	            buttonOptions: {
	                enabled: false
	            }
	        },
			credits :{
				enabled:false
			},
			colors: colors1,
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		    },
//		    chart: {
//	            plotBackgroundColor: null,
//	            plotBorderWidth: null,
//	            plotShadow: false,
//	            type: 'pie'
//	        },
		    title: {
		        text: '异常签收占比',
		        style:{
		        	"color":"#358ff0",
		        	"font-size": "16px"
		        }
		    },
		    tooltip: {
		        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
		    },
		    plotOptions: {
//		        pie: {
//		            allowPointSelect: true,
//		            cursor: 'pointer',
//		            depth: 35,
//		            dataLabels: {
//		                enabled: true,
//		                format: '{point.name}'
//		            }
//		        }
		    pie: {
		    	size:"50%",
	            allowPointSelect: true,
	            cursor: 'pointer',
	            depth: 25,
	            dataLabels: {
	            	distance:0,
	                enabled: true,
	                format: '{percentage:.2f}'+'%'
	            },
	            showInLegend: true
	        }
		    },
		    series: [{
		        type: 'pie',
		        name: '异常签收占比',
		        data:  data3
		    }]
		});
		
		
		/**
		 * 第四按张饼图
		 */
		Highcharts.chart('container4', {
			navigation: {
	            buttonOptions: {
	                enabled: false
	            }
	        },
			credits :{
				enabled:false
			},
			colors: colors1,
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		    },
//		    chart: {
//	            plotBackgroundColor: null,
//	            plotBorderWidth: null,
//	            plotShadow: false,
//	            type: 'pie'
//	        },
		    title: {
		        text: '风险转移占比',
		        style:{
		        	"color":"#358ff0",
		        	"font-size": "16px"
		        }
		    },
		    tooltip: {
		        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
		    },
		    plotOptions: {
//		        pie: {
//		            allowPointSelect: true,
//		            cursor: 'pointer',
//		            depth: 35,
//		            dataLabels: {
//		                enabled: true,
//		                format: '{point.name}'
//		            }
//		        }
		    pie: {
		    	size:"50%",
	            allowPointSelect: true,
	            cursor: 'pointer',
	            depth: 25,
	            dataLabels: {
	            	distance:0,
	                enabled: true,
	                format: '{percentage:.2f}'+'%'
	            },
	            showInLegend: true
	        }
		    },
		    series: [{
		        type: 'pie',
		        name: '风险转移占比',
		        data: data4
		    }],
		    legend:{
		    	width:"100%"
		    }
		    
		});
		
		/**
		 * 第五张饼图
		 */
		Highcharts.chart('container5', {
			navigation: {
	            buttonOptions: {
	                enabled: false
	            }
	        },
			credits :{
				enabled:false
			},
			colors: colors1,
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		    },
//		    chart: {
//	            plotBackgroundColor: null,
//	            plotBorderWidth: null,
//	            plotShadow: false,
//	            type: 'pie'
//	        },
		    title: {
		        text: '理赔整体占比',
		        style:{
		        	"color":"#358ff0",
		        	"font-size": "16px"
		        }
		    },
		    tooltip: {
		        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
		    },
		    plotOptions: {
//		        pie: {
//		            allowPointSelect: true,
//		            cursor: 'pointer',
//		            depth: 35,
//		            dataLabels: {
//		                enabled: true,
//		                format: '{point.name}'
//		            }
//		        }
		    
		    pie: {
		    	size:"50%",
	            allowPointSelect: true,
	            cursor: 'pointer',
	            depth: 25,
	            dataLabels: {
	            	distance:0,
	                enabled: true,
	                format: '{percentage:.2f}'+'%'
	            },
	            
//	            formatter:function (){
//	            	return this.percentage+"%";
//	            },
	            showInLegend: true
	        }
		    },
		    series: [{
		        type: 'pie',
		        name: '理赔整体占比',
		        data: data5
		    }],
//		    legend:{
//		    	labelFormatter:function (){
//		    		return '('+this.percentage+')';
//		    	}
//		    }
		});
		
	}

	
	/**
	 * 加载右侧柱状图
	 */
	function loadRight(columnResultList){
		var j = columnResultList.length;
		if (j<1) {
			$("#graphRight").html("暂无数据");
		}else{
			var categories = [];
			var data = [];
			/*********处理Y轴坐标start**********/
			if (!vidate(columnResultList[0].payAmount)) {
				columnResultList[0].payAmount = 0;
			}
			if (!vidate(columnResultList[0].businIncome)) {
				columnResultList[0].businIncome = 0;
			}
			var maxData =  parseFloat((columnResultList[0].payAmount/columnResultList[0].businIncome*100).toFixed(0))+1;
			/*********处理Y轴坐标end**********/
			for (var i = 0; i < j; i++) {
				if (!vidate(columnResultList[i].guestType)) {
					columnResultList[i].guestType = '';
				}
				if (columnResultList[i].businIncome != 0.0) {
					data[i] = parseFloat((columnResultList[i].payAmount/columnResultList[i].businIncome*100).toFixed(2));
					categories[i] = columnResultList[i].guestType;
//					console.log(columnResultList[i].guestType+"========");
				}
			}
			
//			console.log(data+"+++++++++"+categories)
			Highcharts.chart('graphRight', {
				navigation: {
		            buttonOptions: {
		                enabled: false
		            }
		        },
			    chart: {
			        type: 'column',
			        height:400,
			        options3d: {
			            enabled: true,
			            alpha: 0,
			            beta: 25,
			            depth: 70
			        }
			    },
			    title: {
			        text: '各行业赔付',
			        style:{
			        	"color":"#358ff0",
			        	"font-size": "16px"
			        }
			        	
			    },
//			    subtitle: {
//			        text: 'Notice the difference between a 0 value and a null point'
//			    },
			    plotOptions: {
			        column: {
			        	maxPointWidth:50, //柱子宽度
			            depth: 25,
			            dataLabels: {
			                enabled: true,
			                format: '{point.y}%'
			            },
			        }
			    },
			    tooltip: {
			        headerFormat: '<b>{point.x}</b><br/>',
			        pointFormat: '{series.name}: {point.y}%<br/>'
			    },
			    xAxis: {
			        categories: categories,
				    title: {
			            text: '行业名称'
			        },
			        labels: {
		                style: { 
		                    color: '#4572A7' //设置标签颜色 
		                } 
		            } 
			    },
			    yAxis: {
			    	max:maxData,
			    	min:0,
//			    	tickPositions: [0, 5, 10, 15, 20, 50, 100],
			        title: {
			            text: '行业赔付占比'
			        },
			        labels: { 
		                formatter: function() {//格式化标签名称 
		                    return this.value + '%'; 
		                }, 
		                style: { 
		                    color: '#4572A7' //设置标签颜色 
		                } 
		            },
			    },
			    series: [{
			        name: '占比',
			        data: data
			    }]
			});
		}
	}
	
	
	function loadGraphOther(otherResultList){
		
		
	}
	
	
	//数据导出
	$(function(){
		
		$("#export_data").click(function(){
			
			var beginTime =$("#beginTime").val();
			var endTime = $("#endTime").val();
			
			var customerName=encodeURI($("#customerName").val(),"UTF-8");
		    customerName=encodeURI(customerName,"UTF-8");
			
			var companyName=encodeURI($("#companyName").val(),"UTF-8");
			companyName=encodeURI(companyName,"UTF-8");
			
		    
		    window.location.href = basePath+'operationClaimReport/oprationClaim.do?beginTime='+beginTime+'&endTime='+endTime+'&customerName='+customerName+'&companyName='+companyName;
		});	
		
	});
	
	

	
	