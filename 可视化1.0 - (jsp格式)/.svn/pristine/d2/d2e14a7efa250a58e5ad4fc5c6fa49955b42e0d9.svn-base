$(function() {
	FastClick.attach(document.body);
});
$('.weui-tabbar__item').click(function() {
	document.title = $(this).children('.weui-tabbar__label').html();
	if (document.title == '首页') {
		document.title = "二维码绑定";
	}
})

 //更多跳转
$('.aLink_more1').click(function() {
	window.location.href = 'waybill.html';
})

//全选
$('.input_all').click(function() {
	var $allcheck = $(this).find('.all_check');
	$allcheck[0].checked = !$allcheck[0].checked;
	if ($allcheck.is(':checked')) {
		$('.sin_check').prop("checked", true);
	} else {
		$('.sin_check').prop("checked", false);
	}

})

//单选
$('.position_list').delegate('.input_one', 'click', function() {
	var $sinCheck = $('.sin_check');
	var $input = $(this).find('.sin_check');
	$input[0].checked = !$input[0].checked;
	if($input.is(':checked')){
		$input.attr('checked',true);
	}else{
		$input.attr('checked',false);
	}

	if($sinCheck.filter(':checked').length == $sinCheck.length){
		$('.input_all>input').prop("checked", true);
	}else{
		$('.input_all>input').prop("checked", false);
	}
})

//更多跳转页面
$('.pt_more').click(function() {
	$('#more_form').submit();
})

function moreList(){
	var bind = $("#curIndex").val();
	var timedate = $('#timedate').val();
	var searchData = $('#searchData').val();
	var map = {};
	if(strValidate(bind)&&bind!=0){
		map['status']=bind;
	}
	if(strValidate(timedate)){
		map['createtime']=timedate;
	}
	if(strValidate(searchData)){
		map['searchData']=searchData;
	}else{
		map['searchData']='';
	}
	$('#searchParam').val(JSON.stringify(map));
	var param = $("#searchParam").val();
	strValidate(param);
}
//卸货功能	
function unload(waybillid,userid,path) {
	var url = path+'weixin/toUpload.html';
	var map = {};
	map['waybillid'] = waybillid;
	map['userid'] = userid;
	console.log(JSON.stringify(map));
	$.ajax({
				url : url, // 请求的url地址
				timeout : 5000,
				dataType : "json",
				data : "param=" + JSON.stringify(map), // 参数值
				type : "POST", // 请求方式
				success : function(data) {
					// 请求成功时处理
					if (data.resultCode == 200) {
						$.toast(data.reason);
						window.location.href = path+"weixin/myTask.html";
					} else {
						// 注册失败提示
						$.toast(data.reason);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$.toptip("网络异常，请求失败！");
				}
			});
}
//选项卡（//司机历史任务单条件搜索）
$('.itemTab').click(function() {
	$('.itemTab').eq($(this).index()).addClass("current").siblings().removeClass('current');
	var id=$(this).attr('id');
	var index=0;
	if(id=="way"){index=1}else if(id=="end"){index=2}else{index=0}
	$("#curIndex").val(index);
	setParam();
	$('#status_form').submit();
});
//司机历史任务单条件搜索
/*$('#searchClear').click(function(){
	setParam();
	$('#search_form').submit();
})*/

function setParam() {
	var bind = $("#curIndex").val();
	var timedate = $('#timedate').val();
	var map = {};
	if(strValidate(bind)&&bind!=0){
		map['status']=bind;
	}
	if(strValidate(timedate)){
		map['createtime']=timedate;
	}
	$('#param').val(JSON.stringify(map));
}

function strValidate(str){
	if(str!= undefined && str!=null && str!=''){
		return true;
	}else{
		return false;
	}
}
//任务单卸货
$('.barCode-list').delegate('.pl_out','click',function(){
	var createDateTime = $(this).attr('data-datetime');//获取司机首次扫码时间
	var dateTime = FormatDate(createDateTime);
	var beginDate = new Date(dateTime.replace(/\-/g,'/').replace('.0',''));
	var nowDate = new Date();
	var dateCompare=nowDate.getTime()-beginDate.getTime();  //时间差的毫秒数
	var days=Math.floor(dateCompare/(24*3600*1000))//计算出相差天数
	var leave=dateCompare%(24*3600*1000)    //计算天数后剩余的毫秒数
	var hours=Math.floor(leave/(3600*1000)) //计算出小时数
	/*不准删除此注释，以后要用
	 * if(days<1&&hours<1){
		//一小时内不准卸货
		$.toptip("该任务单暂不能卸货");
		return;
	}*/
	
	var waybillid = $(this).attr('data-waillId');
	var userid = $(this).attr('data-userId');
	var path = $(this).attr('data-path');
	$.confirm({
		title: '是否卸货',
		text: '',
		onOK: function () {
		    //点击确认
			unload(waybillid,userid,path)
		},
		onCancel: function () {
			//点击取消
		}
	});
})

//定位列表卸货
$('.position_list').delegate('.pl_out','click',function(){
	var createDateTime = $(this).attr('data-datetime');//获取司机首次扫码时间
	var dateTime = timeStamp2String(createDateTime);
	var beginDate = new Date(dateTime.replace(/\-/g,'/').replace('.0',''));
	var nowDate = new Date();
	var dateCompare=nowDate.getTime()-beginDate.getTime();  //时间差的毫秒数
	var days=Math.floor(dateCompare/(24*3600*1000))//计算出相差天数
	var leave=dateCompare%(24*3600*1000)    //计算天数后剩余的毫秒数
	var hours=Math.floor(leave/(3600*1000)) //计算出小时数
	/*不准删除此注释，以后要用
	 * if(days<1&&hours<1){
		//一小时内不准卸货
		$.toptip("该任务单暂不能卸货");
		return;
	}*/
	
	var waybillid = $(this).attr('data-waillId');
	var userid = $(this).attr('data-userId');
	var path = $(this).attr('data-path');
	$.confirm({
		title: '是否卸货',
		text: '',
		onOK: function () {
		    //点击确认
			unload(waybillid,userid,path)
		},
		onCancel: function () {
			//点击取消
		}
	});
})

//格式化日期
function FormatDate (strTime) {
    var date = new Date(strTime);
    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()
    				+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
}

//timestamp转换成datetime
function timeStamp2String(time){
     var datetime = new Date();
     datetime.setTime(time);
     var year = datetime.getFullYear();
     var month = datetime.getMonth() + 1;
     var date = datetime.getDate();
     var hours = datetime.getHours();
     var minutes = datetime.getMinutes();
     var seconds = datetime.getSeconds();
     return year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds;
};
