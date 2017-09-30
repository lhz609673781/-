/**
 * created By lhz on 2017-8-14
 */


$(function(){
/*******定义全局变量*********/
	var pagecurr = null;
	var Psize = null;
	var renderer;
	var companySelect = null;
	var selfNumber = 0,AnchoredNum = 0;/*****集团下所有分公司挂靠和自营*****/
	
	drayLine ();
	getcarInformation ();
/********************************************绘制路径**************************************************************/
function drayLine () {
	renderer = new Highcharts.Renderer(
		    $('.groupControlCar')[0],350,300
		);
		renderer.path(['M', 81, 176, 'L', 152, 94])
		    .attr({
		    'stroke-width': 1,
		    stroke: '#c2c2c2'
		})
		    .add();

		renderer.path(['M', 270, 172, 'L', 210, 94])
			.attr({
			'stroke-width': 1,
			stroke: '#c2c2c2'
		})
			.add();
}


/******************************************获取页面所有车辆信息******************************************************/

/********获取自营时触发的函数******/
function getOwnInfo(){
	$('.right-container,.pie-draw,.Table-rendering').show();
	$('.Anchored-menu,.Anchored-container,.AnchoredTable-rendering').hide();
	companySelect = $('.companyName').find('.layui-this').text();
	if(!flag){
		$('.selectValue').val('10');
		getAllCompany ();/*****得到自营车辆下的所有公司******/
		getAllcarNumber (flag);/******获取详细信息****/
		flag = true;
	}else{
		getAllcarNumber (!flag);/******获取详细信息****/
	}
	getTableInformation (null,1);/******自营表格详细*******/
	getPieData ();/*****得到饼图信息********/
	getbarData ();/*****获取条形图信息******/
}
/********获取挂靠时触发的函数*******/
function getAnchoredInfo (){
	getAllcarNumber (flag);/******获取详细信息****/
	getAnchoredbarData (flag);
	getAnchoredTable (null,1,10);/******列表******/
	if(flag){
		$('.selectValue').val('10');
		getAnchoedAllCompany ();/****获取挂靠下的所有公司******/
		getAnchoedcarsNumber ();/*****获取各分公司下的挂靠车辆排名******/
		btnChange ()  /******柱状图按钮切换*******/
		flag = false;
	}
	$('.right-container,.pie-draw,.Table-rendering').hide();
	$('.Anchored-menu,.Anchored-container,.AnchoredTable-rendering').show();
}
function getcarInformation () {
	getAllCompany ();
	getAllcarNumber (flag);
	getTableInformation (null,1);
	initcolumn ();
	getPieData (); /****获取车辆占比数据****/
	getbarData ();/*******条形图********/
	/******查询条件点击！！！！！！！*******/
	/*$('#ownCarInfo').on('click',function(){
		getOwnInfo();
	});*/
	$('#carInformationSearchBtn').on('click',function(){ 
		var  _carProperty = $('.carProperty').find('.layui-this').text();//车辆性质
			if(_carProperty=='挂靠车辆'){
				_carProperty='挂靠';
				$('.groupControlCar').addClass('AnchoredControlCar');
				getAnchoredInfo ();/******获取挂靠信息*****/
			}else{
				$('.groupControlCar').removeClass('AnchoredControlCar');
				getOwnInfo(); /*****获取自营信息*******/
			}
	})
}

/*************************************************获取下拉框里所有的公司***********************************************/
function getAllCompany (){
	EasyAjax.ajax_Post_Json({
	    url: _basicsPath_ + '/CarBasicInfo/findAllCompany.do',
	    data: ''
	},
	function (data) {
		layui.use(['layer','element','form'], function(){
			layer = layui.layer,
		    element = layui.element(),
			form = layui.form();
			var dataJson = JSON.parse(data.resultInfo);
			var $options = $('<option value="">所有公司</option><option >所有公司</option>');
			$('.select-company').html($options);
			$.each(dataJson,function(index,ele){
				var _CompanyName = ele.carCompany;
				$('.select-company').append('<option>'+_CompanyName+'</option>');
				form.render();
			})
			if(companySelect){
				$('.companyName input').attr('placeholder',companySelect);
			}
		});
	});
}



/************************************************获取汇总信息*******************************************************/
function getAllcarNumber (flag) {
	var getAllcarsNumber = $('.companyName').find('.layui-this').text();//公司名称
	var database = {carCompany:getAllcarsNumber};
	if(getAllcarsNumber=='所有公司' || getAllcarsNumber=='' || flag == true) {
		getgroupcarsNum ();
	}else{
		getBranchOfficecarsNum ();
	};
	/*********获取分公司可控车辆数********/
	function getBranchOfficecarsNum (){
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/CarBasicInfo/totalCarType.do',
		    data: database
		},
		function (data) {
					var dataJson = JSON.parse(data.resultInfo);
					$('#controlledCar-number').html(dataJson.totalCar);
					$('#Anchored-car-number').html(dataJson.attached);
					$('#Self-support-number').html(dataJson.own);
		});
	}
	
	/********获取集团可控车辆数********/
	function getgroupcarsNum (){
		EasyAjax.ajax_Post_Json({ /****自营车辆接口*****/
		    url: _basicsPath_ + '/CarBasicInfo/showOwnCarCount.do',
		    data: ''
		},
		function (data) {
					var dataJson = JSON.parse(data.resultInfo);
					selfNumber = dataJson.totalCar;
					$('#Self-support-number').html(dataJson.totalCar);
					
					EasyAjax.ajax_Post_Json({ /****挂靠车辆接口*****/
					    url: _basicsPath_ + '/CarBasicInfo/showAttacheCarCount.do',
					    data: ''
					},
					function (data) {
								var dataJson = JSON.parse(data.resultInfo);
								AnchoredNum = dataJson.attacheSum;
								$('#Anchored-car-number').html(dataJson.attacheSum);
								$('#controlledCar-number').html(selfNumber + AnchoredNum);
					});
		});
	}
}
/*******绘制轮播图********/
function initSlider() {
    $('.chartsSlider').islider({
            currentIndex: 0,
            duration: 0.5,
            touch: true,
            start: function () {
            	_showbtn ();
            	$('.right-container').find('.dot').eq(mySlider.prevIndex).removeClass('dot_active');
            	$('.right-container').find('.dot').eq(mySlider.currentIndex).addClass('dot_active');
            },
            ended: function () {
            },
            container: '.slider-container',
            children: ".slider",
            prevBtn: '.prev-btn',
            nextBtn: '.next-btn'
        },
        function () {
            mySlider = this;
        }
    );
}

/***********************************************初始化柱状图********************************************************/
function initcolumn (){
	getcompanycarsNumber ();
	$('.right-container,.branchOfficeRanking').hover(function(){
		if($(this).find('.slider').length>1){
			 $(this).find('.btn').show();
		}
	  },function(){
		 $(this).find('.btn').hide();
	})
}
/************获取柱状图信息*************/
function getcompanycarsNumber (){
	var dataJson;
	var CompanydataARR = [];
	var CarydataARR = [];
	EasyAjax.ajax_Post_Json({
	    url: _basicsPath_ + '/CarBasicInfo/carGroupByComCount.do',
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
						totalCar.push(dataJson[i].totalCar);
						CarydataARR.push(totalCar);
					}else{
						carCompany.push(dataJson[i].carCompany);
						totalCar.push(dataJson[i].totalCar);
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
					$('.right-container').find('.slider-container').append($item);
					$('.right-container').find('#dot-container').append($dot);
					initcolumnCharts(".right-container .slider"+index,CarydataARR[index],item,500,'辆','       ');
				})	
				initSlider();
				$('.right-container').find('.dot').eq(0).addClass('dot_active');
				$('.right-container').find(".dot").each(function(_index,_item){
					$(_item).on('click',function(){
						if(_index == mySlider.currentIndex) return false;
						mySlider.seekTo(_index);
					})
				})
	});
		
}
/**********************************************初始化条形图*********************************************************/

/**************获取条形图数据*****************/	
	function getbarData (){
		var CompanydataARR = [];
		var CarydataARR = [];
		var getAllcarsNumber = $('.companyName').find('.layui-this').text();//公司名称
		if(getAllcarsNumber == '所有公司') getAllcarsNumber = "" ;
		var database = {carCompany:getAllcarsNumber};
		EasyAjax.ajax_Post_Json({
		    url: _basicsPath_ + '/CarBasicInfo/ownCarModel.do',
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
						totalCar.push(dataJson[i].totalCar);
						CarydataARR.push(totalCar);
					}else{
						carCompany.push(dataJson[i].carModel);
						totalCar.push(dataJson[i].totalCar);
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
/*********************************************获取饼图数据********************************************************/	
function getPieData (){
	var getAllcarsNumber = $('.companyName').find('.layui-this').text();//公司名称
	if(getAllcarsNumber == '所有公司') getAllcarsNumber = "" ;
	var database = {carCompany:getAllcarsNumber};
	EasyAjax.ajax_Post_Json({
	    url: _basicsPath_ + '/CarBasicInfo/carBrandShare.do',
	    data: database
	},
	function (data) {
			var dataJson = JSON.parse(data.resultInfo);
			var carproportion  = [];
			var brandShare = 0;
			console.log(dataJson);
			$.each(dataJson,function(index,ele){
				if(ele.brandShare<= 0.02){
					brandShare += ele.brandShare;
					brandShare = Number(brandShare.toFixed(4)); 
					console.log(ele.brandShare+'===='+brandShare);
				}else{
					carproportion.push({
						name: ele.carBrand,
						y: ele.brandShare-0.0001,
						sliced: true,
	                    selected: true
					})
				}
			})
			$('#branchOfficeName span').html(getAllcarsNumber);
			if(getAllcarsNumber == '所有公司' || getAllcarsNumber == ''){
				$('#branchOfficeName span').html('所有');
			}
			carproportion.push({
				name: '其他',
				y: brandShare,
				sliced: true,
                selected: true
			})
			console.log(brandShare);
			console.log(carproportion);
			charts3d("#pie-container",carproportion,true,'#7cb5ec','right','top', "vertical");
	});
}
	
/************************************获取表格详细信息*************************************************************/
function getTableInformation (type,curr,_Psize) {
	 _companyName = $('.companyName').find('.layui-this').text();//公司名称
	 _carProperty = $('.carProperty').find('.layui-this').text();//车辆性质
	if(_companyName=='所有公司') _companyName='';
	if(_carProperty=='所有车辆'){
		_carProperty=''
	}else if(_carProperty=='自有车辆'){
		_carProperty='自有';
	}else if(_carProperty=='挂靠车辆'){
		_carProperty='挂靠';
	};
	_Psize = _Psize || 10;
	pagecurr = curr;
	Psize = _Psize;
	var getTableData = {carCompany:_companyName,carType:_carProperty,PageNo:curr,PageSize:_Psize}
	EasyAjax.ajax_Post_Json({
	    url: _basicsPath_ + '/CarBasicInfo/Cardetail.do',
	    data: getTableData
	},
	function (data) {
				if(data.resultInfo.length>1){
					var dataJson = JSON.parse(data.resultInfo);
				}else{
					var dataJson = data.resultInfo;
				}
				$('.totalNumber').html(dataJson.totalRecords);
	        page(dataJson.list,dataJson.totalPages,"#SearchTpl","#showcarInformationList",curr,getTableInformation);
	        
	});
}
/********表格按字段名排序********/
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
			var _basicConfig ;
			if(_orderBy == 'board_Date'){
				_basicConfig = {carCompany:_companyName,carType:_carProperty,orderByDate:_orderBy,PageNo:_pageNo,PageSize:_pageSize}
			}else{
				_basicConfig = {carCompany:_companyName,carType:_carProperty,orderBy:_orderBy,PageNo:_pageNo,PageSize:_pageSize}
			}
			
			EasyAjax.ajax_Post_Json({
			    url:  _basicsPath_  + '/CarBasicInfo/CardetailOr.do',
			    data: _basicConfig
			},
			function (data) {
				var dataJson = JSON.parse(data.resultInfo);
						$('.totalNumber').html(dataJson.totalRecords);
						page(dataJson.list,dataJson.totalPages,"#SearchTpl","#showcarInformationList",pageNo,fieldOrderHandler,_orderBy);
			});
}

});

/************左右按钮显示****************/
function _showbtn (){
//	 if(mySlider.currentIndex == mySlider._itemLen-1){
		 $('.right-container').hover(function(){
			 $('.btn').show();
//			 mySlider._nb.hide();
		  },function(){
			$('.btn').hide();
		})
//			 mySlider._pb.show();
//			 mySlider._nb.hide();
//	}else if(mySlider.currentIndex == 0){
//		$('.right-container').hover(function(){
//			 $('.btn').show();
//			 mySlider._pb.hide();
//		  },function(){
//			$('.btn').hide();
//		})
//			mySlider._nb.show();
//			 mySlider._pb.hide();
//	}else{
//		$('.btn').show();
//		$('.right-container').hover(function(){
//			 $('.btn').show();
//		  },function(){
//			$('.btn').hide();
//		})
//	}
}

//数据导出
$(function(){
	
	$("#carBasic_excelImpl").click(function(){
		
		var  carCompany =$('.companyName').find('.layui-this').text();

		carCompany=encodeURI(encodeURI(carCompany));
		

		carCompany=encodeURI(carCompany,"UTF-8");

		 var  carType = $('.carProperty').find('.layui-this').text();
		 carType=encodeURI(encodeURI(carType));
		
	
	    window.location.href = basePath+'CarBasicInfo/CardetailExcelImpl.do?carCompany='+carCompany+'&carType='+carType;
	});	
	
});















