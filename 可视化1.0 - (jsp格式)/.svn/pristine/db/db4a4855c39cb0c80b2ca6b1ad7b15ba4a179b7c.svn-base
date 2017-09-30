/**
 * 微信带日期下拉分页--->按日期分页
 * 按天查询数据
 * 数据合并日期
 */
$(function(){
	var startDataTime =daysJian(); //开始时间
	var endDataTime = new Date().Format("yyyy-MM-dd"); //结束时间
    var flagNoData = true; //数据未加载完
    var loading = false;
    var flag = 1;//0下拉涮新，1上拉加载
    var dataday=0;//有数据的天数
    var pageNum=0;//当前已加载条数
    var pageSize=pageSizeNum;//总条数数据
    var pagedata ={"startDataTime":startDataTime,"endDataTime":endDataTime}
    var listpage={
	    	showAjax:function(url,page,flag) {
	    		  if(typeof(wpagedata)!="undefined"){
		          	wpagedata.startDataTime=startDataTime;
		          	wpagedata.endDataTime=endDataTime;
		          }else{
		          	pagedata.startDataTime=startDataTime;
		          	pagedata.endDataTime=endDataTime;
		          }
	    		  EFTPWX.getListById(url,page||pagedata,function(dataObj){
	    			  //时间减一天
					  startDataTime = dateJian(startDataTime);
    				  endDataTime = dateJian(endDataTime);
	    			  if(JSON.stringify(dataObj) == "{}"){//当前没数据取得下一天数据
	    				  if(pageNum>=pageSize){//当前条数大于等于总条数，则结束查询
	    					  $('#loadMsg').html("无更多数据");
	  			              flagNoData = false;
	    				  }else{
	    					  listpage.init();
	    				  }
	    			  }else{
	    				  for(var key in dataObj){
	    						pageNum+=dataObj[key].length;
	    				  }
	    				  var strData = wxpagedata(dataObj);
	  	    			  listpage.showContent(strData,flag);
	    				  if(dataday==2){//三天数据加载
	    					  dataday=0;
	    				  }else{
	    					  listpage.init();
	    					  dataday++;
	    				  }
	    			  }
	    		})
		    },
		    showContent:function (datacontent,flag){//设置内容
		    	if(flag==1){//加载
		    		$("#contentDiv").append(datacontent);
		    	}else{//涮新
		    		$("#contentDiv").html(datacontent);
		    		$(document.body).pullToRefreshDone();
		    	}
		    },
		    init:function(){
		    	if(!flagNoData){
		    		return false;
		    	}
		    	if(typeof(wpagedata)!="undefined"){
				     listpage.showAjax(url,wpagedata,flag);
				 }else{
				      listpage.showAjax(url,pagedata,flag);
				 }
		    }
    	};
    /*$("body").append("<div id=\"contentDiv\"></div>" +
		"<div id=\"loadMsg\" class=\"weui-loadmore\"><span class=\"weui-loadmore__tips\">上拉加载更多</span></div>");*/
    	
		listpage.init();
		//上拉加载
		$(document.body).infinite().on("infinite", function() {
		    if(flagNoData){
		       if(loading) return false;
		       $('#loadMsg').html("<i class='weui-loading'></i><span class='weui-loadmore__tips'>正在加载</span>");
		   	      loading = true;
		   	      flag = 1;
		   	      setTimeout(function() {
		   	    	listpage.init();
		   	        loading = false;
		   	      }, 1000);
		    	}
		  });
	});
