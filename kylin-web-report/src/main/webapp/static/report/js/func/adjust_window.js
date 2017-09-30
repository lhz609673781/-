/**
 * 调整销售额相关js方法.
 */


//按钮绑定和ajax提交修改销售额
$(function(){
	/* 分公司营业数据调整 */
	$("#button-ad").click(function(){    // 点击右上角关闭按钮,弹窗关闭
	  $("#base5").hide();
	});
	$("#down").click(function(){    // 点击向下箭头,弹窗延伸
	  $("#adjust-up").show();
	  $("#down").hide();
	 });
	$("#up").click(function(){     // 点击向上按钮,弹窗回缩
	  $("#down").show();
	  $("#adjust-up").hide();
	 });
	   
	   // 平台销售额调整时自动计算
	   $("#pt_adjust").blur(function() {
	   	var pt_sale = $("#pingtai_sale").html() * 1;// 平台销售额
	   	var st_sale = $("#shiti_sale").html() * 1;// 实体销售额
	   	var pt_adjust = $("#" + this.id).val() * 1;// 平台调整度
	   	var st_adjust = $("#st_adjust").val() * 1;// 实体调整度
	   	var pt_af_adjust = Math.round((pt_sale + pt_adjust)*10)/10;// 平台调整后销售额
	   	var st_af_adjust = Math.round((st_sale + st_adjust)*10)/10;// 实体调整后销售额
	   	
	   	// 页面数据
	   	$("#pingtai_af_adjust").html(pt_af_adjust);// 平台调整后-销售额
	   	$("#shiti_af_adjust").html(st_af_adjust);// 实体调整后-销售额
	   	$("#all_af_adjust").html(Math.round((pt_af_adjust + st_af_adjust)*10)/10);// 总的调整后-销售额
	   	$("#all_adjust").html(Math.round((pt_adjust + st_adjust)*10)/10);// 总的调整度
	   });

	   
	   // 实体销售额调整时自动计算
	   $("#st_adjust").blur(function() {
		var pt_sale = $("#pingtai_sale").html() * 1;// 平台销售额
	   	var st_sale = $("#shiti_sale").html() * 1;// 实体销售额
	   	var st_adjust = $("#" + this.id).val() * 1;// 实体调整度
	   	var pt_adjust = $("#pt_adjust").val() * 1;// 平台调整度
	   	var st_af_adjust = Math.round((st_sale + st_adjust)*10)/10;// 实体调整后销售额
	   	var pt_af_adjust = Math.round((pt_sale + pt_adjust)*10)/10;// 平台调整后销售额
	   			
	   	// 页面数据
	   	$("#pingtai_af_adjust").html(pt_af_adjust);// 平台调整后-销售额
	   	$("#shiti_af_adjust").html(st_af_adjust);// 实体调整后-销售额
	   	$("#all_af_adjust").html(Math.round((pt_af_adjust + st_af_adjust)*10)/10);// 总的调整后-销售额
	   	$("#all_adjust").html(Math.round((pt_adjust + st_adjust)*10)/10);// 总的调整度
	   });
	   
	   
	   // 保存调整后的平台和实体销售额
	   $("#button-ok").click(function(){
	   	var year = $("#year").val()*1;
	   	var month = $("#month").val()*1;
	   	var day = $("#day").val()*1;
	   	if(year>0&&month>0&&day>0){
	   		month = month>9?month+"":"0"+month;
	   		day = day>9?day+"":"0"+day;
	   		var saleDate = year+"-"+month+"-"+day;
	   		var pingtai_af_adjust = $("#pingtai_af_adjust").html()*1;
	   	   	var shiti_af_adjust = $("#shiti_af_adjust").html()*1;
	   	   	var pingtaiNum = pingtai_af_adjust;
	   	   	var shitiNum = shiti_af_adjust;
	   	   	var st_adjust = $("#st_adjust").val() * 1;// 实体调整度
	   	   	var pt_adjust = $("#pt_adjust").val() * 1;// 平台调整度
	   	   	var groupName = $("#fengsi_name").html();
	   	   	var oldPingtai = $("#pingtai_sale").html() * 1
	   	   	var oldShiti = $("#shiti_sale").html() * 1;
	   	   	var oldSale = $("#all_sale").html() * 1;
	   	   	if(shiti_af_adjust==0&&pingtai_af_adjust==0){
	   	   		alert("未调整的数据不能提交");
	   	   		return false;
	   	   	}
	   	   	if(!confirm("确定要修改营销数据吗？")){
	   	   		return false;
	   	   	}
		   	 $.ajax({
		 		url:basePath+'branchData/adjustSale.do',
		 		type:"POST",
		 		dataType:"json",
		 		data:{"pingtaiNum":pingtaiNum,"shitiNum":shitiNum,"groupName":groupName,"saleDate":saleDate,"oldPingtaiNum":oldPingtai,"oldShitiNum":oldShiti,"adjustPingtaiNum":pt_adjust,"adjustShitiNum":st_adjust,"oldSale":oldSale},
		 		success:function succ(data){
		 			var mas = data.mas;
					if (mas=="success") {
						alert("调整成功！");
						$("#base5").hide();
						searchAndAdjust();
					}
		 		},
		 		error:function err(data){
		 			if(data.mas){
		 				alert("对不起，调整失败！"+data.mas);
		 			}else{
		 				alert("对不起，调整失败！");
		 			}
		 			
		 		}
		 	});
	   	}else{
	   		alert("年月日信息不全，不能修改销售额！");
	   	}
	   });
});


// 销售额调整弹出框信息设置
function adjustWindow(saleDate,oldPingtaiSale,oldShitiSale,currPingtaiSale,currShitiSale,adjustPingtaiSale,adjustShitiSale,groupName,createTime,userName,oldSale) {
	$("#pingtai_af_adjust").html("");
	$("#shiti_af_adjust").html("");
	$("#all_af_adjust").html("");
	$("#all_adjust").html("");
	$("#st_adjust").val("");
	$("#pt_adjust").val("");

	$("#fengsi_name").html(groupName);
	$("#pingtai_sale").html(oldPingtaiSale);
	$("#shiti_sale").html(oldShitiSale);
	$("#all_sale").html(oldSale);

	if (saleDate && saleDate != '' &&saleDate.length>8) {
		$("#new-date").html(saleDate);
		$("#name-chen").html(userName);
		$("#shu-two").html(adjustPingtaiSale>=0?'+'+adjustPingtaiSale:''+adjustPingtaiSale);
		$("#shu").html(adjustShitiSale>=0?'+'+adjustShitiSale:''+adjustShitiSale);
		$("#pt_sale_rd").html(oldPingtaiSale);
		$("#st_sale_rd").html(oldShitiSale);
		$("#st_af_sale_rd").html(currShitiSale);
		$("#pt_af_sale_rd").html(currPingtaiSale);
		$("#time").html(createTime);
		$("#record").show();
	} else {
		$("#record").hide();
	}
	$("#base5").show();
}


/**
 * 调整额度权限的底部查询ajax.
 */
function searchAndAdjust(){
	var seayear = parseInt($("#year").val());
	var seamonth = parseInt($("#month").val());
	var seaweek = parseInt($("#week").val());
	var seaday = parseInt($("#day").val());
	var datemodel = {year:seayear,month:seamonth,week:seaweek,day:seaday};
	if (seaday!=-1 && seamonth==-1) {
		alert("请选择月份！");
	}else{
		$.ajax({
			url:basePath+'branchData/searchfilialeachievement.do',
			type:"POST",
			contentType:"application/json",
			dataType:"json",
			data:JSON.stringify(datemodel),
			success:function suc(map){
				var mas = map.mas;
				if (mas=="success") {
					var resultsSummaryls = map.resultsSummaryls;
					if (resultsSummaryls.length>0) {
						var sumsalesIndicators = 0;
						var sumdifference = 0;
						var sumcompletion = 0;
						var sumsales = 0;
						var oldSaleTitle = "";// 原数据
						var adjustSaleTitle = "";// 调整额
						if(seayear>0&&seamonth>0&&seaday>0){
							oldSaleTitle = '<th width="13%"><span class="rstitle"></span>原数据</th>';
							adjustSaleTitle = '<th width="13%"><span class="rstitle"></span>调整额</th>';
						}
						var ht='<table><caption><span id="seadate"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="seaindex"></span></caption><thead>'
						+'<tr>'
							+'<th width="5%">排名</th>'
							+'<th width="18%">分公司名称</th>'
							+'<th width="13%"><span class="rstitle"></span>销售指标</th>'
							+ oldSaleTitle
							+ adjustSaleTitle
							+'<th width="13%"><span class="rstitle"></span>销售额</th>'
							+'<th width="13%"><span class="rstitle"></span>差额</th>'
							+'<th width="13%"><span class="rstitle"></span>完成率</th>'
							+'</tr></thead><tbody>';
						var j = resultsSummaryls.length;
						for (var i = 0; i < j; i++) {
								var saleDate='',createTime='',operatorName='',pingtaiNum=0,shitiNum=0,oldPingtaiNum=0,oldShitiNum=0,adjustPingtai=0,adjustShiti=0,companyName='',oldSale=0;
								if(resultsSummaryls[i].model){
									saleDate = resultsSummaryls[i].model.saleDate;
									createTime = resultsSummaryls[i].model.createTime;
									operatorName = resultsSummaryls[i].model.operatorName;
									oldPingtaiNum = resultsSummaryls[i].model.oldPingtaiNum;
									oldShitiNum = resultsSummaryls[i].model.oldShitiNum;
									adjustPingtai = resultsSummaryls[i].model.adjustPingtaiNum;
									adjustShiti = resultsSummaryls[i].model.adjustShitiNum;
								}
								oldSale = resultsSummaryls[i].oldSale;
								oldPingtaiNum = resultsSummaryls[i].oldPingtaiSale;
								oldShitiNum = resultsSummaryls[i].oldShitiSale;
								pingtaiNum = resultsSummaryls[i].pingtaiSale;
								shitiNum = resultsSummaryls[i].shitiSale;
								companyName =  resultsSummaryls[i].divisionName;
								var adjustSaleValue = "";// 调整按钮
								var oldSaleVale = "";
								if(seayear>0&&seamonth>0&&seaday>0){
									adjustSaleValue = '<td class="add-color">'+(Math.round((resultsSummaryls[i].pingtaiAdjust+resultsSummaryls[i].shitiAdjust)*10)/10)+'&nbsp;&nbsp;&nbsp;&nbsp;'
									+'<a href="javascript:adjustWindow('
									+'\''+saleDate+'\',\''+oldPingtaiNum+'\',\''+oldShitiNum+'\',\''+pingtaiNum+'\',\''+shitiNum+'\',\''
									+ adjustPingtai+'\',\''+adjustShiti+'\',\''+companyName+'\',\''+createTime+'\',\''+operatorName+'\',\''+oldSale
									+'\');"><img id="image-sheet" src="'+staticPath+'/images/pon_03.png"/></a></td>';
									oldSaleVale = '<td>'+oldSale.toFixed(0)+'</td>';
								}
								
								ht+='<tr>'
									+'<td>'+(i+1)+'</td>'
									+'<td>'+resultsSummaryls[i].divisionName+'</td>'
									+'<td>'+resultsSummaryls[i].salesIndicators.toFixed(0)+'</td>'
									+oldSaleVale
									+adjustSaleValue
									+'<td>'+resultsSummaryls[i].sales.toFixed(0)*1+'</td>'
									+'<td>'+resultsSummaryls[i].difference.toFixed(0)+'</td>'
									+'<td>'+(resultsSummaryls[i].completion*100).toFixed(0)+'%</td>'
									+'</tr>'
								sumsalesIndicators += resultsSummaryls[i].salesIndicators;
								sumdifference += resultsSummaryls[i].difference;
								sumsales += resultsSummaryls[i].sales;
//								sumcompletion += resultsSummaryls[i].completion;
						}		
						ht += '</tbody></table>';
						$("#company-info").html(ht);
						$("#seaindex").html("销售业绩汇总：销售指标共计"+sumsalesIndicators.toFixed(0)+"，共计差额"+sumdifference.toFixed(0)+"，共计完成"+(sumsales/sumsalesIndicators*100).toFixed(0)+"%");
						if (seamonth==-1) {
							$("#seadate").html(""+seayear+"年1月1日-"+seayear+"年12月31日");
							$(".rstitle").html(""+seayear+"年");
						}else if (seaweek==-1) {
							var days = getDay(seayear,seamonth);
// if (seamonth==month) {
// days = day - 1;
// }
							$("#seadate").html(""+seayear+"年"+seamonth+"月1日-"+seayear+"年"+seamonth+"月"+days+"日");
							$(".rstitle").html(""+seamonth+"月");
						}else if(seaday==-1){
							if (seaweek==1) {
								$("#seadate").html(""+seayear+"年"+seamonth+"月1日-"+seayear+"年"+seamonth+"月7日");
								$(".rstitle").html("第一周");
							}else if(seaweek==2){
								$("#seadate").html(""+seayear+"年"+seamonth+"月8日-"+seayear+"年"+seamonth+"月14日");
								$(".rstitle").html("第二周");
							}else if(seaweek==3){
								$("#seadate").html(""+seayear+"年"+seamonth+"月15日-"+seayear+"年"+seamonth+"月21日");
								$(".rstitle").html("第三周");
							}else{
								var days = getDay(seayear,seamonth);
								$("#seadate").html(""+seayear+"年"+seamonth+"月22日-"+seayear+"年"+seamonth+"月"+days+"日");
								$(".rstitle").html("第四周");
								
							}
						}else{
							$("#seadate").html(""+seayear+"年"+seamonth+"月"+seaday+"日-"+seayear+"年"+seamonth+"月"+seaday+"日");
							$(".rstitle").html(""+seaday+"日");
						}
					}else{
						alert("对不起，查询失败");
					}
				}else if(mas=="error"){
					alert("对不起，查询失败");
		    	}else if(mas=="unlogin"){
		    		window.parent.location.href=basePath+"view/login.jsp";
		    	}else {
		    		window.location.href=basePath+"view/error.jsp";
				}
			},
			error:function err(map){
				alert("对不起，查询失败");
			}
		});
	}
}