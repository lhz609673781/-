//DOM渲染完成
$(function () {
            //绘制3D饼图
            charts3d("#charts-item1-pic",[["上季度赔付平均值",100]],false);
            charts3d("#charts-item2-pic",[["同期赔付增减",100]],false);
            charts3d("#charts-item3-pic",[["环比赔付增减",100]],false);
            charts3d("#charts-item4-pic",[['承运商', 20],['保险公司', 10],{name: '远成',y: 70,sliced: true,selected: true}],true);
            //客户查询全局对象
            var $clientSearchDateStart = $("#clientSearchDateStart"),
                  $clientSearchDateStart = $("#clientSearchDateStart");
            //初始化客户查询
            function initClientSearch() {
                       var clientSearchDateStart = $clientSearchDateStart.val(),
                             clientSearchDateStart = $clientSearchDateStart.val(),
                             baseValue = {clientSearchDateStart:clientSearchDateStart,clientSearchDateStart:clientSearchDateStart};
                       EasyAjax.ajax_Post_Json({
                                   url: "suggest/getSuggestsList.json",
                                   data: baseValue
                       },
                       function (data) {
                                   page(data,"#clientSearchTpl","#showClientSearchList");
                       });
            }
            initClientSearch();
            //搜索客户查询
            $("#clientSearchSearchBtn").on("click",function () {
                       initClientSearch();
            });
});