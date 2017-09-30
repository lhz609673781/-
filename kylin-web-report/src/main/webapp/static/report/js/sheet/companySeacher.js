//DOM渲染完成
$(function () {
            flag = false;
            //初始化公司查询
            initSearch(0,1);
            initPieInfo (flag);
            //搜索公司查询
            $("#companySearchSearchBtn").on("click",function () {
                      initSearch(0,1);
                      initPieInfo(flag) ;
            });
            
            
});
//数据导出
$(function(){
	
	$("#company_excel_impl").click(function(){
		
		var beginTime =$("#SearchDateStart").val() ? $("#SearchDateStart").val() : $("#SearchDateStart").attr('placeholder');//开始时间
		var endTime = $("#SearchDateStop").val() ? $("#SearchDateStop").val() : $("#SearchDateStop").attr('placeholder');//结束时间
		
		var searchType=$("#company_findtype").val();//查询条件
	     console.log(searchType);
	     
	    window.location.href = basePath+'acceptClaimsReport/searchClaimsCompany.do?beginTime='+beginTime+'&endTime='+endTime+'&searchType='+searchType+'&coordinate='+0;
	});	
	
});