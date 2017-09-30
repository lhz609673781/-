/**
 * created by lhz on 2017/9/14
 * 
 * 车辆罚款统计
 */
$(function () {
/*********初始化所有函数和全局变量************/
	var colors = ['#7cb5ec','#434348','#90ed7d','#f7a35c','#8085e9'];
	var _beginTime = $("#SearchDateStart"),
    	_endTime = $("#SearchDateStop");
	var $staticPath = $('#urlpath').html(); //路径
	
	getAllCompany ();
	maintenanceTable (null,1,10);
	getbarData ();
/*************查询搜索**************/
	$('#carInformationSearchBtn').on('click',function(){
		maintenanceTable (null,1,10);
		getbarData ();
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
		var _companyName = $('.companyName').find('.layui-this').text();//公司名称
		if(_companyName == '') {
			_companyName ='上海';
		};
		return {beginTime:beginTime,endTime:endTime,companyName:_companyName};
	}

/**********车辆维修列表*******/
	function maintenanceTable (type,curr,pgSize){
		var config = formatsearchTime (_beginTime,_endTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,blameCompany:config.companyName,pageNo:curr,pageSize:pgSize};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carFine/carRecord.do',
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
						window.location.href = $staticPath + 'views/report/view/sheet/carPenaltyStatisticsDetail.jsp?companyName='+campanyN+'&beginTime='+config.beginTime+'&endTime='+config.endTime+'&carBrand='+carBrand+'&navId=24';
					})
				})
		});
	}
	
/**********************************************初始化条形图和柱状图**************************************************/
	function getbarData (){
		var config = formatsearchTime (_beginTime,_endTime);
		var database = {beginTime:config.beginTime,endTime:config.endTime,blameCompany:config.companyName};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/carFine/carSummaryInfo.do',
		    data: database
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				$('#untreatedMoney').html(dataJson.untreatedMoney);
				$('#untreatedPoints').html(dataJson.untreatedPoints);
				/**************获取条形图数据*****************/
				(function(){
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
				/**************获取柱状轮播图数据*****************/
				(function(){
					var countNum = [];
					var PenaltyType = [];
					var CompanydataARR = [];
					var CarydataARR = [];
					var fineTypes = dataJson.fineCarPoints;
					CarouselPageHandler (CompanydataARR,CarydataARR,countNum,PenaltyType,fineTypes,true);
					$.each(CompanydataARR,function(index,item){
						var $item = $("<div class='slider slider"+index+"'></div>");
						var $dot = $('<div class="dot"><i class="dot_normal"></i></div>');
						$('.right-container').find('.slider-container').empty().append($item);
						$('.right-container').find('#dot-container').empty().append($dot);
						initcolumnCharts(".right-container .slider"+index,CarydataARR[index],item,null,'分','   ');
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
				
		});
	}
/**************箭头hover效果****************************/
	function _showbtn (){
		 $('.right-container').hover(function(){
			 $('.btn').show();
		  },function(){
			$('.btn').hide();
	  		})
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
