//购买
var div=document.getElementById("shoppingcar");

var table=document.createElement("table");
							table.cellSpacing=0;
							table.cellPadding=0;
							table.style.border="none";
							table.setAttribute('id','shop_table');
				var thead=document.createElement("thead");
				var tr=document.createElement("tr");
				tr.setAttribute("class","shop_tr");
							var str1="<tr>";
							str1+="<td>食物名</td><td>价格</td><td>增加</td><td>数量</td><td>减少</td><td>小计</td><td>取消订购</td>";
							str1+="</tr>"
							tr.innerHTML=str1;
							thead.appendChild(tr);
				table.appendChild(thead);
				var tbody=document.createElement("tbody");
				tbody.setAttribute('id','shop_body');
				table.appendChild(tbody);
				div.appendChild(table);
				var input=document.createElement("input");
				input.setAttribute('id','refirm_buy');
				input.value="确认购买";
				input.type="button";

				div.appendChild(input);

		
var shop_num=lhz.$("shop_num");
var shop_body=lhz.$("shop_body");
var tr=shop_body.childNodes;
for(var i=0;i<tr.length;i++){
	var td=tr[i].childNodes[3].innerHTML;
	shop_num.innerHTML+=td;
}
