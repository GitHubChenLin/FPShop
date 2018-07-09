<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cn.fpshop.domain.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>FP商城，一站式购物体验！</title>
<link href="./css/bootstrap.css" rel="stylesheet">
<link type="text/css" rel="styleSheet" href="./css/index.css">
<!-- <script type="text/javascript" src="./js/jquery-1.8.3.js"></script> -->
<script src="./js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="./js/bootstrap.min.js"></script>
<script>
	$(function() {
		$(".register").click(function() {
			$("#register_modal").fadeIn(400);
			$(".modal_background").show();

		});
		$(".modal_background").click(function() {
			$("#register_modal").fadeOut(200);
			$("#login_modal").fadeOut(200);
			$(".modal_background").hide();
		});
	})
	function UsernameCheck() {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/userservlet?method=checkSameUname",
					data : $("#register_form").serialize(),
					async : true,
					dataType : "json",
					type : "post",
					success : function(data) {
						var isSame = data.isSame;
						if (isSame == true) {
							$("#reg_warn_input").html("用户名已存在！");
						} else {
							$("#reg_warn_input").html("");
						}
					}

				})

	}
	function namecheck(e) {
		var check = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,18}$/;
		var usernameValue = e.value;
		if (!check.test(usernameValue)) {
			document.getElementById("reg_warn_input").innerHTML = "格式不正确"
		} else {
			document.getElementById("reg_warn_input").innerHTML = "";
			UsernameCheck();
		}
	}
	function passwordcheck() {
		var check = /^[a-zA-Z0-9]{6,18}$/;
		var pwdValue = document.getElementById("reg_pwd").value;
		if (!check.test(pwdValue)) {
			document.getElementById("reg_warn_pwd").innerHTML = "格式不正确"
		} else {
			document.getElementById("reg_warn_pwd").innerHTML = "";
		}
	}
	function matchPassword() {
		var pwd = document.getElementById("reg_pwd").value;
		var repwd = document.getElementById("reg_repwd").value;
		if (repwd != pwd) {
			document.getElementById("reg_warn_repwd").innerHTML = "两次输入不一致"
		} else {
			document.getElementById("reg_warn_repwd").innerHTML = "";
		}
	}
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
	function registerSubmit() {
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
						url : "${pageContext.request.contextPath}/userservlet?method=register",
						data : $("#register_form").serialize(),
						async : true,
						dataType : "json",
						type : "post",
						success : function(data) {
							var registerSuccess = data.registerSuccess;
							if (registerSuccess == true) {
								$(".registerSuccess")
										.html("注册成功，将在3秒后跳转到登录页面！");
								setTimeout(function() {
									location.href = "login.jsp";
								}, 3000);
							} else {
								$(".registerSuccess").html("服务器异常，请重新注册。");
							}
						}

					})
		} else {
			alert("请完善注册信息！");
		}
	}
</script>
</head>
<body>
	<div id = "aaa"><jsp:include page="/header.jsp"></jsp:include></div>
	

	<div id="body">
		<div class="banner">
			<div id="carousel-example-generic" class="carousel slide banner-img"
				data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#carousel-example-generic" data-slide-to="0"
						class="active"></li>
					<li data-target="#carousel-example-generic" data-slide-to="1"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox">
					<div class="item active">
						<img src="./img/230.jpg" alt="First slide">
					</div>
					<div class="item">
						<img src="./img/816.jpg" alt="Second slide">
					</div>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#carousel-example-generic"
					role="button" data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#carousel-example-generic"
					role="button" data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
			<div class="login-register">
				<%
					User user = (User) request.getSession().getAttribute("user");
					if (user != null) {
						out.write("<div class ='user_info'>");
						out.write("<div class='user_img'><img src='./img/p1.png' style='height: 100%; width: auto;'></div>");
						out.write("<div class='info'><div>昵称：" + user.getUname() + "</div><div>余额：" + user.getMoney()
								+ "</div></div></div>");
					} else {
						out.write("<div class='login'><a href=\"/FPShop/login.jsp\">登录</a></div>");
						out.write("<div class='register'><a href='#'>注册</a></div>");
					}
				%>
			</div>
		</div>
		<div class="new_product">
			<div class="title">
				<div style="">最新商品</div>
			</div>
			<div class="product-list">
				<c:forEach var="product" items="${newProductList }">
					<div class="product-item1">
						<a href="${pageContext.request.contextPath }/productservlet?method=productInfo&pid=${product.pid}&cid=${product.cid}"
							style="border: 1px solid rgb(241, 55, 53); display: block; width: 100%; height: auto;">
							<img src="${pageContext.request.contextPath }/${product.image }"
							style="width: 100%; height: auto;">
						</a>
						<div
							style="padding: 8px; text-align: left; color: rgb(241, 55, 53);">￥${product.price }</div>
						<div style=""><a href = "${pageContext.request.contextPath }/productservlet?method=productInfo&pid=${product.pid}&cid=${product.cid}">${product.pname }</a></div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="hot-product">
			<div class="title">
				<div style="">热门商品</div>
			</div>
			<div class="product-list">
				<c:forEach var="product" items="${hotProductList }">
					<div class="product-item1">
						<a href="${pageContext.request.contextPath }/productservlet?method=productInfo&pid=${product.pid}&cid=${product.cid}"
							style="border: 1px solid rgb(241, 55, 53); display: block; width: 100%; height: auto;"><img
							src="${pageContext.request.contextPath }/${product.image }"
							style="width: 100%; height: auto;"></a>
						<div
							style="padding: 8px; text-align: left; color: rgb(241, 55, 53);">￥${product.price }</div>
						<div style=""><a href="${pageContext.request.contextPath }/productservlet?method=productInfo&pid=${product.pid}&cid=${product.cid}">${product.pname }</a></div>
					</div>
				</c:forEach>
			</div>
		</div>

	</div>

	<jsp:include page="/footer.jsp"></jsp:include>




	<!-- 模态框 -->
	<div class="modal_background"></div>

	<div class="modal" id="register_modal">
		<div class="modal_header" style="height: 35px; line-height: 35px;">
			<a href="" style="color: #adadad">
				<div class="modal_close"
					style="float: right; display: block; font-size: 20px; width: 35px; text-align: center;">×</div>
			</a>
		</div>
		<div class="modal_body"
			style="display: flex; justify-content: flex-end; align-content: center; margin: 5px 0;">
			<form id="register_form" action="/FPShop/userserlvet?method=register"
				method="post">
				<div class=""
					style="display: inline-block; float: left; width: 100%; font-size: 25px; color: #7a7a7a; margin: 0 0 10px 5px;">注册
					Register</div>
				<div>
					<table>
						<tr>
							<td><span class="key">用户名：</span></td>
							<td><input id="reg_input" class="value" type="text"
								name="username" placeholder="6-18位字母和数字组成"
								onchange="namecheck(this)"></td>
							<td>
								<div class="warn" id="reg_warn_input"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">昵称：</span></td>
							<td><input id="reg_name" class="value" type="text"
								name="uname" placeholder="请你输入昵称"></td>
							<td>
								<div class="warn" id="reg_warn_input"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">密码：</span></td>
							<td><input id="reg_pwd" class="value" type="password"
								name="password" placeholder="至少6位以上数字或字母"
								onchange="passwordcheck()"></td>
							<td>
								<div class="warn" id="reg_warn_pwd"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">确认密码：</span></td>
							<td><input id="reg_repwd" class="value" type="password"
								name="repwd" placeholder="确认密码" onchange="matchPassword()">
							</td>
							<td>
								<div class="warn" id="reg_warn_repwd"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">邮箱：</span></td>
							<td><input id="email" class="value" type="text" name="email"
								placeholder="填入邮箱，用于登录" onchange="emailcheck()"></td>
							<td>
								<div id="checkemail" class="warn"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">年龄：</span></td>
							<td><input id="age" class="value" type="text" name="age"
								placeholder="填入您的年龄" onchange="agecheck()"></td>
							<td>
								<div id="reg_warn_age" class="warn"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">性别：</span></td>
							<td>
								<div style="float: left; margin-left: 5px;">
									<input type="radio" name="sex" value="1" checked>&nbsp;&nbsp;男
								</div>
								<div style="float: left; margin-left: 20px;">
									<input type="radio" name="sex" value="0">&nbsp;&nbsp;女
								</div>
							</td>
							<td>
								<div id="" class="warn"></div>
							</td>
						</tr>
						<tr>
							<td><span class="key">联系方式：</span></td>
							<td><input id="telephone" class="value" type="text"
								name="telephone" placeholder="填入您的手机号" onchange="telcheck()"></td>
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
					style="display: inline-block; text-align: center; margin-left: 70px;">
					<input style="" class="form_control" type="button" value="注册"
						onclick="registerSubmit()"> <input style=""
						class="form_control" type="reset">
				</div>
			</form>

		</div>
	</div>
</body>
</html>