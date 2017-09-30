/**
 * 微信端ajax方法调用
 */
var EFTPWX={
	/*Json 工具类*/
	isJson:function(str){
		var obj = null; 
		try{
			obj = EFTPWX.paserJson(str);
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
	
	phone:function (xgfPhone){//手机电话
		window.location.href = 'tel://' + xgfPhone;  
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
			 		if($.isFunction(callback)){
			 			callback(data);
			 		}
			 	},
			 	cancel:function(response, textStatus, cancelThrown){
			 		try{
			 			var data = $.parseJSON(response.responseText);
			 		}catch(e){
			 			$.toast("请求出现异常,请联系管理员."+e.message,'cancel');
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
			 		if($.isFunction(callback)){
			 			callback(data);
			 		}
			 	},
			 	cancel:function(response, textStatus, cancelThrown){
			 		try{
			 			var data = $.parseJSON(response.responseText);
			 		}catch(e){
			 			$.toast("请求出现异常,请联系管理员."+e.message,'cancel');
			 		}
			 	},
			 	complete:function(){
			 	
			 	}
			 }
			 EFTPWX.ajaxSubmit(form,option);
	},
	saveForm:function(form,callback){
		if(form.form('validate')){
			//ajax提交form
			EFTPWX.submitForm(form,function(data){
			 	if(data.success){
			 		if(callback){
				       	callback(data);
				    }else{
				    	$.toast("操作成功");
			        } 
		        }else{
		        	$.toast(data.msg||'操作失败','cancel');  
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
		EFTPWX.ajaxJson(url,option,function(data){
			if(data.success){
				if(callback){
			       	callback(data);
			    }
			}else{
				$.toast(data.msg||'操作失败','cancel');   
			}
		});
	},
	
	getListById:function(url,option,callback){
		EFTPWX.ajaxJson(url,option,function(data){
			if(callback){
			     callback(data);
			 }
		});
	},
	deleteForm:function(url,option,callback){
		EFTPWX.ajaxJson(url,option,function(data){
				if(data.success){
					if(callback){
				       	callback(data);
				    }
				}else{
					$.toast(data.msg||'操作失败','cancel');  
				}
		});
	},
	otherForm:function(url,option,callback){
		EFTPWX.ajaxJson(url,option,function(data){
				if(data.success){
					if(callback){
				       	callback(data);
				    }
				}else{
					$.toast(data.msg||'操作失败','cancel');  
				}
		});
	}
}


/*表单转成json数据*/
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
