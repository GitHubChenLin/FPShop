<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请查看您的订单</title>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<link type="text/css" rel="styleSheet"
	href="${pageContext.request.contextPath}/css/index.css">
<script>
	function buyNow() {
		var value = $('input[name = "payment"]:checked').val();
		location.href = "${pageContext.request.contextPath}/productservlet?method=pay&mode="
				+ value;
	}
</script>
<style>
body {
	text-align: center;
	background-color: rgb(241, 235, 223);
	margin: 0px;
}

a, a:hover, a:visited {
	text-decoration: none;
	color: #000;
}

#header {
	background-color: rgb(249, 172, 172);
	margin-bottom: 20px;
}

#body1 {
	display: inline-block;
	box-sizing: border-box;
	width: 1020px;
	padding: 50px;
	background-color: rgb(252, 213, 213);
	min-height: 600px;
	margin: 10px 0;
}

.order_table {
	margin-top: 20px;
	width: 99%;
	border: 1px solid rgb(247, 132, 131);
	table-layout: fixed;
	border-collapse: collapse;
	font-size: 15px;
}

.order_table tr {
	border-bottom: 1px solid rgb(247, 132, 131);
}

.order_table th {
	height: 40px;
	padding: 0 5px;
	background-color: rgb(249, 172, 172);
	text-align: left;
}

.order_table td {
	padding: 5px;
	word-wrap: break-word;
	word-break: break-all;
	text-align: center;
}

.first_tbody>tr>th {
	text-align: center;
}

.col-img {
	width: 70px;
}

.col-pname {
	
}

.col-count {
	width: 60px;
	text-align: center;
}

.col-price {
	width: 100px;
	text-align: center;
}

.col-total {
	width: 115px;
	border-left: 1px solid rgb(247, 132, 131);
	border-right: 1px solid rgb(247, 132, 131);
	text-align: center;
}



.action {
	cursor: pointer;
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
				style="display: inline-block; height: 70px; line-height: 70px; float: left; margin-left: 20px;">订单详情
				Order Information</div>
		</div>
	</div>
	<div id="body1">
		<table class="order_table">
			<tbody class="first_tbody">
				<tr>
					<th colspan="2">商品</th>
					<th>单价</th>
					<th>数量</th>
					<th>实付款</th>
				</tr>
			</tbody>
			<colgroup>
				<col class="col-img"></col>
				<col class="col-pname"></col>
				<col class="col-price"></col>
				<col class="col-count"></col>
				<col class="col-total"></col>
			</colgroup>

			<tr>
				<th colspan="5">订单号：${order.oid }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<fmt:formatDate type="both" value="${order.order_time}" />
				</th>
			</tr>
			<c:forEach var="item" items="${order.orderItems }">
				<tr>
					<td><img
						src="${pageContext.request.contextPath }/${item.product.image }"
						style="width: 100%; height: auto;"></td>
					<td>${item.product.pname }</td>
					<td>${item.product.price }</td>
					<td>${item.count }</td>
					<td>${item.subtotal }</td>
				</tr>
			</c:forEach>


		</table>
		<div
			style="font-size: 20px; float: right; clear: right; margin: 30px 0 10px 0;">
			支付金额：<span style="color: rgb(241, 55, 53)">￥<fmt:formatNumber
					type="number" value="${order.total }" pattern="0.00"
					maxFractionDigits="2" /></span>
		</div>


		<div>收货人： ${order.address.name }</div>
		<div>收货地址：${order.address.address }</div>
		<div>联系方式：${order.address.tel }</div>

		<div style="display: inline-block; margin: 20px 0; font-size: 18px;">请选择您的支付方式：</div>
		<div>
			<span><input type="radio" name="payment" value="money">余额（￥${user.money }元）</span>&nbsp;&nbsp;&nbsp;
			<span><input type="radio" name="payment" value="online"
				checked>在线支付</span>
		</div>

		<a href="javascript:;"
			style="background-color: rgb(244, 93, 92); width: 80px; height: 50px; margin: 20px auto;"
			onclick="buyNow()">确认支付</a>
	</div>
	<jsp:include page="/footer.jsp"></jsp:include>
</html>