/**
 * 微信图片操作
 */
/*--------图片点击放大的js----------start*/
	var imgs = document.getElementsByTagName("img");
    var lens = imgs.length;
    var popup = document.getElementById("popup");

    for(var i = 0; i < lens; i++){
        imgs[i].onclick = function (event){
            event = event||window.event;
            var target = document.elementFromPoint(event.clientX, event.clientY);
            showBig(target.src);
        }
    }
    popup.onclick = function (){
        popup.style.display = "none";
    }
    function showBig(src){
    	$("#targetObj").attr("style","position:relative;transform-origin:center");
        popup.getElementsByTagName("img")[0].src = src;
        popup.style.display = "block";
    }
    /*--------图片点击放大的js----------end*/