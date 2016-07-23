function prepareSlideShow(){
	if(!lhz.iscompatible()) return false;
	if(!lhz.$("linklist")) return false;
	if(!lhz.$("preview")) return false;

	var preview=lhz.$("preview");
	preview.style.position="absolute";
	preview.style.left="0px";
	preview.style.top="0px";

	var list=lhz.$("linklist");
	var links=list.getElementsByTagName("a");


	/*for(var i=0;i<links.lenghth;i++){
		lhz.addEvent(links[i],'moseover',function(){
			//lhz.moveElement("preview",(i+1)*100,0,10);//会出现闭包问题：i的值总是会为3
			/*
				为每一个link绑定
				方案一：写三个事件绑定onmouseover,但会写死
				方法二：用循环处理，但不是闭包
				for(var i=0;i<links.length;i++){
					links[i].index=i+1  //给link增加一个属性index
					lhz.addEvent(links[i],'mouseover',function(){
						//函数中直接访问这个index属性   这不是一个闭包
						lhz.moveElement("preview",this.index*(-100),0,10);	
						
					})
				}

			*///闭包方式：
			for(var i=0;i<links.length;i++){
				(function(index){//自调用，index保存了当前i的值
					lhz.addEvent(links[index],"mouseover",function(){
						lhz.moveElement("preview",(index+1)*-100,0,10);
					});
				})(i);
			}

		
	
}
lhz.addLoadEvent(prepareSlideShow);