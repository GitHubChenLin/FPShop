<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单</title>
<script>
	function confirmRec(oid) {
		if(confirm("是否确认收货")){
			location.href = "${pageContext.request.contextPath}/productservlet?method=confirmRec&oid="+oid; 
		}
	}
</script>
<style>
a,a:hover{
	text-decoration: none;
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

.col-action {
	width: 85px;
	text-align: center;
}

.action {
	cursor: pointer;
}
</style>
</head>
<body>
	<div style="font-size: 20px; color: rgb(110, 126, 141);">订单
		Orders</div>
	<table class="order_table">
		<tbody class="first_tbody">
			<tr>
				<th colspan="2">商品</th>
				<th>单价</th>
				<th>数量</th>
				<th>实付款</th>
				<th>操作</th>
			</tr>
		</tbody>
		<colgroup>
			<col class="col-img"></col>
			<col class="col-pname"></col>
			<col class="col-price"></col>
			<col class="col-count"></col>
			<col class="col-total"></col>
			<col class="col-action"></col>
		</colgroup>
		<c:forEach var="order" items="${orderList}">
			<tbody>
				<tr>
					<th colspan="6"
						style="height: 20px; background-color: inherit; border-left: 1px solid rgb(252, 213, 213); border-right: 1px solid rgb(252, 213, 213);"></th>
				</tr>
				<tr>
					<th colspan="6">订单号：${order.oid }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate
							type="both" value="${order.order_time}" />
					</th>
				</tr>
				<c:forEach var="item" items="${order.orderItems }" begin="0" end="0">
					<tr>
						<td><img
							src="${pageContext.request.contextPath }/${item.product.image }"
							style="width: 100%; height: auto;"></td>
						<td>${item.product.pname }</td>
						<td>${item.product.price }</td>
						<td>${item.count }</td>
						<td rowspan="${order.orderItems.size()}">${order.total }</td>
						<td rowspan="${order.orderItems.size()}"
							data-state="${order.state }"><c:choose>
								<c:when test="${order.state == 0 }">未付款</c:when>
								<c:when test="${order.state == 1 }">未发货</c:when>
								<c:when test="${order.state == 2 }">
									<span class="action"><a href="javascript:;"
										onclick="confirmRec('${order.oid}')">确认收货</a></span>
								</c:when>
								<c:when test="${order.state == 3 }">已完成</c:when>
							</c:choose></td>
					</tr>
				</c:forEach>
				<c:forEach var="item" items="${order.orderItems }" begin="1">
					<tr>
						<td><img
							src="${pageContext.request.contextPath }/${item.product.image }"
							style="width: 100%; height: auto;"></td>
						<td>${item.product.pname }</td>
						<td>${item.product.price }</td>
						<td>${item.count }</td>
					</tr>
				</c:forEach>
			</tbody>
		</c:forEach>

	</table>
</body>
</html>