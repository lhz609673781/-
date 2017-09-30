/*
 *Created by lhz on 2017/08/09.
 * 
 *财务详情业务逻辑部分
 */

$(function () {
/*********初始化全局变量********/
	var _beginTime = $("#SearchDateStart"),
    	_endTime = $("#SearchDateStop");
	var $staticPath = $('#urlpath').text();
	var $dotShow = $('#dot-show').html();
	var index_ = 0, pagecurr = null;
	var Psize = null;
getAllCompany ();	
operationDetail (null,1,10);//表格详情
tansportationRanking ();//运输详情
/*************查询搜索**************/
	$('#clientSearchSearchBtn').on('click',function(){
		$(".selectValue").find("option").attr('selected',false);
		$(".selectValue").find("option[value=10]").attr('selected',true);
		operationDetail (null,1,10);
		tansportationRanking ();
		
	})

/**********监听是否按月或按日查询**********/
	function epyselect (){
		isMonth = true;
		if(index_ >= 2){
			if ($(".layui-form-switch").hasClass("layui-form-onswitch")) {
				isMonth = true;
			} else {
				isMonth = false;
			}
		}
		index_ ++;
		return isMonth;
	}
	
/***********获取下拉框里所有的公司*********/
	function getAllCompany (){
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/marginDetails/findAllCompany.do',
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
					if(ele != null){
						var _CompanyName = ele.groupName;
						$('.select-companyN').append('<option >'+_CompanyName+'</option>');
						form.render();
					}
				})
			});
		});
	}
	
/*****************折线图*******************************************************************/	
	function Brokenlineinit (xValue,dataArr){
		$("#ranking-right").highcharts({
					chart : {
						type : 'line',
						style : {
							'padding' : '5px'
						},
						
					},
					title : {
						text : '毛利/毛利率月度走势',
					},
					xAxis : {
						categories : xValue
					},
					yAxis : {
						title : {
							text : ''
						}
					},
					tooltip : {
						
					},
					credits : {
						enabled : false
					},
					legend : {
						enabled : true
					},
					plotOptions : {
						line : {
							dataLabels : {
								enabled : true
							// 开启数据标签
							}
						// enableMouseTracking: flag //
						// 关闭鼠标跟踪，对应的提示框、点击事件会失效
						}
					},
					series : dataArr
				})
	}
/*******************柱状图**************/
	function initClumn (CompanyName,data) {
        $('#ranking-container').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: '收入/成本月度走势图'
            },
            xAxis: {
                categories: CompanyName,
                tickmarkPlacement: 'between',
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                }
            },
            tooltip: {
//                headerFormat: '<span style="font-size:10px">{point.key}</span><table style="width:auto">',
//                pointFormat: '<tr><td style="padding:0">运输重量：<b>&nbsp;{point.y:.2f} 万吨</b></td></tr>',
//                footerFormat: '</table>',
//                shared: true,
//                useHTML: true
            },
            credits:{
                enabled:false
            },
            legend : {
				enabled : true
			},
            plotOptions: {
                column: {
                    pointPadding:0.1,
                    borderWidth: 0.5,
                    shadow: true,
                    dataLabels : {
						enabled : true,
						allowOverlap : false
					}
                }
            },
            series: data
        });
	}
        
		
/**********集团运营情况列表*******/
		function operationDetail (type,curr,pgSize){
			var APIdress, config;
			var isflag = epyselect ();
			if(isflag){
				config = formatsearchTime (_beginTime,_endTime,'上月年月','本月年月');
				APIdress = _basicsPath_ + '/marginDetails/monthlyChartDetailByMonth.do'
			}else{
				config = formatsearchTime (_beginTime,_endTime,'上月年月日','本月年月日');
				APIdress = _basicsPath_ + '/marginDetails/monthlyChartDetailByDay.do'
			}
			var _companyName = $('.companyName').find('.layui-this').text();//公司名称
			if(_companyName == '') {
				_companyName ='上海';
			};
			var database = {groupName:_companyName,beginTime:config.beginTime,endTime:config.endTime,pageNo:curr,pageSize:pgSize};
			EasyAjax.ajax_Post_Json({
			    url: APIdress,
			    data: database,
			    beforeHandler: function(){
			    	$('#loading').show();
			    }
			},
			function (data) {
					$('#loading').hide();
					if(data.resultInfo.length>1){
						var dataJson = JSON.parse(data.resultInfo);
					}else{
						var dataJson = data.resultInfo;
					}
					$('.totalNumber').html(dataJson.totalRecords);
					page(dataJson.list,dataJson.totalPages,'#SearchTpl','#showgroupOperationList',curr,operationDetail,type);
			});
		}

/**********分公司收入/成本月度走势图*******/
		function tansportationRanking (){
			var APIdress, config;
			var isflag = epyselect ();
			if(isflag){
				config = formatsearchTime (_beginTime,_endTime,'上月年月','本月年月');
				APIdress = _basicsPath_ + '/marginDetails/monthlyChartByMonth.do';
			}else{
				config = formatsearchTime (_beginTime,_endTime,'上月年月日','本月年月日');
				APIdress = _basicsPath_ + '/marginDetails/monthlyChartByDay.do';
			}
			var _companyName = $('.companyName').find('.layui-this').text();//公司名称
			if(_companyName == '') {
				_companyName ='上海';
			};
			var database = {groupName: _companyName,endTime:config.endTime};
			EasyAjax.ajax_Post_Json({
			    url: APIdress,
			    data: database
			},
			function (data) {
					var dataJson = JSON.parse(data.resultInfo);
					var _CompanyName = [];
						_data = [],_income = [],_cost = [],income_indicators = [],
						_grossProfit = [],_grossProfitRate = [],
						_dataTwo = [];
					$.each(dataJson,function(index,ele){
						_income.push(Number(( ele.income / 10000 ).toFixed(2)));
						_cost.push(Number(( ele.cost / 10000 ).toFixed(2)));
						_CompanyName.push(ele.date);
						_grossProfit.push(Number(( ele.grossProfit / 10000 ).toFixed(2)));
						_grossProfitRate.push(Number(( ele.grossProfitRate).toFixed(2)));
					})
					if(isflag){
						EasyAjax.ajax_Post_Json({
						    url: _basicsPath_ + '/marginDetails/showIndicator.do',
						    data: database
						},
						function (data) {
								var dataJson = JSON.parse(data.resultInfo);
								for(var o in dataJson.incomeIndicator){
									income_indicators.push(Number((dataJson.incomeIndicator[o] / 10000).toFixed(2)));
								}
								_data.push({
									name: '收入（万）',
									data: _income,
									color: '#94d0f4'
								},{
									name: '收入指标（万）',
									data: income_indicators,
									color: '#b8c7e6'
								},{
									name: '成本（万）',
									data: _cost,
									color: '#f7a35c'
								});
								initClumn (_CompanyName,_data) ;
						});
					}else{
						_data.push({
							name: '收入（万）',
							data: _income,
							color: '#94d0f4'
						},{
							name: '成本（万）',
							data: _cost,
							color: '#f7a35c'
						});
						initClumn (_CompanyName,_data) ;
					}
					_dataTwo.push({
						name: '毛利（万）',
						data: _grossProfit,
						color: '#94d0f4'
					},{
						name: '毛利率',
						data: _grossProfitRate,
						color: '#f7a35c'
					});
					Brokenlineinit (_CompanyName,_dataTwo);
			});
		}

/**********************表格按字段名排序**********************/
		$('#table-thead th[data-type]').each(function(index,_item){
			$(_item).append('<i></i>');
			$(_item).on('click',function(){
				pagecurr != null ? pagecurr : 1;
				Psize != null ? Psize : 10;
				$('#table-thead th[data-type]').find('i').html("").css('margin-left','');
				$(this).find('i').html('&darr;').css('margin-left','13px');
				var itemType = $(this).data('type');
				fieldOrderHandler (itemType,pagecurr,Psize);
			})
		})
		function fieldOrderHandler (_orderBy,pageNo,pageSize){
					pagecurr = pageNo;
					Psize = pageSize;
					var _pageNo = pageNo || 1,
						_pageSize = pageSize || 10;
					var _companyName = $('.companyName').find('.layui-this').text();//公司名称
					if(_companyName == '') {
						_companyName ='上海';
					};
					var config = formatsearchTime (_beginTime,_endTime,'上月年月','本月年月');
					var _basicConfig = {groupName:_companyName,beginTime:config.beginTime,endTime:config.endTime, orderParame:_orderBy,PageNo:_pageNo,PageSize:_pageSize}
					
					EasyAjax.ajax_Post_Json({
					    url:  _basicsPath_  + '/marginDetails/orderBy.do',
					    data: _basicConfig
					},
					function (data) {
						var dataJson = JSON.parse(data.resultInfo);
								$('.totalNumber').html(dataJson.totalRecords);
								page(dataJson.list,dataJson.totalPages,'#SearchTpl','#showgroupOperationList',pageNo,fieldOrderHandler,_orderBy);
					});
		}
		/**
		 * 财务详情导出
		 * 
		 */
		$("#importBut").click(function(){
			
			var config = formatsearchTime (_beginTime,_endTime);
			var beginTime = config.beginTime;
			var endTime = config.endTime;
			var pageSize = $(".totalNumber").html();
						
			window.location.href = _basicsPath_+'/operationGroupReport/exportOperationGroupList.do?beginTime='+beginTime+'&endTime='+endTime+'&pageSize='+pageSize;
			
		});
});

