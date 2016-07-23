/*本版本的优点：将img和p从html中删除，由dom来动态创建和管理*/

function preparePlaceHolder(){
	if(!lhz.iscompatible())return false;
	if(!(lhz.$('imagegallery')))return false;
	//创建<img>标签
	var placeholder=document.createElement("img");
	placeholder.setAttribute("src","image/placeholder.png");
	placeholder.setAttribute("id","placeholder");
	placeholder.setAttribute("alt","图片浏览");
	//创建<p>请选择一张图片</p>
	var description=document.createElement('p');
	description.setAttribute("id","description");
	var desctext=document.createTextNode("请选择一张图片");
	description.appendChild(desctext);
	//将创建的标签插入html
	var gallery=document.getElementById("imagegallery");
	lhz.insertAfter(placeholder,gallery);
	lhz.insertAfter(description,placeholder);
}
lhz.addLoadEvent(preparePlaceHolder);



function  showPic(whichPic){
		//whichPic指当前传入的图片
		//如果不存在placeholder,则无法显示图片，程序无法运行
		//且placeholder由DOM创建
		if(!lhz.$('placeholder')) return false;
		var source=whichPic.getAttribute("href");//图片的地址

		//传入img标签
		var placeholder=lhz.$("placeholder");
		if(placeholder.nodeName!='IMG')return false;
		//更改img的图片地址
		placeholder.setAttribute("src",source);//在placeholder中显示图片

		//如果description不存在，则不显示
		//description即p标签
		if(lhz.$("description")){
			//得到传入的当前图片的title,没有设置值就为空
			var text=whichPic.getAttribute("title")?whichPic.getAttribute("title"):"";
			var description=lhz.$("description");
			if(description.firstChild.nodeType==3){
				//如果p标签第一个子节点是文本节点则将text值传入进去
				description.firstChild.nodeValue=text; 
			}
		}
		return true;
	}

/*这个函数用于做浏览器测试和检测，这样js代码不再依赖于那些没有保证的假设，
可以保证js代码能平稳退化*/
	function preparePic(){
		if(!lhz.iscompatible()){return false;}
		//在页面上指定了容器ul的id,这样就可以通过js一次性地给所有的a元素加入事件
		if(!lhz.$("imagegallery")){return false;}//ul
		var gallery=lhz.$("imagegallery");
		var links=gallery.getElementsByTagName("a");
		for(var i=0;i<links.length;i++){
			links[i].onclick=function(){//循环a标签
				//this  -> link[i]
				return showPic(this)?false:true;
				//如果showPic(this)函数已经被调用则返回false,那么将不会运行<a>
			}
		}
	}
	lhz.addLoadEvent(preparePic);

