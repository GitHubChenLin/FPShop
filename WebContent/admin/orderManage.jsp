<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<title>订单</title>
<script>
	$(function (){
		$(".showModal").click(function() {
			$("#order_modal").fadeIn(400);
			$(".modal_background").show();
		});
		$(".modal_background").click(function() {
			$("#order_modal").fadeOut(200);
			$(".modal_background").hide();
		});
	})
	function setdeliveryOrder(oid) {
		if(confirm("确定发货吗？")){
		location.href = "${pageContext.request.contextPath}/admin?method=setdelivery&oid="
				+ oid;
		}
	};

	function showOrderInfo(i) {
		var value = ${json}; //数组
		var x = value[i].orderItems;
		console.log(x);
		var content;
		for (var a = 0; a < x.length; a++) {
			content += "<tr><td><img src='${pageContext.request.contextPath }/"
					+ x[a].product.image
					+ "' style='width: 100%; height: auto;'></td>";
			content += "<td>" + x[a].product.pname + "</td>";
			content += "<td>" + x[a].product.price + "</td>";
			content += "<td>" + x[a].count + "</td><td>" + x[a].subtotal
					+ "</td></tr>";
		}
		$(".orderItem").html(content);

	}
</script>
<style>
a,a:hover{
	text-decoration: none;
}
.order_table {
	margin-top: 20px;
	width: 99%;
	border: 1.5px solid rgb(48, 60, 69);
	table-layout: fixed;
	border-collapse: collapse;
	font-size: 15px;
	color: #e2e2e2;
}

.order_table tr {
	border-bottom: 1.5px solid rgb(48, 60, 69);
}

.order_table th {
	height: 40px;
	padding: 0 5px;
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

.col-uname {
	width: 80px;
	text-align: center;
}

.col-name {
	width: 80px;
	text-align: center;
}

.col-address {
	width: 220px;
	text-align: center;
}

.col-tel {
	width: 110px;
	text-align: center;
}

.col-action {
	width: 105px;
	text-align: center;
}

.action {
	cursor: pointer;
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
	background-color: rgb(63, 74, 83);
	margin: auto;
	opacity: 1;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	text-align: left;
}

.modal_header>a:hover .modal_close {
	background-color: rgb(63, 74, 83);
}


</style>
</head>
<body>
	<div style="font-size: 20px; color: rgb(110, 126, 141);">订单
		Orders</div>
	<table class="order_table">
		<tbody class="first_tbody">
			<tr>
				<th>购买者</th>
				<th>收货人</th>
				<th>地址</th>
				<th>联系方式</th>
				<th>操作</th>
				<th></th>
			</tr>
		</tbody>
		<colgroup>
			<col class="col-uname"></col>
			<col class="col-name"></col>
			<col class="col-address"></col>
			<col class="col-tel"></col>
			<col class="col-action"></col>
		</colgroup>
		<c:forEach var="order" items="${orderList}" varStatus="status">
			<tbody>
				<tr>
					<th colspan="6"
						style="height: 20px; background-color: inherit; border-left: 1.5px solid rgb(27, 31, 42); border-right: 1.5px solid rgb(27, 31, 42);"></th>
				</tr>
				<tr>
					<th colspan="6">订单号：${order.oid }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate
							type="both" value="${order.order_time}" />
					</th>
				</tr>
				<tr>
					<td>${order.address.user.uname }</td>
					<td>${order.address.name }</td>
					<td>${order.address.address }</td>
					<td>${order.address.tel }</td>
					<td><c:choose>
							<c:when test="${order.state == 0 }">未付款</c:when>
							<c:when test="${order.state == 1 }">
								<a href="javascript:;"
									onclick="setdeliveryOrder('${order.oid}')">发货</a>
							</c:when>
							<c:when test="${order.state == 2 }">
								<span class="action">已发货</span>
							</c:when>
							<c:when test="${order.state == 3 }">已完成</c:when>
						</c:choose></td>
					<td><a href="javascript:;" class = "showModal"
						onclick="showOrderInfo('${status.index}')">详情</a></td>
				</tr>
			</tbody>
		</c:forEach>

	</table>

	<div class="modal_background"></div>

	<div class="modal" id="order_modal">
		<div class="modal_header" style="height: 35px; line-height: 35px;">
			<a href="" style="color: #adadad">
				<div class="modal_close"
					style="float: right; display: block; font-size: 20px; width: 35px; text-align: center;">×</div>
			</a>
		</div>
		<div class="modal_body"
			style="display: flex; justify-content: flex-end; align-content: center; margin: 5px 0;">
			<div>
				<table class="order_table" style = "margin:20px auto;">
					<tbody>
						<tr>
							<th colspan="2">商品</th>
							<th>单价</th>
							<th>数量</th>
							<th>实付款</th>
						</tr>
					</tbody>
					<colgroup>
						<col class="col-name"></col>
						<col class="col-img"></col>
						<col class="col-price"></col>
						<col class="col-amount"></col>
						<col class="col-subtotal"></col>
					</colgroup>
					<tbody class = "orderItem">
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>