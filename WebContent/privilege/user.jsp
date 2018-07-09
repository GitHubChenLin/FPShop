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
	background-color: rgb(241, 235, 223);
	margin: 0px;
}

a, a:hover, a:visited {
	text-decoration: none;
}

#header {
	background-color: rgb(249, 172, 172);
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
	background-color: pink;
}

.content {
	display: inline-block;
	float: right;
	width: 850px;
	min-height: 750px;
	background-color: rgb(252, 213, 213);
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
	background-color: rgb(249, 172, 172);
}

.function_list>.active {
	background-color: rgb(249, 172, 172);
}

.function_list>li>a {
	width: 100%;
	height: 60px;
	line-height: 60px;
	color: rgb(110, 126, 141);
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
	function emailcheck() {
		var emailvalue = document.getElementById("email").value;
		if ((emailvalue.indexOf('@', 0) == -1)
				|| (emailvalue.indexOf('.', 0) == -1)) {
			document.getElementById("checkemail").innerHTML = "格式不正确";
		} else {
			document.getElementById("checkemail").innerHTML = "";
		}
	}
	function agecheck() {
		var check = /^\+?[1-9][0-9]*$/;
		var ageValue = document.getElementById("age").value;
		if (!check.test(ageValue)) {
			document.getElementById("reg_warn_age").innerHTML = "请输入正确的年龄";
		} else {
			document.getElementById("reg_warn_age").innerHTML = "";
		}
	}
	function telcheck() {
		var check = /^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/;
		var ageValue = document.getElementById("telephone").value;
		if (!check.test(ageValue)) {
			document.getElementById("reg_warn_tel").innerHTML = "请输入正确的手机号";
		} else {
			document.getElementById("reg_warn_tel").innerHTML = "";
		}
	}

	function modifySubmit() {
		var x = document.getElementsByClassName("warn");
		var forbid = 0
		for (var i = 0; i < x.length; i++) {
			if (x[i].innerHTML != "") {
				forbid = forbid + 1;
			}
		}
		if (forbid == 0) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/userservlet?method=modifyUser",
						data : $("#modify_form").serialize(),
						async : true,
						dataType : "json",
						type : "post",
						success : function(data) {
							var modifySuccess = data.isSuccess;
							if (modifySuccess == true) {
								alert("修改成功！");
								location.reload();
							} else {
								alert("服务器异常，请重新修改。");
							}
						}
					})
		} else {
			alert("请完善注册信息！");
		}
	}
	
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
			<a href = "${pageContext.request.contextPath }/default.jsp"
				style="display: inline-block; height: 100%; width: 130px; background-color: rgb(244, 93, 92); float: left;"></a>
			<div
				style="display: inline-block; height: 70px; line-height: 70px; float: left; margin-left: 20px;">个人中心
				Personal Center</div>
		</div>
	</div>
	<div id="body">
		<div class="menu">
			<ul class="function_list">
				<li class="active"><a
					href="${pageContext.request.contextPath}/privilege/userInfo.jsp"
					target="main_frame">个人资料</a></li>
				<li><a href = "${pageContext.request.contextPath}/cart.jsp">购物车</a></li>
				<li><a
					href="${pageContext.request.contextPath}/productservlet?method=findAllOrders"
					target="main_frame">我的订单</a></li>
				<li><a
					href="${pageContext.request.contextPath}/privilege/balance.jsp"
					target="main_frame">我的余额</a></li>
				<li><a href="${pageContext.request.contextPath}/userservlet?method=showAdd"
					target="main_frame">地址管理</a></li>
			</ul>
		</div>
		<div class="content">
			<iframe name="main_frame" id="main_frame"
				src="${pageContext.request.contextPath}/privilege/userInfo.jsp"
				style="min-height: 600px; width: 700px; border: 0px; padding: 50px 75px;"
				scrolling="no" onload="javascript:iframeAutoHeight();"></iframe>
		</div>
	</div>

	<!-- 修改资料模态框 -->
	<div class="modal_background"></div>

	<div class="modal" id="modify_modal">
		<div class="modal_header" style="height: 35px; line-height: 35px;">
			<a href="" style="color: #adadad">
				<div class="modal_close"
					style="float: right; display: block; font-size: 20px; width: 35px; text-align: center;">×</div>
			</a>
		</div>
		<div class="modal_body"
			style="display: flex; justify-content: flex-end; align-content: center; margin: 5px 0;">
			<form id="modify_form" action="/FPShop/userserlvet?method=modifyUser"
				method="post">
				<div class=""
					style="display: inline-block; float: left; width: 100%; font-size: 25px; color: #7a7a7a; margin: 0 0 20px 5px;">修改个人资料
					Modify</div>
				<div>
					<table>
						<tr>
							<td><span class="key">昵称：</span></td>
							<td><input id="user_id" type="text" name="uid"
								value="${user.uid }" style="display: none;"> <input
								id="reg_name" class="value" type="text" name="uname"
								placeholder="请你输入昵称" value="${user.uname }"></td>
							<td>
								<div class="warn" id="reg_warn_input"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">邮箱：</span></td>
							<td><input id="email" class="value" type="text" name="email"
								placeholder="填入邮箱，用于登录" onchange="emailcheck()"
								value="${user.email }"></td>
							<td>
								<div id="checkemail" class="warn"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">年龄：</span></td>
							<td><input id="age" class="value" type="text" name="age"
								placeholder="填入您的年龄" onchange="agecheck()" value="${user.age }"></td>
							<td>
								<div id="reg_warn_age" class="warn"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">性别：</span></td>
							<td><c:if test="${user.sex == true }">
									<div style="float: left; margin-left: 5px;">
										<input type="radio" name="sex" value="1" checked>&nbsp;&nbsp;男
									</div>
									<div style="float: left; margin-left: 20px;">
										<input type="radio" name="sex" value="0">&nbsp;&nbsp;女
									</div>
								</c:if> <c:if test="${user.sex != true }">
									<div style="float: left; margin-left: 5px;">
										<input type="radio" name="sex" value="1">&nbsp;&nbsp;男
									</div>
									<div style="float: left; margin-left: 20px;">
										<input type="radio" name="sex" value="0" checked>&nbsp;&nbsp;女
									</div>
								</c:if></td>
							<td>
								<div id="" class="warn"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">联系方式：</span></td>
							<td><input id="telephone" class="value" type="text"
								name="telephone" placeholder="填入您的手机号" onchange="telcheck()"
								value="${user.telephone }"></td>
							<td>
								<div id="reg_warn_tel" class="warn"></div>
							</td>
						</tr>
						<tr style="height: 20px;">
							<td colspan="2">
								<div class="registerSuccess"
									style="color: red; text-align: center;"></div>
							</td>
						</tr>
					</table>
				</div>

				<div
					style="display: inline-block; text-align: center; margin-left: 130px;">
					<input style="" class="form_control" type="button" value="修改"
						onclick="modifySubmit()">
				</div>
			</form>

		</div>
	</div>
</body>
</html>