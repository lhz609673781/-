/**
 * created by lhz on 2017/9/19
 */
/*********初始化所有函数和全局变量************/
	var colors = ['#ccc','#eef3fa','#f8e1ce','#7cb5ec','#90ed7d','#f7a35c','#8085e9'];
	var _beginTime = $("#SearchDateStart"),isMouth = 0,
    	_endTime = $("#SearchDateStop");
	var $staticPath = $('#urlpath').text();
	informationSummary ();
	getcompanycarsNumber ();
	AllReaultSummary ();
	$('#carInformationSearchBtn').on('click',function(){
		informationSummary ();
		getcompanycarsNumber ();
		AllReaultSummary ();
	})
	$('#turn-to-next').on('click', function(){
		window.location.href = $staticPath + 'views/report/view/sheet/grossStatisticsDetail.jsp?navId=27';
	})
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
            legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				maxHeight : 300,
				navigation : {
					activeColor : '#3E576F',
					animation : true,
					arrowSize : 12,
					inactiveColor : '#CCC',
					style : {
						fontWeight : 'bold',
						color : '#333',
						fontSize : '12px'
					}
				},
				y:10
			},
            series: [{
                type: 'pie',
                name: '收入占比',
                data: dataArr
            }]
        });
    }
    
/**********饼图汇总*******/
	function informationSummary (){
		var config = formatsearchTime (_beginTime,_endTime,'上月年月','本月年月');
		var database = {beginTime: config.beginTime, endTime: config.endTime}
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/companyGrossProfit/companyIncomeProportion.do',
		    data: database
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				var dataArr = [];
				var otherIncome = 0;
				$.each(dataJson,function(i,a){
					if(i<9){
						if(i == 5){
							dataArr.push({
								name: a.groupName,
								y: (a.income)*100,
			                    sliced: true,
			                    selected: true
							})
						}else{
							var configArr = [];
							configArr.push(a.groupName);
							configArr.push((a.income)*100);
							dataArr.push(configArr);
						}
					}else{
						otherIncome += (a.income)*100;
					}
				})
				var configArr = [];
				dataArr.push({
					name: '其他分公司',
					y: otherIncome,
                    color: '#edecec'
				})
				initchartsData (dataArr);//初始化饼图
		});
	}

/**********查询结果汇总*******/
	function AllReaultSummary (){
		var config = formatsearchTime (_beginTime,_endTime,'上月年月','本月年月');
		var database = {beginTime: config.beginTime, endTime: config.endTime}
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/companyGrossProfit/companyProportionAveraging.do',
		    data: database
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				console.log(dataJson);
				$('#num_one').html((dataJson.averagingCost/10000).toFixed(2));
				$('#num_two').html((dataJson.averagingIncome/10000).toFixed(2));
				$('#num_three').html((dataJson.grossProfitSum/10000).toFixed(2));
				$('#num_four').html((dataJson.averagingGrossProfit/10000).toFixed(2));
		});
	}

/*************************获取到各公司毛利率********************/
	function getcompanycarsNumber (){
		var config = formatsearchTime (_beginTime,_endTime,'上月年月','本月年月');
		var database = {beginTime: config.beginTime, endTime: config.endTime}
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/companyGrossProfit/companyProportion.do',
		    data:database
		},
		function (data) {
			dataJson = JSON.parse(data.resultInfo);
			/**************获取蜘蛛图数据*****************/
			(function(){
				var countNum = [];
				var CompanyName = [];
				var CompanydataARR = [];
				var CarydataARR = [];
				CarouselspiderHandler (CompanydataARR,countNum,CompanyName,CarydataARR,dataJson);
				$('.spider-map').find('.swiper-wrapper div').remove();
				$.each(CompanydataARR,function(index,item){
					var $item = $("<div class='swiper-slide swiper"+index+"'></div>");
					$('.spider-map').find('.swiper-wrapper').append($item);
					var config = {
							XValue : item,
							dataArr : [{
								name: '毛利率',
								data: CarydataARR[index],
								color: '#275586'
							}],
							decimals : true//允许小数
					}
					initbarChartsHandler ($('.spider-map').find(".swiper"+index),config,false);
				})
				sliderUpandDown ();
			})();
			
			/**************获取条形图数据*****************/
			(function(){
				var countNum = [];
				var PenaltyType = [];
				var CompanydataARR = [];
				var CarydataARR = [];
				var incomeARR = [];
				var income = [];
				CarouselPageHandler (CompanydataARR,CarydataARR,countNum,PenaltyType,incomeARR,income,dataJson);
				$('#bar-container').find('.swiper-wrapper div').remove();
				$.each(CompanydataARR,function(index,item){
					var $item = $("<div class='swiper-slide swiper"+index+"'></div>");
					$('#bar-container').find('.swiper-wrapper').append($item);
					var config = {
							XValue : item,
							dataArr : [{
								name: '成本',
								data: CarydataARR[index],
								color: '#94d0f4'
							},{
								name: '收入',
								data: incomeARR[index],
								color: '#f7a35c'
							}],
							decimals : true//允许小数
					}
					initbarChartsHandler ($('#bar-container').find(".swiper"+index),config,true);
				})
				sliderUpandDown ();
			})();
			/**************获取柱状轮播图数据*****************/
			(function(){
				var CompanyName = [];/**公司名字**/
				var CompanydataARR = [];/**公司名字大数组**/
				var countNum = [];/**收入**/
				var CarydataARR = [];/**收入大数组**/
				var grossProfit = [];/**毛利**/
				var grossProfitARR = [];/**毛利大数组**/
				var incomeIndicators = []/**收入指标**/
				var incomeIndicatorsARR = []/**收入指标大数组**/
				var config = {
						CompanyName 	: CompanyName,
						CompanydataARR  : CompanydataARR,
						countNum 		: countNum,
						CarydataARR 	: CarydataARR,
						grossProfit 	: grossProfit,
						grossProfitARR  : grossProfitARR,
						incomeIndicators: incomeIndicators,
						incomeIndicatorsARR : incomeIndicatorsARR
				}
				CarouselColumPageHandler (config,dataJson);
				$('.right-container').find('.slider-container').remove();
				$('.right-container').find('#dot-container').empty();
				$('.chartsSlider').append('<div class="slider-container"></div>');
				$.each(config.CompanydataARR,function(index,item){
					var $item = $("<div class='slider slider"+index+"'></div>");
					var $dot = $('<div class="dot"><i class="dot_normal"></i></div>');
					$('.right-container').find('.slider-container').append($item);
					$('.right-container').find('#dot-container').append($dot);
					if(isMouth == 1){
						var dataArrconfig = [{
							name: '收入',
							data: config.CarydataARR[index]
						},{
							name: '毛利',
							data: config.grossProfitARR[index],
							color: '#d48265'
						},{
							name: '收入指标',
							data: config.incomeIndicatorsARR[index],
							color: '#61a0a8'
						}]
					}else{
						var dataArrconfig = [{
							name: '收入',
							data: config.CarydataARR[index]
						},{
							name: '毛利',
							data: config.grossProfitARR[index],
							color: '#d48265'
						}]
					}
					
					initcolumnCharts(".slider"+index,dataArrconfig,item,'万元');
					
				})	
				initSlider('.chartsSlider') ;
				_showbtn ();
				$('.right-container').find('.dot').eq(0).addClass('dot_active');
				$('.right-container').find(".dot").each(function(_index,_item){
					$(_item).on('click',function(){
						if(_index == mySlider.currentIndex) return false;
						mySlider.seekTo(_index);
					})
				})
			})();
		})
	}

/************************生成条形轮播页面********************/
	function CarouselPageHandler (CompanydataARR,CarydataARR,countNum,PenaltyType,incomeARR,income,obj){
		for (var i = 0; i < obj.length; i++){
			if(i == obj.length-1){
				//****当最后一个元素的时候直接添加*****//
				PenaltyType.push( obj[i].groupName );
				CompanydataARR.push( PenaltyType );
				countNum.push( parseInt(((obj[i].countNum) / 10000).toFixed(2)) );
				CarydataARR.push( countNum );
				income.push( parseInt(((obj[i].income) / 10000).toFixed(2)) );
				incomeARR.push(income);
			}else{
				PenaltyType.push( obj[i].groupName );
				countNum.push( parseInt(((obj[i].cost) / 10000).toFixed(2)) );
				income.push( parseInt(((obj[i].income) / 10000).toFixed(2)) );
				if( (i+1)%5 == 0 ){
					CompanydataARR.push( PenaltyType );
					CarydataARR.push( countNum );
					incomeARR.push(income);
					PenaltyType = [];
					countNum = [];
					income = [];
				}
			}
			
		}
		//*******判断每组数据是否小于5******//*
		var cardataLen = CarydataARR[CarydataARR.length-1];
		var incomeLen = incomeARR[incomeARR.length-1];
		var carCompanyLen = CompanydataARR[CompanydataARR.length-1];
		if(cardataLen.length < 5){
			var dist = 5 - cardataLen.length;
			for(var k=0;k<dist;k++){
				cardataLen.push(null);
				incomeLen.push(null);
				carCompanyLen.push(' ');
			}
		}
	}
	

	
/************************生成柱状轮播页面********************/
	function CarouselColumPageHandler (config,obj){
		for (var i = 0; i < obj.length; i++){
			if(i == obj.length-1){
				//****当最后一个元素的时候直接添加*****//
				config.CompanyName.push( obj[i].groupName );/*公司名称*/
				config.CompanydataARR.push( config.CompanyName );
				config.countNum.push( parseInt(((obj[i].income) / 10000).toFixed(2)) );/*收入*/
				config.CarydataARR.push( config.countNum );
				config.grossProfit.push( parseInt(((obj[i].grossProfit) / 10000).toFixed(2)) );/*毛利*/
				config.grossProfitARR.push(config.grossProfit);
				isMouth = obj[i].isMouth;
				if(obj[i].isMouth == 1){
					config.incomeIndicators.push( parseInt(((obj[i].incomeIndicators) / 10000).toFixed(2)) );/*收入指标*/
					config.incomeIndicatorsARR.push(config.incomeIndicators);
				}
			}else{
				config.CompanyName.push( obj[i].groupName );/*公司名称*/
				config.countNum.push( parseInt(((obj[i].income) / 10000).toFixed(2)) );/*收入*/ 
				config.grossProfit.push( parseInt(((obj[i].grossProfit) / 10000).toFixed(2)) );/*毛利*/
				if(obj[i].isMouth == 1){
					config.incomeIndicators.push( parseInt(((obj[i].incomeIndicators) / 10000).toFixed(2)) );/*收入指标*/
				}
				if( (i+1)%5 == 0 ){
					config.CompanydataARR.push( config.CompanyName );
					config.CarydataARR.push( config.countNum );
					config.grossProfitARR.push(config.grossProfit);
					if(obj[i].isMouth == 1){
						config.incomeIndicatorsARR.push(config.incomeIndicators);
					}
					config.CompanyName = [];
					config.countNum = [];
					config.grossProfit = [];
					config.incomeIndicators = [];
				}
			}
			
		}
		//*******判断每组数据是否小于5******//*
		var carCompanyLen = config.CompanydataARR[config.CompanydataARR.length-1];/*公司名称*/
		var cardataLen = config.CarydataARR[config.CarydataARR.length-1];/*收入*/
		var grossProfitARRLen = config.grossProfitARR[config.grossProfitARR.length-1];/*毛利*/
		if(isMouth == 1){
			var incomeIndicatorsLen = config.incomeIndicatorsARR[config.incomeIndicatorsARR.length-1];/*收入指标*/
		}
		if(cardataLen.length < 5){
			var dist = 5 - cardataLen.length;
			for(var k=0;k<dist;k++){
				cardataLen.push(null);
				grossProfitARRLen.push(null);
				if(isMouth == 1){
					incomeIndicatorsLen.push(null);
				}
				carCompanyLen.push(' ');
			}
		}
	}
/************************蜘蛛图**********************************/
	function CarouselspiderHandler (CompanydataARR,countNum,CompanyName,CarydataARR,obj){
		for (var i = 0; i < obj.length; i++){
			if(i == obj.length-1){
				//****当最后一个元素的时候直接添加*****//
				countNum.push( obj[i].grossProfitRate );
				CarydataARR.push( countNum );
				CompanyName.push( obj[i].groupName);
				CompanydataARR.push( CompanyName );
			}else{
				countNum.push( obj[i].grossProfitRate );
				CompanyName.push( obj[i].groupName);
				if( (i+1)%10 == 0 ){
					CarydataARR.push( countNum );
					CompanydataARR.push( CompanyName );
					countNum = [];
					CompanyName = [];
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
/*****************************柱状图******************************************/
	function initcolumnCharts(container, Arrdata, CompanyName,unit) {/*unit:tooltips的单位*/
		$(container)
				.highcharts(
						{
							chart : {
								type : 'column',
								options3d: {
					                enabled: false,
					                alpha: 10,
					                beta: 15,
					                depth: 90
					            }
							},
							title : {
								text : ''
							},
							xAxis : {
								categories : CompanyName,
								tickmarkPlacement : 'between',
							},
							yAxis : {
								min : 0,
								title : {
									text : ''
								},
								labels: {
					                	rotation: 90
					            }
							},
							tooltip : {
								
							},
							credits : {
								enabled : false
							},
							plotOptions : {
								column : {
									pointPadding : 0.2,
									borderWidth : 0.2,
									groupPadding : 0.1,
									shadow : true,
									dataLabels : {
										enabled : true,
										allowOverlap : false
									}
								}

							},
							legend : {
								enabled : true
							},
							series : Arrdata
						});
	}
	
/***********************************************条形图*******************************************************/	
	function initbarChartsHandler (container,config,des){
		$(container).highcharts({
	        chart: {
	            type: 'bar',
	        	options3d: {
	                enabled: false,
	                alpha: 10,
	                beta: -10,
	                depth: 100
	            }
	        },
	        title: {
	            text: ''
	        },
	        xAxis: {
	            categories: config.XValue,
	            title: {
	                text: null
	            },
	            labels: {
	            	formatter: function() {//解决x轴文字过长
	            		//获取到刻度值
	            		var labelVal = this.value;
	            		//实际返回的刻度值
	            		var reallyVal = labelVal;
	            		//判断刻度值的长度
	            		if(labelVal.length > 5)
	            		{
	            			//截取刻度值
	            			reallyVal = labelVal.substr(0,5)+"...<br/>";
//	            			reallyVal = labelVal.substr(0,5)+"<br/>"+labelVal.substring(5,labelVal.length-1);
	            		}
	            			return reallyVal;
	            		}
	            }
	        },
	        yAxis: {
	            min: 0,
	            allowDecimals: config.decimals || false,        //控制数轴是否显示小数。
	            title: {
	                text: '',
	                align: 'high'
	            },
	            labels: {
	                overflow: 'justify'
	            }
	        },
	        tooltip: {
	            valueSuffix: ''
	        },
	        legend: {
	        	enabled : des || false
	        },
	        plotOptions: {
	            bar: {
	            	shadow: true,
	                dataLabels: {
	                    enabled: true,
	                    allowOverlap: true
	                }
	            }
	        },
	        credits: { /***********版权标签***************/
	            enabled: false
	        },
	        series:  config.dataArr
	    });
	}
	
	
/**********************蜘蛛图***********************************/	
	