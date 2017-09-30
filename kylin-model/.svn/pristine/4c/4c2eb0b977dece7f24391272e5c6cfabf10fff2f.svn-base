"use strict";
angular.module("app").service("cookie",function () {
    /**
     * 存储用户信息
     */
    this.set_user = function (data) {
        $.cookie("user",JSON.stringify(data),{path:"/"});
    };
    /**
     * 删除用户信息
     */
    this.del_user = function () {
        $.cookie("user","",{path:"/"});
    };
    /**
     * 获取用户昵称
     */
    this.get_userName = function () {
        var user = $.cookie("user");
        if (user) {
            return JSON.parse(user).userName;
        }else{
            return null;
        }
    };
    /**
     * 存储用户token
     */
    this.set_token = function (data) {
        $.cookie("token",JSON.stringify(data),{path:"/"});
    };
    /**
     * 获取用户token
     */
    this.get_token = function () {
        var token = $.cookie("token");
        return token;
    };
});