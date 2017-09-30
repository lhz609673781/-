"use strict";
angular.module("app").controller("baseLimitSetController",function ($rootScope,$scope,$http,config,base) {
    /**
     * 权限列表渲染完成
     * 等级列表渲染完成
     */
    $scope.renderFinish = function(){
        base.formRender();
    };
    /**
     * 加载权限列表
     */
    $scope.loadLimit = function () {
        $http({
            method : 'POST',
            url : config.api_host + 'limit/api/limitList',
            headers : {
                'Content-Type': 'application/json',
                "X-Token": $rootScope.token,
                "X-Request-Type":"ajax"
            }
        }).success(function(data) {
            if (data.success) {
                $scope.limits = data.limits;
                //加载等级列表
                $scope.loadLevel();
            }else{
                layer.msg(data.message);
            }
        });
    };
    /**
     * 加载等级列表
     */
    $scope.loadLevel = function () {
        $http({
            method : 'POST',
            url : config.api_host + 'level/api/levelList',
            headers : {
                'Content-Type': 'application/json',
                "X-Token": $rootScope.token,
                "X-Request-Type":"ajax"
            }
        }).success(function(data) {
            if (data.success) {
                $scope.levels = data.levels;
                //加载相应等级拥有的权限
                $scope.loadLevelLimit();
            }else{
                layer.msg(data.message);
            }
        });
    };
    /**
     * 加载相应等级拥有的权限
     */
    $scope.loadLevelLimit = function () {
        $http({
            method : 'POST',
            url : config.api_host + 'levelLimit/api/levelLimitList',
            headers : {
                'Content-Type': 'application/json',
                "X-Token": $rootScope.token,
                "X-Request-Type":"ajax"
            }
        }).success(function(data) {
            if (data.success) {
                $scope.levelLimits = data.levelLimits;
                //将权限数组、等级数组，相应等级拥有的权限数组封装成一个数组,用来统一处理数据渲染
                $.each($scope.limits,function (index,ele) {
                    ele.levels = $scope.levels;
                    ele.levelLimits = $scope.levelLimits[ele.id];
                });
                //动态加载完菜单项进行layui组件渲染
                base.layui.use(['form']);
            }else{
                base.layer.msg(data.message);
            }
        });
    };
    /**
     * 保存基础权限设置
     */
    $scope.save = function () {
        var para = {};
        $.each($scope.limits,function (index,ele) {
            para[ele.id] = ele.levelLimits;
        });
        $http({
            method : 'POST',
            url : config.api_host + 'save/api/save',
            data : JSON.stringify(para),
            headers : {
                'Content-Type': 'application/json'
            }
        }).success(function(data) {
            if (data.success) {
                base.layer.msg("保存成功");
            }else{
                base.layer.msg(data.message);
            }
        });
    };
    //页面加载完成执行定义方法
    // $scope.loadLimit();
    /**
     * 测试数据
     */
    //权限列表
    $scope.limits = [
        {
            id : "bottom1",
            comment : "按钮1"
        },
        {
            id : "bottom2",
            comment : "按钮2"
        },
        {
            id : "bottom3",
            comment : "按钮3"
        },
        {
            id : "bottom4",
            comment : "按钮4"
        },
        {
            id : "bottom5",
            comment : "按钮5"
        },
        {
            id : "bottom6",
            comment : "按钮6"
        }
    ];
    //等级列表
    $scope.levels = [
        {
            id : "1",
            comment : "管理员"
        },
        {
            id : "2",
            comment : "主播"
        },
        {
            id : "3",
            comment : "助理"
        },
        {
            id : "4",
            comment : "钻石"
        },
        {
            id : "5",
            comment : "铂金"
        },
        {
            id : "6",
            comment : "黄金"
        },
        {
            id : "7",
            comment : "白银"
        },
        {
            id : "8",
            comment : "会员"
        }
    ];
    //相应等级拥有的权限
    $scope.levelLimits = {
        bottom1 : ["1","2","3","4","5","6","7","8"],
        bottom2 : ["1","2","3","4","5","6","7"],
        bottom3 : ["1","2","3","4","5","6"],
        bottom4 : ["1","2","3","4","5"],
        bottom5 : ["1","2","3","4"],
        bottom6 : ["1","2","3"]
    };
    $.each($scope.limits,function (index,ele) {
        ele.levels = $scope.levels;
        ele.levelLimits = $scope.levelLimits[ele.id];
    });
});
