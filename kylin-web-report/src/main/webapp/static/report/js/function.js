//前台分页
var pageFlag = true;


//var urlPath = 'http://172.16.250.28:8090/kylin-web-report';

var urlPath = 'http://172.16.251.253';
//var urlPath = 'http://ql.ycgwl.com';

function page(data,pages,tpl,cont,curr,coordinateValue,selectValue) {//数据 jsrender渲染容器 表格tbody
			var $tplArray = $(tpl).render(data);
			$(cont).html($tplArray);
			if(pageFlag){
				layui.use(['layer','element','laydate','form','laypage'], function(){
					layui.laypage({
		        	    cont: 'page'
		        	    ,pages: pages //总页数
		        	    ,skip: true
		        	    ,curr: curr
		        		,jump: function (obj, first) {
		            		if(!first){
		            			curr = obj.curr;
		            			initSearch(coordinateValue,obj.curr);
		            		}
		        		}
		        	});
				})
				$(".selectValue").unbind("change").bind("change",function(){
	    			pageFlag = true;
	    			initSearch(coordinateValue,curr);
	    		})
				pageFlag = false;
			}	
}

//格式化日期
function formatDate(date){
	var year=date.getFullYear();
	var month=date.getMonth();
	var day=date.getDate();
	var hour=date.getHours();
	var minute=date.getMinutes();
    var lastMonthday = new Date(year,month+1,0);
    	lastMonthday = lastMonthday.getDate();//获取上月最后一天
	if(minute<10){
		minute="0"+minute;
	}
	var second=date.getSeconds();
	if(month<10){
		month="0"+month;
	}
    // return year+"/"+month+"/"+day+" "+hour+":"+minute+":"+second;
	return year+"-"+month;
}

//计算日期天数
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
//3D饼图
function charts3d(key,arr,des,color){
	var dis;
    $(key).highcharts({
                chart: {
                    type: 'pie',
                    options3d: {
                        enabled: true,
                        alpha: des ? 60 : 45,
                        beta: 0
                    }
                },
                title: {
                    text: ''
                },
                tooltip: {
                    enabled: des,
                    pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
                },
                colors:[color, '#d6ad4a', '#c8c1af', '#f7a35c', '#6373b5', 
                        '#4c766a', '#e4d354', '#a6dff0', '#cda198', '#91e8e1','#deb9db'],
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        depth: des ? 60 : 35,
                        dataLabels: {
                            enabled: des,
                            useHTML: true,
                            color:'#fff',
                            // format: '{point.name} {point.percentage} %'，
                            formatter: function(){
//                                return "<b>"+this.point.name+"</b>: "+this.point.percentage.toFixed(2)+" %";
                                return this.point.percentage.y > 1 ? "<p style='width: 46px; display:inline-block; white-space:pre-wrap;'><b>"
                                		+this.point.name+"</b>: "+this.point.percentage.toFixed(2)+" %</p>" : null;
                            },
                            distance:-20,
                            x:20,
                            y:10
                            
                        },
                		showInLegend: des
                    }
                	
                },
                series: [{
                    type: 'pie',
                    name: '占比',
                    data: arr
                }],
                credits:{
                     enabled:false
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'top',
                    maxHeight:300,
                    navigation: {
                        activeColor: '#3E576F',
                        animation: true,
                        arrowSize: 12,
                        inactiveColor: '#CCC',
                        style: {
                            fontWeight: 'bold',
                            color: '#333',
                            fontSize: '12px'
                        }
                    }
                }
            });
}

//改变描述值
function changedata(resdata,ifadd,value){
          if(resdata<0){
            ifadd.html('减少');value.html(resdata.substring(1));
          }else{
            ifadd.html('增加');value.html(resdata);
          }   
}

//绘制3D饼图
function drawPies(flag){
      charts3d("#charts-item1-pic",[["上季度赔付平均值",100]],false,'#7cb5ec');
      charts3d("#charts-item2-pic",[["同期赔付增减",100]],false,'#faca1b');
      charts3d("#charts-item3-pic",[["环比赔付增减",100]],false,'#6373b5');
      charts3d("#charts-item5-pic",[["上季度赔付平均值",100]],false,'#a6dff0');
      if(flag){
           EasyAjax.ajax_Post_Json({
                       url: urlPath + '/acceptClaimsReport/guestTypeGroupBy.do',
                       data: baseValue
           },
           function (data) {
                      var resdata = JSON.parse(data.resultInfo),
                          totalPay = 0;
                          dataArr = [];
                          
                          for(var i in resdata){
                              totalPay += resdata[i].payAmount;
                          }
                          for(var i in resdata){
                        		  dataArr.push({
                        			  'name':resdata[i].guestType,
                        			  'y':resdata[i].payAmount/totalPay,
                        			  'sliced': true,
                                      'selected': true
                        		  })
                          }
                      charts3d("#charts-item4-pic",dataArr,true,'#7cb5ec');
           });
          
      }
      
}


//客户查询全局对象
var $SearchDateStart = $("#SearchDateStart"),
    $SearchDateStop = $("#SearchDateStop"),
    $searchType = $("#searchType"),
    $totalNumber = $('.totalNumber'),
    baseValue,
    $chartsitem1value = $('#charts-item1-value'),
    $chartsitem2value = $('#charts-item2-value'),
    $chartsitem5value = $('#charts-item5-value'),
    $chartsitem3value = $('#charts-item3-value');

//初始化客户查询
function initSearch(coordinateValue,curr) {
             var SearchDateStart = $SearchDateStart.val(),
             	 layValue = $searchType.find('.layui-this').attr('lay-value'),
             	 selectValue = $(".selectValue").val() ? $(".selectValue").val() : 10;
                 SearchDateStop = $SearchDateStop.val();
                 SearchType = layValue ? layValue : $searchType.find("option:selected").val();
                 if((SearchDateStart == null || SearchDateStart == '')||(SearchDateStop == null || SearchDateStop == '')){
                      var initDate = new Date(); 
                      if(SearchDateStart == null || SearchDateStart == ''){
                    	  SearchDateStart = formatDate(initDate);
                      }
                      if(SearchDateStop == null || SearchDateStop == '') SearchDateStop = formatDate(initDate);
                      $SearchDateStart.attr('placeholder',SearchDateStart)
                      $SearchDateStop.attr('placeholder',SearchDateStart)
                 }
                 baseValue = {beginTime:SearchDateStart,endTime:SearchDateStop,searchType:SearchType,PageNo:curr,PageSize:selectValue,coordinate:coordinateValue};

           EasyAjax.ajax_Post_Json({
                       url: urlPath + '/acceptClaimsReport/searchClaims.do',
                       data: baseValue
           },
           function (data) {
        	   			var dataJson = JSON.parse(data.resultInfo);
        	   	
//        	   			$('#Supplier_amount').html(dataJson.obj.carrierPay);
//        	   			$('#Insurance_amount').html(dataJson.obj.insurancePay);
//        	   			$('#Retention_amount').html(dataJson.obj.companyPay);
//        	   			
//        	   			var Supplier_amount = Number($('#Supplier_amount').html());
//        	   			var Insurance_amount = Number($('#Insurance_amount').html());
//        	   			var Retention_amount = Number($('#Retention_amount').html());
//        	   				totalSum = Number(Supplier_amount + Insurance_amount + Retention_amount);
//        	   			var Supplier_percent =(parseInt( Supplier_amount / totalSum ) * 100).toFixed(2) ;
//        	   				$('#Supplier_percent').html(Supplier_percent);
//        	   			var	Insurance_percent =(parseInt( Insurance_amount / totalSum ) * 100).toFixed(2) ;
//        	   				$('#Insurance_percent').html(Insurance_percent);
//        	   			var	Retention_percent =(parseInt( Retention_amount / totalSum ) * 100).toFixed(2) ;
//        	   				$('#Retention_percent').html(Retention_percent);
        	   			
        	   			
        	   			$.each(dataJson.list,function(index,ele){
        	   				ele.carrierPayPercent = ((ele.carrierPay/(ele.companyPay+ele.insurancePay+ele.carrierPay))*100).toFixed(2)+"%";
        	   				ele.companyPayPercent = ((ele.companyPay/(ele.companyPay+ele.insurancePay+ele.carrierPay))*100).toFixed(2)+"%";
        	   				ele.insurancePayPercent = ((ele.insurancePay/(ele.companyPay+ele.insurancePay+ele.carrierPay))*100).toFixed(2)+"%";
        	   				ele.firstMonthLastSeason = (ele.firstMonthLastSeason/10000).toFixed(2);
        	   				ele.secondMonthLastSeason = (ele.secondMonthLastSeason/10000).toFixed(2);
        	   				ele.thirdMonthLastSeason = (ele.thirdMonthLastSeason/10000).toFixed(2);
        	   				ele.ringPayment = ((ele.ringPayment)*100).toFixed(2)+"%";
        	   				ele.contemporaneousPayment = ((ele.contemporaneousPayment)*100).toFixed(2)+"%";
        	   				ele.averageLastSeason = (ele.averageLastSeason/10000).toFixed(2);
        	   				ele.payAmount = (ele.payAmount/10000).toFixed(2);
        	   			})
        	   		   $totalNumber.html(dataJson.totalRecords);
                       page(dataJson.list,dataJson.totalPages,"#SearchTpl","#showSearchList",curr,coordinateValue,selectValue);
           });
}

//初始化饼图信息
function initPieInfo (flag) {
           EasyAjax.ajax_Post_Json({
                       url: urlPath + '/acceptClaimsReport/gatherAccept.do',
                       data: baseValue
           },
           function (data) {
                      var resdata = JSON.parse(data.resultInfo);
                      $('#Supplier_amount').html((resdata.carrierPay / 10000).toFixed(2));
      	   			  $('#Insurance_amount').html((resdata.insurancePay / 10000).toFixed(2));
      	   			  $('#Retention_amount').html((resdata.companyPay / 10000).toFixed(2));
      	   			
      	   			  var Supplier_amount = Number($('#Supplier_amount').html());
      	   			  var Insurance_amount = Number($('#Insurance_amount').html());
      	   			  var Retention_amount = Number($('#Retention_amount').html());
      	   			  var totalSum = Number(Supplier_amount + Insurance_amount + Retention_amount);
      	   				 
      	   			  var Supplier_percent =(parseFloat( Supplier_amount / totalSum ) * 100).toFixed(2) ;
      	   				$('#Supplier_percent').html(Supplier_percent);
      	   			  var Insurance_percent =(parseFloat( Insurance_amount / totalSum ) * 100).toFixed(2) ;
      	   				$('#Insurance_percent').html(Insurance_percent);
      	   			  var	Retention_percent =(parseFloat( Retention_amount / totalSum ) * 100).toFixed(2) ;
      	   				$('#Retention_percent').html(Retention_percent);
                      
                      var averageValue = (resdata.averageLastSeason/10000).toFixed(2)
                      $chartsitem1value.html(averageValue+'万元');
                      $chartsitem2value.html((resdata.contemporaneousPayment*100).toFixed(2)+'%');
                      $chartsitem3value.html((resdata.ringPayment*100).toFixed(2)+'%');
                      $chartsitem5value.html((resdata.payAmount/10000).toFixed(2)+"万元");
                      $('#desAverage').html(averageValue);
                      $('#payAmout').html((resdata.payAmount/10000).toFixed(2));
                      
                      changedata((resdata.contemporaneousPayment*100).toFixed(2),$('.SamePay'),$('#desSameCompensation'));
                      changedata((resdata.ringPayment*100).toFixed(2),$('.ringPay'),$('#desSurroundCompensation'));
                      
                      drawPies(flag);
           });
}