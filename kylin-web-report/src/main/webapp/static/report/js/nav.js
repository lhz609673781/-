$(function(){
	//列表
	pageControl();
	$(window).resize(function(){
		pageControl();
	});
	toggleMenu();
	selectChange();
	navHandler ();
	$('.admin').find("a").attr('href','http://172.16.251.253/user/logout.do');
	//$('.admin').find("a").attr('href','http://172.16.255.28:8080/kylin-web-report/user/logout.do');
})
function navHandler () {
	var url = window.location.href;
	var idOld = url.split('navId=');
	var arrId = idOld[idOld.length-1];
	var targetArr = arrId.split('#');
	var targetId = targetArr[0];
	$('.subtitle[navId='+targetId+']').addClass('selected');
	$('.subtitle[navId='+targetId+']').parent('.sub-menu').show();
	$('.subtitle[navId='+targetId+']').parents('.parent-li').addClass('selected');
	$('.subtitle').each(function(i,a){
		$(a).hover(function(){
			$('.subtitle').removeClass('selected');
			$('.subtitle[navId='+targetId+']').addClass('selected');
			$(this).addClass('selected');
		},function(){
			$(this).removeClass('selected');
		})
	})
}


function pageControl(){
	    var Wdocument=$(window).width();
	    var Hdocument=$(window).height();
	    $('#navigation').height(Hdocument);
}
function toggleMenu(){
	$('.parent-li .parent-menu').click(function(){
		var $li = $(this).parent();
		var $selected = $li.hasClass('selected');
		if($selected){
			$li.removeClass('selected');
			$li.find('.sub-menu').stop().slideUp();
		}else{
			$li.addClass('selected').siblings().removeClass('selected');
			$li.find('.sub-menu').stop().slideDown();
			$li.siblings().find('.sub-menu').stop().slideUp();
		}

    })
}
function selectChange(){
   $(".sel select").on('change',function(){
   		var $selectText = $(this).children("option:selected").text();
        $(this).parent().find(".cur-select").text($selectText);
   })
}
$(document).ready(function(){
	/*新建事业部*/
  $(".depart-add").click(function(){
  $("#base2").show();
  $("#pop-big").show();
  });
  $("#radius-b").click(function(){
  $("#pop-big").hide();
  $("#base2").hide();
  });
  $("#bottom-b").click(function(){
//  $("#pop-big").hide();
//  $("#base2").hide();
  });

/*导入*/
  $(".import").click(function(){
  $("#base3").show();
  $("#pop-small").show();
  });
  $("#radius-s").click(function(){
  $("#pop-small").hide();
  $("#base3").hide();
  });
  $("#bottom-s").click(function(){
  $("#pop-small").hide();
  $("#base3").hide();
  });
  
  
   /*****
    * 
    * 编辑
    * 
    * ****/ 
   /*编辑start*/
   $('.delete').click(function() {
	var num = $('tbody tr').length;
	if (num<2) {
		$("#base4").show();
		$("#remove").show();
		$("#buininfo").html("请至少保留一个客户");
		return;
	}
   	var textname = $("#text-syb").val().trim();
   	var custname = $(this).parent().parent().find('td')[1].innerHTML;
   	if (!vidate(textname)) {
   		alert("事业部不能为空");
   		return;
   	}
   	var thistd = $(this);
   	$("#base4").show();
   	$("#disappear").show();
   	$("#delcust").html(custname);
   	$("#deldivis").html(textname);
   	$('#add-car').click(function() {
   		thistd.parent().parent().remove();
   		$('tbody tr').each(function() {
   			var target = $(this).find('td')[0];
   			$(target).html($(this).prevAll('tr').length + 1)
   		})
   		$("#base4").hide();
   		$("#disappear").hide();	
   	})
   }); 
   $('#add-appear').click(function() {
   	$("#base4").hide();
   	$("#disappear").hide();
   });

   /***
    * 点击添加客户（验证客户）
    * **/
   $("#add-c").click(function(){
   	var textname = $("#text-syb").val().trim();
   	var inquiry = $("#text-bm").val().trim();
   	if (!vidate(textname)) {
   		alert("事业部不能为空");
   		return;
   	}
   	if (!vidate(inquiry)) {
   		alert("客户编码不能为空");
   		return;
   	}
   	var bl = false;
   	$('tbody tr').each(function() {
   		var target = $(this).find('td')[3];
   		if (inquiry==target.innerHTML) {
   			$("#base4").show();
  			$("#remove").show();
   			$("#buininfo").html("您输入的编码已和当前事业部（"+textname+"）绑定，请重新输入");
   			bl = true;
   		}
   	})
   	if (bl) {
   		return;
   	}
   	var bac = {clientCode:inquiry,bindDivision:textname};
   	$.ajax({
   		url : basePath + "divisionManage/validatCust.do",
   		type : 'POST',
   		contentType:"application/json",
   		dataType:"json",
   		data:JSON.stringify(bac),
   		success : function(map) {
   			var mas = map.mas;
   			if (mas=="success" || mas=="other") {
   				if(mas=="other"){
   	   				var resutl = map.pm.obj;
   	   				$("#base4").show();
   	   				$("#remove").show();
   	   				if (resutl != null && resutl != undefined) {
   	   					$("#buininfo").html(resutl.focusMultiCustomer+"，请您谨慎编辑");
   	   				}else{
   	   					alert("查询异常");
   	   					return;
   	   				}
   				}
   				var list = map.pm.list;
   				for (var i = 0; i < list.length; i++) {
   					var num = $('tbody tr').length + 1;
   					var number = num-1;
   					var ht = '<tr>';
   					ht += '<input id="customerIdGroupId'+number+'" type="hidden" name="customerIdGroupId" value="'+list[i].customerIdGroupId+'"/>';
                  		ht += '<input id="customerId'+number+'" type="hidden" name="customerId" value="'+list[i].customerId+'"/>';
                  		ht += '<input id="customerType'+number+'" type="hidden" name="customerType" value="'+list[i].customerType+'"/>';
   					ht += '<td>'+ num + '</td><td name="customerName" id="customerName'+number+'">'+list[i].customerName+'</td>';
   					if (list[i].customerType == 'not_platform') {
   						ht+= '<td>非平台</td>';
   					}
   					if(list[i].customerType == 'platform'){
   						ht+= '<td>平台</td>';
   					}
   					ht+= '<td name="clientCode" id="clientCode'+number+'">'+list[i].clientCode+'</td><td name="computerName" id="computerName'+number+'">'+list[i].computerName+'</td><td><a class="delete" id="delete-y" href="javascript:;"><img src="'+staticPath+'images/der_03.png"></a></td></tr>';
   					$('tbody').append(ht);
   				}
   				//绑定delete事件
   				$('.delete').click(function() {
   					var num = $('tbody tr').length;
   					if (num<2) {
   						$("#base4").show();
   		   				$("#remove").show();
   						$("#buininfo").html("请至少保留一个客户");
   						return;
					}
   					var textname = $("#text-syb").val().trim();
   					var custname = $(this).parent().parent().find('td')[1].innerHTML;
   					if (!vidate(textname)) {
   						alert("事业部不能为空");
   						return;
   					}
   					var thistd = $(this);
   					$("#base4").show();
   					$("#disappear").show();
   					$("#delcust").html(custname);
   					$("#deldivis").html(textname);
   					$('#add-car').click(function() {
   						thistd.parent().parent().remove();
   						$('tbody tr').each(function() {
   							var target = $(this).find('td')[0];
   							$(target).html($(this).prevAll('tr').length + 1)
   						})
   						$("#base4").hide();
   						$("#disappear").hide();	
   					})
   				});
   			}else if(mas=="fail"){
   				var resutl = map.pm.obj;
   				$("#base4").show();
   				$("#remove").show();
   				if (resutl != null && resutl != undefined) {
   					if (vidate(resutl.hasOtherExistRef)) {
   						$("#buininfo").html(resutl.hasOtherExistRef);
   					}
   					if (vidate(resutl.customerNotExist)) {
   						$("#buininfo").html(resutl.customerNotExist+"无对应客户，请重新输入");
   					}
   					
   				}else{
   					alert("查询异常");
   				}
   			}
   		},
   		error : function(data) {
   			alert("客户查询失败");
   		}
   	});
   }); 
   $("#add").click(function(){
    $("#base4").hide();
    $("#remove").hide();
   }); 
   //$("#button-c1").click(function(){
   //// $("#base4").show();
   //// $("#confirm").show();
//   	$("#fromedit").submit();
   //}); 
   $("#button-career").click(function(){
    $("#confirm").hide();
    $("#base4").hide();
    });

   });
   /*编辑end*/
function vidate(obj) {
	if (obj == "" || obj == null || obj == undefined) {
		return false;
	}
	return true;
}
