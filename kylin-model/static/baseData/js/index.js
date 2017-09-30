//行信息基础数据
var id = "",
      index = "",
      dataDetail = {};

//treeGrid基础配置
var config = {
	id: "tg",
	width: "100%",
	renderTo: "arborescence_table",
	headerAlign: "left",
	headerHeight: "30",
	dataAlign: "left",
	indentation: "20",
	folderColumnIndex: "1",
	folderOpenIcon: "img/xia.png",
	folderCloseIcon: "img/zhan.png",
	defaultLeafIcon: "img/zhan.png",
	hoverRowBackground: "true",
	itemClick: "itemClickEvent",
	columns:[
		{headerText: "", headerAlign: "center", dataAlign: "center", width: "1", handler: "customCheckBox"},
		{headerText: "数据", dataField: "name", headerAlign: "center", dataAlign: "left",  width: "100"},
		{headerText: "数据编码", dataField: "code", headerAlign: "center", dataAlign: "center", width: "100"},
		{headerText: "操作", headerAlign: "center", dataAlign: "center", width: "40", handler: "customLook"}
	],
	data:[]
};

/*
	单击数据行后触发该事件
	id：行的id
	index：行的索引。
	data：json格式的行数据对象。
*/
function itemClickEvent(id, index, data){
	jQuery("#currentRow").val(id + ", " + index + ", " + TreeGrid.json2str(data));
	id = id;
	index = index;
	dataDetail = data;
}
	
/*
	通过指定的方法来自定义栏数据
*/
function customCheckBox(row, col){
	return "";
}

function customLook(row, col){
	return "<button class='btn btn-primary btn-1m1 editBtn' style='margin-left:5px;background:green;bolder:none;'  data-toggle='modal' data-target='#myModEdit'>修改</button><button class='btn btn-primary btn-1m1 delBtn' style='margin-left:5px;background:red;bolder:none;' data-toggle='modal' data-target=''>删除</button>";
}

//DOM结构渲染完成
$(function(){
	//初始化树形结构
	EasyAjax.ajax_Post_Json({
            	url: "basic/data/api/manage",
            	data: {}
            },
            function (data) {
            	$.each(data.page,function(index,ele){
        			ele.name = ele.dataValue;
        			ele.code = ele.dataCode;
        			ele.children = ele.list;
        			delete ele.dataValue;
        			delete ele.dataCode;
        			delete ele.list;
        			if (ele.children.length > 0) {
        				$.each(ele.children,function(index,ele){
        					ele.name = ele.dataValue;
		        			ele.code = ele.dataCode;
		        			ele.children = ele.list;
		        			delete ele.dataValue;
		        			delete ele.dataCode;
		        			delete ele.list;
		        			if (ele.children.length > 0) {
		        				$.each(ele.children,function(index,ele){
		        					ele.name = ele.dataValue;
				        			ele.code = ele.dataCode;
				        			ele.children = ele.list;
				        			delete ele.dataValue;
				        			delete ele.dataCode;
				        			delete ele.list;
		        				});
		        			}
        				});
        			}
            	});
            	config.data = data.page;
	var treeGrid = new TreeGrid(config);
	treeGrid.show();
	treeGrid.expandAll("N");
	$("#arborescence_table tr").attr("open","N");
	$("#arborescence_table tr").each(function(index,ele){
		$(this).find("td:first").hide();
	})
            });

	//新增节点
	$("#addTypeBtn").bind("click",function(){
		if (dataDetail.dataLevel) {
			if (dataDetail.dataLevel < 3) {
				if (dataDetail.dataLevel == 1) {
					$("#modal-header-title").html("新增二级类型");
				}else{
					$("#modal-header-title").html("新增三级类型");
				}
				EasyAjax.ajax_Post_Json({
			            	url: "basic/data/api/createCode",
			            	data: {
			            		parentId:dataDetail.id
			            	}
			            },
			            function (data) {
			            	var $addTplCodePrefix = data.basicData.dataCode.substring(0,data.basicData.dataCode.length - 3),
			            	      $addTplCodeSuffix = data.basicData.dataCode.substring(data.basicData.dataCode.length - 3);
			            	$("#addTplType").val(dataDetail.name + " " + dataDetail.code);
			            	$("#addTplCodePrefix").html($addTplCodePrefix);
			            	$("#addTplCodeSuffix").val($addTplCodeSuffix);
			            	$("#addTplCodeSuffix").css("textIndent",$("#addTplCodePrefix").html().length*7 - 7);
			            });
			}else{
				layer.msg("不支持给子类添加类型！");
				return false;
			}
		}else{
			layer.msg("请先选择您要添加类型的父类型！");
			return false;
		}
	});

	//保存新增节点
	$("#saveBtn").bind("click",function(){
		if ($("#addTplCodeSuffix").val().length == 3) {
			if ($("#addTplName").val()) {
				var baseValue = {dataCode:$("#addTplCodePrefix").html() + $("#addTplCodeSuffix").val(),dataValue:$("#addTplName").val().trim(),parentId:parseInt(dataDetail.id)};
				EasyAjax.ajax_Post_Json({
			            	url: "basic/data/api/insert/save",
			            	contentType:"application/json",
			            	data: JSON.stringify(baseValue)
			            },
			            function (data) {
			            	layer.msg("添加成功！");
			            	window.location.reload();
			            });
			}else{
				layer.msg("请输入数据名称！");
			}
		}else{
			layer.msg("请输入3位字符或数字组成的编码！");
		}
	});

	//新增根节点
	$("#addRootTypeBtn").bind("click",function(){
		EasyAjax.ajax_Post_Json({
	            	url: "basic/data/api/createCode",
	            	data: {
	            		parentId:""
	            	}
	            },
	            function (data) {
	            	$("#addRootTplCodeSuffix").val(data.basicData.dataCode);
	            });
	});

	//保存新增根节点
	$("#saveRootBtn").bind("click",function(){
		if ($("#addRootTplCodeSuffix").val().length == 3) {
			if ($("#addRootTplName").val()) {
				var baseValue = {dataCode:$("#addRootTplCodeSuffix").val(),dataValue:$("#addRootTplName").val().trim(),parentId:""}
				EasyAjax.ajax_Post_Json({
			            	url: "basic/data/api/insert/save",
			            	contentType:"application/json",
			            	data: JSON.stringify(baseValue)
			            },
			            function (data) {
			            	layer.msg("添加成功！");
			            	window.location.reload();
			            });
			}else{
				layer.msg("请输入类型名称！");
			}
		}else{
			layer.msg("请输入3位字符或数字组成的编码！");
		}
	});

	//删除节点
	$(".delBtn").live("click",function(){
		layer.confirm('确认删除', {
		            btn: ['确认','取消'],
		            anim: 6
		        }, function(){
		            EasyAjax.ajax_Post_Json({
		            	url: "basic/data/api/enable",
		            	data: {
		            		id:dataDetail.id
		            	}
		            },
		            function (data) {
		            	layer.msg("删除成功！");
		            	window.location.reload();
		            });
		        }, function(){

		        });
	});

	//修改节点
	$(".editBtn").live("click",function(){
		var pid = $(this).parents("tr:first").attr("pid");
		if (pid) {
			var pName = $("#"+pid).find("td:eq(1)").text(),
			      pCode = $("#"+pid).find("td:eq(2)").html();
			$("#isShow").show();
		}else{
			$("#isShow").hide();
		}
		$("#editTplType").val(pName + " " + pCode);
		$("#editTplCode").val(dataDetail.code);
		$("#editTplName").val(dataDetail.name);
	});

	//保存修改节点
	$("#saveEditBtn").bind("click",function(){
		if ($("#editTplName").val()) {
			var baseValue = {dataCode:$("#editTplCode").val(),dataValue:$("#editTplName").val().trim(),parentId:dataDetail.parentId};
			EasyAjax.ajax_Post_Json({
		            	url: "basic/data/api/update/save",
		            	contentType:"application/json",
		            	data: JSON.stringify(baseValue)
		            },
		            function (data) {
		            	layer.msg("修改成功！");
		            	window.location.reload();
		            });
		}else{
			layer.msg("请输入类型名称！");
		}
	});

	//搜索节点
	$("#seacherBtn").bind("click",function(){
		$("#arborescence_table tr").removeClass("row_active");
		var $seacherCode = $("#seacherCode").val(),
		      $seacherName = $("#seacherName").val();
		if ($seacherCode && $seacherName) {
			var $nodeCodeSelected = $("#arborescence_table tr").find("td:eq(2):contains("+$seacherCode+")"),
			      $nodeNameSelected = $("#arborescence_table tr").find("td:eq(1):contains("+$seacherName+")");
			if ($nodeCodeSelected.length && $nodeNameSelected.length) {
				var $nodeSelected = new Array();
				$.each($nodeCodeSelected,function(index,ele){
					var $codeId = $(this).parents("tr:first").attr("id"),
					       $this = $(this);
					$.each($nodeNameSelected,function(index,ele){
						var $nameId = $(this).parents("tr:first").attr("id");
						if ($codeId == $nameId) {
							$nodeSelected.push($this);
						}
					});
				});
				if ($nodeSelected.length) {
					$.each($nodeSelected,function(index,ele){
						$(this).parents("tr:first").addClass("row_active");
						/*var open = $(this).parents("tr:first").attr("open");
						if (open == "N") {
							$(this).prev().children("img").click();
						}*/
						var pid = $(this).parents("tr:first").attr("pid");
						while (pid) {
							var open = $("#"+pid).attr("open");
							if (open == "N") {
								$("#"+pid).find("img").click();
							}
							var pid = $("#"+pid).attr("pid");
						}
					});
				}else{
					layer.tips('未匹配到相关节点', '#seacherBtn',{
						tips: [2, '#333']
					});
				}
			}else{
				layer.tips('未匹配到相关节点', '#seacherBtn',{
					tips: [2, '#333']
				});
			}
		}
		if ($seacherCode && !$seacherName) {
			var $nodeSelected = $("#arborescence_table tr").find("td:eq(2):contains("+$seacherCode+")");
			if ($nodeSelected.length) {
				$.each($nodeSelected,function(index,ele){
					$(this).parents("tr:first").addClass("row_active");
					/*var open = $(this).parents("tr:first").attr("open");
					if (open == "N") {
						$(this).prev().children("img").click();
					}*/
					var pid = $(this).parents("tr:first").attr("pid");
					while (pid) {
						var open = $("#"+pid).attr("open");
						if (open == "N") {
							$("#"+pid).find("img").click();
						}
						var pid = $("#"+pid).attr("pid");
					}
				});
			}else{
				layer.tips('未匹配到相关节点', '#seacherBtn',{
					tips: [2, '#333']
				});
			}
		}
		if ($seacherName && !$seacherCode) {
			var $nodeSelected = $("#arborescence_table tr").find("td:eq(1):contains("+$seacherName+")");
			if ($nodeSelected.length) {
				$.each($nodeSelected,function(index,ele){
					$(this).parents("tr:first").addClass("row_active");
					/*var open = $(this).parents("tr:first").attr("open");
					if (open == "N") {
						$(this).children("img").click();
					}*/
					var pid = $(this).parents("tr:first").attr("pid");
					while (pid) {
						var open = $("#"+pid).attr("open");
						if (open == "N") {
							$("#"+pid).find("img").click();
						}
						var pid = $("#"+pid).attr("pid");
					}
				});
			}else{
				layer.tips('未匹配到相关节点', '#seacherBtn',{
					tips: [2, '#333']
				});
			}
		}
		if (!$seacherName && !$seacherCode) {
			layer.tips('请输入关键字', '#seacherBtn',{
				tips: [2, '#333']
			});
		}
	});
});