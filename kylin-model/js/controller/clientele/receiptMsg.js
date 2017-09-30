"use strict";
angular.module("app").controller("receiptMsgController",function ($rootScope,$scope,$http,$uibModalInstance,config,base,clientele,addressProvinces) {
    $scope.clientele = clientele; //接收外层控制器传入的客户信息数据
    $scope.addressProvinces = addressProvinces; //接收外层控制器传入的省市地址数据
    $scope.addressCitys = {}; //市级地址对象，用户接收动态绑定的地址信息
    /**
     * 初始化市级列表
     */
    $scope.initAddressCity = function (code,index) {
        if (code != "" && code != null){
            var para = {};
            para.code = code;
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
                    $scope.addressCitys["arr" + index] = data.addressCitys;
                }else{
                    layer.msg(data.message);
                }
            });
        }else{
            $scope.addressCitys["arr" + index] = [];
        }
    };
    /**
     * 初始化常用收货信息
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
                for (var i in data.receiptMsgs){
                    $scope.initAddressCity(data.receiptMsgs[i].addressProvinceId,data.receiptMsgs[i].index);
                }
                $scope.receiptMsgs = data.receiptMsgs;
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
        para.receiptMsgs = $scope.receiptMsgs;
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
     * 新增一条常用收货信息
     * 点击“+”号按钮，增加一条常用收货信息
     */
    $scope.addList = function () {
        $scope.receiptMsgs.push({
            index : base.getTimeStamp(),
            receiverName : "",
            receiverPhone : "",
            receiverTelephone : "",
            addressProvinceComment : "",
            addressProvinceId : "",
            addressCityComment : "",
            addressCityId : "",
            addressDetail : "",
            backListDayNum : ""
        });
    };
    /**
     * 删除一条常用收货信息
     * 点击“-”号按钮，删除一条常用收货信息
     */
    $scope.delList = function (index) {
        if ($scope.receiptMsgs.length > 1){
            for (var i in $scope.receiptMsgs){
                if ($scope.receiptMsgs[i].index == index){
                    $scope.receiptMsgs.splice(i,1); //从数组中移除匹配到的数组元素
                    delete $scope.addressCitys["arr" + index]; //删除指定元素后，删除相应市级对象属性
                    break;
                }
            }
        }else{
            layer.msg("请至少保留一条常用收货信息！");
        }
    };
    //页面加载完成执行定义方法
    // $scope.init();
    /**
     * 测试数据
     */
    //常用收货信息
    $scope.receiptMsgs = [
        {
            index : "1",
            receiverName : "张全蛋",
            receiverPhone : "13013013130",
            receiverTelephone : "02152125020",
            addressProvinceComment : "安徽省",
            addressProvinceId : "1",
            addressCityComment : "滁州市",
            addressCityId : "1",
            addressDetail : "天长路520号",
            backListDayNum : "3"
        },
        {
            index : "2",
            receiverName : "张全蛋",
            receiverPhone : "13013013130",
            receiverTelephone : "02152125020",
            addressProvinceComment : "安徽省",
            addressProvinceId : "1",
            addressCityComment : "合肥市",
            addressCityId : "2",
            addressDetail : "天长路520号",
            backListDayNum : "3"
        },
        {
            index : "3",
            receiverName : "张全蛋",
            receiverPhone : "13013013130",
            receiverTelephone : "02152125020",
            addressProvinceComment : "安徽省",
            addressProvinceId : "1",
            addressCityComment : "淮南市",
            addressCityId : "3",
            addressDetail : "天长路520号",
            backListDayNum : "3"
        }
    ];
    //市区1
    $scope.addressCitys["arr1"] = [
        {
            id : "0",
            comment : "六安市"
        },
        {
            id : "1",
            comment : "滁州市"
        },
        {
            id : "2",
            comment : "合肥市"
        },
        {
            id : "3",
            comment : "淮南市"
        },
        {
            id : "4",
            comment : "蚌埠市"
        }
    ];
    //市区2
    $scope.addressCitys["arr2"] = [
        {
            id : "0",
            comment : "六安市"
        },
        {
            id : "1",
            comment : "滁州市"
        },
        {
            id : "2",
            comment : "合肥市"
        },
        {
            id : "3",
            comment : "淮南市"
        },
        {
            id : "4",
            comment : "蚌埠市"
        }
    ];
    //市区3
    $scope.addressCitys["arr3"] = [
        {
            id : "0",
            comment : "六安市"
        },
        {
            id : "1",
            comment : "滁州市"
        },
        {
            id : "2",
            comment : "合肥市"
        },
        {
            id : "3",
            comment : "淮南市"
        },
        {
            id : "4",
            comment : "蚌埠市"
        }
    ];
});
