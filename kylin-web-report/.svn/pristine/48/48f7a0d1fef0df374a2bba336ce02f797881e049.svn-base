<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../config.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>编辑事业部</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>编辑事业部</title>
		<link rel="stylesheet" type="text/css" href="${staticPath}css/popup.css"/>
		<link rel="stylesheet" href="${staticPath}css/reset.css" />
		<link rel="stylesheet" href="${staticPath}css/layout.css" />
		<link rel="stylesheet" href="${staticPath}css/rightcontent.css" />
		<script type="text/javascript" src="${staticPath}js/jquery-1.11.1.js" ></script>
		<script type="text/javascript" src="${staticPath}js/nav.js" ></script>
		<script type="text/javascript" src="${staticPath}js/sheet/buiness.js" ></script>
		<script type="text/javascript">
		      var basePath = "${basePath}";
		      var staticPath = "${staticPath}";
		</script>
		<script type="text/javascript">
		      var olddisname = "${page.obj}";
		</script>
	</head>
	<body>
 <!--编辑-->
     <div id="compile">
      <div id="header-c">
      	<p id="title-c"><b>编辑事业部</b></p>
    	<!--<div id="radius-c">
    		 <b>&times;</b>
    	</div>-->
     </div>
     <c:if test="${not empty page }">
	     <ul id="content-c">
	      	<li id="name-c">
	      		<b id="b-c">事业部名称：</b><input type="text" id="text-syb" value="${page.obj }" placeholder="快销品事业部" />
	      	</li>
	      	<li id="name-c">
	      		<b id="b-c">添加客户：</b><input type="text" id="text-bm" value="" placeholder="请输入客户编码" />
	      	</li>
	    	<li id="xiushi"></li>
	    	<li id="tabtwo">
	    		<!--客户名称: --><input id="username" type="text" class="none-c">
	            <!--客户类别:--> <input id="age" type="text" class="none-c">
	            <!--客户代码：--><input type="text" id="lix" class="none-c"/> 
	            <!--客户所属分公司：--><input type="text" id="gongsi" class="none-c"/> 
	            <!--<input type="button" id="add" value="+">-->
	            <input type="button" name="add-c" id="add-c" value="+" class="pointer" />
	            <table id="tab1" border="1px">
	                <thead id="scale">
	                   <td style="width: 10%">序号</td>
	                   <td style="width: 35%">客户名称</td>
	                   <td style="width: 10%">客户类别</td>
	                   <td style="width: 20%">客户代码</td>
	                   <td style="width: 15%">客户所属分公司</td>
	                   <td style="width: 10%">操作</td>
	                </thead>
	               <tbody>
		               	<c:forEach items="${page.list }" var="results" varStatus="status">
			                 <tr>
				               <input id="customerIdGroupId${status.index }" type="hidden" name="customerIdGroupId" value="${results.customerIdGroupId}"/>
			               	   <input id="customerId${status.index }" type="hidden" name="customerId" value="${results.customerId}"/>
			               	   <input id="customerType${status.index }" type="hidden" name="customerType" value="${results.customerType}"/>
			                   <td>${status.index+1 }</td>
			                   <td name="customerName" id="customerName${status.index }">${results.customerName }</td>
			                   <c:if test="${results.customerType == 'not_platform'}">
									<td>非平台</td>
							   </c:if>
							   <c:if test="${results.customerType == 'platform'}">
									<td>平台</td>
							   </c:if>
			                   <td name="clientCode" id="clientCode${status.index }" >${results.clientCode }</td>
			                   <td name="computerName" id="computerName${status.index }">${results.computerName }</td>
			                   <td><a class="delete" id="delete-y" href="javascript:;"><img src="${staticPath}images/der_03.png"></a></td>
			                 </tr>
			            </c:forEach>
	           </tbody>
	         </table>    
	    	</li>
	    	<li id="bottom-c">
	    		<button name="button-c1" id="button-c1" onclick="editdivis();">提交</button>
	    	</li>
	      </ul>
      </c:if>
    </div>
    <div id="base4">
	    <!-- <div id="confirm">
	    	<h4>温馨提示</h4>
	    	<div id="career">
	    		<b>您输入的事业部名称已经存在,请重新输入</b>
	    		<div id="bottom-career">
	    			<input type="button" name="button-career" id="button-career" value="确定" />
	    		</div>
	    	</div>
	    </div> -->
	    <div id="remove">
	    	<h4>温馨提示</h4>
	    	<div id="career">
	    		<b id="buininfo"></b>
	    		<br />
	    		<div id="bottom-career">
	    			<input type="button" name="button-career" id="add" value="确定" />
	    		</div>
	    	</div>
	    </div>
	    <div id="disappear">
	    	<h4>温馨提示</h4>
	    	<div id="career">
	    		<b>您确定把<span id="delcust"></span><br/>从<span id="deldivis"></span>中移除吗？</b>
	    		<br />
	    		<div id="bottom-career">
	    			<input type="button" name="button-career" id="add-car" value="确定" />
	    			<input type="button" id="add-appear" value="取消"/>
	    		</div>
	    	</div>
	    </div>
    </div>
  </body>
</html>
