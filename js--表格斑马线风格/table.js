

function stripeTable(){
	if(!lhz.iscompatible()) return false;//是否兼容
	var tables=document.getElementsByTagName("table");//获取所有的table
	var odd,rows;//偶数 行
	for(var i=0;i<tables.length;i++){
		odd=false;//第一次不添加颜色
		rows=tables[i].getElementsByTagName("tr");//获取所有的tr标签
		for(var j=0;j<rows.length;j++){
			if(odd==true){
				lhz.addClassName(rows[j],"odd");
				odd=false;
			}else{
				odd=true;
			}
		}
	}
}

lhz.addLoadEvent(stripeTable);