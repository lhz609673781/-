/**
 * created by lhz on 2017-8-10
 * 
 * 项目运营
 */
$(function(){
/*************初始化变量**************/
	var colors = ['#ccc','#eef3fa','#f8e1ce','#7cb5ec','#90ed7d','#f7a35c','#8085e9'];
	var _beginTime = $("#SearchDateStart"),
	_endTime = $("#SearchDateStop"),
	_ransportVotes = $('#ransport-votes'), //今日运输票数
	_ransportWeight = $('#ransport-weight'),//今日运输重量
	_ransportVolume = $('#ransport-volume');//今日运输体积 
	var $staticPath = $('#urlpath').html(); //路径
	var datastr = ['毛利率','提货及时率','返单合格及时率','到货及时率','信息录入准确率'];
/******获取下拉框里匹配到的项目******/
	var timer = false;
	function getmatchProject (){
		var configdata = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var beginTime = configdata.beginTime, endTime = configdata.endTime, _projectName = $('#project-name').val();
		var dataPath = {beginTime:beginTime,endTime:endTime,projectName:_projectName}
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/operationGroupReport/loadProjectNameByDeliveryTime.do',
		    data: dataPath
		},
		function (data) {
			if(data.resultCode == 9999){
				$('#selectSearch').html('').hide();
			}
			var dataJson = JSON.parse(data.resultInfo);
			$('#selectSearch').html('')
							  .append($('#projectNameSearch').render(dataJson))
							  .show();
			$('#selectSearch li').each(function(index,item){
				$(item).click(function(){
					$('#project-name').val($(item).html());
					$('#selectSearch').hide();
				})
			})
			
		});
	}
	
/***********公司名称输入绑定事件***************/
	$('.deleteAll').on('click',function(){
		$('#project-name').val('');
		$('#selectSearch').hide();
	})
	
	$('#project-name').on('input',function(){
		clearTimeout(timer); // 清除未执行的代码，重置回初始化状态
	    timer = setTimeout(function(){
	    	var valueLen = $('#project-name').val();
	    	if(valueLen.length < 1){
	    		$('#selectSearch').hide();
	    	}else{
	    		getmatchProject ();
	    	}
	    }, 300);
	})
	
/*************查询搜索**************/
	$('#clientSearchSearchBtn').on('click',function(){
		var _companyName = $('#project-name').val();
		if(_companyName == '') _companyName = companyName;
		var configdata = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
    	var beginTime = configdata.beginTime, endTime = configdata.endTime;
		window.location.href = $staticPath + 'views/report/view/sheet/projectOperation.jsp?beginTime='+beginTime+'&endTime='+endTime+'&company='+_companyName+'&navId=23';
	})
	
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
	var companyName = decodeURIComponent(urlObj.company);
	var startTime = urlObj.beginTime;
	var stopTime = urlObj.endTime;
	$('.compName').html(companyName);
	$('#project-name').val(companyName).attr('placeholder',companyName);
	dayStatistics ();  //日营运
	tonnageChange (); //吨位变化
	fiveIndexdata ();  //5个指标维度
	operationDetail (null,1,10);  //运营详情列表
	
	
/***************蜘蛛图************/
	function spiderInit (dataArr){
		var spiderConfig = {
				container : '#summary-container',
			   chartsType : 'area',
			   titleText  : '',
			   xAxisValue : ['A','B','C','D',
		                     'E'],
			   data       : dataArr,
			   tickmarkPlacement : 'on',
			   pointformat : '<span style="color:{series.color}"><span id=tspantext>'+datastr[4]+'</span><b>{point.y:,.2f}%</b><br/>',
			   color: colors,
			   options3d:{
				   enabled: false
			   }
		}
		initCharts (spiderConfig,true);
		/******获取tooltips的值*****/
		$('#summary-container .highcharts-color-undefined').mousemove(function(){
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
	
/**************折线图************/
	function Brokenlineinit (xValue,dataArr){
		var BrokenlineConfig = {
				container : '#ranking-container',
				chartsType : 'line',
				titleText  : '当前项目吨位运输走势图(万吨)',
				xAxisValue : xValue,
				data   : dataArr,
				tickmarkPlacement : 'between',
				pointformat : '<span style="color:{series.color}"><b>{point.y:,.2f}万吨</b><br/>',
				color: colors,
				options3d:{
	                enabled: true,
	                alpha: 0,
	                beta: 0,
	                depth: 150,
	                viewDistance: 10
	           }
		}
		initCharts (BrokenlineConfig,false);
	}
	
/**********格式化默认时间***********/ 
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
		return {beginTime:beginTime,endTime:endTime};
	}
	
/***********项目当日运营统计********/
    function dayStatistics (){
    	var datapath = {projectName:companyName};
    	EasyAjax.ajax_Post_Json({
    	    url: _basicsPath_ + '/projectOperation/dayOperation_pro.do',
    	    data: datapath
    	},
    	function (data) {
    			var dataJson = JSON.parse(data.resultInfo);
				_ransportVotes.html(dataJson.sumOperaNum);
				_ransportWeight.html(dataJson.sumWeight);
				_ransportVolume.html(dataJson.sumVolume);
    	});
    }
    
/***********项目吨位变化********/
    function tonnageChange (){
    	var datapath = {projectName:companyName};
    	EasyAjax.ajax_Post_Json({
    	    url: _basicsPath_ + '/projectOperation/tonnageTrend_pro.do',
    	    data: datapath
    	},
    	function (data) {
    			var dataJson = JSON.parse(data.resultInfo);
				var monthArr = [];
				var dataArr = [];
				$.each(dataJson,function(index,item){
					var _weight =Number(( item.sumWeight / 10000 ).toFixed(2));
					monthArr.push(item.month);
					dataArr.push(_weight);
				})
				monthArr = monthArr.reverse();
				dataArr = dataArr.reverse();
				Brokenlineinit (monthArr,dataArr);
    	});
    }
    
/***********项目5个指标维度********/
    function fiveIndexdata (){
    	var configdata = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
    	var beginTime = configdata.beginTime, endTime = configdata.endTime;
    	var datapath = {projectName:companyName,beginTime:startTime,endTime:stopTime}
    	EasyAjax.ajax_Post_Json({
    	    url: _basicsPath_ + '/projectOperation/indexShow_pro.do',
    	    data: datapath
    	},
    	function (data) {
    			var dataJson = JSON.parse(data.resultInfo);
				var dataArr = [];
				$.each(dataJson,function(index,ele){
					dataArr.push(Number((ele*100).toFixed(2)));
				})
				spiderInit (dataArr);
				
    	});
    }
    
/**********项目运营情况列表*******/
	function operationDetail (type,curr,pgSize){
		var configdata = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var beginTime = configdata.beginTime, endTime = configdata.endTime;
		var database = {projectName:companyName,beginTime:beginTime,endTime:endTime,pageNo:curr,pageSize:pgSize};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/projectOperation/operationDetails_pro.do',
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
//				console.log(dataJson.list);
				$.each(dataJson.list,function(index,ele){
	   				ele.info = ((ele.informationEntryRate)*100).toFixed(2)+"%";
	   				ele.quali = ((ele.qualifiedRateOf)*100).toFixed(2)+"%";
	   				ele.RateIntime = ((ele.arrivalRateIntime)*100).toFixed(2)+"%";
	   				ele.prompt = ((ele.promptDeliveryRate)*100).toFixed(2)+"%";
	   				ele.gross = ((ele.grossProfitMargin)*100).toFixed(2)+"%";
	   				
	   			})
				page(dataJson.list,dataJson.totalPages,'#tableExhibition','#showgroupOperationList',curr,operationDetail,type);
		});
	}
	
/**
	 * 项目运营的数据导出
	 */
	$("#projectExcelImpl").click(function(){
		var configdata = formatsearchTime (_beginTime,_endTime,startTime,stopTime);
		var beginTime = configdata.beginTime, endTime = configdata.endTime;
	
		var projectName = encodeURI($(".compName").html(),"UTF-8");
		projectName = encodeURI(projectName,"UTF-8");
		
		var pageSize = $(".totalNumber").html();
					
		window.location.href = _basicsPath_+'/projectOperation/doProjectDetailsExcele.do?beginTime='+beginTime+'&endTime='+endTime
			+'&pageSize='+pageSize+'&projectName='+projectName;
	});
	
})
