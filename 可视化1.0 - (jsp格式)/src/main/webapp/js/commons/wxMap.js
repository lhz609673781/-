/**
 * 微信地图
 */
    var geocoder,map,marker,info,content= null;
	var longitude=$('#longitude').val();
	var latitude=$('#latitude').val();
	var address=$('#address').val();
	var driverPhone=$('#driverPhone').val();
	var scanTime=$('#scanTime').val();
	var content="定位地址："+address+"</br>定位时间："+scanTime+"</br>联系人：<span style='color:#30aafa' onclick='EFTPWX.phone("+driverPhone+")'>"+driverPhone+"</span>";
	content="<div style='text-align: left;'>"+content+"</div>";
	
	var createDateTime=$('#createtime').val();
	var pointArray,trackArray  = null;
	var item_contents,locations;
	
var init = function() {
	    var center = new qq.maps.LatLng(latitude,longitude);
	    map = new qq.maps.Map(document.getElementById('mapContainer'),{
	        center: center,
	        zoom: 13
	    });
	    
	    //整理轨迹
	    var trackList=$('#trackList').val();
		if(trackList!=null&&trackList!=''){
			trackList=trackList+"";
			trackArray = eval('(' + trackList + ')');
			pointArray=new Array();
			for(var i=0;i<trackArray.length;i++){
				pointArray[i]=new qq.maps.LatLng(trackArray[i].latitude,trackArray[i].longitude);
			}
		}
	    
	    if(pointArray!=null){
	    	var polyline = new qq.maps.Polyline({
		        path: pointArray,
		        strokeColor: '#000000',
		        strokeWeight: 5,
		        editable:false,
		        map: map
		    });
	    	polyline.setStrokeDashStyle("dash");
	    	polyline.setVisible(true);
	    }
	    
	    var anchor = new qq.maps.Point(6, 6),
        size = new qq.maps.Size(50, 50),
        origin = new qq.maps.Point(0, 0),
        icon = new qq.maps.MarkerImage('images/newcar.png', size, origin, anchor);
		marker = new qq.maps.Marker({
			icon: icon,
	        position: center,
	        map: map
	    });

		item_contents = new Array(trackArray.length);
		locations = new Array(trackArray.length);
		for(var i=1;i<trackArray.length;i++){
			locations[i] =  new qq.maps.LatLng(trackArray[i].latitude,trackArray[i].longitude);
			var item_content="定位地址："+trackArray[i].locations+"</br>定位时间："+timeStamp2String(trackArray[i].createtime)+"</br>联系人：<span style='color:#30aafa' onclick='EFTPWX.phone("+trackArray[i].user.mobilephone+")'>"+trackArray[i].user.mobilephone+"</span>";
			item_content="<div style='text-align: left;'>"+item_content+"</div>";
			item_contents[i]=item_content;
		}
		
		//添加到提示窗
	    info = new qq.maps.InfoWindow({
	        map: map
	    });
		
        for(var i = 1;i < locations.length; i++) {
            (function(n){
                var marker = new qq.maps.Marker({
                    position: locations[n],
                    map: map
                });
                qq.maps.event.addListener(marker, 'click', function() {
                	info.setContent('<div style="text-align:center;width:230px;'+
                            'margin:5px;">'+item_contents[n]+'</div>');
                	info.setPosition(locations[n]);
                	info.open();
                });
            })(i);
        }
		
		
	    
        info.setContent('<div style="text-align:center;width:230px;'+
        'margin:5px;">'+content+'</div>');
        info.setPosition(center); 
        info.open(); 
        
		if(content!=null&&content!=''){
			//获取标记的点击事件
		    qq.maps.event.addListener(marker,'click', function() {
		        info.setContent('<div style="text-align:center;width:230px;'+
		        'margin:5px;">'+content+'</div>');
		        info.setPosition(center);
		        info.open();
		    }); 
		}
		
	    var $targetObj = $('#targetObj');
        //初始化设置
        cat.touchjs.init($targetObj, function (left, top, scale, rotate) {
            $('#left').text(left);
            $('#top').text(top);
            $('#scale').text(scale);
            $('#rotate').text(rotate);
            $targetObj.css({
                left: left,
                top: top,
                'transform': 'scale(' + scale + ') rotate(' + rotate + 'deg)',
                '-webkit-transform': 'scale(' + scale + ') rotate(' + rotate + 'deg)'
            });
        });
        //初始化拖动手势（不需要就注释掉）
        cat.touchjs.drag($targetObj, function (left, top) {
            $('#left').text(left);
            $('#top').text(top);
        });
        //初始化缩放手势（不需要就注释掉）
        cat.touchjs.scale($targetObj, function (scale) {
            $('#scale').text(scale);
        });
        //初始化旋转手势（不需要就注释掉）
        /* cat.touchjs.rotate($targetObj, function (rotate) {
            $('#rotate').text(rotate);
        }); */

	}

