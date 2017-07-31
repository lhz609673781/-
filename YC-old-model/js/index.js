//DOM渲染完成
$(function(){
	//侧边导航收缩
	function pullBack(){
		var $control=$(".control"),
		      $navBar=$("#navBar"),
		      $mainContent=$(".mainContent"),
		      $flag=true;
		$control.on("click",function(){
			if ($flag) {
				$navBar.addClass("active");
				$mainContent.addClass("active");
				$flag=false;
			}
			else{
				$navBar.removeClass("active");
				$mainContent.removeClass("active");
				$flag=true;
			}
		});
	};
	pullBack();
	//核心内容iframe框架切换
	function iframeTab(){
		var $a=$("#navBar a"),
			$mainContent=$(".mainContent");
		$a.on("click",function(){
			var $this=$(this),
			    $src=$this.attr("data-src");
			if ($this.hasClass("active")) {
				return false;
			}
			else{
				$a.removeClass("active");
				$this.addClass("active");
				if ($src) {
					var $iframe=$("<iframe frameborder='0'></iframe>");
					$iframe.attr("src",$src);
					$mainContent.html($iframe);	
				}
			}
		});
	};
	iframeTab();
	//展示用户昵称
	$(".username").html(nickName);
	//注销
	$(".logout").on("click",function () {
		easyCookie.del_login();
		window.location.reload();
	});
});