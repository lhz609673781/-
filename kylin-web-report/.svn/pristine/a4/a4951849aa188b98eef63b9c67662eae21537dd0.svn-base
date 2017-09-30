/**
 * created by lhz on 2017/9/6
 * 
 * 车辆维修成本业务逻辑
 */
$(function () {
/*********初始化所有函数和全局变量************/
	var colors = ['#ccc','#eef3fa','#f8e1ce','#7cb5ec','#90ed7d','#f7a35c','#8085e9'];
	var _beginTime = $("#SearchDateStart"),
    	_endTime = $("#SearchDateStop");

/**********获取到url传送过来的值**************/
	var urlpath = window.location.href;
	urlpathArr = urlpath.split('?');
	urlpath = urlpathArr[1];
	var strArr =  urlpath.split('&');
	var urlObj = {};
	for(var i=0;i<strArr.length;i++){
		var str = strArr[i].split('=');
		urlObj[str[0]] = str[1];
	}
	var carId = decodeURIComponent(urlObj.carBrand);
	var startTime = urlObj.beginTime;
	var stopTime = urlObj.endTime;
	var companyN = decodeURIComponent(urlObj.companyName);
	$('.getcompany').html(companyN);
	$('#project-name').val(carId).attr('placeholder',carId);
	informationSummary ();/*********饼图详情汇总********/
	maintenanceTable (null,1,10);/******列表详情*******/
	initIllegalFrequency ()/***********折线图汇总*******/
/*************查询搜索**************/
	$('#carInformationSearchBtn').on('click',function(){
		informationSummary ();
		maintenanceTable (null,1,10);
	})

/***************************************为下拉框绑定事件搜索**********************************************/
	$('.deleteAll').on('click',function(){
		$('#project-name').val('');
		$('#selectSearch').hide();
	})
	var timer;
	$('#project-name').on('input',function(){
		clearTimeout(timer); // 清除未执行的代码，重置回初始化状态
	    timer = setTimeout(function(){
	    	var valueLen = $('#project-name').val();
	    	if(valueLen.length < 1){
	    		$('#selectSearch').hide();
	    	}else{
	    		getAllCarbrand ();
	    	}
	    }, 300);
	})
/************获取所有车牌号**************/
	function getAllCarbrand (){
		var carbrandVal = $('#project-name').val();
    	var config = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,blameCompany:companyN,searchKey:carbrandVal};
    	EasyAjax.ajax_Post_Json({
    	    url: _basicsPath_ + '/carFine/carNumberPage.do',
    	    data: database
    	},
		function (data) {
    		var dataJson = JSON.parse(data.resultInfo);
    		console.log(dataJson);
			if(data.resultCode == 9999){
				$('#selectSearch').html('').hide();
			}
			var dataJson = JSON.parse(data.resultInfo);
			$('#selectSearch').html('')
							  .append($('#projectNameSearch').render(dataJson.list))
							  .show();
			if((dataJson.list).length == 0){
				$('#selectSearch').append('<p class="noMatch">无匹配项</p>');
				$('#project-name').val('').attr('placeholder',carId);
			}
			$('#selectSearch li').each(function(index,item){
				$(item).click(function(){
					$('#project-name').val($(item).html());
					$('#selectSearch').hide();
				})
			})
			
		});
	}

/**********格式化默认时间以及获取表单初始信息***********/ 
    function formatsearchTime (_beginTime,_endTime,startTime,stopTime){
		var beginTime = _beginTime.val();
		var endTime = _endTime.val();
		if( beginTime=='' || beginTime==null ){
			_beginTime.attr('placeholder',startTime);
			beginTime = startTime;
		};
		if( endTime=='' || endTime==null ){
			_endTime.attr('placeholder',stopTime);
			endTime = stopTime;
		};
		$(_beginTime,_endTime).on('click',function(){
			_beginTime.attr('placeholder','请输入开始日期');
			_endTime.attr('placeholder','请输入结束日期');
		})
		var d = dateInterval(beginTime,endTime)
		if(d<0){
			layer.msg('开始日期大于结束日期，请重新输入');
			return;
		}
		var _carId = $('#project-name').val();
		if(_carId == '') _carId = carId;
		return {beginTime:beginTime,endTime:endTime,companyName:_carId};
	}
/*******饼图********************/
    function initchartsData (dataArr){
    	$('#pie-container').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: ''
            },
            tooltip: {
                headerFormat: '{series.name}<br>',
                pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
            },
            colors : [  '#f7a35c','#6373b5', '#4c766a', '#e4d354', '#a6dff0',
						'#cda198', '#91e8e1', '#deb9db' ],
            credits : {
    			enabled : false
    		},
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [{
                type: 'pie',
                name: '当前车辆违章占比',
                data: dataArr
            }]
        });
    }
    
/**********饼图汇总*******/
	function informationSummary (){
		var config = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,carNumber:config.companyName};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carFine/carSummarySubInfo.do',
		    data: database
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				var dataArr = [];
				var totalCount = 0;
				$.each(dataJson.proportions,function(i,a){
					totalCount += a.count;
				});
				
				$.each(dataJson.proportions,function(i,a){
					var currCount = parseFloat((a.count / totalCount) * 100);
					if(i == dataJson.proportions.length/2){
						dataArr.push({
							name: a.type,
							y: currCount,
		                    sliced: true,
		                    selected: true
						})
					}else{
						var configArr = [];
						configArr.push(a.type);
						configArr.push(currCount);
						dataArr.push(configArr);
					}
				})
				initchartsData (dataArr);//初始化饼图
		});
	}

/**************折线图汇总***********/
	function initIllegalFrequency (){
		var config = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var database = {carNumber:config.companyName};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carFine/carSummarySubYearInfo.do',
		    data: database
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				$('.fine').html(dataJson.fineMoney);
				$('.Points').html(dataJson.pointCount);
				var totalC = 0;
				$.each(dataJson.proportions,function(index,ele){
					totalC += ele.count;
				})
				$('.Illegal-frequence').html(totalC);
		});
	}
/**************折线图************/
	function Brokenlineinit (xValue,dataArr){
		var BrokenlineConfig = {
				container : '#line-container',
				chartsType : 'line',
				titleText  : '     ',
				xAxisValue : xValue,
				data   : dataArr,
				tickmarkPlacement : 'between',
				pointformat : '<span style="color:{series.color}"><b>{point.y}次</b><br/>',
				color: colors,
				options3d:{
	                enabled: true,
	                alpha: 0,
	                beta: 0,
	                depth: 350,
	                viewDistance: 10
	           }
		}
		initCharts (BrokenlineConfig,false);
	}
	var xValue = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];
	var dataArr = [0, 0, 1, 2, 1, 0, 5, 2, 0, 4, 0, 1];
	Brokenlineinit (xValue,dataArr)
/**********车辆维修列表*******/
	var repairProjectArr = [], repairDateArr = [];
	function maintenanceTable (type,curr,pgSize){
		var config = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,carNumber:config.companyName,pageNo:curr,pageSize:pgSize};
		EasyAjax.ajax_Post_Json({/*******获取总列表数据*******/
		    url: _basicsPath_ + '/carFine/carRecordById.do',
		    data: database
		},
		function (data) {
				if(data.resultInfo.length>1){
					var dataJson = JSON.parse(data.resultInfo);
				}else{
					var dataJson = data.resultInfo;
				}
				$.each(dataJson.list,function(index,ele){
					repairProjectArr.push(ele.repairProject);/******弹窗参数存储*******/
					repairDateArr.push(ele.repairDate);/******弹窗参数存储*******/
				})
				$('.totalNumber').html(dataJson.totalRecords);
				page(dataJson.list,dataJson.totalPages,'#SearchTpl','#showcarInformationList',curr,maintenanceTable,type);
		});
	}
	/**
	 * 车辆维修导出
	 * 
	 */
	$("#carBasic_excelImpl").click(function(){
		var config = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var beginTime = config.beginTime;
		var endTime = config.endTime;
		var carN = config.companyName;
		window.location.href = _basicsPath_+'/carMaintenance/carRecordDownloadById.do?beginTime='+beginTime+'&endTime='+endTime+'&carNumber='+carN;
		
	});
});
