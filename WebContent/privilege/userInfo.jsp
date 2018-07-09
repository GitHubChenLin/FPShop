<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="cn.fpshop.domain.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人资料</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<style>
body {
	margin: 0px;
	padding: 0px;
}

a, a:hover {
	text-decoration: none;
}

.info_left {
	display: inline-block;
	float: left;
	width: 120px;
	height: 120px;
	border: 2px solid rgb(172, 184, 206);
}

.info_right {
	display: inline-block;
	float: left;
	width: 540px;
	margin-left: 30px;
}

.userInfo_table {
	float: left;
}

.userInfo_table td {
	height: 60px;
	font-size: 19px;
	color: rgb(110, 126, 141);
}

.modify {
	color: rgb(110, 126, 141);
}

.modify:hover {
	color: rgb(241, 55, 53);
}
</style>
<script>
	$(function() {
		$(".modify").click(function() {
			$(window.parent.document).find("#modify_modal").fadeIn(400);
			$(window.parent.document).find(".modal_background").show();

		});
		
	})
	
</script>
</head>
<body>
	<div class="userInfo"
		style="width: auto; height: auto; display: block;">
		<div class="info_left">
			<img src="${pageContext.request.contextPath}/img/p1.png"
				style="width: 100%; height: 100%;">
		</div>
		<div class="info_right">
			<c:if test="${!empty user}">
				<table class="userInfo_table">
					<tr>
						<td>昵称：</td>
						<td>${user.uname }</td>
					</tr>
					<tr>
						<td>邮箱：</td>
						<td>${user.email }</td>
					</tr>
					<tr>
						<td>年龄：</td>
						<td>${user.age }</td>
					</tr>
					<tr>
						<td>性别：</td>
						<td>${user.sex ? "男":"女"}</td>
					</tr>
					<tr>
						<td>手机：</td>
						<td>${user.telephone }</td>
					</tr>
					<tr>
						<td>余额：</td>
						<td>${user.money }</td>
					</tr>
				</table>
				<div style="display: inline-block; float: right;">
					<a class="modify" href="#">修改</a>
				</div>
			</c:if>
		</div>
	</div>

</body>
</html>