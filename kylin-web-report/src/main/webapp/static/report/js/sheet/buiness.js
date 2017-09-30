function editdivis(){
	var bindDivisiontext = $("#text-syb").val();
	if (!vidate(bindDivisiontext)) {
		alert("事业部名称不能为空");
		return;
	}
	var bndCusTomerAndDivisionModel = [];
	var i = 0;
//	var page = $('tbody tr').length;
	$('tbody tr').each(function() {
//		alert($(this).find('input')[1].value);
//		alert($(this).find('td')[1].innerHTML);
		bndCusTomerAndDivisionModel[i] = {customerType:$(this).find('input')[2].value,customerIdGroupId:$(this).find('input')[0].value,customerId:$(this).find('input')[1].value,customerName:$(this).find('td')[1].innerHTML,clientCode:$(this).find('td')[3].innerHTML,bindDivision:bindDivisiontext,computerName:$(this).find('td')[4].innerHTML};
		i++;
	})
//	alert(listbind[i].computerName);
//	return;
	$.ajax({
		url : basePath + "divisionManage/editDivision.do",
		type : 'POST',
		contentType:"application/json",
		dataType:"json",
		data:JSON.stringify({list:bndCusTomerAndDivisionModel,name:olddisname}),
		success : function(map) {
			var mas = map.mas;
			if (mas=="success") {
				var resutl = map.divisionReason;
				if (resutl != null && resutl != undefined) {
					if (vidate(resutl.hasOtherExistRef)) {
						alert(resutl.hasOtherExistRef+"这些客户编码已经与其他事业部存在关联");
					}
					if (vidate(resutl.customerNotExist)) {
						alert(resutl.customerNotExist+"无对应客户，请重新输入");
					}
					if (vidate(resutl.focusMultiCustomer)) {
						alert("修改成功！"+focusMultiCustomer);
					}
				}else{
					alert("修改成功！");
					window.location.href= basePath+"divisionManage/findDivision.do?bindDivision="+encodeURI(encodeURI($("#text-syb").val()));
				}
			}else if(mas=="error"){
				var info = map.info;
				if (info != null && info != undefined) {
					alert(info);
				}else{
					alert("对不起，修改失败！");
				}
				
			}
		},
		error : function(data) {
			alert("修改失败");
		}
	});
	
}
function vidate(obj) {
	if (obj == "" || obj == null || obj == undefined) {
		return false;
	}
	return true;
}