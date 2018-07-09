<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>

<style>
a, a:hover {
	text-decoration: none;
}

.add_table td {
	height: 50px;
	font-size: 18px;
}

input {
	font-size: 18px;
}

.add_table tr {
	margin: 10px 0;
}

.add_button {
	display: inline-block;
	width: 70px;
	height: 45px;
	line-height: 45px;
	background-color: rgb(247, 132, 131);
	text-align: center;
}

.info_table {
	margin-top: 20px;
	width: 97%;
	border: 1px solid rgb(247, 132, 131);
	table-layout: fixed;
	border-collapse: collapse;
}

.info_table tr {
	border-bottom: 1px solid rgb(247, 132, 131);
}

.info_table th {
	height: 40px;
	padding: 0 5px;
	background-color: rgb(249, 172, 172);
	text-align: left;
}

.info_table td {
	padding: 5px;
	word-wrap: break-word;
	word-break: break-all;
}

.col-man {
	width: 95px;
}

.col-add {
	width: 250px;
}

.col-tel {
	width: 120px;
}

.col-action {
	
}

.modify, .del {
	cursor: pointer;
	color: rgb(110, 126, 141);
}
</style>
<script>
	$(function() {
		$(".modify").click(function() {
			var id = $(this).attr("data-aid");

			var x = document.getElementsByClassName(id);
			var td1 = x[0].innerHTML;//name
			var td2 = x[1].innerHTML;//add
			var td3 = x[2].innerHTML;//tel
			var td4 = x[3].innerHTML;//defaultAdd
			var td5 = x[4].innerHTML;//aid
			$("input[name = 'name']").val(td1);
			$("input[name = 'add']").val(td2);
			$("input[name = 'tel']").val(td3);
			$("input[name = 'aid']").val(td5);
			if (td4 == "true") {
				$("input[name = 'defaultAdd']").attr("checked", true);
			} else {
				$("input[name = 'defaultAdd']").removeAttr("checked");

			}
		});
	});
	function setDefault(aid) {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/userservlet?method=setDefaultCartUserAdd",
					data : {
						"aid" : aid
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
</head>
<body>
	<table class="info_table" border="0" cellspacing="0" cellpadding="0">
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
			<th>操作</th>
			<th></th>
		</tr>
		<c:forEach var="add" items="${addList }">
			<tr>
				<td class="${add.aid }">${add.name }</td>
				<td class="${add.aid }">${add.address }</td>
				<td class="${add.aid }">${add.tel }</td>
				<td class="${add.aid }" style="display: none;">${add.defaultAdd }</td>
				<td class="${add.aid }" style="display: none;">${add.aid }</td>

				<td><span class="modify" data-aid="${add.aid }">修改</span> <span>
						| </span> <span class="del" data-aid="${add.aid }">删除</span></td>
				<td class="choosen"><c:choose>
						<c:when test="${add.defaultAdd == true }">
							<div
								style="text-align: center; margin: 0 auto; display: block; width: 70px; height: 30px; line-height: 30px; font-size: 14px; color: #adadad; background-color: rgb(241, 55, 53)">默认地址</div>
						</c:when>
						<c:when test="${add.defaultAdd == false }">
							<a href="javascript:;" onclick="setDefault('${add.aid}')">选择</a>
						</c:when>
					</c:choose></td>
			</tr>
		</c:forEach>

	</table>
</body>
</html>