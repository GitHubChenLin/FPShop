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
	function modify(cid,cname){
		$("input[name= 'cid']").val(cid);
		$("input[name= 'cname']").val(cname);
		var value = $("input[name= 'cid']").val();
		if(value != ""){
			$(".button").val("修改");
			}
	}
	function changeText(){
		var value = $("input[name= 'cname']").val();
		if(value == ""){
			$("input[name= 'cid']").val("");
			$(".button").val("添加");
		}
	}
</script>
<style>
.category_table {
	margin: 20px auto;
	width: 70%;
	border: 2px solid rgb(48, 60, 69);
	table-layout: fixed;
	border-collapse: collapse;
	font-size: 15px;
	color: #adadad;
}

.category_table tr {
	border-bottom: 2px solid rgb(48, 60, 69);
}

.category_table th {
	height: 40px;
	padding: 0 5px;
}

.category_table td {
	padding: 5px;
	word-wrap: break-word;
	word-break: break-all;
	text-align: center;
}

.first_tbody>tr>th {
	text-align: center;
}

.col-num {
	width: 130px;
	text-align: center;
}

.col-name {
	width: 150px;
	text-align: center;
}

.col-action {
	width: 130px;
	text-align: center;
}

.action {
	cursor: pointer;
}

.modify, .del {
	cursor: pointer;
	color: rgb(110, 126, 141);
}
</style>
</head>
<body>

	<div style = "margin:0 auto;display:block;text-align:center;">
		<form action = "${pageContext.request.contextPath }/admin?method=addOrchange" method="post">
			<input name = "cid" style = "display:none;">
			<input type = "text" name = "cname" style = "font-size:20px;height:30px;padding:0;margin:0;border:0;" oninput="changeText()">&nbsp;&nbsp;&nbsp;
			<span><input type = "submit" value = "添加" class = "button" style = "display:inline-block;width:60px;height:30px;line-height:30px;background-color: rgb(128, 128, 128);text-align:center;border:0;"></span>
		</form>
	</div>
	<c:if test="${!empty categoryList }">
		<table class="category_table">
			<tbody class="first_tbody">
				<tr>
					<th>编号</th>
					<th>类名</th>
					<th>操作</th>
				</tr>
			</tbody>
			<colgroup>
				<col class="col-num"></col>
				<col class="col-name"></col>
				<col class="col-action"></col>
			</colgroup>
			<c:forEach var="category" items="${categoryList}">
				<tr>
					<td>${category.cid }</td>
					<td>${category.cname }</td>
					<td><span class="modify" data-aid="${category.cid }" onclick = "modify('${category.cid }','${category.cname}')">修改</span> <span>
							| </span> <span class="del" data-aid="${category.cid }" onclick= "">删除</span></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	
</body>
</html>