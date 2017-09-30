/**
 * 时间查询验证
 * @param beginTime
 * @param endTime
 * @returns {Boolean}
 */
function validate(beginTime,endTime){
	if (beginTime == "点击添入内容" || beginTime == "" || beginTime == undefined) {
		alert("起始时间不能为空");
		return false;
	}
	if (endTime == "点击添入内容" || endTime == "" || endTime == undefined) {
		alert("截至时间不能为空");
		return false;
	}
	if (!valiTime(beginTime,endTime)) {
		alert("起始时间不能大于截至时间");
		return false;
	}
	if (!valiTime2(beginTime,endTime)) {
		alert("查询时间跨度不能超过一年");
		return false;
	}
	return true;
}
/***
 * 判断起始时间是否小于截至时间
 * ***/
function valiTime(beginTime,endTime){
	var date1 = new Date(beginTime.replace(/-/g,"/"));
	var date2 = new Date(endTime.replace(/-/g,"/"));
	var t1 = Date.parse(date1);
	var t2 = Date.parse(date2);
	if ((t2-t1) >= 0) {
		return true;
	}else{
		return false;
	}
}
/**
 * 判断起始时间和截止时间是否大于一年
 */
function valiTime2(beginTime,endTime){
	var d1 = new Date(beginTime.replace(/-/g,"/"));
	var d2 = new Date(endTime.replace(/-/g,"/"));
	var months;
    months = (d2.getFullYear() - d1.getFullYear()) * 12;
    months -= d1.getMonth();
    months += d2.getMonth() + 1;
    var m = months <= 0 ? 0 : months;
	if (m<13) {
		return true;
	}else{
		return false;
	}
}

function vidate(obj) {
	if (obj == "" || obj == null || obj == undefined) {
		return false;
	}
	return true;
}

/*********************************************/
function clickout(){
	if ($(".out").css("display") === "none") {
		$(".out").show(800);
	}else{
		$(".out").hide(800);
	}
	
}
function quit(){
	window.parent.location.href=basePath+"view/login.jsp";
}

/* 当前页面高度 */
function pageHeight() {
	return document.body.scrollHeight;
}

/* 当前页面宽度 */
function pageWidth() {
	return document.body.scrollWidth;
}
/* 定位到页面中心 */
function adjust(id) {
    var w = $(id).width();
    var h = $(id).height();
    
    var t = scrollY() + (windowHeight()/2) - (h/2);
    if(t < 0) t = 0;
    
    var l = scrollX() + (windowWidth()/2) - (w/2);
    if(l < 0) l = 0;
    
    $(id).css({left: l+'px', top: t+'px'});
}

//浏览器视口的高度
function windowHeight() {
    var de = document.documentElement;

    return self.innerHeight || (de && de.clientHeight) || document.body.clientHeight;
}

//浏览器视口的宽度
function windowWidth() {
    var de = document.documentElement;

    return self.innerWidth || (de && de.clientWidth) || document.body.clientWidth
}

/* 浏览器垂直滚动位置 */
function scrollY() {
    var de = document.documentElement;

    return self.pageYOffset || (de && de.scrollTop) || document.body.scrollTop;
}

/* 浏览器水平滚动位置 */
function scrollX() {
    var de = document.documentElement;

    return self.pageXOffset || (de && de.scrollLeft) || document.body.scrollLeft;
}
