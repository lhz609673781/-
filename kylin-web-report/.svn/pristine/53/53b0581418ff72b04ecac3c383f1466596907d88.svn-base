function leading() {
	var file =$("#text-b").val();
	var extStart = file.lastIndexOf(".");
    var ext = file.substring(extStart, file.length).toUpperCase();
	if(ext==".XLS"){
		var map = {};
		//var myForm = $('#departAndCustomLeading');
		var formdata = new FormData();
		formdata.append('file', $('#text-b')[0].files[0]);
//		formdata.append('params', JSON.stringify(map));
		$.ajax({
			url : basePath + "divisionManage/cognateCusLeading.do",
			type: 'POST',
		    cache: false,
		    data: formdata,
		    processData: false,
		    contentType: false,
		    success : function(json) {
				var mas = json.mas;
		    	if(mas=="success"){
		    		alert("导入成功！");
		    		//getCompany();
		    	}else if(mas=="error"){
		    		alert("导入失败！");
		    	}else if(mas=="login"){
		    		window.location.href=basePath+"view/login.jsp";
		    	}else{
		    		alert(mas);
		    	}
			},
			error : function(data) {
				alert("连接失败！");
			}
		});
	}else{
		alert("文件类型错误，必须是以xls文件");
	}
}

function searchdivis(currPage){
	var pageing = $("#pageing").val().trim();
	if (currPage==0 && pageing != "") {
		currPage = pageing;
	}
	var pageSize = $("#kuang").val();
	$.ajax({
		url : basePath + "divisionManage/cognateCustSearch.do",
		type : 'POST',
		data : {
			customerName:$("#customerName").val(),
			bindDivision:$("#bindDivision").val(),
			customerType:$("#customerType").val(),
			pageSize:pageSize,
			currPage:currPage
		},
		success : function(map) {
			var mas = map.mas;
			if (mas=="success") {
				var page = map.page;
				var bctList = page.list;
				if (bctList.length>0) {
					$("#bctList").html("");
					var ht="";
					ht+='<thead><tr><th width="10%">序号</th><th width="13%">事业部</th><th width="27%">客户名称</th><th width="10%">客户类别</th><th width="15%">客户代码</th><th width="15%">客户所属分公司</th></tr></thead><tbody>';
					for (var i = 0; i < bctList.length; i++) {
						ht+='<tr><td>'+(i+1)+'</td>';
						if (bctList[i].bindDivision == undefined || bctList[i].bindDivision == null) {
							bctList[i].bindDivision = "";
						}
						ht+='<td><form action="'+basePath+'divisionManage/findDivision.do" id="from'+i+'" method="post"><input type="hidden" name="bindDivision" value="'+bctList[i].bindDivision+'"/></form><a href="#" onclick="finddivis('+i+');">'+bctList[i].bindDivision+'</a></td>';
						ht+='<td>'+bctList[i].customerName+'</td>';
						if (bctList[i].customerType == 'not_platform') {
							ht+='<td>非平台</td>';
						}
						if (bctList[i].customerType == 'platform') {
							ht+='<td>平台</td>';
						}
						ht+='<td>'+bctList[i].clientCode+'</td>';
						if (bctList[i].computerName == undefined || bctList[i].computerName == null) {
							bctList[i].computerName = "";
						}
						ht+='<td>'+bctList[i].computerName+'</td></tr>';
					}
					ht+="</tbody>";
					$("#bctList").html(ht);
				}else{
					$("#bctList").html("<tr><td>对不起，没有符合条件的数据</td></tr>");
				}
				var htm = "";
				htm +='<p>共计：'+page.totalRecords+'条 &nbsp;&nbsp;&nbsp;每页显示';
				htm +='<select name="" id="kuang" class="kuang" onchange="searchdivis('+page.pageNo+')">';
					htm +='<option value="10">10</option>';
					htm +='<option value="20">20</option>';
					htm +='<option value="30">30</option>';
					htm +='</select>条&nbsp;&nbsp;&nbsp<span id="list"><span>';
					htm +='<a onclick="searchdivis(1);" class="pointer">首页</a>';
					htm +='<input class="pointer" type="button" value="&lt" onclick="searchdivis('+page.previousPageNo+');"/>';
					htm +='<strong>当前页为：'+page.pageNo+'</strong>';
					htm +='<input class="pointer" type="button" value="&gt" onclick="searchdivis('+page.nextPageNo+');" />';
					htm +='<a class="pointer" onclick="searchdivis('+page.totalPages+')">末页</a></span></span>';
					htm +='到第<input class="kuang" id="pageing" value="">页&nbsp;&nbsp;&nbsp;';
					htm +='<button id="confim" onclick="searchdivis(0);">跳转</button>&nbsp;&nbsp;&nbsp;共计：'+page.totalPages+'页</p>';
					$("#paging").html(htm);
					$("#kuang").val(page.pageSize);
			}else if(mas=="lost"){
				alert("对不起，查询失败");
			}else if(mas=="error"){
				alert("对不起，查询失败");
	    	}else if(mas=="login"){
	    		window.parent.location.href=basePath+"view/index.jsp";
	    	}else {
	    		window.location.href=basePath+"view/error.jsp";
			}
		},
		error : function(data) {
			alert("对不起，查询失败！");
		}
	});
}

function addDivisionManage(){
	$("#diviHasExist").html("");
	$("#hasOtherExistRef").html("");
	$("#customerNotExist").html("");
	var textname = $("#text-name").val().trim();
	var inquiry = $("#inquiry").val().trim();
	if (!vidate(textname)) {
		$("#result-text").attr("style","color:red");
		$("#diviHasExist").html("事业部名称不能为空");
		return;
	}
	if (!vidate(inquiry)) {
		$("#result-text").attr("style","color:red");
		$("#diviHasExist").html("客户编码不能为空");
		return;
	}
	var bac = {clientCode:inquiry,bindDivision:textname};
	$.ajax({
			url : basePath + "divisionManage/addDivision.do",
			type : 'POST',
			contentType:"application/json",
			dataType:"json",
			data:JSON.stringify(bac),
			success : function(map) {
				var mas = map.mas;
				if (mas=="success") {
					$("#result-text").attr("style","color:green");
					$("#diviHasExist").html("增加事业部成功！");
				}else if (mas=="other") {
					var resutl = map.divisionReason;
					if (resutl != null && resutl != undefined) {
						$("#result-text").attr("style","color:green");
						$("#diviHasExist").html("增加事业部成功！"+resutl.focusMultiCustomer+"您可以到编辑事业部修改");
					}else{
						$("#result-text").attr("style","color:red");
						$("#diviHasExist").html("对不起，新增异常");
					}
				}else if (mas=="fail") {
					var resutl = map.divisionReason;
					if (resutl != null && resutl != undefined) {
						if (vidate(resutl.hasOtherExistRef)) {
							$("#hasOtherExistRef").html(resutl.hasOtherExistRef+"，剩余编码已添加成功。");
						}
						if (vidate(resutl.customerNotExist)) {
							$("#result-text").attr("style","color:red");
							$("#customerNotExist").html(resutl.customerNotExist+"无对应客户，请重新输入");
						}
					}else{
						$("#result-text").attr("style","color:red");
						$("#diviHasExist").html("对不起，新增异常");
					}
				}else if(mas=="error"){
					$("#result-text").attr("style","color:red");
					$("#diviHasExist").html("对不起，增加事业部失败");
		    	}
			},
			error : function(data) {
				$("#result-text").attr("style","color:red");
				$("#diviHasExist").html("对不起，增加事业部失败");
			}
		});	
}

function vidate(obj) {
	if (obj == "" || obj == null || obj == undefined) {
		return false;
	}
	return true;
}
//function setfilename(){
//	var file =$("#pic").val();
//	$("#text-b").val(file);
//}
function downmodel(){
	$("#model-lo").submit();
}

function finddivis(index){
	$("#from"+index+"").submit();
}