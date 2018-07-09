<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./js/jquery-1.11.3.min.js"></script>
<script>
	
</script>
<link type="text/css" rel="styleSheet" href="./css/index.css">
<style>
.pagination{
	text-align:center;
	display:inline-block;
	list-style: none;
}

.pagination > li{
	float:left;
	width:auto;
	height:auto;
	text-decoration: none;
}
.pagination >li a{
	text-decoration: none;
	display:block;
	width:40px;
	height:40px;
	line-height:40px;
	background-color:rgb(247, 132, 131);
	border:0.5px solid rgb(241, 55, 53);
	color:#000;
	
}
.pagination >li a:hover{
	background-color:rgb(244, 93, 92);
	
}
.pagination >li >.activePage{
	background-color:rgb(244, 93, 92);
}
</style>
<title>FPShop，一站式购物体验！</title>
</head>
<body>
	<div id = "aaa"><jsp:include page="/header.jsp"></jsp:include></div>
	<div id = "body" style = "">
		<div class="product-list" data-cid = "">
			<c:forEach var="product" items="${pageBean.list }">
				<div class="product-item1">
					<a href="${pageContext.request.contextPath }/productservlet?method=productInfo&pid=${product.pid}&cid=${product.cid}"
						style="border: 1px solid rgb(241, 55, 53); display: block; width: 100%; height: auto;">
						<img
						src="${pageContext.request.contextPath }/${product.image }"
						style="width: 100%; height: auto;"></a>
					<div
						style="padding: 8px; text-align: left; color: rgb(241, 55, 53);">￥${product.price }</div>
					<div style=""><a href="${pageContext.request.contextPath }/productservlet?method=productInfo&pid=${product.pid}&cid=${product.cid}">${product.pname }</a></div>
				</div>
			</c:forEach>
		</div>
		<div class="" style="width: 100%;height:auto; margin: 0 auto; margin-top: 20px;display:block;">
			<ul class="pagination" style="">
				<c:if test="${pageBean.currentPage==1}">
					<li><a href="javascript:void(0);"  style = "margin-right:5px;cursor:not-allowed;">◀</a></li>	
				</c:if>
				<c:if test="${pageBean.currentPage!=1}">
					<li><a href="${pageContext.request.contextPath }/productservlet?method=findProductListByCid&cid=${cid}&currentPage=${pageBean.currentPage-1}" style = "margin-right:5px;">◀</a></li>	
				</c:if>
				
				
				<c:forEach var = "page" begin="1" end = "${pageBean.totalPage }">
					<c:if test="${page == pageBean.currentPage }">
						<li><a href="javascript:void(0);" class = "activePage" style = "cursor:default;">${page }</a></li>
					</c:if>
					<c:if test="${page != pageBean.currentPage }">
						<li><a href="${pageContext.request.contextPath }/productservlet?method=findProductListByCid&cid=${cid}&currentPage=${page}">${page }</a></li>
					</c:if>
				</c:forEach>
				
				
				<c:if test="${pageBean.currentPage==pageBean.totalPage}">
					<li><a href="javascript:void(0);" style = "margin-left:5px;cursor:not-allowed;">▶</a></li>	
				</c:if>
				<c:if test="${pageBean.currentPage!=pageBean.totalPage}">
					<li><a href="${pageContext.request.contextPath }/productservlet?method=findProductListByCid&cid=${cid}&currentPage=${pageBean.currentPage+1}" style = "margin-left:5px;">▶</a></li>	
				</c:if>
			</ul>
		</div>
	</div>
	
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>