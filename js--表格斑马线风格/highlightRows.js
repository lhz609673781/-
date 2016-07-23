//给每一行加入事件，以实现切换效果

function highlightRows(){
	if(!lhz.iscompatible()) return false;
	var rows=document.getElementsByTagName("tr");
	for(var i=0;i<rows.length;i++){
		rows[i].onmouseover=function(){
			lhz.removeClassName(this,'mouseout');
			lhz.addClassName(this,'mouseover');
		}
		rows[i].onmouseout=function(){
			lhz.removeClassName(this,'mouseover');
			lhz.addClassName(this,'mouseout');
		}
	}
}
lhz.addLoadEvent(highlightRows);