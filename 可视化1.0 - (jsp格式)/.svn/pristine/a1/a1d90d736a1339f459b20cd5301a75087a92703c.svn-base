var formatTime = "yyyy-MM-dd HH:mm";
function searchMyTask(){
	var searchData = $("#searchData").val().trim();
	var createtime = $("#createtime").val();
	var status = $("#bindstatusSear").val();
	var delay = $("#delaySear").val();
	$.ajax({
		url : basePath + "weixin/myTaskSear.html",
		type : 'POST',
		data : {
			searchData:searchData,
			createtime:createtime,
			status:status,
			delay:delay
		},
		success : function(data) {
			var json = JSON.parse(data)
			var resultCode = json.resultCode;
			var ht='';
			var htm = "";
			if (resultCode==200) {
				var resutl = json.resutl;
				for (var key in resutl) {  
					var list = resutl[key];
					ht += '<div class="task-list-item">'
					ht += '<p class="task-list-item-title">'+key+'</p>'
					ht += '<div class="task-list-item-con">'
					for (var i = 0; i < list.length; i++) {
							//日期里面内容循环从这开始
						ht += '<div class="task-list-item-part">'
						ht +='<input class="wayId" type="hidden" value="'+list[i].id+'">'
						ht +='<input class="shareId" type="hidden" value="'+list[i].shareid+'">'
						ht += '<div class="weui-flex">'
						ht += '<div class="task-con-title">送货单号 :</div>'
						if (list[i].deliveryNumber == null || list[i].deliveryNumber == undefined) {
							ht += '<div class="weui-flex__item one-line-hide title-right"></div>'
						}else{
							ht += '<div class="weui-flex__item one-line-hide title-right">'+list[i].deliveryNumber+'</div>'
						}
						ht += '</div>'
						ht += '<div class="weui-flex">'
						ht += '<div class="task-con-title">收货客户 :</div>'
						if (list[i].companyName == null || list[i].companyName == undefined) {
							ht += '<div class="weui-flex__item one-line-hide"></div>'
						}else{
							ht += '<div class="weui-flex__item one-line-hide">'+list[i].companyName+'</div>'
						}
						ht += '</div>'
						ht += '<div class="weui-flex">'
						ht += '<div class="task-con-title">收货地址 :</div>'
						if (list[i].companyAddress == null || list[i].companyAddress == undefined) {
							ht += '<div class="weui-flex__item more-line-hide"></div>'
						}else{
							ht += '<div class="weui-flex__item more-line-hide">'+list[i].companyAddress+'</div>'
						}
						ht += '</div>'
						ht += '<div class="weui-flex">'
						ht += '<div class="task-con-title">任务摘要 :</div>'
						if (list[i].orderSummary == null || list[i].orderSummary == undefined) {
							ht += '<div class="weui-flex__item one-line-hide"></div>'
						}else{
							ht += '<div class="weui-flex__item one-line-hide">'+list[i].orderSummary+'</div>'
						}
						ht += '</div>'
						ht += '<div class="pbox">发货时间：<span class="upload-task-time1">'+Format(list[i].createtime,formatTime)+'</span></div>'
						ht += '<div class="pbox">要求到货时间：<span class="upload-task-time2">'+Format(list[i].arrivaltime,formatTime)+'</span></div>'
						ht += '<div class="pbox">实际到货时间：<span class="upload-task-time2">'+Format(list[i].actualArrivalTime,formatTime)+'</span></div>'
						ht += '<div class="pbox">'
						ht += '<input class="source" type="hidden" value="'+list[i].type+'">'
						ht += '<input class="numOfReport" type="hidden" value="'+list[i].numOfREPORT+'">'
						ht += '<input class="totalTime" type="hidden" value="'+list[i].totalTime+'">'
						ht += '<input class="bindstatus" type="hidden" value="'+list[i].bindstatus+'">'
						ht += '<input class="delay" type="hidden" value="'+list[i].delay+'">'
						if (list[i].type == 1) {
							ht += '<span class="span-info">任务来自：<em class="color-mark">扫码</em></span>'
							ht += '<span class="span-info">已运送：<em class="color-mark">'+list[i].totalTime+'</em>天</span>'
							ht += '<span class="span-info">已定位：<em class="color-mark">'+list[i].numOfREPORT+'</em>次</span>'
							ht += '</div>'
							ht += '<a href="'+basePath+'weixin/ReceiptUp.html?wayBillId='+list[i].id+'" class="upload-task-link">上传回单</a>'
						}
						if (list[i].type == 2) {
							ht += '<span class="span-info">任务来自：<em class="color-mark">'+list[i].shareName+'</em></span>'
							ht += '<span class="span-info">总共运送：<em class="color-mark">'+list[i].totalTime+'</em>天</span>'
							ht += '<span class="span-info">总共定位：<em class="color-mark">'+list[i].numOfREPORT+'</em>次</span>'
							ht += '</div>'
							ht += '<a href="'+basePath+'weixin/ReceiptUp.html?wayBillId='+list[i].id+'&shareId='+list[i].shareid+'" class="upload-task-link">上传回单</a>'
						}
						if (list[i].delay == true) {
							ht += '<span class="upload-task-status status-delay color-red">已延迟</span>'
						}
						if (list[i].barcode.bindstatus == 20) {
							ht +='<span class="upload-task-status color-green">已绑定</span>'
						}
						if (list[i].barcode.bindstatus == 30) {
							ht +='<span class="upload-task-status color-blue">运输中</span>'				
						}
						if (list[i].barcode.bindstatus == 40) {
							ht +='<span class="upload-task-status color-gray">已完成</span>'
						}
						ht += '</div>'//日期里面内容循环在这结束
						ht += '</div>'
						ht += '</div>';
					}
					
				}
//					
			}else{
				ht +='<p style="text-align:center;">暂无数据。。。</p>';
			}
			$("#showData").html(ht);
		},
		error : function(data) {
//			alert("对不起，查询失败！");
		}
	});
	
}
function Format(now,mask)
{
if (now == null || now == undefined) {
	return "";
}
    var d = new Date(now);
    var zeroize = function (value, length)
    {
        if (!length) length = 2;
        value = String(value);
        for (var i = 0, zeros = ''; i < (length - value.length); i++)
        {
            zeros += '0';
        }
        return zeros + value;
    };
 
    return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0)
    {
        switch ($0)
        {
            case 'd': return d.getDate();
            case 'dd': return zeroize(d.getDate());
            case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
            case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
            case 'M': return d.getMonth() + 1;
            case 'MM': return zeroize(d.getMonth() + 1);
            case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
            case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
            case 'yy': return String(d.getFullYear()).substr(2);
            case 'yyyy': return d.getFullYear();
            case 'h': return d.getHours() % 12 || 12;
            case 'hh': return zeroize(d.getHours() % 12 || 12);
            case 'H': return d.getHours();
            case 'HH': return zeroize(d.getHours());
            case 'm': return d.getMinutes();
            case 'mm': return zeroize(d.getMinutes());
            case 's': return d.getSeconds();
            case 'ss': return zeroize(d.getSeconds());
            case 'l': return zeroize(d.getMilliseconds(), 3);
            case 'L': var m = d.getMilliseconds();
                if (m > 99) m = Math.round(m / 10);
                return zeroize(m);
            case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
            case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
            case 'Z': return d.toUTCString().match(/[A-Z]+$/);
            // Return quoted strings with the surrounding quotes removed
            default: return $0.substr(1, $0.length - 2);
        }
    });
};
