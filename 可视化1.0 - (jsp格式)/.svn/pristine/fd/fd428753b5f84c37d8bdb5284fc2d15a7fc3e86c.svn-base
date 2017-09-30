$(function(){
	//列表
	pageWHeight();
	wrapWidth();
	$(window).resize(function(){
		pageWHeight();
		wrapWidth();
	});

	
	//切换页面
	$('.menu_a').click(function(){
		$('#iframe-main').attr('src',$(this).attr('link'));
		$('.menu_a').parent().removeClass('active');
		$(this).parent().addClass('active');
	})
	
	//跟踪页面，点击添加备注，弹出框
	$('.track-content .add-info').on('click',modelShow);
	
	//客户信息页面，点击按钮，出弹出框
//	$('.custom-content .add-edit').on('click',modelShow);
//	$('.custom-content .add-info').on('click',modelShow);
	
	//点击X关闭弹框
	$(".model-box .close").on('click',modelClose);
	
	//点击空白处关闭弹框
	$('.model').on('click',function(event){
		var $target = $(event.target);
		if($target.is('.model')){
			modelClose();
		}
	})

	//form表单宽

  
})

function pageWHeight(){
    var Wdocument=$(document).width();
    var Hdocument=$(document).height()-80;
    $('#navigation').height(Hdocument);
}
function modelClose(){
	$('.model').css('display','none');

}
function modelShow(){
	$('.model').css('display','block');
}
function wrapWidth(){
	var num = $('.content-search .labe_l').width();
	var min = $('.col-min').outerWidth()-num;
	var middle = $('.col-middle').outerWidth()-num;
	var max = $('.col-max').outerWidth()-num;
	$('.col-min .tex_t').css('width',min);
	$('.col-middle .tex_t').css('width',middle);
	$('.col-max .tex_t').css('width',max);
}

