// JavaScript Document
/*
	var req=wq.ajaxRequest('http://218.196.14.220:8080/res/resfood.action',
	{'method':'POST','send':'op=findAllFoods','jsonResponseListener':listener});
	
	function listener(json){
		
		var obj=json.obj;
		for(var i=0;i<obj.length;i++){
			alert(obj[i].fname);
			}
		//alert(json.code+"\t"+json.obj.fname);
		}
	*/
	
	
	var content=wq.$('content');
	var req1=wq.ajaxRequest('http://218.196.14.220:8080/res/resfood.action',
	{'method':'POST','send':'op=findAllFoods','jsonResponseListener':listener1});
	
	/*var req=wq.ajaxRequest("http://218.196.14.220:8080/res/resfood.action?op=findAllSelectedFoods",
	{'method':'POST','send':null,'jsonResponseListener':listener2});
	*/
	
			
			
		
				
	
	function listener1(json){
		
		var boolean=true;
		var obj1=json.obj;
		var div=wq.$('table');
		
		
		var ul=document.createElement("ul");
			for(var i=0;i<obj1.length-6;i++){
				var li=document.createElement("li");
				li.setAttribute("class","mytable")
				li.appendChild(document.createTextNode(obj1[i].fname+"———————————￥"+obj1[i].realprice));
				ul.appendChild(li);
			}
			wq.prependChild('table',ul);
			
	
		
		
	
		wq.addEvent('btn3','click',function(){
			var btn1=wq.$("btn1");
			btn1.style.display='block';
			var img=wq.$("total1");
			if(img.style.display=='none'){
				img.style.display='block';
				}
			var div1=document.createElement("div");
			div1.setAttribute('id','first');
			var div=wq.$('table');
			var ul=document.createElement("ul");
			
			if(boolean){
				for(var j=obj1.length-1;j>5;j--){
					var li=document.createElement("li");
					li.setAttribute("class","mytable");
					li.appendChild(document.createTextNode(obj1[j].fname+"———————————￥"+obj1[j].realprice));
					ul.appendChild(li);
				}
				div1.appendChild(ul);
				//insertAfter(node,referenceNode)
				wq.insertAfter(div1,div);
				boolean=false;
			}
		});
		wq.addEvent("btn1","click",function(){
			var img=wq.$("total1");
			var img1=wq.$("total");
			img1.style.backgroundColor="#ECECEC";
			img.innerHTML="";
			var ul=document.createElement("ul");
			ul.style.width=830+"px";
			for(var i=0;i<obj1.length;i++){
				var li=document.createElement("li");
				var p=document.createElement("p");
				p.style.textAlign='center';
				p.innerHTML=obj1[i].fname+"     "+obj1[i].realprice;
				var p1=document.createElement("p");
				var inp=document.createElement("input");
				var inp1=document.createElement("input");
				inp.type="button";
				inp.value="购买";
				inp.className="inp";
				inp1.type="button";
				inp1.value="查看详情";
				inp1.className="find";
				p1.appendChild(inp);
				p1.appendChild(inp1);
				li.style.marginLeft=50+"px";
				li.style.marginTop=100+"px";
				
				var startimg=document.createElement("img");
				startimg.style.width=153+"px";
				startimg.style.height=158+"px";
				startimg.src="http://218.196.14.220:8080/res/images/"+obj1[i].fphoto;
				li.appendChild(startimg);
				li.appendChild(p);
				li.appendChild(p1);
				ul.appendChild(li);
			}
			img.appendChild(ul);
			var num=0;
			var inps=document.getElementsByClassName("inp"); 
			var table=document.getElementById("shop_table");
		for(var j=0;j<inps.length;j++){
			(function(index){
				lhz.addEvent(inps[index],'click',function(){
					//下订单
					var options={
						"completeListener":function(){
							alert(obj1[index].fname+"已添加至购物车");
						}
					};
					lhz.xssRequest("http://218.196.14.220:8080/res/resorder.action?num=1&op=order&fid="+obj1[index].fid,options);
				 
				 	
			//添加到购物车
				var option={
					"completeListener":function(){
						var obj=this.responseJSON.obj
						var str="";
						for(var i=1;i<13;i++){
							if(obj[i]){
								var tbody=lhz.$("shop_body");
								str+="<tr data="+i+">";
								str+="<td>"+obj[i].food.fname+"</td><td>"+obj[i].food.realprice+
								"</td><td><input type='button' class='addfoodnum'  value='+'></td><td>"+obj[i].num+"</td><td><input type='button' class='addfoodnum' id='reduce' value='-'></td><td>"+obj[i].smallCount+
								"</td><td><input class='delete' type='button' value='x'></td>";
								str+="</tr>";
								
							}
						}
						tbody.innerHTML=str;
						
					}
				};
			lhz.xssRequest("http://218.196.14.220:8080/res/resorder.action?op=getCartInfo",option);
				 	
			
			 	 })
				
			})(j);

		}

			//查看商品浏览记录
			var find1=document.getElementsByClassName("find");
			for(var i=0;i<find1.length;i++){
				
				var times=10;
				var total=wq.$('total1');
				var div1=document.createElement("div");
				div1.style.width=230+"px";
				div1.style.height='auto';
				(function(index){
					wq.addEvent(find1[index],"click",function(){
						var p2=document.createElement("p");
						Cookies.set('name',obj1[index].fname,times*24*60);
						p2.innerHTML=obj1[index].fname;
						div1.appendChild(p2);
						
						})
					})(i)
					
					wq.prependChild('total1',div1);
				
				/*wq.addLoadEvent(function(){
					if(Cookies.get('name')){
					
						}
					})*/
		}
			
			
		})
		
		
		
	}

	/*
	(function(index){
					wq.addEvent(smalldiv[index],'mouseover',function(){
						smalldiv[index].style.backgroundColor='#ccc';
						});
						wq.addEvent(smalldiv[index],'mouseout',function(){
							smalldiv[index].style.backgroundColor='#fff';
							})
					})(i)
				
				}
	*/	
	
	lhz.addEvent('shop','click',function(){
			div.style.display="block";
			//添加到购物车
				var option={
					"completeListener":function(){
						var obj=this.responseJSON.obj;
						for(var i=1;i<13;i++){
							if(obj[i]){
								var tbody=lhz.$("shop_body");

								var tr=document.createElement("tr");
									tr.data=i;

								var td1=document.createElement("td");
								td1.innerHTML=obj[i].food.fname;
								tr.appendChild(td1);

								var td2=document.createElement("td");
								td2.innerHTML=obj[i].food.realprice;
								tr.appendChild(td2);

								var td3=document.createElement("td");
								var input_add=document.createElement("input");
								input_add.setAttribute("onclick","addfood(this)");
								//input_add.onclick=addfood(this);
								input_add.type="button";
								input_add.className="addfoodnum";
								input_add.value="+";
								
								

								td3.appendChild(input_add);
								tr.appendChild(td3);
								
								
								var td4=document.createElement("td");
								td4.innerHTML=obj[i].num;
								tr.appendChild(td4);

								var td5=document.createElement("td");
								var input_reduce=document.createElement("input");
								input_reduce.setAttribute("onclick","reducefood(this)");
								input_reduce.type="button";
								input_reduce.className="addfoodnum";
								input_reduce.value="-";

								td5.appendChild(input_reduce);
								tr.appendChild(td5);

								var td6=document.createElement("td");
								td6.innerHTML=obj[i].smallCount;
								tr.appendChild(td6);

								var td7=document.createElement("td");
								var input_del=document.createElement("input");
								input_del.setAttribute("onclick","del(this)");
								input_del.type="button";
								input_del.className="delete";
								input_del.value="X";
								td7.appendChild(input_del);
								tr.appendChild(td7);

								tbody.appendChild(tr);
								

								}
							}
							
						}
						
						
					
				};
			lhz.xssRequest("http://218.196.14.220:8080/res/resorder.action?op=getCartInfo",option);
			
			function addfood(obj){
				var obj1=obj.parendNode;
				var td4=obj1.getElementsByTagName("td")[3];
				td4.innerHTML++;
				}
			function del(obj1){
				var obj2=obj1.parendNode;
				var td4=obj2.getElementsByTagName("td")[3];
				td4.innrHTML--;
					}
			
			
			
			// var tr=document.getElementsByTagName("tr");
			// for(var i=1;i<tr.length;i++){
			// 			var option={
			// 			"completeListener":function(){
			// 				tr[i].childNodes[2].setAttribute('onClick',addfood());
			// 					function addfood(){
			// 						tr[i].childNodes[3].innerHTML++;
			// 						tr[i].childNodes[5].innerHTML=tr[i].childNodes[5].innerHTML+tr[i].childNodes[1].innerHTML
			// 					}
			// 			}
			// 		}
			// 		lhz.xssRequest("http://218.196.14.220:8080/res/resorder.action?op=orderJson&num=1&fid="+tr[i].data,option);
				
					
			// 	}
			// }

			
		})


	
			
	


	//图片轮换
	function change(){
		var d1=wq.$("content");
		var u2=wq.$("content1");
		var total=wq.$("total");
		var speed=3;
		var timer=null;
		var l2=u2.getElementsByTagName("li");
		
			u2.innerHTML=u2.innerHTML+u2.innerHTML;
			u2.style.width=l2[0].offsetWidth*(l2.length)+150+"px";
			
			function move(){
			if(u2.offsetLeft<-u2.offsetWidth/2){
				u2.style.left='0';
				}
			if(u2.offsetLeft>0){
				u2.style.left=-u2.offsetWidth/2+"px";
				}
			u2.style.left=u2.offsetLeft+speed+"px";
			}
		 	timer=setInterval(move,40);
			var aa=total.getElementsByTagName('a');
			aa[0].onmousemove=function(){
			speed=-2;
			
			}
			aa[1].onmousemove=function(){
			speed=2;
			
			}
		
			d1.onmouseout=function(){
			timer=setInterval(move,40);
			}
			d1.onmouseover=function(){
			clearInterval(timer);
			}
		
		}
	
	wq.addLoadEvent(change);
	
		