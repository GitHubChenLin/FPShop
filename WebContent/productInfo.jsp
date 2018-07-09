<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="styleSheet" href="./css/index.css">
<script>
	function addCart(){
		var buyNum = $(".buyNum").val();
		location.href = "${pageContext.request.contextPath}/productservlet?method=addCart&pid=${product.pid}&buyNum="+buyNum;
	}
</script>
<style>
.left{
	box-sizing: border-box;
	width:460px;
	float:left;
	display:block;
}
.right{
	box-sizing: border-box;
	width:600px;
	float:left;
	display:block;
	text-align:left;
}
</style>
<title>${product.pname }</title>
</head>
<body>
	<div id = "aaa"><jsp:include page="/header.jsp"></jsp:include></div>
	
	<div id = "body" style = "background-color:rgb(252, 213, 213);">
		<div class = "left">
			<div style = "width:420px;height:420px;margin:20px auto ;display:table;">
				<img src = "${pageContext.request.contextPath }/${product.image}"  alt = "${product.pname }" style = "width:100%;height:100%;vertical-align: middle;">
			</div>
		</div>
		<div class = "right">
			<div style = "width:100%;font-size:25px;margin:20px 10px;">${product.pname }</div>
			<div style="width: 100%; margin:20px 0;">
				<div>上市时间：${product.pdate }</div>
				<div style="height:30px;">
					价格: <span style="color: rgb(241, 55, 53); font-size: 19px;">${product.price }</span>
				</div>
			</div>
			<div style = "font-size:14px;margin: 25px 0;color:#adadad">${product.pdesc }</div>
			<div style = "height:20px;">
				<span>数量：</span><input class = "buyNum" name = "buyNum" type = "number" value = "1" min = "1" style = "width:50px;">&nbsp;&nbsp;&nbsp;<span>库存：${product.amount }</span>
			</div>
			<div><a href = "javascript:;"  onclick = "addCart()" style = "display:inline-block;width:90px;height:40px;line-height:40px;text-align:center;background-color:rgb(241, 55, 53);border:0px;margin:20px 0;">加入购物车</a></div>
			<a style = "margin-top:120px;display:block;color:#adadad;font-size:13px;" href = "${pageContext.request.contextPath}/productservlet?method=findProductListByCid&cid=${cid }">返回列表页面</a>
		</div>
	</div>
	
	<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>