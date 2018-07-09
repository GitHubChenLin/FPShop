<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	$(function() {
		$(".modify").click(function() {
			$("#productInfo_modal").fadeIn(400);
			$(".modal_background").show();

		});
		$(".modal_background").click(function() {
			$("#productInfo_modal").fadeOut(200);
			$(".modal_background").hide();
		});

	});
	function modify(pid) {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/admin?method=showProductInfo",
					data : {
						"pid" : pid
					},
					async : true,
					dataType : "json",
					type : "post",
					success : function(data) {
						$("input[name = 'pid']").val(data.pid);
						$("input[name = 'pname']").val(data.pname);
						$("input[name = 'price']").val(data.price);
						$("textarea[name = 'pdesc']").html(data.pdesc);
						$("input[name = 'amount']").val(data.amount);
					}

				})
	}
	function submitModify() {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/admin?method=modifyProduct",
					data : $("#modify_form").serialize(),
					async : true,
					dataType : "json",
					type : "post",
					success : function(data) {
						if (data.isSuc) {
							alert("修改成功");
							window.location.reload();
						} else {
							alert("服务器异常，请稍后再试");
						}
					}

				})
	}

	function orderBy() {
		var cateValue = $("select[name = 'category']").val();
		var price = $("select[name = 'price']").val();
		var amount = $("select[name = 'amount']").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/admin?method=orderBy",
			data : {
				"cid" : cateValue,
				"price" : price,
				"amount" : amount
			},
			async : true,
			dataType : "text",
			type : "post",
			success : function(data) {
				$(".new").empty().html(data);
			},
			error : function() {
				alert("服务器异常，请稍后再试");
			}

		})

	}
	function orderBy1() {
		$("select[name = 'amount']").val("");
		var cateValue = $("select[name = 'category']").val();
		var price = $("select[name = 'price']").val();
		var amount = $("select[name = 'amount']").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/admin?method=orderBy",
			data : {
				"cid" : cateValue,
				"price" : price,
				"amount" : amount
			},
			async : true,
			dataType : "text",
			type : "post",
			success : function(data) {
				$(".new").empty().html(data);
			},
			error : function() {
				alert("服务器异常，请稍后再试");
			}

		})

	}
	function orderBy2() {
		$("select[name = 'price']").val("");
		var cateValue = $("select[name = 'category']").val();
		var price = $("select[name = 'price']").val();
		var amount = $("select[name = 'amount']").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/admin?method=orderBy",
			data : {
				"cid" : cateValue,
				"price" : price,
				"amount" : amount
			},
			async : true,
			dataType : "text",
			type : "post",
			success : function(data) {
				$(".new").empty().html(data);
			},
			error : function() {
				alert("服务器异常，请稍后再试");
			}

		})

	}
</script>
<style>
a, a:hover {
	text-decoration: none;
}

.product_table {
	margin: 20px auto;
	width: 100%;
	border: 2px solid rgb(48, 60, 69);
	table-layout: fixed;
	border-collapse: collapse;
	font-size: 15px;
	color: #adadad;
}

.product_table tr {
	border-bottom: 2px solid rgb(48, 60, 69);
}

.product_table th {
	height: 40px;
	padding: 0 5px;
}

.product_table td {
	padding: 5px;
	word-wrap: break-word;
	word-break: break-all;
	text-align: center;
}

.first_tbody>tr>th {
	text-align: center;
}

.col-num {
	width: 50px;
	text-align: center;
}

.col-name {
	width: 130px;
	text-align: center;
}

.col-action {
	width: 50px;
	text-align: center;
}

.action {
	cursor: pointer;
}

.modify, .del {
	cursor: pointer;
	color: rgb(110, 126, 141);
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
	height: 500px;
	background-color: rgb(48, 60, 69);
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

.key {
	display: inline-block;
	float: left;
	font-size: 14px;
	height: 20px;
	line-height: 20px;
	margin: 5px;
	color: #adadad;
	background-color: transparent;
}

.value {
	height: 30px;
	width: 230px;
	margin: 5px;
	font-size: 16px;
	font-weight: 100;
	color: #000;
	background-color: rgb(143, 144, 145);
	border: 2px solid rgb(143, 144, 145);
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
	background-color: rgb(72, 83, 92);
}

.form_control:hover {
	background: rgb(128, 128, 128);
}
</style>
</head>
<body>
	<div style="display: inline-block; width: 100%; height: 80px;">
		<select name="category" style="" onchange="orderBy()">
			<option value="">全部</option>
			<c:forEach var="category" items="${categoryList }">
				<option value="${category.cid }"
					onclick="showProduct('${category.cid}')">${category.cname }</option>
			</c:forEach>
		</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #adadad">价格：</span>
		<select name="price" onchange="orderBy1()">
			<option value="">默认</option>
			<option value="asc">升序</option>
			<option value="desc">降序</option>
		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #adadad">库存：</span>
		<select name="amount" onchange="orderBy2()">
			<option value="">默认</option>
			<option value="asc">升序</option>
			<option value="desc">降序</option>
		</select>
	</div>
	<div>
		<a href="${pageContext.request.contextPath }/admin/addProduct.jsp"
			style="display: block; width: 80px; height: 50px; line-height: 50px; background-color: rgb(72, 83, 92); color: #adadad; text-align: center;">上传商品</a>
	</div>
	<div class="new">

		<c:if test="${!empty productList }">
			<table class="product_table">
				<tbody class="first_tbody">
					<tr>
						<th>编号</th>
						<th>商品名</th>
						<th>图片</th>
						<th>上架日期</th>
						<th>价格</th>
						<th>库存</th>
						<th>描述</th>
						<th>操作</th>
					</tr>
				</tbody>
				<colgroup>
					<col class="col-num"></col>
					<col class="col-name"></col>
					<col class="col-img"></col>
					<col class="col-pdate"></col>
					<col class="col-price"></col>
					<col class="col-amount"></col>
					<col class="col-desc"></col>
					<col class="col-action"></col>

				</colgroup>
				<c:forEach var="product" items="${productList}">
					<tr>
						<td>${product.pid }</td>
						<td>${product.pname }</td>
						<td><img
							src="${pageContext.request.contextPath }/${product.image }"
							style="width: 100%; height: auto;"></td>
						<td>${product.pdate }</td>
						<td>${product.price }</td>
						<td>${product.amount }</td>
						<td>${product.pdesc}</td>
						<td><span class="modify" data-aid="${product.pid }"
							onclick="modify('${product.pid}')">修改</span></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>


		<!-- 修改资料模态框 -->
		<div class="modal_background"></div>

		<div class="modal" id="productInfo_modal">
			<div class="modal_header" style="height: 35px; line-height: 35px;">
				<a href="" style="color: #adadad">
					<div class="modal_close"
						style="float: right; display: block; font-size: 20px; width: 35px; text-align: center;">×</div>
				</a>
			</div>
			<div class="modal_body"
				style="display: flex; justify-content: flex-end; align-content: center; margin: 5px 0;">
				<form id="modify_form" action="/FPShop/admin?method=modifyProduct"
					method="post">
					<div class=""
						style="display: inline-block; float: left; width: 100%; font-size: 25px; color: #7a7a7a; margin: 0 0 20px 5px;">修改产品信息
						Modify</div>
					<div>
						<table>
							<tr>
								<td><span class="key">编号：</span></td>
								<td><input id="reg_name" class="value" type="text"
									name="pid" placeholder="编号" value="" readonly="readonly"></td>
								<td>
									<div class="warn" id="reg_warn_input"></div>
								</td>
							</tr>
							<tr>
								<td><span class="key">商品名：</span></td>
								<td><input id="reg_name" class="value" type="text"
									name="pname" placeholder="商品名" value=""></td>
								<td>
									<div class="warn" id="reg_warn_input"></div>
								</td>
							</tr>
							<tr>
								<td><span class="key">价格：</span></td>
								<td><input id="reg_name" class="value" type="text"
									name="price" placeholder="价格" value=""></td>
								<td>
									<div class="warn" id="reg_warn_input"></div>
								</td>
							</tr>
							<tr>
								<td><span class="key">库存：</span></td>
								<td><input id="reg_name" class="value" type="text"
									name="amount" placeholder="库存" value=""></td>
								<td>
									<div class="warn" id="reg_warn_input"></div>
								</td>
							</tr>
							<tr>
								<td><span class="key">描述：</span></td>
								<td><textarea id="reg_name" class="value" name="pdesc"
										placeholder="描述" style="height: 100px;" wrap="soft"></textarea></td>
								<td>
									<div class="warn" id="reg_warn_input"></div>
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
						<input class="form_control" type="button" value="修改"
							onclick="submitModify()">
					</div>
				</form>

			</div>
		</div>
	</div>
</body>
</html>