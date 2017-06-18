//绑定登录事件
lhz.addEvent('submit_t',"click",function(){
	document.getElementById("myform").style.display="block";
	lhz.$(shop).style.display="none";
	document.body.style="background:rgba(0,0,0,0.5);";
})

//图片更改
function change_pic(){
	var img=document.getElementById("code_img");
	img.src="http://218.196.14.220:8080/res/verifyCodeServlet?"+Math.random();
}

//登录操作
function add(){
 	var myform=document.myform;
 var parama=lhz.serialize(myform);
 //alert(parama);
var denglu=lhz.ajaxRequest('http://218.196.14.220:8080/res/resuser.action',{'method':'POST','send':parama,'jsonResponseListener':listener});

	function listener(json){
		//alert(json.code);
		if(json.code==0){
			alert(json.msg);
		}else{
			document.getElementById('submit_t').style.display='none';
			var uname=document.getElementsByTagName("input")[1].value;
			document.getElementById("myform").style.display="none";
			var p_sub=document.getElementById('sub_result').innerHTML="欢迎您，"+uname;
			lhz.$(shop).style.display="block";
			document.body.style.background="none";

		}
	}
}

//取消登录
lhz.addEvent('btn2',"click",function(){
	document.getElementById("myform").style.display="none";
	lhz.$(shop).style.display="block";
	document.body.style.background="none";
})



 


// 用户退出
lhz.addEvent('out','click',function(){

	var out=lhz.ajaxRequest('http://218.196.14.220:8080/res/resuser.action',{'method':'POST','send':'op=logout','jsonResponseListener':listener1});

	function listener1(json){
		if(json.code==1){
			document.getElementById('submit_t').style.display='block';
			var p_sub=document.getElementById('sub_result').innerHTML=null;
		}
	}
})

