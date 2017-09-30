//DOM渲染完成
$(function () {
            var flag = true;
            //初始化客户查询
            initSearch(1,1);
            //初始化饼图信息
            initPieInfo (flag);
            //搜索客户查询
            $("#clientSearchSearchBtn").on("click",function () {
            	var $SearchDateStart = $('#SearchDateStart').val();
                var $SearchDateStop = $('#SearchDateStop').val();
    			var timeInterval = dateInterval($SearchDateStart,$SearchDateStop);
    			if(timeInterval>356){
    				layer.msg('查询时间间隔不超过一年');
    				return false;
    			}
               initSearch(1,1);
               initPieInfo(flag);
            });
});
//customer_excel_impl
//String beginTime, String endTime, Integer searchType, Integer coordinate

//数据导出
$(function(){
	
	$("#customer_excel_impl").click(function(){
		
		var beginTime =$("#SearchDateStart").val() ? $("#SearchDateStart").val() : $("#SearchDateStart").attr('placeholder');//开始时间
		var endTime = $("#SearchDateStop").val() ? $("#SearchDateStop").val() : $("#SearchDateStop").attr('placeholder');//结束时间
		
		var searchType=$("#customer_findtype").val();//查询条件
	    window.location.href = basePath+'acceptClaimsReport/searchClaimsCustomer.do?beginTime='+beginTime+'&endTime='+endTime+'&searchType='+searchType+'&coordinate='+1;
	});	
	
});