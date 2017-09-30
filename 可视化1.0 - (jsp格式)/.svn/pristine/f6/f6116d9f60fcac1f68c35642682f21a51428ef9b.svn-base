/**
 * 微信端ajax方法调用
 */
var EFTP={
	/*Json 工具类*/
	isJson:function(str){
		var obj = null; 
		try{
			obj = EFTP.paserJson(str);
		}catch(e){
			return false;
		}
		var result = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length; 
		return result;
	},
	//字符串key-value转换为json
	paserJson:function(str){
		return eval("("+str+")");
	},
	//alert弹出框
	alert:function(message, callback, title, opts){
		alert(title, message, callback, opts);
	},
	//选择是否框
	confirm:function (message, callback, opts,title){
		confirm(title, message, callback, opts);
	},
	
	//加载进度条
	progress:function(title){
		var msg = title ||'数据加载中...'
		//获取浏览器页面可见高度和宽度
		var _PageHeight = document.documentElement.offsetHeight || document.documentElement.scrollHeight,
		  _PageWidth = document.documentElement.offsetWidth || document.documentElement.scrollWidth;
		//计算loading框距离顶部和左部的距离（loading框的宽度为215px，高度为61px）
		var _LoadingTop = _PageHeight > 61 ? (_PageHeight - 61) / 2 : 0,
		  _LoadingLeft = _PageWidth > 215 ? (_PageWidth - 215) / 2 : 0;
		//在页面未加载完毕之前显示的loading Html自定义内容
		 var _LoadingHtml = '<div id="loadingDiv" style="position:absolute;left:0;width:100%;height:' + _PageHeight + 
		 'px;top:0;background:#f3f8ff;opacity:0.5;filter:alpha(opacity=50);z-index:10000;"><div style="position: absolute; cursor1: wait; left: '
		 + _LoadingLeft + 'px; top:' + _LoadingTop + 'px; width: auto; height: 57px; line-height: 57px; padding-left: 50px; padding-right: 5px; background: #fff url(../../images/loading.gif) no-repeat scroll 5px 10px; border: 0px solid #95B8E7; color: #696969; font-family:\'Microsoft YaHei\';">'
		 +msg+'</div></div>';
		  //呈现loading效果
		 $('body').append(_LoadingHtml)
	},
	//移除进度条
	closeProgress:function(){
		$("#loadingDiv").remove();
	},
	ajaxSubmit:function(form,option){
		form.ajaxSubmit(option);
	},
	ajaxJson: function(url,option,callback){
		$.ajax(url,{
			type:'post',
			 	dataType:'json',
			 	data:option,
			 	success:function(data){
			 		EFTP.closeProgress();
			 		if($.isFunction(callback)){
			 			callback(data);
			 		}
			 	},
			 	error:function(response, textStatus, errorThrown){
			 		try{
			 			EFTP.closeProgress();
			 			var data = $.parseJSON(response.responseText);
			 		}catch(e){
			 			EFTP.alert("请求出现异常,请联系管理员."+e.message);
			 		}
			 	},
			 	complete:function(){
			 	}
		});
	},
	submitForm:function(form,callback,dataType){
			var option =
			{
			 	type:'post',
			 	dataType: dataType||'json',
			 	success:function(data){
			 		EFTP.closeProgress();
			 		if($.isFunction(callback)){
			 			callback(data);
			 		}
			 	},
			 	error:function(response, textStatus, errorThrown){
			 		try{
			 			EFTP.closeProgress();
			 			var data = $.parseJSON(response.responseText);
			 		}catch(e){
			 			EFTP.alert("请求出现异常,请联系管理员."+e.message);
			 		}
			 	},
			 	complete:function(){
			 	}
			 }
			 EFTP.ajaxSubmit(form,option);
	},
	saveForm:function(form,callback){
		if(form.form('validate')){
			EFTP.progress("数据提交中...");
			//ajax提交form
			EFTP.submitForm(form,function(data){
			 	if(data.success){
			 		if(callback){
				       	callback(data);
				    }else{
				    	EFTP.alert("操作成功");
			        } 
		        }else{
		        	EFTP.alert(data.msg||'操作失败');  
		        }
			});
		 }
	},
	/**
	 * 
	 * @param {} url
	 * @param {} option {id:''} 
	 */
	getById:function(url,option,callback){
		EFTP.progress();
		EFTP.ajaxJson(url,option,function(data){
			if(data.success){
				if(callback){
			       	callback(data);
			    }
			}else{
				EFTP.alert(data.msg||'操作失败');   
			}
		});
	},
	deleteForm:function(url,option,callback){
		EFTP.progress("数据提交中...");
		EFTP.ajaxJson(url,option,function(data){
				if(data.success){
					if(callback){
				       	callback(data);
				    }
				}else{
					EFTP.alert(data.msg||'操作失败');  
				}
		});
	},
	//其他form提交
	otherForm:function(url,option,callback){
		EFTP.progress("数据提交中...");
		EFTP.ajaxJson(url,option,function(data){
				if(data.success){
					if(callback){
				       	callback(data);
				    }
				}else{
					EFTP.alert(data.msg||'操作失败');  
				}
		});
	},
	
	//h5上传方式
	h5UploadForm:function(url,callback,option){
		option = option || new FormData($( "#uploadForm" )[0]);
		EFTP.uploadFrom(url,function(data){
			if(data.success){
				if(callback){
			       	callback(data);
			    }
			}else{
				EFTP.alert(data.msg||'操作失败');  
			}
		},option);
	},
	//文件上传
	uploadFrom:function(url,callback,option){
		EFTP.progress("文件上传中...");
		$.ajax({  
	          url: url,  
	          type: 'POST',  
	          data: option, 
	          async: false,  
	          cache: false,  
	          contentType: false,  
	          processData: false,  
	          success:function(data){
	        	  EFTP.closeProgress();
			 		if($.isFunction(callback)){
			 			data =$.parseJSON(data);
			 			callback(data);
			 		}
			 	},
			 	error:function(response, textStatus, errorThrown){
			 		 EFTP.closeProgress();
			 		try{
			 			var data = $.parseJSON(response.responseText);
			 		}catch(e){
			 			EFTP.alert("请求出现异常,请联系管理员."+e.message);
			 		}
			 	},
			 	complete:function(){
			 		
			 	} 
	     });
	}
}


/*表单转成json对象数据*/
$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [ o[this.name] ];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}
