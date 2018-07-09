<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<script>
	$(function(){
		setTimeout(function(){
			window.history.back();
		},3000);
	})
</script>
<title>余额不足！</title>
</head>
<body>
	余额不足，将在3秒后跳回付款界面...
</body>
</html>