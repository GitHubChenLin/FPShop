<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<script>
	$(function() {
		setTimeout(function() {
			$(".pay_info").html("支付中...");
			setTimeout(function() {
				$(".pay_info").html("支付成功！");
				setTimeout(function() {
					window.location.href = "${pageContext.request.contextPath}/privilege/user.jsp";
				},2000);
			}, 5000);
		}, 3000);
		

	})
</script>
<title></title>
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

.pay_img {
	display: block;
	width: 150px;
	height: 200px;
	float: left;
	margin: 15px;
}
</style>
</head>
<body>
	<div id="header">
		<div
			style="display: inline-block; width: 1020px; height: 70px; text-align: left;">
			<div
				style="display: inline-block; height: 100%; width: 130px; background-color: rgb(244, 93, 92); float: left;"></div>
			<div
				style="display: inline-block; height: 70px; line-height: 70px; float: left; margin-left: 20px;">充值中心
				Recharge Center</div>
		</div>
	</div>
	<div
		style="width: 1020px; height: 500px; text-align: center; display: inline-block; background-color: rgb(249, 172, 172);">
		<div style="display:inline-block;">
			<div class="pay_img">
				<img src="${pageContext.request.contextPath }/img/alipay.jpg"
					style="width: 100%;"> <span>支付宝支付</span>
			</div>
			<div class="pay_img">
				<img src="${pageContext.request.contextPath }/img/wechatpay.jpg"
					style="width: 100%;"> <span>微信支付</span>
			</div>
		</div>
		<div style="display: block;color:green;" class="pay_info"></div>
	</div>
</body>
</html>