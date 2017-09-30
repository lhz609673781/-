/**
 * Created by lhz on 2017-8-10
 * 
 * 公共部分的js逻辑实现
 */
/***********配置url************/
 // var _ipConfig =  'http://172.16.255.28:8080',
	//_configurl_ = '/kylin-web-report',
		_testurlPath_ = 'http://172.16.251.253',
	//_basicsPath_ = _ipConfig + _configurl_;  //本地
	_basicsPath_ = _testurlPath_;   //测试地址
//	_basicsPath_ = 'http://ql.ycgwl.com';//正式环境

/*********初始化图形(蜘蛛图、折线图、填充图)**********/
function initCharts(config, flag) {
	$(config.container)
			.highcharts(
					{
						chart : {
							polar : true,
							type : config.chartsType,
							style : {
								'padding' : '5px'
							},
							polar : flag,/*是否生成极地图*/
							options3d: config.options3d
						},
						title : {
							text : config.titleText, 
							useHTML : true
						},
						xAxis : {
							categories : config.xAxisValue,
							tickmarkPlacement : config.tickmarkPlacement,// 刻度线位于类别名上
							gridLineColor: config.color[0] || null,											// between在中间
							lineWidth : 0
						},
						yAxis : {
							gridLineInterpolation : 'polygon',
							gridLineColor: config.color[0] || null,
							title : {
								text : ''
							},
							alternateGridColor: config.color[1] || null
						},
						tooltip : {
							shared : true,
							useHTML : flag,
							pointFormat : config.pointformat
						},
						credits : {
							enabled : false
						},
						legend : {
							enabled : false
						},
						plotOptions : {
							line : {
								dataLabels : {
									enabled : !flag
								// 开启数据标签
								}
							// enableMouseTracking: flag //
							// 关闭鼠标跟踪，对应的提示框、点击事件会失效
							},
							series: {
					            color: 'rgba(224,85,44,1)'
					        },
							area: {
					               fillColor: 'rgba(224,85,44,0.5)',
					               dataLabels : {
										enabled : true,
										formatter: function() {return '<b style="font-size:12px;">'+this.y+'%</b>';}
									// 开启数据标签
									}
							}
						},
						series : [ {
							name : '',
							data : config.data
						} ]
					})
}
/****************************************************初始化条形图**************************************************/
function initbarChartsHandler (container,config,des){
	$(container).highcharts({
        chart: {
            type: 'bar',
        	options3d: {
                enabled: des || false,
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
//            			reallyVal = labelVal.substr(0,5)+"<br/>"+labelVal.substring(5,labelVal.length-1);
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
        credits: { /***********版权标签***************/
            enabled: false
        },
        series: [{
            name: '数量',
            color: config.color || '#f7a35c',
            data: config.dataArr
        }]
    });
}
/********************************************上下滚动轮播图实现*****************************************************/
function sliderUpandDown (des){
	var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination', //分页器
        observer:des || true,//自动初始化swiper
        paginationClickable:des || true,
//        autoplay: 3000, //可选选项，自动滑动
        speed:1000,//滑动速度
        mousewheelControl:des || true,
        prevButton: '.swiper-button-prev',// 箭头
        nextButton: '.swiper-button-next',// 箭头
        direction: 'vertical' // 滑动方向
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

/**************************************绘制轮播图**********************************/
function initSlider(container) {
    $(container).islider({
            currentIndex: 0,
            duration: 0.5,
            touch: true,
            start: function () {
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

/**************箭头hover效果****************************/
function _showbtn (){
	 $('.right-container').hover(function(){
		 $('.btn').show();
	  },function(){
		$('.btn').hide();
  	})
}
/** ****************************************************表格渲染和分页***************************************** */
function page(data, pages, tpl, cont, curr, callback,type) {// 数据 jsrender渲染容器
														// 表格tbody   type是表格是否排序，传入表头名字，没有就是null
	var $tplArray = $(tpl).render(data);
	var pageFlag = true;
	var pgSize;
	$(cont).html('');
	$(cont).html($tplArray);
	if (pageFlag) {
		layui.use([ 'layer', 'element', 'laydate', 'form', 'laypage' ],
				function() {
					layui.laypage({
						cont : 'page',
						pages : pages, // 总页数
						skip : true,
						curr : curr,
						jump : function(obj, first) {
							if (!first) {
								pgSize = $(".selectValue").find("option:selected").val();
								curr = obj.curr;
								callback(type,obj.curr,pgSize);
							}
						}
					});
				})
		$(".selectValue").unbind("change").bind("change", function() {
			pageFlag = true;
			pgSize = $(".selectValue").find("option:selected").val();
			callback(type,curr,pgSize);
		})
		pageFlag = false;
		$('.layui-laypage-btn').click(function(){
			var skipValue = $('.layui-laypage-skip').val();
			if(skipValue > pages) {
				layer.msg('超出页码范围，请重新输入！');
				$('.layui-laypage-skip').val(pages);
			}
		})
	}
}

/** *****日期插件切换****** */
function initDatehandler(flag) {
	var formated = flag ? 'YYYY-MM' : 'YYYY-MM-DD';
	layui.use(
					[ 'layer', 'element', 'laydate', 'form', 'laypage' ],
					function() {
						var layer = layui.layer, element = layui.element(), laydate = layui.laydate, form = layui
								.form(), laypage = layui.laypage;
						laydate.callBack = function() {

						};
						var start = {
							min : '2016-1',
							max : laydate.now(),
							istime : true,
							format : formated,
							choose : function(datas) {
								end.min = datas; // 开始日选好后，重置结束日的最小日期
								end.start = datas // 将结束日的初始值设定为开始日
							}
						};

						var end = {
							min : '2016-1',
							max : laydate.now(),
							istime : true,
							format : formated,
							choose : function(datas) {
								start.max = datas; // 结束日选好后，重置开始日的最大日期
							}
						};
						document.getElementById('SearchDateStart').onclick = function() {
							start.elem = this;
							laydate(start);
							if ($(".layui-form-switch").hasClass(
									"layui-form-onswitch")) {
								$("#laydate_table").css('display', 'none');
							} else {
								$("#laydate_table").css('display', 'block');
							}
						}
						document.getElementById('SearchDateStop').onclick = function() {
							end.elem = this
							laydate(end);
							if ($(".layui-form-switch").hasClass(
									"layui-form-onswitch")) {
								$("#laydate_table").css('display', 'none');
							} else {
								$("#laydate_table").css('display', 'block');
							}
						}
						form.on('switch(switchTest)', function(data) {
							if ($(".layui-form-switch").hasClass(
									"layui-form-onswitch")) {
								start.format = end.format = "YYYY-MM";
								$("#laydate_table").css('display', 'none');
								$('#SearchDateStart').attr({
									'placeholder' : '请输入开始日期'
								}).val("");
								$('#SearchDateStop').attr('placeholder',
										'请输入结束日期').val("");
							} else {
								start.format = end.format = "YYYY-MM-DD";
								$("#laydate_table").css('display', 'block');
								$('#SearchDateStart').attr({
									'placeholder' : '请输入开始日期'
								}).val("");
								$('#SearchDateStop').attr('placeholder',
										'请输入结束日期').val("");
							}
						});
					});
}

/** *********3D饼图*********** */
function charts3d(key, arr, des, color,_align,_verticalAlign,_layout) {
	var dis;
	$(key)
			.highcharts(
					{
						chart : {
							type : 'pie',
							options3d : {
								enabled : true,
								alpha : des ? 60 : 45,
								beta : 0
							}
//							marginLeft: 100
						},
						title : {
							text : ''
						},
						tooltip : {
							enabled : des,
							pointFormat : '{series.name}: <b>{point.percentage:.2f}%</b>'
						},
						colors : [ color, '#d6ad4a', '#c8c1af', '#f7a35c',
								'#6373b5', '#4c766a', '#e4d354', '#a6dff0',
								'#cda198', '#91e8e1', '#deb9db' ],
						plotOptions : {
							pie : {
								allowPointSelect : true,
								cursor : 'pointer',
								depth : des ? 65 : 35,
								dataLabels : {
									enabled : true,
									useHTML : true,
									color : '#000',
									formatter : function() {
										 return "<p style='width: 80px; display:inline-block; white-space:pre-wrap;'><b>"+
										 		this.point.name+"</b>: "+
										 		this.percentage.toFixed(2)+" %</p>"; // 重点在white-space:pre-wrap  
										 
									},
									distance : 1
								},
								showInLegend : des
							}

						},
						series : [ {
							type : 'pie',
							name : '占比',
							data : arr,
							dataLabels: {
				                /*formatter: function () {
				                    // 大于1则显示
				                    return this.y > 1 ? '<b>' + this.point.name + ':</b> ' + this.y + '%'  : null;
				                }*/
				            }
						} ],
						credits : {
							enabled : false
						},
						legend : {
							layout : _layout || 'horizontal',
							align : _align || 'center',
							verticalAlign : _verticalAlign || 'bottom',
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
						}
					});
}

/**********柱状图**************/
function initcolumnCharts(container, Arrdata, CompanyName, max_value, unit, Ytitle, des) {
	$(container)
			.highcharts(
					{
						chart : {
							type : 'column',
							options3d: {
				                enabled: des || false,
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
							max: max_value || null,
							title : {
								text : Ytitle || ''
							},
							labels: {
				                	rotation: 90
				            }
						},
						tooltip : {
							headerFormat : '<span style="font-size:10px">{point.key}</span><table style="width:auto">',
							pointFormat : '<tr><td style="padding:0"><b>&nbsp;{point.y:.0f} '+unit+'</b></td></tr>',
							footerFormat : '</table>',
							shared : true,
							useHTML : true
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
							enabled : false
						},
						series : [ {
							 color: { linearGradient: { x1: 0, y1: 0, x2: 1,y2: 0 }, //横向渐变效果 如果将x2和y2值交换将会变成纵向渐变效果 
								 		stops: [[0,Highcharts.Color('#7cb5ec').setOpacity(1).get('rgba')],
								 		        [0.5, 'rgb(255, 255, 255)'],
								 		        [1,Highcharts.Color('#7cb5ec').setOpacity(1).get('rgba')] ] },
							data : Arrdata
						} ]
					});
}

/**********格式化日期**********/
function formatDate(date,getdata){
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var hour=date.getHours();
	var minute=date.getMinutes();
    var second=date.getSeconds();
    var lastMonthday = new Date(year,month,0);
	lastMonthday = lastMonthday.getDate();//获取上月最后一天
	lastMonth = month-1;
	lastyear = year;
	lastday = day-1;
	lastYearmonth = month + 1;
	if(lastYearmonth == 13) lastYearmonth == 1;
	beforeyear = year - 1;
	if(lastMonth == 0){
		lastMonth = 12;
		lastyear = year - 1;
	}
	if(lastday == 0){
		lastday = lastMonthday;
		month = month - 1;
	}
	function changeNum (item){
		if(item<10){
			item="0"+item;
		}
		return item;
	}
	month = changeNum (month);
	day = changeNum (day);
	minute = changeNum (minute);
	second = changeNum (second);
	lastMonth = changeNum (lastMonth);
	lastMonthday = changeNum (lastMonthday);
	lastday = changeNum (lastday);
	lastYearmonth = changeNum (lastYearmonth);
	switch (getdata){
	   case '本月年月日':
		   return year+"-"+month+"-"+day;
		   break;
	   case '上月年月日':
		   return lastyear+"-"+lastMonth+"-"+day;
		   break;
	   case '上月年月':
		   return lastyear+"-"+lastMonth;
		   break;
	   case '本月年月':
		   return year+"-"+month;
		   break;
	   case '本月年月前日':
		   return year+"-"+month+"-"+lastday;
		   break;
	   case '一年年月日':
		   return beforeyear+"-"+lastYearmonth+"-"+day;
		   break;
	   case '一年年月':
		   return beforeyear+"-"+lastYearmonth;
		   break;
	}
    // return year+"/"+month+"/"+day+" "+hour+":"+minute+":"+second;
//	return year+"-"+month;
}

/**********格式化默认时间***********/ 
function formatsearchTime (_beginTime,_endTime,defaultstartTime,defaultstopTime){
	var defaultstart = defaultstartTime || '上月年月日',
		defaultstop = defaultstopTime || '本月年月前日'
	var beginTime = _beginTime.val();
	var endTime = _endTime.val();
	if( beginTime=='' || beginTime==null ){
		beginTime = formatDate(new Date(),defaultstart);
		_beginTime.attr('placeholder',beginTime);
	};
	if( endTime=='' || endTime==null ){
		endTime = formatDate(new Date(),defaultstop);
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

/*********计算日期天数********/
function dateInterval(beginTime,endTime) {
	//换算成毫秒
    var minutes = 1000 * 60
    var hours = minutes * 60
    var days = hours * 24
    
    var date1 = beginTime.replace('-',',');
    var date2 = endTime.replace('-',',');
    
    var day1 = Date.parse(date1);
    var day2 = Date.parse(date2);
    d = day2 - day1;
    d = d / days;
    
    return d;
  }

/*********slider***********/
!function($) {
	"use strict";

	if ($ === undefined) {
		throw "need jQuery or Zepto";
		return;
	}

	if (!Array.prototype.indexOf) {
		Array.prototype.indexOf = function(obj) {
			for (var i = 0, il = this.length; i < il; i++) {
				if (this[i] == obj) {
					return i;
				}
			}
		};
	}

	var ISlider = function(element, options) {
		this.$e = $(element);
		this.options = options;
		this.currentIndex = this.options.currentIndex;
		this._prevIndex = this.currentIndex;
		this._initDom();
	};

	ISlider.prototype = {
		constructor : ISlider,
		_initDom : function() {
			if ([ "relative", "absolute" ].indexOf(this.$e.css("position")) === -1) {
				this.$e.css("position", this.options.defaultPosition);
			}
			this.container = this.$e.find(this.options.container);
			if (this.container.length !== 1) {
				throw new Error(
						"iSlider should have only one/at least one container!")
			}

			this.container.css({
				listStyle : "none",
				width : "100%",
				height : "100%",
				top : 0,
				position : 'absolute',
				margin : 0,
				padding : 0
			});

			this._items = this.container.children('.slider');
			this._items.each(function(i) {
				var $this = $(this);
				$this.data("index", i);
				$this.css({
					width : "100%",
					height : "100%",
					paddingTop : '16px',
					overflow : "hidden",
					position : 'absolute'
				});
			});
			this._itemLen = this._items.length;
			this._width = this.$e.width();
			this._height = this.$e.height();

			if (this._itemLen <= 1) {
				return;
			}
			this._sortItem();
			this._initEvent();
		},
		_initEvent : function() {
			var sliderInst = this, scope = this;

			if (this.options.prevBtn) {
				if (this.options.prevBtn === $.fn.islider.defaults.prevBtn) {
					this._pb = $(this.options.prevBtn);

				}
				this._pb.on("click", function() {
					// tl3.pause();
					sliderInst.prev();
					return false;
				});
			}

			if (this.options.nextBtn) {
				if (this.options.nextBtn === $.fn.islider.defaults.nextBtn) {
					this._nb = $(this.options.nextBtn);
				}
				this._nb.on("click", function() {
					// tl3.pause();
					sliderInst.next();
					return false;

				});
			}
			if (this.options.indicators) {
				if (this.options.indicators === $.fn.islider.defaults.indicators) {
					this._ins = this.$e.children(this.options.indicators);
				} else {
					this._ins = $(this.options.indicators);
				}
				this._indItems = this._ins.on("click touchstart seek", "li",
						function(e) {
							if (scope.animating)
								return;
							var $this = $(this);
							if (e) {
								sliderInst.seekTo($this.data("index"));	
							}
							scope._ins.find(".active").removeClass('active');
							$this.addClass('active');
							return false;
						}).children("li").each(function(i) {
					$(this).data("index", i);
				});
				this._indItems.eq(this.currentIndex).trigger('click');
			}
			var hasTouch = ("ontouchstart" in window);
			if (this._itemLen > 2 && hasTouch && this.options.touch) {
				$('.main-container').on("touchstart", function(e) {
					scope._touchStart(e.originalEvent ? e.originalEvent : e);
				});
			}
		},
		_sortItem : function() {
			var _startIndex = this.currentIndex;
			var css = {};

			for (var i = 0, il = this._itemLen; i < il; i++) {
				if (i !== this._itemLen - 1) {
					this._items.eq(_startIndex % this._itemLen).css({
						left : i * 100 + "%"
					});
				} else {
					this._items.eq(_startIndex % this._itemLen).css({
						left : -100 + "%"
					});
				}
				_startIndex++;
			}
			this.container.css("left", 0);
		},
		_normalSort : function(index) {
			var css = {};
			for (var i = 0, il = this._itemLen; i < il; i++) {
				this._items.eq(i).css({
					left : i * 100 + "%"
				});
			}

			css["left"] = (-index * this.$e.width()) + "px";
			this.container.css(css);
		},
		_touchStart : function(e) {
			this.startX = e.touches[0].pageX;
			this.startY = e.touches[0].pageY;
			$('.main-container').on("touchmove", onTouchMove);
			$('.main-container').on("touchend", onTouchEnd);
			this.cp = 0;
			var isScroll = true, liW = this.container.width(), boundW = this.options.bound ? liW * 0.25
					: 0, lastDistanse, scope = this;
			function onTouchMove(e) {
				var touch = e.originalEvent ? e.originalEvent.touches[0]
						: e.touches[0];
				if (isScroll && Math.abs(touch.pageY - scope.startY) > 5) {
					onTouchEnd();
					return true;
				}
				if (scope.animating) {
					return;
				}
				// clearInterval(timeId);
				isScroll = false;
				lastDistanse = touch.pageX - scope.startX;
				scope.cp += lastDistanse;
				scope.container.css("left", scope.cp / liW * 100 + "%");
				scope.startX = touch.pageX;
				scope.startY = touch.pageY;
				return false;
			}

			function onTouchEnd(e) {
				$('.main-container').off("touchmove", onTouchMove);
				$('.main-container').off("touchend", onTouchEnd);
				if (scope.cp === 0) {
					return;
				}
				if (e) {
					var i = Math.abs(scope.cp / liW);
					i = i > .25 ? .25 : i;
					i = i < .1 ? .1 : i;
					var index = -scope.cp / liW;// (liW +
												// scope.options.itemMargin);
					if (Math.abs(index) > .15) {
						index += .5 * (index > 0 ? 1 : -1);
						if (index > 0) {
							scope.next(i);
						} else {
							scope.prev(i);
						}
					} else {
						$.fn.islider.animate.apply(scope, [ 0, .1,
								scope.options.easing ]);
					}
				}
			}
		},
		start : function() {
			if (typeof this.options.start == "function") {
				this.options.start.call(this, this.currentIndex,
						this.prevIndex, this.direction);
			}
			if (this._indItems && this._indItems.eq(this.currentIndex)) {
				this._indItems.eq(this.currentIndex).trigger('seek');
			}
			this.animating = true;
		},
		end : function() {
			this._sortItem();
			this.animating = false;
			if (typeof this.options.ended == "function") {
				this.options.ended.call(this, this.currentIndex,
						this.prevIndex, this.direction);
			}
		},
		prev : function(t, easing) {
			if (this._itemLen < 2) {
				return;
			}
			var index = this.currentIndex - 1;
			if (index < 0) {
				index = index + this._itemLen;
			}
			this.seekTo(index, t, easing, "prev");
		},
		next : function(t, easing) {
			if (this._itemLen < 2) {
				return;
			}
			if (this._itemLen === 2) {
				this._items.eq(1 - this.currentIndex).css("left", "100%");
			}
			var index = this.currentIndex + 1;
			if (index > this._itemLen - 1) {
				index = this._itemLen - index;
			}
			this.seekTo(index, t, easing, "next");
		},
		seekTo : function(index, t, easing, direction) {
			if (this.animating || index === this.currentIndex || index < 0
					|| index > this._itemLen - 1) {
				return;
			}
			this.prevIndex = this.currentIndex;
			var _seek;
			if (direction) {
				if (direction == "prev") {
					_seek = 1;
				} else if (direction == "next") {
					_seek = -1;
				}
				this.direction = direction;
			} else {
				this._normalSort(this.currentIndex);
				_seek = -index;
				if (index > this.prevIndex) {
					this.direction = "next";
				} else {
					this.direction = "prev";
				}
			}

			this.currentIndex = index;
			this.start();
			$.fn.islider.animate.apply(this, [ _seek * this.container.width(),
					t != undefined ? t : this.options.duration,
					easing ? easing : this.options.easing ]);
		}
	};

	/*
	 * ISLIDER PLUGIN DEFINITION ==========================
	 */
	var old = $.fn.islider;

	$.fn.islider = function(option, completeCb) {
		return this.each(function() {
			var $this = $(this), options = $.extend({}, $.fn.islider.defaults,
					typeof option == 'object' && option);
			if (!$this._isliderInst) {
				$this._isliderInst = new ISlider(this, options);
				if (typeof completeCb === "function") {
					completeCb.call($this._isliderInst);
				}
			}
		});
	};

	$.fn.islider.Constructor = ISlider;

	$.fn.islider.defaults = {
		currentIndex : 0,
		duration : .6,
		easing : "swing",
		touch : true,
		defaultPosition : "relative",
		start : undefined,
		ended : undefined,
		container : ".islider-container",
		indicators : ".islider-indicators",
		prevBtn : ".prev-btn",
		nextBtn : ".next-btn"
	};

	$.fn.islider.animate = function(leftValue, t, easing) {
		var scope = this, timeId, duration = (t != undefined ? t
				: this.options.duration) * 1000;

		if (duration == 0) {
			this.container.css("left", leftValue);
			scope.end();
		} else {
			this.container.animate({
				left : leftValue
			}, duration, easing != undefined ? easing : this.options.easing,
					function() {
						if (timeId > 0) {
							clearTimeout(timeId);
							scope.end();
						}
					});
			// fixed when element been hide, the end event will not fill in
			// zepto.js
			timeId = setTimeout(function() {
				timeId = -1;
				scope.end();
			}, duration + 1000);
		}
	};
	/*
	 * ISLIDER NO CONFLICT ====================
	 */
	$.fn.islider.noConflict = function() {
		$.fn.islider = old;
		return this;
	};

	if (typeof window.define === 'function' && window.define.amd) {
		window.define('iSlider', [], function() {
		});
	}
}(window.jQuery || window.Zepto);