/**
 * created By lhz on 2017-9-5
 */
var flag = true;
/***************************获取拥有挂靠车辆下拉框里的公司*******************/
	function getAnchoedAllCompany (){
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/CarBasicInfo/findAttacheCarCompany.do',
		    data: ''
		},
		function (data) {
			layui.use(['layer','element','laydate','form','laypage'], function(){
				layer = layui.layer,
			    element = layui.element(),
				laydate = layui.laydate,
				form = layui.form(),
				laypage = layui.laypage;
				var dataJson = JSON.parse(data.resultInfo);
				var $options = $('<option value="">所有公司</option><option >所有公司</option>');
				$('.select-company').html($options);
				$.each(dataJson,function(index,ele){
					var _CompanyName = ele.carCompany;
					$('.select-company').append('<option >'+_CompanyName+'</option>');
					form.render();
				})
			});
		});
	}
	

/************获取柱状图信息*************/
	function getAnchoedcarsNumber (){
		var dataJson;
		var CompanydataARR = [];
		var CarydataARR = [];
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/CarBasicInfo/GroupByAttacheCarCount.do',
		    data:''//不需要参数
		},
		function (data) {
					dataJson = JSON.parse(data.resultInfo);
					var totalCar = [];
					var carCompany = [];
					for (var i=0;i<dataJson.length;i++){
						if(i==dataJson.length-1){
							/****当最后一个元素的时候直接添加*****/
							carCompany.push(dataJson[i].carCompany);
							CompanydataARR.push(carCompany);
							totalCar.push(dataJson[i].attacheSum);
							CarydataARR.push(totalCar);
						}else{
							carCompany.push(dataJson[i].carCompany);
							totalCar.push(dataJson[i].attacheSum);
							if((i+1)%10==0){
								CompanydataARR.push(carCompany);
								CarydataARR.push(totalCar);
								carCompany = [];
								totalCar = [];
							}
						}
					}
					/*******判断每组数据是否小于10******/
					var cardataLen = CarydataARR[CarydataARR.length-1];
					var carCompanyLen = CompanydataARR[CompanydataARR.length-1];
					if(cardataLen.length < 10){
						var dist = 10 - cardataLen.length;
						for(var k=0;k<dist;k++){
							cardataLen.push(null);
							carCompanyLen.push(' ');
						}
					}
					$.each(CompanydataARR,function(index,item){
						var $item = $("<div class='slider slider"+index+"'></div>");
						var $dot = $('<div class="dot"><i class="dot_normal"></i></div>');
						$('.branchOfficeRanking').find('.slider-container').append($item);
						$('.branchOfficeRanking').find('#chartsShowdot-container').append($dot);
						initcolumnCharts(".branchOfficeRanking .slider"+index,CarydataARR[index],item, '', '', true);
					})	
					initSlider();
					$('.branchOfficeRanking').find('.dot').eq(0).addClass('dot_active');
					$('.branchOfficeRanking').find(".dot").each(function(_index,_item){
						$(_item).on('click',function(){
							if(_index == mySlider.currentIndex) return false;
							meSlider.seekTo(_index);
						})
					})
					if($('.branchOfficeRanking .slider').length<=1) $('#chartsShowdot-container').hide();
		});
		var CarrierdataARR = [];
		var CarydataARR = [];
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/CarBasicInfo/GroupByAttacheCarCount.do',
		    data:''//不需要参数
		},
		function (data) {
					dataJson = JSON.parse(data.resultInfo);
					var totalCar = [];
					var carCompany = [];
					for (var i=0;i<dataJson.length;i++){
						if(i==dataJson.length-1){
							/****当最后一个元素的时候直接添加*****/
							carCompany.push(dataJson[i].carCompany);
							CarrierdataARR.push(carCompany);
							totalCar.push(dataJson[i].attacheSum);
							CarydataARR.push(totalCar);
						}else{
							carCompany.push(dataJson[i].carCompany);
							totalCar.push(dataJson[i].attacheSum);
							if((i+1)%10==0){
								CarrierdataARR.push(carCompany);
								CarydataARR.push(totalCar);
								carCompany = [];
								totalCar = [];
							}
						}
					}
					/*******判断每组数据是否小于10******/
					var cardataLen = CarydataARR[CarydataARR.length-1];
					var carCompanyLen = CarrierdataARR[CarrierdataARR.length-1];
					if(cardataLen.length < 10){
						var dist = 10 - cardataLen.length;
						for(var k=0;k<dist;k++){
							cardataLen.push(null);
							carCompanyLen.push(' ');
						}
					}
					$.each(CarrierdataARR,function(index,item){
						var $item = $("<div class='slider slider"+index+"'></div>");
						var $dot = $('<div class="dot"><i class="dot_normal"></i></div>');
						$('.Carrier-chart').find('.slider-container').append($item);
						$('.Carrier-chart').find('#dot-container').append($dot);
						initcolumnCharts(".Carrier-chart .slider"+index,CarydataARR[index],item);
					})	
					initSlider();
					$('.Carrier-chart').find('.dot').eq(0).addClass('dot_active');
					$('.Carrier-chart').find(".dot").each(function(_index,_item){
						$(_item).on('click',function(){
							if(_index == mySlider.currentIndex) return false;
							meSlider.seekTo(_index);
						})
					})
		});
			
	}	
	
/*************绘制轮播图***************/
	function initSlider() {
	    $('.chartsShow').islider({
	            currentIndex: 0,
	            duration: 0.5,
	            touch: true,
	            start: function () {
	            	_showbtn ();
	            	$('.branchOfficeRanking').find('.dot').eq(meSlider.prevIndex).removeClass('dot_active');
	            	$('.branchOfficeRanking').find('.dot').eq(meSlider.currentIndex).addClass('dot_active');
	            },
	            ended: function () {
	            },
	            container: '.slider-container',
	            children: ".slider",
	            prevBtn: '.left-btn',
	            nextBtn: '.right-btn'
	        },
	        function () {
	            meSlider = this;
	        }
	    );
	    
	    $('.Carrier-chart').islider({
            currentIndex: 0,
            duration: 0.5,
            touch: true,
            start: function () {
            	_showbtn ();
            	$('.branchOfficeRanking').find('.dot').eq(CarrierSlider.prevIndex).removeClass('dot_active');
            	$('.branchOfficeRanking').find('.dot').eq(CarrierSlider.currentIndex).addClass('dot_active');
            },
            ended: function () {
            },
            container: '.slider-container',
            children: ".slider",
            prevBtn: '.prev-btn',
            nextBtn: '.next-btn'
        },
	        function () {
        		CarrierSlider = this;
	        }
	    );
	}

/***********获取表格详细信息**********/
	function getAnchoredTable (type,curr,_Psize) {
		 _companyName = $('.companyName').find('.layui-this').text();//公司名称
		 _carProperty = $('.carProperty').find('.layui-this').text();//车辆性质
		if(_companyName=='' || _companyName=='所有公司') _companyName = null;
		if(flag && flag == true) _companyName = null;
		_Psize = _Psize || 10;
		var getTableData = {carCompany:_companyName,PageNo:curr,PageSize:_Psize};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/CarBasicInfo/attacheCardetail.do',
		    data: getTableData
		},
		function (data) {
					if(data.resultInfo.length>1){
						var dataJson = JSON.parse(data.resultInfo);
					}else{
						var dataJson = data.resultInfo;
					}
					$('.totalNumber').html(dataJson.totalRecords);
		        page(dataJson.list,dataJson.totalPages,"#anchoredList","#showcarAnchoredList",curr,getAnchoredTable);
		        $('.carNum').each(function(i,a){
		        	$(a).hover(function(){
		        		var titleVal = $(a).find('span').html();
		        		$(this).attr('title',titleVal);
		        	})
		        })
		});
	}
	
/********************************************柱状图按钮切换********************************************/
	function btnChange (){
		$('.rankingIndex').each(function(i,a){
			if($(a).hasClass('layui-this')){
				$(a).addClass('selected-li');
			}
			$(a).on('click',function(){
					$('.rankingIndex').removeClass('selected-li');
					$(a).addClass('selected-li');
			})
		})
	}
	
	
/**********************************************初始化条形图*********************************************************/
	function initbarChartsHandler (container,XValue,dataArr){
		$(container).highcharts({
	        chart: {
	            type: 'bar'
	        },
	        title: {
	            text: ''
	        },
	        xAxis: {
	            categories: XValue,
	            title: {
	                text: null
	            }
	        },
	        yAxis: {
	            min: 0,
	            allowDecimals: false,        //控制数轴是否显示小数。
//	            max: 2500,
	            title: {
	                text: '',
	                align: 'high'
	            },
	            labels: {
	                overflow: 'justify'
	            }
	        },
	        tooltip: {
	            valueSuffix: '辆'
	        },
	        legend: {
	        	enabled : false
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
	        credits: {
	            enabled: false
	        },
	        series: [{
	            name: '数量',
	            color: '#f7a35c',
	            data: dataArr
	        }]
	    });
	}
	/******************上下滚动轮播图实现**************/
	function sliderUpandDown (){
		var swiper = new Swiper('.swiper-container', {
	        pagination: '.swiper-pagination', //分页器
	        observer:true,
	        paginationClickable: true,
//	        autoplay: 3000, //可选选项，自动滑动
	        speed:1000,//滑动速度
	        mousewheelControl:true,
	        prevButton: '.swiper-button-prev',// 箭头
	        nextButton: '.swiper-button-next',// 箭头
	        direction: 'vertical' // 滑动方向
	    });
	}
	
/**************获取条形图数据*****************/	
	function getAnchoredbarData (flag){
		var CompanydataARR = [];
		var CarydataARR = [];
		var getAllcarsNumber = $('.companyName').find('.layui-this').text();//公司名称
		if(getAllcarsNumber == '所有公司' || flag == true) getAllcarsNumber = "" ;
		var database = {carCompany:getAllcarsNumber};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/CarBasicInfo/attacheCarModel.do',
		    data: database
		},
		function (data) {
				var dataJson = JSON.parse(data.resultInfo);
				var totalCar = [];
				var carCompany = [];
				$('.barcharts-name').html(getAllcarsNumber);
				if(getAllcarsNumber == ''){
					$('.barcharts-name').html('所有');
				}
				for (var i=0;i<dataJson.length;i++){
					if(i==dataJson.length-1){
						/****当最后一个元素的时候直接添加*****/
						carCompany.push(dataJson[i].carModel);
						CompanydataARR.push(carCompany);
						totalCar.push(dataJson[i].attacheSum);
						CarydataARR.push(totalCar);
					}else{
						carCompany.push(dataJson[i].carModel);
						totalCar.push(dataJson[i].attacheSum);
						if((i+1)%10==0){
							CompanydataARR.push(carCompany);
							CarydataARR.push(totalCar);
							carCompany = [];
							totalCar = [];
						}
					}
					
				}
				/*******判断每组数据是否小于10******/
				var cardataLen = CarydataARR[CarydataARR.length-1];
				var carCompanyLen = CompanydataARR[CompanydataARR.length-1];
				if(cardataLen.length < 10){
					var dist = 10 - cardataLen.length;
					for(var k=0;k<dist;k++){
						cardataLen.push(null);
						carCompanyLen.push(' ');
					}
				}
//				$('.swiper-wrapper').html('');
				$('.swiper-wrapper div').remove();
				$.each(CompanydataARR,function(index,item){
					var $item = $("<div class='swiper-slide swiper"+index+"'></div>");
					$('.swiper-wrapper').append($item);
					initbarChartsHandler ($(".swiper"+index),item,CarydataARR[index]);
				})
				sliderUpandDown ();
		});
	}