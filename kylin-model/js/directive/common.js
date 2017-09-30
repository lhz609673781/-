"use strict";
angular.module("app").directive("repeatFinish",function () {
    /**
     * repeatFinish
     * 监听repeat指令渲染完成
     */
    return {
        link: function(scope,element,attr){
            if(scope.$last){
                scope.$eval( attr.repeatFinish );
            }
        }
    }
});