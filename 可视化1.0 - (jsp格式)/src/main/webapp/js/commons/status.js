/**
 * 前端web和微信端状态显示js定义
 * 前端状态
 */
	var RIGHT_CODE = 200;// 成功



//消息表状态0微信端未读、1已读
function msgStatus(arg){
	var statusCN="";
	if(arg=='0'){//未读
		statusCN="有回单消息";
	}
	return statusCN;
}

//判断js值是否为null
function valueIsNull(value){
	var strvalue="";
	if(value!="" && value!="null" && value!=null){
		strvalue = value;
	}
	return strvalue;
}

//判断对象是否为空并取得属性值
function valueAttr(value,attrb){
	var strvalue="";
	if(value!="" && value!="null" && value!=null){
		strvalue = value[""+attrb+""];
	}
	return strvalue;
}
