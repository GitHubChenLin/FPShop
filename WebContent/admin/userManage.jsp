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
		$(".modal_background").click(function() {
			$("#addressInfo_modal").fadeOut(200);
			$(".modal_background").hide();
		});

	});
	function showAddList(uid) {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/admin?method=showAddressList",
					data : {
						"uid" : uid
					},
					async : true,
					dataType : "json",
					type : "post",
					success : function(data) {
						console.log(data);
						var content;
						console.log(data[0].name);
						for (var i = 0; i < data.length; i++) {
							content += "<tr><td>" + data[i].name + "</td>";
							content += "<td>" + data[i].address + "</td>";
							content += "<td>" + data[i].tel + "</td>";
							content += "<td style='display: none;'>"
									+ data[i].defaultAdd + "</td></tr>";
						}
						$(".addinfo").html(content);
						$("#addressInfo_modal").fadeIn(400);
						$(".modal_background").show();
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
		$("select[name = 'consume']").val("");
		var money = $("select[name = 'money']").val();
		if(money != ""){
			$.ajax({
				url : "${pageContext.request.contextPath}/admin?method=showMoney",
				data : {
					"money" : money
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
			
		}else{
			window.location.reload();
		}

	}
	function orderBy2() {
		$("select[name = 'money']").val("");
		var consume = $("select[name = 'consume']").val();
		if(consume != ""){
			$.ajax({
				url : "${pageContext.request.contextPath}/admin?method=showConsume",
				data : {
					"consume" : consume
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
			
		}else{
			window.location.reload();
		}

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

.info_table {
	margin: 20px auto;
	width: 97%;
	border: 1px solid #adadad;
	table-layout: fixed;
	border-collapse: collapse;
}

.info_table tr {
	border-bottom: 1px solid #adadad;
}

.info_table th {
	height: 40px;
	padding: 0 5px;
	text-align: left;
	color:#e2e2e2;
}

.info_table td {
	padding: 5px;
	word-wrap: break-word;
	word-break: break-all;
	color:#adadad;
}
</style>
</head>
<body>
	<div style="display: inline-block; width: 100%; height: 80px;">
		<span style="color: #adadad">余额：</span> 
		<select name="money" onchange = "orderBy1()">
			<option value="">默认</option>
			<option value="asc">升序</option>
			<option value="desc">降序</option>
		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #adadad">消费：</span>
		<select name="consume" onchange = "orderBy2()">
			<option value="">默认</option>
			<option value="asc">升序</option>
			<option value="desc">降序</option>
		</select>
	</div>

	<div class="new">

		<c:if test="${!empty userList }">
			<table class="product_table">
				<tbody class="first_tbody">
					<tr>
						<th>编号</th>
						<th>用户名</th>
						<th>昵称</th>
						<th>email</th>
						<th>年龄</th>
						<th>性别</th>
						<th>联系方式</th>
						<th>余额</th>
						<th>地址</th>
						<th>状态</th>
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
				<c:forEach var="user" items="${userList}">
					<tr>
						<td>${user.uid }</td>
						<td>${user.username }</td>
						<td>${user.uname }</td>
						<td>${user.email }</td>
						<td>${user.age }</td>
						<td><c:choose>
								<c:when test="${user.sex == true }">男</c:when>
								<c:when test="${user.sex == false }">女</c:when>
							</c:choose></td>
						<td>${user.telephone }</td>
						<td>${user.money }</td>
						<td><a href="javascript:;" class="showAddList"
							onclick="showAddList('${user.uid}')">详情</a></td>
						<td><c:choose>
								<c:when test="${user.ustate == 0 }">失效</c:when>
								<c:when test="${user.ustate == 1 }">正常</c:when>
							</c:choose></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>


		<!-- 修改资料模态框 -->
		<div class="modal_background"></div>

		<div class="modal" id="addressInfo_modal">
			<div class="modal_header" style="height: 35px; line-height: 35px;">
				<a href="" style="color: #adadad">
					<div class="modal_close"
						style="float: right; display: block; font-size: 20px; width: 35px; text-align: center;">×</div>
				</a>
			</div>
			<div class="modal_body" style="margin: 5px 0;">
				<table class="info_table" border="0" cellspacing="0" cellpadding="0">

					<tbody>
						<tr>
							<th>收货人</th>
							<th>详细地址</th>
							<th>联系方式</th>
						</tr>
					</tbody>
					<colgroup>
						<col class="col-man">
						<col class="col-add">
						<col class="col-tel">
					</colgroup>
					<tbody class="addinfo">

					</tbody>

				</table>
			</div>
		</div>
	</div>
</body>
</html>