<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<script>
	function loginCheck() {
		var value2 = $("#password").val();
		var value1 = $("#account").val();
		if (value1 != "" && value2 != "") {
			$.ajax({
				url : "${pageContext.request.contextPath}/userservlet?method=loginUser",
				data : $(".login_form").serialize(),
				async : true,
				dataType : "json",
				type : "post",
				success : function(data) {
					var isSuccess = data.isSuccess;
					if (isSuccess == false) {
						$("#checkInfo").css("color", "red");
						$("#checkInfo").html("用户名/邮箱或密码错误");
					} else {
						window.location.href = "/FPShop/default.jsp";
					}
				}

			})
		} else {
			$("#checkInfo").css("color", "red");
			$("#checkInfo").html("用户名/邮箱或密码不能为空");
		}
	}
	function isNull() {
		var value1 = $("#account").val();
		var value2 = $("#password").val();
		if (value1 != "" && value2 != "") {
			$("#checkInfo").html("");
		}
	}
</script>
<style>
body {
	margin: 0;
	text-align: center;
}

a, a:hover {
	text-decoration: none;
}

.header {
	width: 100%;
	background-color: rgb(252, 213, 213);
}

h1 {
	width: 20%;
	height: 100%;
	display: inline-block;
	float: left;
}

.header-right {
	width: 80%;
	height: 80px;
	line-height: 80px;
	display: inline-block;
	float: left;
}

.info {
	font-size: 13px;
	width: auto;
	height: 30px;
	line-height: 30px;
	background-color: white;
	border: 0.5px solid rgb(241, 55, 53);
	display: inline-block;
	margin-top: 20px;
}

.body {
	width: 100%;
	height: 450px;
	background-color: rgb(247, 132, 131);
}

.body-left {
	width: 70%;
	height: 100%;
	float: left;
}

.body-right {
	width: 30%;
	height: 100%;
	float: left;
}

.login {
	display: inline-block;
	width: 95%;
	height: 65%;
	margin-top: 17.5%;
	background-color: rgb(252, 213, 213);
	border: 1px solid rgb(241, 55, 53);
}

table {
	display: inline-block;
}

td {
	height: 50px;
	font-size: 16px;
}

input {
	height: 30px;
	font-size: 16px;
}

.login_button {
	width: 90%;
	height: 35px;
	line-height: 35px;
	background-color: rgb(241, 55, 53);
	border: 0px;
	display: inline-block;
	color: #e2e2e2;
	border-radius: 3px;
}

img {
	width: auto;
	height: 100%;
}
</style>
</head>
<body>
	<div class="header">
		<div style="width: 1120px; height: 80px; display: inline-block;">
			<h1></h1>
			<div class="header-right" style="">
				<div class="info">&nbsp;&nbsp;&nbsp;为确保您账户的安全及正常使用，依《网络安全法》相关要求，6月1日起会员账户需绑定手机。如您还未绑定，请尽快完成，感谢您的理解及支持！&nbsp;&nbsp;&nbsp;</div>
			</div>
		</div>
	</div>
	<div class="body">
		<div style="width: 1120px; height: 100%; display: inline-block;">
			<div class="body-left">
				<div
					style="height: 200px; width: 100%; display: inline-block; margin-top: 100px;">
					<img src="./img/p1.png"> <img src="./img/p2.png"> <img
						src="./img/p3.png"> <img src="./img/p4.png">
				</div>
			</div>
			<div class="body-right">
				<div class="login">
					<form action="##" class="login_form"
						style="text-align: center; margin-top: 30px;">
						<table>
							<tr>
								<td colspan="2" style="padding: 0; text-align: left;">登录
									Login</td>
							</tr>
							<tr>
								<td>账号&nbsp;&nbsp;</td>
								<td><input id="account" type="text" name="account"
									placeholder=" 账号/邮箱" onchange="isNull()"></td>
							</tr>
							<tr>
								<td>密码&nbsp;&nbsp;</td>
								<td><input id="password" type="password" name="password"
									placeholder=" 密码" onchange="isNull()"></td>
							</tr>
							<tr>
								<td colspan="2" style="height: 20px;"><span id="checkInfo"></span>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="height: 35px;"><input
									class="login_button" type="button" value="登录"
									onclick="loginCheck()"></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div></div>
</body>
</html>