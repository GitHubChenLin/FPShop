<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<c:if test="${!empty addListCart }">
		<table class="info_table" border="0" cellspacing="0" cellpadding="0">
			<colgroup>
				<col class="col-man">
				<col class="col-add">
				<col class="col-tel">
				<col class="col-actions">
				<col class="col-default">
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
					<td class="${add.aid }" style="display: none;">${add.defaultAdd }</td>
					<td class="${add.aid }" style="display: none;">${add.aid }</td>
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
</body>
</html>