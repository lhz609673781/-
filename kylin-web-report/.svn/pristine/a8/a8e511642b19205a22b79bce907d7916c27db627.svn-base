/*
 *Created by lhz on 2017/08/09.
 * 
 *集团运营业务逻辑部分
 */

$(function () {
/*********初始化全局变量********/
	var colors = ['#ccc','#eef3fa','#f8e1ce','#7cb5ec','#90ed7d','#f7a35c','#8085e9'];
	var _beginTime = $("#SearchDateStart"),
    	_endTime = $("#SearchDateStop"),
    	_ransportVotes = $('#ransport-votes'), //今日运输票数
    	_ransportWeight = $('#ransport-weight'),//今日运输重量
    	_ransportVolume = $('#ransport-volume');//今日运输体积        
	var $staticPath = $('#urlpath').text();
	var $dotShow = $('#dot-show').html();
	var datastr = ['毛利率','提货及时率','返单合格及时率','到货及时率','信息录入准确率'];
	
dayStatistics ();  	//当日运营统计
operationDetail (null,1,10);//表格详情
tansportationRanking ();//运输详情
indexDimension ();//集团指标维度
/*************查询搜索**************/
	$('#clientSearchSearchBtn').on('click',function(){
		$(".selectValue").find("option").attr('selected',false);
		$(".selectValue").find("option[value=10]").attr('selected',true);
		operationDetail (null,1,10);
		tansportationRanking ();
		indexDimension ();
	})
	
/**********初始化蜘蛛图**************/
	function initSpider (dataArr){
		var spiderConfig = {
				   container : '#summary-container',
				   chartsType : 'area',
				   titleText  : '',
				   xAxisValue : ['A','B','C','D',
			                     'E'],
				   data       : dataArr,
				   pointformat: '<span style="color:{series.color}"><span id=tspantext>'+datastr[4]+'</span>:<b>{point.y:,.2f}%</b><br/>',
				   tickmarkPlacement : 'on',
				   color: colors
			}
			initCharts (spiderConfig,true);
		/******获取tooltips的值*****/
		$('.highcharts-color-undefined').mousemove(function(){
			$('#tspantext').parent().parent().addClass('configtooltips');
			var tspanId =  $('#tspantext').parent().prev().prev();
			var tspantext = $('#tspantext');
			switch (tspanId.html()){
				case 'A':
					tspantext.html('毛利率');
					break;
				case 'B':
					tspantext.html('提货及时率');
					break;
				case 'C':
					tspantext.html('返单合格及时率');
					break;
				case 'D':
					tspantext.html('到货及时率');
					break;
				case 'E':
					tspantext.html('信息录入准确率');
					break;
			}
		})
		
		
	}
	
/*******************柱状图**************/
	function initClumn (CompanyName,data) {
        $('#ranking-container').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: '各公司的运输重量排名 TOP10'
            },
            xAxis: {
                categories: CompanyName,
                tickmarkPlacement: 'between',
            },
            yAxis: {
                min: 0,
                title: {
                    text: '货物吨位数 (万吨)'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table style="width:auto">',
                pointFormat: '<tr><td style="padding:0">运输重量：<b>&nbsp;{point.y:.2f} 万吨</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            credits:{
                enabled:false
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
            legend: {                                                                    
                enabled: false                                                           
            },
            series: [{
                data: data
            }]
        });
	}
        
/***********集团当日运营统计********/
        function dayStatistics (){
        	EasyAjax.ajax_Post_Json({
        	    url: _basicsPath_ + '/operationGroupReport/operationGroupTotal.do',
        	    data: ''
        	},
        	function (data) {
        			var dataJson = JSON.parse(data.resultInfo);
					_ransportVotes.html(dataJson.votes);
					_ransportWeight.html(dataJson.weight);
					_ransportVolume.html(dataJson.volume);
        	});
        }
        
/**********格式化默认时间***********/ 
		function formatsearchTime (_beginTime,_endTime){
			var beginTime = _beginTime.val();
			var endTime = _endTime.val();
			if( beginTime=='' || beginTime==null ){
				beginTime = formatDate(new Date(),'上月年月日');
				_beginTime.attr('placeholder',beginTime);
			};
			if( endTime=='' || endTime==null ){
				endTime = formatDate(new Date(),'本月年月前日');
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
			return {beginTime:beginTime,endTime:endTime};
		}
		
/**********集团运营情况列表*******/
		function operationDetail (type,curr,pgSize){
			var config = formatsearchTime (_beginTime,_endTime);
			var database = {beginTime:config.beginTime,endTime:config.endTime,pageNo:curr,pageSize:pgSize};
			EasyAjax.ajax_Post_Json({
			    url: _basicsPath_ + '/operationGroupReport/operationGroupReportPage.do',
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
					NameClickHandler (config.beginTime,config.endTime);
			});
		}
/***给列表里的项目和公司名绑定click事件****/
		function NameClickHandler (beginTime,endTime){
			$('.companyName').each(function(index,_item){
				$(_item).on('click',function(){
					var companyName = $.trim($(_item).text());
					window.location.href = $staticPath + 'views/report/view/sheet/BranchOfficeOperation.jsp?beginTime='+beginTime+'&endTime='+endTime+'&company='+companyName+'&navId=23';
				})
			});
			$('.projectName').each(function(index,_item){
				$(_item).on('click',function(){
					var projectName = $.trim($(_item).text());
					window.location.href = $staticPath + 'views/report/view/sheet/projectOperation.jsp?beginTime='+beginTime+'&endTime='+endTime+'&company='+projectName+'&navId=23';
				})
			})
		}
/**********各分公司运输重量排名*******/
		function tansportationRanking (){
			var config = formatsearchTime (_beginTime,_endTime);
			var database = {beginTime:config.beginTime,endTime:config.endTime};
			EasyAjax.ajax_Post_Json({
			    url: _basicsPath_ + '/operationGroupReport/operationGroupRanking.do',
			    data: database
			},
			function (data) {
					var dataJson = JSON.parse(data.resultInfo);
					var _CompanyName = [];
						_data = [];
					$.each(dataJson,function(index,ele){
						var _weight =Number(( ele.weight / 10000 ).toFixed(2));
						_CompanyName.push(ele.companyName);
						_data.push(_weight);
					})
					initClumn (_CompanyName,_data) ;
			});
		}

/**********集团运营5个指标维度*******/
		function indexDimension (){
			var config = formatsearchTime (_beginTime,_endTime);
			var database = {beginTime:config.beginTime,endTime:config.endTime};
			EasyAjax.ajax_Post_Json({
			    url: _basicsPath_ + '/operationGroupReport/operationGroupIndicatorsDimension.do',
			    data: database
			},
			function (data) {
					var dataJson = JSON.parse(data.resultInfo);
					var dataArr = [];
//					$.each(dataJson,function(index,ele){
						dataArr.push(Number((dataJson.projectRote).replace('%','')));
						dataArr.push(Number((dataJson.promptRote).replace('%','')));
						dataArr.push(Number((dataJson.returnRote).replace('%','')));
						dataArr.push(Number((dataJson.arriclaRote).replace('%','')));
						dataArr.push(Number((dataJson.loadRote).replace('%','')));
//					})
					initSpider (dataArr)
					$('#summary-container').prepend($dotShow);
			});
		}
		
		
		/**
		 * 集团运营导出
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

