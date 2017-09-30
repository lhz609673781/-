"use strict";
var app = angular.module("app",["ui.bootstrap","ui.router","oc.lazyLoad"]);
/**
 * 全局配置路由对象
 */
app.run(function($rootScope, $state, $stateParams) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;
});
/**
 * 入口模块配置
 */
app.config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/main');
    $stateProvider
        .state('login', { //登陆模块
            url: '/login',
            views: {
                '': {
                    templateUrl: 'view/enter/login.html',
                    controller: "loginController",
                    resolve: {
                        lazyLoad: ['$ocLazyLoad', function ($ocLazyLoad) {
                            return $ocLazyLoad.load([
                                {
                                    name: 'app',
                                    files: ['js/controller/enter/login.js']
                                }
                            ]);
                        }]
                    }
                }
            }
        })
        .state('main', { //主模块
            url: '/main',
            views: {
                '': {
                    templateUrl: 'view/main.html',
                    controller : function ($rootScope,$scope,cookie,base) {
                        //获取用户名称
                        $scope.userName = cookie.get_userName();
                        //全局存储用户名称
                        $rootScope.rootUserName = cookie.get_userName();
                        //判断用户是否登陆
                        if ($scope.userName){
                            var token = cookie.get_token();
                            var reg = new RegExp('"',"g");
                            $rootScope.token = token.replace(reg, "");
                            //iframe临时模块，为了给iframe页面传递token
                            window.token = token.replace(reg, "");
                        }else{
                            $rootScope.$state.go("login");
                        }
                        /**
                         * 注销
                         */
                        $scope.logout = function () {
                            cookie.del_user();
                            $rootScope.$state.go("login");
                        };
                        /**
                         * 启动layui模块，调用内部组件
                         */
                        $rootScope.element = layui.element(); //基本组件
                        $rootScope.layer = layui.layer; //弹出层组件
                        $rootScope.form = layui.form(); //表单组件
                        $rootScope.laypage = layui.laypage; //分页组件
                        $rootScope.tree = layui.tree; //树形菜单组件
                    }
                },
                'navBar@main': { //导航模块
                    templateUrl: 'view/navBar/navBar.html',
                    controller: "navBarController",
                    resolve: {
                        lazyLoad: ['$ocLazyLoad', function ($ocLazyLoad) {
                            return $ocLazyLoad.load([
                                {
                                    name: 'app',
                                    files: ['js/controller/navBar/navBar.js']
                                }
                            ]);
                        }]
                    }
                },
                'content@main': { //默认模块
                    templateUrl: 'view/content/welcome.html',
                    controller: "welcomeController",
                    resolve: {
                        lazyLoad: ['$ocLazyLoad', function ($ocLazyLoad) {
                            return $ocLazyLoad.load([
                                {
                                    name: 'app',
                                    files: ['js/controller/welcome.js']
                                }
                            ]);
                        }]
                    }
                }
            }
        })
        .state('main.menuManager', { //菜单管理模块
            url: '/menuManager',
            views: {
                'content@main': {
                    templateUrl: 'view/content/organize/menuManager.html',
                    controller: "menuManagerController",
                    resolve: {
                        lazyLoad: ['$ocLazyLoad', function ($ocLazyLoad) {
                            return $ocLazyLoad.load([
                                {
                                    name: 'app',
                                    files: ['js/controller/organize/menuManager.js']
                                }
                            ]);
                        }]
                    }
                }
            }
        })
        .state('main.baseLimitSet', { //基础权限设置模块
            url: '/baseLimitSet',
            views: {
                'content@main': {
                    templateUrl: 'view/content/organize/baseLimitSet.html',
                    controller: "baseLimitSetController",
                    resolve: {
                        lazyLoad: ['$ocLazyLoad', function ($ocLazyLoad) {
                            return $ocLazyLoad.load([
                                {
                                    name: 'app',
                                    files: ['js/controller/organize/baseLimitSet.js']
                                }
                            ]);
                        }]
                    }
                }
            }
        })
        .state('main.contractClientele', { //合同客户模块
            url: '/contractClientele',
            views: {
                'content@main': {
                    templateUrl: 'view/content/clientele/contractClientele.html',
                    controller: "contractClienteleController",
                    resolve: {
                        lazyLoad: ['$ocLazyLoad', function ($ocLazyLoad) {
                            return $ocLazyLoad.load([
                                {
                                    name: 'app',
                                    files: ['js/controller/clientele/contractClientele.js','js/controller/clientele/receiptMsg.js','js/controller/clientele/goodsMsg.js']
                                }
                            ]);
                        }]
                    }
                }
            }
        })
});
