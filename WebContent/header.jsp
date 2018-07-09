<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cn.fpshop.domain.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<script>
	$(function() {
		
		
		/* $(".nav-bar > li").click(function() {
			$(".nav-bar > li").removeClass();
			$(this).addClass("active");
		}); */
		var test = $(".test").val();
		if (test == "") {
			$.ajax({
					url : "${pageContext.request.contextPath}/productservlet?method=findCategory",
					async : true,
					type : "post",
					success : function(data) {
						$("#aaa").html(data);
						
						
						var c = <%=request.getAttribute("cid") %>;
						if(c == null){
							
						}else{
							var list = document.getElementsByClassName("categoryMenu");
							var a = list.length;
							for(var i = 0;i<list.length;i++){
								if($(list[i]).attr("data-cid") == c){
									$("#index").removeClass();
									$(list[i]).addClass("active");
								}
							}
						}
					}
	
				})
				
		}
	});
</script>
</head>
<body>
	<div id="header">
		<div class="header_top">
			<div class="item" style="">
				<h1></h1>
			</div>
			<div class="item" style="">
				<img src="./img/peppa.png" style="height: 100%; width: auto;">
			</div>
			<div class="item" style="">
				<div class="user-function">
					<%
						User user = (User) request.getSession().getAttribute("user");
						if (user != null) {
							out.write(user.getUname() + "，您好！");
							out.write(" &nbsp;&nbsp;&nbsp;<a href='#'>退出</a>");
						} else {
							out.write("<a href=\"/FPShop/login.jsp\">登录</a>");
						}
					%>
					&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/cart.jsp">购物车</a>&nbsp;&nbsp;&nbsp;<a
						href="${pageContext.request.contextPath}/privilege/user.jsp">个人中心</a>
				</div>
			</div>
		</div>
		<div class="nav">
			<input class="test" type="hidden" value="${categoryList[0].cname }">
			<ul class="nav-bar">
				<li class="active" id = "index"><a href="${pageContext.request.contextPath }/default.jsp" style = "font-size:20px;">首页</a></li>
				<c:forEach var="category" items="${categoryList }">
					<li class="categoryMenu" data-cid = "${category.cid }"><a href="${pageContext.request.contextPath }/productservlet?method=findProductListByCid&cid=${category.cid }">${category.cname }</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
</body>
</html>