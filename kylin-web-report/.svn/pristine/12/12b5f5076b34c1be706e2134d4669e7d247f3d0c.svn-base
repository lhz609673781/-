/**
 * created by lhz on 2017/8/24
 * 
 * 车辆维修成本业务逻辑
 */
$(function () {
/*********初始化所有函数和全局变量************/
	var colors = ['#7cb5ec','#434348','#90ed7d','#f7a35c','#8085e9'];
	var _beginTime = $("#SearchDateStart"),
    	_endTime = $("#SearchDateStop");
	var $staticPath = $('#urlpath').html(); //路径
	
	getAllCompany ();
	informationSummary ();
	maintenanceTable (null,1,10);
	maintenancefrequency ();
	
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

/************获取所有公司**************/
    function getAllCompany (){
    	EasyAjax.ajax_Post_Json({
    	    url: _basicsPath_ + '/CarBasicInfo/findAllCompany.do',
    	    data: ''
    	},
    	function (data) {
    		layui.use(['layer','element','laydate','form','laypage','layedit'], function(){
    			layer = layui.layer,
    		    element = layui.element(),
    			laydate = layui.laydate,
    			form = layui.form(),
    			layedit = layui.layedit,
    			laypage = layui.laypage;
    			var dataJson = JSON.parse(data.resultInfo);
    			$.each(dataJson,function(index,ele){
    				var _CompanyName = ele.carCompany;
    				$('.select-company').append('<option >'+_CompanyName+'</option>');
    				form.render();
    			})
    		});
    	});
    }

/**********格式化默认时间以及获取表单初始信息***********/ 
	function formatsearchTime (_beginTime,_endTime){
		var beginTime = _beginTime.val();
		var endTime = _endTime.val();
		if( beginTime=='' || beginTime==null ){
			beginTime = formatDate(new Date(),'上月年月');
			_beginTime.attr('placeholder',beginTime);
		};
		if( endTime=='' || endTime==null ){
			endTime = formatDate(new Date(),'本月年月');
			_endTime.attr('placeholder',endTime);
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
		var _companyName = $('.companyName').find('.layui-this').text();//公司名称
		if(_companyName == '') {
			_companyName ='上海';
		};
		return {beginTime:beginTime,endTime:endTime,companyName:_companyName};
	}

/**********基本信息汇总以及条形图汇总*******/
	function informationSummary (){
		var config = formatsearchTime (_beginTime,_endTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,companyName:config.companyName};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carMaintenance/carSummaryInfo.do',
		    data: database
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				$('.carCount').html(dataJson.carCount);
				$('.maintainCount').html(dataJson.maintainCount);
				$('.maintainTime').html(dataJson.maintainTime);
				$('.maintainAmount').html((dataJson.maintainAmount/10000).toFixed(2));
				$('#company_name').html(dataJson.companyName);
				$('#begin-time').html(dataJson.beginTime);
				$('#stop-time').html(dataJson.endTime);
				var _carCount = $('.carCount').html();
				if(dataJson.maintainCount != 0) {
					$('#averageTime').html((dataJson.maintainTime/dataJson.maintainCount).toFixed(2));
				}else{
					$('#averageTime').html(0);
				}
				/********获取到当前公司总车辆数*********/
				var databasic = {carCompany:config.companyName};
				EasyAjax.ajax_Post_Json({
				    url: _basicsPath_ + '/CarBasicInfo/totalCarType.do',
				    data: databasic
				},
				function (data) {
						var dataJson = JSON.parse(data.resultInfo);
						owncar = dataJson.own;
						if(owncar == 0){
							_carCountpercent = 0;
						}else{
							_carCountpercent = ((Number(_carCount) / owncar) * 100).toFixed(2);
						}
						$('#carCountpercent').html(_carCountpercent);
				});	
		});
	}

/**********车辆维修列表*******/
	function maintenanceTable (type,curr,pgSize){
		var config = formatsearchTime (_beginTime,_endTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,companyName:config.companyName,pageNo:curr,pageSize:pgSize};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carMaintenance/carRecordAll.do',
		    data: database
		},
		function (data) {
				if(data.resultInfo.length>1){
					var dataJson = JSON.parse(data.resultInfo);
				}else{
					var dataJson = data.resultInfo;
				}
				$('.totalNumber').html(dataJson.totalRecords);
				page(dataJson.list,dataJson.totalPages,'#SearchTpl','#showcarInformationList',curr,maintenanceTable,type)
				/**********绑定列表点击事件进入子页面**********/
				$('.car-Number').each(function(i,a){
					var carBrand = $.trim($(a).text());
					var campanyN = encodeURIComponent(config.companyName);
					console.log(campanyN);
					$(a).on('click',function(){
						window.location.href = $staticPath + 'views/report/view/sheet/carMaintenanceDetail.jsp?companyName='+campanyN+'&beginTime='+config.beginTime+'&endTime='+config.endTime+'&carBrand='+carBrand+'&navId=26';
					})
				})
		});
	}
	
/************************生成轮播页面********************/
	function CarouselPageHandler (CompanydataARR,CarydataARR,countNum,PenaltyType,obj,flag){
		for (var i = 0; i < obj.length; i++){
			if(i == obj.length-1){
				//****当最后一个元素的时候直接添加*****//
				PenaltyType.push( obj[i].type );
				CompanydataARR.push( PenaltyType );
				if(flag){
					if( obj[i].count > 12 ) {
						countNum.push( {y:obj[i].count,color: '#e77268'} );
					}else if( obj[i].count < 12 && obj[i].count > 6){
						countNum.push( {y:obj[i].count,color: '#ffce44'} );
					}else{
						countNum.push( obj[i].count );
					}
				}else{
					countNum.push( obj[i].count );
				}
				
				CarydataARR.push( countNum );
			}else{
				PenaltyType.push( obj[i].type );
				if(flag){
					if( obj[i].count > 12 ) {
						countNum.push( {y:obj[i].count,color: '#e77268'} );
					}else if( obj[i].count < 12 && obj[i].count > 6){
						countNum.push( {y:obj[i].count,color: '#ffce44'} );
					}else{
						countNum.push( obj[i].count );
					}
				}else{
					countNum.push( obj[i].count );
				}
				if( (i+1)%10 == 0 ){
					CompanydataARR.push( PenaltyType );
					CarydataARR.push( countNum );
					PenaltyType = [];
					countNum = [];
				}
			}
			
		}
		//*******判断每组数据是否小于10******//*
		var cardataLen = CarydataARR[CarydataARR.length-1];
		var carCompanyLen = CompanydataARR[CompanydataARR.length-1];
		if(cardataLen.length < 10){
			var dist = 10 - cardataLen.length;
			for(var k=0;k<dist;k++){
				cardataLen.push(null);
				carCompanyLen.push(' ');
			}
		}
	}
/**********维修次数，饼图详情*******/
	function maintenancefrequency (){
		var config = formatsearchTime (_beginTime,_endTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,companyName:config.companyName};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carMaintenance/carSummaryInfo.do',
		    data: database
		},
		function (data) {
			var dataJson = JSON.parse(data.resultInfo);
				var dataArr = [];
				var xNames = [];
				var datas = [];
				(function(){/*******条形图*********/
					var countNum = [];
					var PenaltyType = [];
					var CompanydataARR = [];
					var CarydataARR = [];
					var fineTypes = dataJson.fineTypes;
					CarouselPageHandler (CompanydataARR,CarydataARR,countNum,PenaltyType,fineTypes,false);
					$('.swiper-wrapper div').remove();
					$.each(CompanydataARR,function(index,item){
						var $item = $("<div class='swiper-slide swiper"+index+"'></div>");
						$('.swiper-wrapper').append($item);
						var config = {
								XValue : item,
								dataArr : CarydataARR[index]
						}
						initbarChartsHandler ($(".swiper"+index),config,true);
					})
					sliderUpandDown ();
				})();
				$.each(dataJson.proportions,function(index,item){
					dataArr.push ({
				                        name: item.type,
				                        y: item.count,
				                        sliced: true,
				                        selected: true
				                    })
				    xNames.push(item.type);
					datas.push(item.count);
				})
			    charts3d("#car-proportion",dataArr,true,'#7cb5ec');
				$('#car-proportion').prepend('<p class="pie-title">维修种类占比</p>');
//				initbar (xNames,datas);
		});
	}
	
	
	
	/**
	 * 车辆维修导出
	 * 
	 */
	$("#carBasic_excelImpl").click(function(){
		
		var config = formatsearchTime (_beginTime,_endTime);
		var beginTime = config.beginTime;
		var endTime = config.endTime;
		var companyName = config.companyName;
					
		window.location.href = _basicsPath_+'/carMaintenance/carRecordDownloadAll.do?beginTime='+beginTime+'&endTime='+endTime+'&companyName='+companyName;
		
	});
});
