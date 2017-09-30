$(function(){
	var delParent;
	var defaults = {
		fileType : ["jpg","png","bmp","jpeg","JPG","PNG","BMP","JPEG"],   // 上传文件的类型
		fileSize : 1024 * 1024 * 10              // 上传文件的大小 10M
	};
	var sumCount=0;//总图片数量记录
	var fileSumList=[];//总图片集合
	var buttonObject;
	
		/*点击图片的文本框*/
	$("#uploaderInput").change(function(){
		var idFile = $(this).attr("id");
		var file = document.getElementById(idFile);
		var imgContainer = $(this).parents(".z_photo"); //存放图片的父亲元素
		var fileList = file.files; //获取的图片文件
		var input = $(this).parent();//文本框的父亲元素,指的是z-file;
		var imgArr = [];
		//遍历得到的图片文件
		var numUp = imgContainer.find(".weui-uploader__file").length;
		var totalNum = numUp + fileList.length;  //总的数量
		if(fileList.length > 10 || totalNum > 50 ){
			$.alert("一次上传图片数量不能超过10个");  //一次选择上传超过5个 或者是已经上传和这次上传的到的总数也不可以超过5个
		}
		else if(numUp < 50){
			fileList = validateUp(fileList);
			for(var i = 0;i<fileList.length;i++){
			var imgUrl = window.URL.createObjectURL(fileList[i]);
			    imgArr.push(imgUrl);
			    fileSumList[sumCount]=fileList[i];
			var $section = $("<li class='weui-uploader__file' id='"+sumCount+"'>");
			    imgContainer.prepend($section);
			    sumCount++;
		     /*var $img0 = $("<img class='close-upimg'>");
				 $img0.attr("src","images/del-icon.png").appendTo($section);*/
			var $i = $("<i class='close-upimg'>");
				$i.appendTo($section);
		    var $img = $("<img class='up-img'>");
		        $img.attr("src",imgArr[i]);
		        $img.appendTo($section);
		    var $p = $("<p class='img-name-p'>");
		        $p.html(fileList[i].name).appendTo($section);
		    var $input = $("<input id='taglocation' name='taglocation' value='' type='hidden'>");
		        $input.appendTo($section);
		    var $input2 = $("<input id='tags' name='tags' value='' type='hidden'/>");
		        $input2.appendTo($section);
		      
		   }
		}
		$(this).val("");
		setImgsClickEvent();
	});

    $(".z_photo").delegate(".close-upimg","click",function(){
     	  delParent = $(this).parent();
     	  $.confirm({
			  title: '确认删除吗',
			  text: '',
			  onOK: function () {
				//在图片集合中删除该图片
			    var id=delParent.attr("id");
			    for(var i=0;i<fileSumList.length;i++){
			    	if(i==id){
			    		fileSumList[i]=null;
			    		//alert("清理了i为"+i+"的图片");
			    		break;
			    	}
			    }
			   	delParent.remove();
			  }
			});
	});
		
	function validateUp(files){
		var arrFiles = [];//替换的文件数组
		for(var i = 0, file; file = files[i]; i++){
			//获取文件上传的后缀名
			var newStr = file.name.split("").reverse().join("");
			if(newStr.split(".")[0] != null){
					var type = newStr.split(".")[0].split("").reverse().join("");
					if(jQuery.inArray(type, defaults.fileType) > -1){
						// 类型符合，可以上传
						if (file.size >= defaults.fileSize) {
							alert(file.size);
							alert('您这个"'+ file.name +'"文件大小过大');	
						} else {
							// 在这里需要判断当前所有文件中
							arrFiles.push(file);	
						}
					}else{
						alert('您这个"'+ file.name +'"上传类型不符合');	
					}
				}else{
					alert('您这个"'+ file.name +'"没有类型, 无法识别');	
				}
		}
		return arrFiles;
	}
	
	/**
	 * @author:113076
	 * @info:回单提交上传图片
	 * @time:2017-6-5
	 * */
	$("#receiptUploadButton").click(function() {
		 var SumCount=0;
		 for(var i=0; i<fileSumList.length; i++){
	    	 file=fileSumList[i];
	    	 if(file!=null){
	    		 SumCount++;
	    	 }
	     }
		 
		 if(SumCount==0){
			 $.alert("至少上传一张图片！");
			 return;
		 }
		 
		 buttonObject=$("#receiptUploadButton");
		 var wayBillId = document.getElementById("wayBillId");
		 upLoadImage("weixin/ReceiptUpSubmit.html","wayBillId="+wayBillId.value);
	});
	
	/**
	 * @author:113076
	 * @info:异常上报上传图片
	 * @time:2017-6-5
	 * */
	$("#exceptionUploadButton").click(function() {
		 
		 var SumCount=0;
		 for(var i=0; i<fileSumList.length; i++){
	    	 file=fileSumList[i];
	    	 if(file!=null){
	    		 SumCount++;
	    	 }
	     }
		 if(SumCount>10){
			 $.alert("一次上传图片数量不能超过10个");
			 return;
		 }
		
		 buttonObject=$("#exceptionUploadButton");
		 var textAre = document.getElementById("abNormalInfo");
		 if(textAre.value==null||textAre.value==""){
			 $.alert("请填写异常信息！");
			 return;
		 }
		 var wayBillId = document.getElementById("wayBillId");
		 upLoadImage("weixin/ExceptionUpSubmit.html","wayBillId="+wayBillId.value+",abNormalInfo="+textAre.value);
	});
	
	/**
	 * @author:113076
	 * @info:异步上传图片具体方法
	 * @param:其中path是异步上传服务地址，
	 * otherParam是除了图片以外的其他参数（格式为'key1=value1,key2=value2,...'）
	 * @time:2017-6-5
	 * */
	function upLoadImage(path,otherParam){

		 if(fileSumList.length==0&&otherParam.indexOf('ReceiptUp')>0){
			 alert("请至少选择一张图片！");
			 return;
		 }

		 if(otherParam.indexOf('ReceiptUp')>0){
			 buttonObject.html("<img src='images/loading.gif' style='margin-right: 10px;margin-bottom:-10px;'/>图片上传中，请稍后..."); 
		 }else{
			 buttonObject.html("<img src='images/loading.gif' style='margin-right: 10px;margin-bottom:-10px;'/>提交中，请稍后..."); 
		 }
		 
		 buttonObject.css({'background-color':'#cccccc'});
		 buttonObject.attr("disabled", true);

		 var wayBillId;
	     var formData = new FormData();

	     var file;
	     for(var i=0; i<fileSumList.length; i++){
	    	 file=fileSumList[i];
	    	 if(file!=null){
	    		 //alert("第"+i+"个图片被加载");
		         formData.append('file_item', file); 
	    	 }
	     }
	     
	     if(otherParam!=null){
	    	 var paramList=otherParam.split(","); 
	    	 var paramObject;
	    	 for(var i=0;i<paramList.length;i++){
	    		 paramObject=paramList[i].split("="); 
	    		 formData.append(paramObject[0], paramObject[1]); 
	    		 if(paramObject[0]=="wayBillId"){
	    			 wayBillId=paramObject[1];
	    		 }
	    	 }
	     }
	     
	     $.ajax({  
	          url: path,  
	          type: 'POST',  
	          data: formData,  
	          async: true,  
	          cache: false,  
	          contentType: false,  
	          processData: false,  
	          success: function (returndata) {
	        	  if(returndata!=null){
	        		  var jData = jQuery.parseJSON(returndata); //转换为json对象 
	        		  alert(jData.msg);
	        		  buttonObject.html('确定'); 
	        		  buttonObject.css({'background-color':'#31acfa'});
	        		  buttonObject.attr("disabled", false); 
	        		  if(jData.code=="200"){
	  	            	//网页重定向至订单详细页面
	        			if($('#shareId').val()==null||$('#shareId').val()==''){
	        				window.location.href="weixin/ToWaybillDetail.html?wayBillId="+wayBillId;
	        			}else{
	        				var shareId = $('#shareId').val();
	        				window.location.href="weixin/ToWaybillDetail.html?wayBillId="+wayBillId+"&shareId="+shareId;
	        			}
	  		            
	  		            //location.reload();
	  	              }
	        	  }else{
	        		  buttonObject.html('确定'); 
	        		  buttonObject.css({'background-color':'#31acfa'});
	        		  buttonObject.attr("disabled", false);
	        		  alert("网络异常");
	        	  }
	          },  
	          error: function (returndata) {
	        	  buttonObject.html('确定'); 
	        	  buttonObject.css({'background-color':'#31acfa'});
	        	  buttonObject.attr("disabled", false);
	        	  if(returndata!=null){
	        		  var jData = jQuery.parseJSON(returndata); //转换为json对象 
	        		  alert(jData.msg);
	        	  }else{
	        		  alert("网络异常");
	        	  }
	          }  
	     });  
	}
	
	/**
	 * @author:113076
	 * @info:图片点击放大具体方法
	 * @time:2017-6-5
	 * */
	function setImgsClickEvent(){
    	var imgs = document.getElementsByTagName("img");
        var lens = imgs.length;

        for(var i = 0; i < lens; i++){
            imgs[i].onclick = function (event){
                event = event||window.event;
                var target = document.elementFromPoint(event.clientX, event.clientY);
                showBig(target.src);
            }
        }
    }
    
    function showBig(src){
    	$("#targetObj").attr("style","position:relative;transform-origin:center");
        popup.getElementsByTagName("img")[0].src = src;
        popup.style.display = "block";
    }
})