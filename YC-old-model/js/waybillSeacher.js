$(function () {
	var waybillID = $('#waybillId'),
		waybillTime = $('#waybillTime'),

		addBtn = $('.addGoods-btn'),
		delBtn = $('.addGoods-btn');

		function getwaybillSeacher () {
			var waybillIDValue = waybillID.val(),
				waybillTimeValue = waybillTime.val();
				database = {waybillID:waybillIDValue,waybillTime:waybillTimeValue};
			EasyAjax.ajax_post_Json({
				url: 'http://www.xxxx.com',
				data: database
			},
			function (data){
				page(data,'#waybillSearchTable','#showWaybillSeacher')
			});
		}
		getwaybillSeacher ();

		function initBtn () {
			alert(11)
			$('.operation-btns').each(function(i,a){
				$(a).hover(function(){
					$('.operation-btns').removeClass('layui-btn-warm');
					$(this).addClass('layui-btn-warm');
				})
			})
		}

		initBtn ();
})