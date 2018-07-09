<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>

<style>
body {
	text-align: center;
	background-color: rgb(1, 1, 1);
	margin: 0px;
}

a, a:hover, a:visited {
	text-decoration: none;
}

#header {
	background-color: rgb(29, 39, 47);
	margin-bottom: 20px;
}

#body {
	display: inline-block;
	width: 1020px;
}

.menu {
	display: inline-block;
	float: left;
	width: 150px;
	height: 500px;
	background-color: rgb(27, 31, 42);
}

.content {
	display: inline-block;
	float: right;
	width: 850px;
	min-height: 750px;
	background-color: rgb(27, 31, 42);
}

.function_list {
	padding: 0px;
	margin: 0px;
}

.function_list>li {
	list-style: none;
	padding: 0 30px;
}

.function_list>li:hover {
	background-color: rgb(63, 74, 83);
}

.function_list>.active {
	background-color: rgb(63, 74, 83);
}

.function_list>li>a {
	width: 100%;
	height: 60px;
	line-height: 60px;
	color: #e2e2e2;
	font-size: 18px;
	display: inline-block;
	border-bottom: 2px solid rgb(172, 184, 206);
}

.function_list>.active>a, .function_list>.active>a:hover, .function_list>.active>a:focus
	{
	border-bottom: 2px solid rgb(241, 55, 53);
}

.modal_background {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	width: 100%;
	height: 100%;
	background-color: black;
	opacity: 0.7;
	display: none;
}

.modal {
	position: fixed;
	display: none;
	width: 550px;
	height: 450px;
	background-color: rgb(249, 172, 172);
	margin: auto;
	opacity: 1;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	text-align: left;
}

.modal_header>a:hover .modal_close {
	background-color: rgb(241, 55, 53);
}

.key {
	display: inline-block;
	float: left;
	font-size: 14px;
	height: 20px;
	line-height: 20px;
	margin: 5px;
	color: #000;
	background-color: transparent;
}

.value {
	height: 30px;
	width: 230px;
	margin: 5px;
	font-size: 16px;
	font-weight: 100;
	color: rgb(122, 122, 122);
	background-color: rgb(252, 213, 213);
	border: 2px solid rgb(252, 213, 213);
}

.value::-webkit-input-placeholder {
	font-size: 14px;
}

.warn {
	width: 110px;
	height: 36px;
	margin: 5px;
	line-height: 30px;
	font-size: 12px;
	color: red;
	display: inline-block;
}

.form_control {
	width: 80px;
	height: 30px;
	margin: 10px;
	border: 0px;
	color: #e2e2e2;
	background-color: rgb(247, 132, 131);
}

.form_control:hover {
	background: rgb(241, 55, 53);
}


</style>
<script>
	$(function() {
		$(".function_list > li").click(function() {
			$(".function_list > li").removeClass();
			$(this).addClass("active");
		});
		$(".modal_background").click(function() {
			$("#modify_modal").fadeOut(200);
			$(".modal_background").hide();
		});
	})
	
	
	function iframeAutoHeight(){
     	var iframe=document.getElementById("main_frame");
     	if(navigator.userAgent.indexOf("MSIE")>0||navigator.userAgent.indexOf("rv:11")>0||navigator.userAgent.indexOf("Firefox")>0){
     		iframe.height=iframe.contentWindow.document.body.scrollHeight;
     	}else{
     		iframe.height=iframe.contentWindow.document.documentElement.scrollHeight;
     	}
     }
</script>
</head>
<body>
	<div id="header">
		<div
			style="display: inline-block; width: 1020px; height: 70px; text-align: left;">
			<div
				style="display: inline-block; height: 100%; width: 130px; background-color: rgb(244, 93, 92); float: left;"></div>
			<div
				style="display: inline-block; height: 70px; line-height: 70px; float: left; margin-left: 20px;color:#adadad;">商城管理系统
				Management System</div>
		</div>
	</div>
	<div id="body">
		<div class="menu">
			<ul class="function_list">
				<li class="active"><a
					href="${pageContext.request.contextPath}/admin?method=categoryManage"
					target="main_frame">分类管理</a></li>
				<li><a href = "${pageContext.request.contextPath}/admin?method=showAllProduct" target="main_frame">商品管理</a></li>
				<li><a
					href="${pageContext.request.contextPath}/admin?method=orderManage"
					target="main_frame">订单管理</a></li>
				<li><a
					href="${pageContext.request.contextPath}/admin?method=userManage"
					target="main_frame">用户管理</a></li>
			</ul>
		</div>
		<div class="content">
			<iframe name="main_frame" id="main_frame"
				src=""
				style="min-height: 700px; width: 700px; border: 0px; margin:50px;"
				scrolling="yes" ></iframe>  <!-- onload="javascript:iframeAutoHeight();" -->
		</div>
	</div>



</body>
</html>