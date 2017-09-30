/**
 * created by lhz on 2017/9/6
 * 
 * 车辆维修成本业务逻辑
 */
$(function () {
/*********初始化所有函数和全局变量************/
	var colors = ['#7cb5ec','#434348','#90ed7d','#f7a35c','#8085e9'];
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
	$('#project-name').val(carId).attr('placeholder',carId);
	$('.getcompany').html(companyN);
	informationSummary ();/*********详情汇总********/
	maintenanceTable (null,1,10);/******列表详情*******/
	maintenancefrequency ();/******饼图详情********/
/*************查询搜索**************/
	$('#carInformationSearchBtn').on('click',function(){
		informationSummary ();
		maintenanceTable (null,1,10);
		maintenancefrequency ();
	})
/*****************初始化条形图*****************/
	function initbar (xName,datas){
		$('#carMaintenance-frequency').highcharts({
	        chart: {
	            type: 'bar'
	        },
	        title: {
	            text: '维修种类次数汇总'
	        },
	        xAxis: {
	            categories: xName,
	            title: {
	                text: null
	            }
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: '',
	                align: 'high'
	            },
	            labels: {
	                overflow: 'justify'
	            }
	        },
	        tooltip: {
	            valueSuffix: '次'
	        },
	        plotOptions: {
	            bar: {
	                dataLabels: {
	                    enabled: true,
	                    allowOverlap: true
	                }
	            }
	        },
	        credits: {
	            enabled: false
	        },
	        series: [{
	            name: '维修次数',
	            data: datas
	        }]
	    });
	}
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
		var database = {beginTime:config.beginTime,endTime:config.endTime,companyName:companyN,searchKey:carbrandVal};
    	EasyAjax.ajax_Post_Json({
    	    url: _basicsPath_ + '/carMaintenance/carNumberPage.do',
    	    data: database
    	},
		function (data) {
    		var dataJson = JSON.parse(data.resultInfo);
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

/**********基本信息汇总以及条形图汇总*******/
	function informationSummary (){
		var config = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,carNumber:config.companyName};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carMaintenance/carSummarySubInfo.do',
		    data: database
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				$('.carCount').html(dataJson.carSubTime);
				$('.maintainCount').html(dataJson.carSubCount);
				$('.maintainTime').html(dataJson.carSubRepair);
				$('.maintainAmount').html((dataJson.carSubTotal));
				$('#company_name').html(config.companyName);
				$('#begin-time').html(dataJson.beginTime);
				$('#stop-time').html(dataJson.endTime);
		});
	}

/**********车辆维修列表*******/
	var repairProjectArr = [], repairDateArr = [];
	function maintenanceTable (type,curr,pgSize){
		var config = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,carNumber:config.companyName,pageNo:curr,pageSize:pgSize};
		EasyAjax.ajax_Post_Json({/*******获取总列表数据*******/
		    url: _basicsPath_ + '/carMaintenance/carRecordById.do',
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
				$('.repairFee').each(function(i,a){/*****循环两个弹窗按钮*********/
					$(a).click(function(){
						var datasum = {repairDate:repairDateArr[i],repairProject:repairProjectArr[i],carNumber:config.companyName};
						initAjaxHandler ($(this),datasum);
					})
				})
				$('.hourFee').each(function(i,a){/*****循环两个弹窗按钮*********/
					$(a).click(function(){
						var datasum = {repairDate:repairDateArr[i],repairProject:repairProjectArr[i],carNumber:config.companyName};
						initAjaxHandler ($(this),datasum);
					})
				})
		});
	}
/***********弹出窗口*************/
	function initAjaxHandler (a,datasum){
		EasyAjax.ajax_Post_Json({/***********弹出窗口*************/
		    url: _basicsPath_ + '/carMaintenance/carRecordItemByRecordId.do',
		    data: datasum
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				var num = 0,money = 0, workTime = 0, workTimeFee = 0;
				$.each(dataJson,function(i,ele){/******合并数值*******/
					num += ele.number;
					money += ele.money;
					workTime += ele.time_unit;
					workTimeFee += ele.hourFee;
				})
				$('#numberSum').html(num);
				$('#feeSum').html(money);
				$('#workhour').html(workTime);
				$('#workhourFee').html(workTimeFee);
				if($('.partsdataList')) $('.partsdataList').remove();
				var _content;
				if(a.hasClass('repairFee')){
					_content = $('#partsFeeshowlist');
					$('#showpartsFee').prepend($('#partsFee').render(dataJson));
				}else{
					_content = $('#workTimeFee');
					$('#showworkTimeFee').prepend($('#workTimeFeelist').render(dataJson));
				}
				layui.use(
						[ 'layer', 'element', 'laydate', 'form', 'laypage' ],function(){
							layer.open({
								type: 1
								,title: false //不显示标题栏
								,closeBtn: true
								,area: '80%'
								,shade: 0.8//遮罩层透明度
								,id: 'LAY_layuipro' //设定一个id，防止重复弹出
								,resize: false//是否允许拉伸
								,btn: '确定'
								,btnAlign: 'c'
								,moveType: 1 //拖拽模式，0或者1
								,content: _content
							});
				})
		});
	}
/**********维修次数，饼图详情*******/
	function maintenancefrequency (){
		var config = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,carNumber:config.companyName};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carMaintenance/carSummarySubInfo.do',
		    data: database
		},
		function (data) {
			var dataJson = JSON.parse(data.resultInfo);
				var dataArr = [];
				var xNames = [];
				var datas = [];
				var totaldatas = 0;
				$.each(dataJson.proportions,function(index,item){
					totaldatas += item.count;
				    xNames.push(item.type);
					datas.push(item.count);
				})
				$.each(dataJson.proportions,function(index,item){
					item.percentCount = item.count/totaldatas
					dataArr.push ({
				                        name: item.type,
				                        y: item.percentCount,
				                        sliced: true,
				                        selected: true
				                    })
				})
			    charts3d("#car-proportion",dataArr,true,'#7cb5ec');
				$('#car-proportion').prepend('<p class="pie-title">维修种类占比</p>');
				initbar (xNames,datas);
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
		window.location.href = _basicsPath_+'/carMaintenance/carRecordById.do?beginTime='+beginTime+'&endTime='+endTime+'&carNumber='+carN;
		
	});
});
