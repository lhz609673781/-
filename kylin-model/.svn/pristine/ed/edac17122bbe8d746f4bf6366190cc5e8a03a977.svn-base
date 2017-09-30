"use strict";
angular.module("app").controller("goodsMsgController",function ($rootScope,$scope,$http,$uibModalInstance,config,base,clientele) {
    $scope.clientele = clientele; //接收外层控制器传入的客户信息数据
    /**
     * 初始化常用货品信息
     */
    $scope.init = function () {
        var para = {};
        para.clienteleNo = clientele.clienteleNo;
        $http({
            method : 'POST',
            url : config.api_host + 'limit/api/limitList',
            data : JSON.stringify(para),
            headers : {
                'Content-Type': 'application/json',
                "X-Token": $rootScope.token,
                "X-Request-Type":"ajax"
            }
        }).success(function(data) {
            if (data.success) {
                $scope.goodsMsgs = data.goodsMsgs;
            }else{
                layer.msg(data.message);
            }
        });
    };
    /**
     * 保存常用收货信息
     */
    $scope.save = function () {
        var para = {};
        para.goodsMsgs = $scope.goodsMsgs;
        $http({
            method : 'POST',
            url : config.api_host + 'limit/api/limitList',
            data : JSON.stringify(para),
            headers : {
                'Content-Type': 'application/json',
                "X-Token": $rootScope.token,
                "X-Request-Type":"ajax"
            }
        }).success(function(data) {
            if (data.success) {
                $uibModalInstance.close();
                layer.msg("保存成功！");
            }else{
                layer.msg(data.message);
            }
        });
    };
    $scope.cancel = function () {
        $uibModalInstance.dismiss();
    };
    /**
     * 新增一条常用货品信息
     * 点击“+”号按钮，增加一条常用货品信息
     */
    $scope.addList = function () {
        $scope.goodsMsgs.push({
            index : base.getTimeStamp(),
            goodsCategory : "",
            goodsName: "",
            goodsModel : "",
            goodsUnit : ""
        });
    };
    /**
     * 删除一条常用货品信息
     * 点击“-”号按钮，删除一条常用货品信息
     */
    $scope.delList = function (index) {
        for (var i in $scope.goodsMsgs){
            if ($scope.goodsMsgs[i].index == index){
                $scope.goodsMsgs.splice(i,1); //从数组中移除匹配到的数组元素
                break;
            }
        }
    };
    //页面加载完成执行定义方法
    // $scope.init();
    /**
     * 测试数据
     */
    //常用货品信息
    $scope.goodsMsgs = [
        {
            index : "1",
            goodsCategory : "酸奶",
            goodsName: "安慕希",
            goodsModel : "瓶装",
            goodsUnit : "瓶"
        },
        {
            index : "2",
            goodsCategory : "酸奶",
            goodsName: "莫斯利安",
            goodsModel : "瓶装",
            goodsUnit : "瓶"
        },
        {
            index : "3",
            goodsCategory : "酸奶",
            goodsName: "光明",
            goodsModel : "罐装",
            goodsUnit : "罐"
        }
    ];
});
