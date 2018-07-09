<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<title>购物车</title>
<script>
	function delCartItem(pid) {
		if (confirm("您是否要删除该项？")) {
			location.href = "${pageContext.request.contextPath }/productservlet?method=delCartItem&pid="
					+ pid;
		}
	}

	function clearCart() {
		if (confirm("您是否要清空购物车？")) {
			location.href = "${pageContext.request.contextPath }/productservlet?method=clearCart";
		}
	}
	function setDefault(aid) {
		$.ajax({
			url : "${pageContext.request.contextPath}/userservlet?method=setDefaultCartAdd",
			data : {
				"aid" : aid
			},
			async : true,
			dataType : "text",
			type : "post",
			success : function(data) {
				$(".newAdd").empty().html(data);
			},
			error : function() {
				alert("服务器异常，请稍后再试");
			}

		})
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

.info_table {
	margin-top: 20px;
	width: 70%;
	border: 1px solid rgb(247, 132, 131);
	table-layout: fixed;
	border-collapse: collapse;
	margin: 0 auto;
}

.info_table tr {
	border-bottom: 1px solid rgb(247, 132, 131);
}

.info_table th {
	height: 40px;
	padding: 0 5px;
	background-color: rgb(249, 172, 172);
	text-align: center;
}

.info_table td {
	padding: 5px;
	word-wrap: break-word;
	word-break: break-all;
	text-align:center;
}

.col-man {
	width: 95px;
}

.col-add {
	width: 280px;
}

.col-tel {
	width: 150px;
}

.col-actions {
	width:118px;
}

.col-default {
	
}

.modify, .del {
	cursor: pointer;
	color: rgb(110, 126, 141);
}

.cart_table {
	margin-top: 20px;
	width: 100%;
	border: 1px solid rgb(247, 132, 131);
	table-layout: fixed;
	border-collapse: collapse;
	font-size: 15px;
	margin: 50px 0;
}

.cart_table tr {
	border-bottom: 1px solid rgb(247, 132, 131);
}

.cart_table th {
	height: 40px;
	padding: 0 5px;
	background-color: rgb(249, 172, 172);
	text-align: left;
	text-align: center;
}

.cart_table td {
	padding: 5px;
	word-wrap: break-word;
	word-break: break-all;
	text-align: center;
	font-size: 18px;
}

.col-img {
	width: 60px;
}

.col-pname {
	
}

.col-count {
	width: 80px;
	text-align: center;
}

.col-price {
	width: 120px;
	text-align: center;
}

.col-total {
	width: 115px;
	border-left: 1px solid rgb(247, 132, 131);
	border-right: 1px solid rgb(247, 132, 131);
	text-align: center;
}

.col-action {
	width: 65px;
	text-align: center;
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
				style="display: inline-block; height: 70px; line-height: 70px; float: left; margin-left: 20px;">购物车
				Shopping Cart</div>
		</div>
	</div>
	<div id="body1">


		<c:if test="${!empty cart.cartItems }">
			<div class = "newAdd">
				<c:if test="${!empty addListCart }">
					<table class="info_table" border="0" cellspacing="0"
						cellpadding="0">
						<colgroup>
							<col class="col-man">
							<col class="col-add">
							<col class="col-tel">
							<col class="col-actions">
						</colgroup>
						<tr>
							<th>收货人</th>
							<th>详细地址</th>
							<th>联系方式</th>
							<th></th>
						</tr>
						<c:forEach var="add" items="${addListCart }">
							<tr>
								<td class="${add.aid }">${add.name }</td>
								<td class="${add.aid }">${add.address }</td>
								<td class="${add.aid }">${add.tel }</td>
								<td class="choosen"><c:choose>
										<c:when test="${add.defaultAdd == true }">
											<div
												style="margin:0 auto;display:block;width:70px;height:30px;line-height:30px;font-size: 14px; color: #adadad; background-color: rgb(241, 55, 53)">默认地址</div>
										</c:when>
										<c:when test="${add.defaultAdd == false }">
											<a href="javascript:;" onclick="setDefault('${add.aid}')">选择</a>
										</c:when>
									</c:choose></td>
							</tr>
						</c:forEach>

					</table>
				</c:if>
			</div>
			<table class="cart_table">
				<tr class="first_tr">
					<th colspan="2">商品</th>
					<th>单价</th>
					<th>数量</th>
					<th>实付款</th>
					<th>操作</th>
				</tr>
				<colgroup>
					<col class="col-img"></col>
					<col class="col-pname"></col>
					<col class="col-price"></col>
					<col class="col-count"></col>
					<col class="col-total"></col>
					<col class="col-action"></col>
				</colgroup>
				<c:forEach items="${cart.cartItems }" var="entry">
					<tr>
						<td><a
							href="${pageContext.request.contextPath }/productservlet?method=productInfo&pid=${product.pid}&cid=${product.cid}"><img
								src="${pageContext.request.contextPath }/${entry.value.product.image}"
								style="width: 100%; height: auto;"></a></td>
						<td><a
							href="${pageContext.request.contextPath }/productservlet?method=productInfo&pid=${product.pid}&cid=${product.cid}">${entry.value.product.pname}</a></td>
						<td>${entry.value.product.price}</td>
						<td>${entry.value.buyNum}</td>
						<td>${entry.value.subtotal}</td>
						<td><a href="javascript:;"
							onclick="delCartItem('${entry.value.product.pid}')"
							style="color: #adadad">删除</a></td>
					</tr>
				</c:forEach>
			</table>
			<a href="javascript:;" onclick="clearCart()"
				style="font-size: 13px; color: #adadad; display: block; float: right; margin: 20px 0">清空购物车</a>
			<div
				style="font-size: 20px; float: right; clear: right; margin: 30px 0 10px 0;">
				支付金额：<span style="color: rgb(241, 55, 53)">￥<fmt:formatNumber
						type="number" value="${cart.total }" pattern="0.00"
						maxFractionDigits="2" /></span>
			</div>

			<a
				href="${pageContext.request.contextPath }/productservlet?method=addOrder"
				style="display: block; width: 80px; height: 50px; line-height: 50px; float: right; clear: right; margin: 20px 0; background-color: rgb(241, 55, 53);">提交订单</a>
		</c:if>
		<c:if test="${empty cart.cartItems }">
			<div style="font-size: 50px; color: red; text-align: center;">
				购物车什么都没有！</div>
			<div style="font-size: 50px; color: red; text-align: center;">
				快去买东西啊啊啊啊啊啊啊啊！！！</div>
			<a href="${pageContext.request.contextPath }/default.jsp"
				style="display: block; width: 80px; height: 50px; line-height: 50px; margin: 50px auto; background-color: rgb(241, 55, 53);">返回首页</a>
		</c:if>
	</div>

	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>