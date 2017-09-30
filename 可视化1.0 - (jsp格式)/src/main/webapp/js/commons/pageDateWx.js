/**
 * 微信带日期下拉分页--根据日期合并数据
 * 按条数查询数据
 * 数据插入指定jsp页面中
 */
$(function(){
	var pageNo = 0; //当前条数
	var pageNum = 0; //当前页的页码
	var pageSize =5;//每页加载5条
    var flagNoData = true; //数据未加载完
    var loading = false;
    var flag = 1;//0下拉涮新，1上拉加载
   // var allpage = Math.ceil(count/pageSize)-1; //总页码
    var pagedata ={"pageNo":pageNo,"pageSize":pageSize}
    var listpage={
	    	showAjax:function(url,page,flag) {
	    		  if(typeof(wpagedata)!="undefined"){
		          	wpagedata.pageNo=pageNum*pageSize;
		          	wpagedata.pageSize=pageSize;
		          }else{
		          	pagedata.pageNo=pageNum*pageSize;
		          	pagedata.pageSize=pageSize;
		          }
	    		  EFTPWX.getListById(url,page||pagedata,function(dataObj){
	    			  if(JSON.stringify(dataObj) == "{}" || dataObj==null || dataObj.length==0 || dataObj.length<pageSize){
		    				$('#loadMsg').html("无更多数据");
				            flagNoData = false;
				            return;
		    			}
	    			var strData = wxpagedata(dataObj);
	    			listpage.showContent(strData,flag);
	    			pageNum += 1;  //页数加1
	    		})
		    },
	    	scrollFn:function() {
		      //真实内容的高度
		      var pageHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight);
		      //视窗的高度
		      var viewportHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight || 0;
		      //隐藏的高度
		      var scrollHeight = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
		      if (!flagNoData) { //数据全部加载完了
		      	  $('#loadMsg').html("无更多数据");
		    	  return;
		      }else{
			      var awayBtm = pageHeight - viewportHeight - scrollHeight;
			      if(parseInt(awayBtm)<parseInt(-10)){
			      	$('#loadMsg').html("<i class='weui-loading'></i><span class='weui-loadmore__tips'>正在加载</span>");
					listpage.init()
			      }
		      }
		    },
		    showContent:function (datacontent,flag){//设置内容
		    	if(flag==1){//加载
		    		$("#contentDiv").append(datacontent);
		    	}else{//涮新
		    		$("#contentDiv").html(datacontent);
		    		//$(document.body).pullToRefreshDone();
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
    
    	/*$("body").append("<div id=\"contentDiv\" class=\"position_list\"></div>" +
    			"<div id=\"loadMsg\" class=\"weui-loadmore\"><span class=\"weui-loadmore__tips\">上拉加载更多</span></div></div>");*/
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
		    
		  //下拉涮新
//		  $(document.body).pullToRefresh();
//		  $(document.body).on("pull-to-refresh", function() {
//			  flagNoData = true;
//			  flag = 0;
//			  pageNo = 0; //当前条数
//			  pageNum = 0; //当前页的页码
//			  listpage.init();
//		  });
	});
