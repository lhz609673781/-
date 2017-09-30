"use strict";
angular.module("app").service("base",function ($rootScope) {
    /**
     * layui组件渲染
     * form表单模块
     */
    this.formRender = function () {
      setTimeout(function () {
          $rootScope.form.render();
      },30);
    };
    /**
     * layui组件渲染
     * element模块
     */
    this.elementRender = function () {
        setTimeout(function () {
            $rootScope.element.init();
        },30);
    };
    /**
     * 刷新页面
     */
    this.refresh = function () {
        window.location.reload();
    };
    /**
     * 获取当前系统时间
     * 未经过格式化，返回一段时间戳
     */
    this.getTimeStamp = function () {
        var date = new Date();
        return date.getTime();
    };
    /**
     * 传入时间戳
     * 经过格式化，返回标准时间格式
     * YYYY-MM-DD HH:MM
     */
    this.dateFormat = function (date) {
        var year=date.getFullYear();
        var month=date.getMonth()+1;
        var day=date.getDate();
        var hour=date.getHours();
        var minute=date.getMinutes();
        if(minute<10){
            minute="0"+minute;
        }
        return year+"-"+month+"-"+day+" "+hour+":"+minute;
    };
});