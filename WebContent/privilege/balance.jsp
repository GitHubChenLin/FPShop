<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="cn.fpshop.domain.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>余额</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
<style>
body {
	margin: 0px;
	padding: 0px;
}

a, a:hover {
	text-decoration: none;
}

.user_balance {
	display: inline-block;
	width: 100%;
	height: auto;
}

.recharge {
	display: inline-block;
	width: 100%;
	height: auto;
}

.rechange_option {
	display: inline-block;
	width: 100%;
	height: 300px;
	text-align: left;
}

.recharge_option>.active, .recharge_option>.active:hover,
	.recharge_option>.active:focus {
	border: 1.5px solid rgb(241, 55, 53);
}

.recharge_option li {
	display: inline-block;
	float: left;
	min-width: 120px;
	height: 60px;
	line-height: 60px;
	text-decoration: none;
	text-align: center;
	font-size: 18px;
	margin: 0 25px 35px 0;
	cursor: pointer;
	border: 1.5px solid rgb(110, 126, 141);
}

#num_input {
	border: 0;
	width: 160px;
	float: left;
	display: inline;
	font-size: 18px;
	padding: 19px 0;
	background-color: transparent;
	outline: 0;
	cursor: default;
	outline: 0;
}

.pay_now {
	display: inline-block;
	width: 120px;
	height: 60px;
	line-height: 60px;
	text-align: center;
	background-color: rgb(247, 132, 131);
	margin: 20px 0 0 250px;
	cursor: pointer;
}

.pay_now:hover {
	background-color: rgb(241, 55, 53);
}
</style>
<script>
	$(function() {
		var time = new Date();
		var hour = time.getHours();
		if (hour >= 0 && hour < 6) {
			$(".time").html(" ，凌晨好！");
		} else if (hour >= 6 && hour < 12) {
			$(".time").html(" ，早上好！");
		} else if (hour == 12) {
			$(".time").html(" ，中午好！");
		} else if (hour > 12 && hour < 18) {
			$(".time").html(" ，下午好！");
		} else if (hour >= 18 && hour <= 23) {
			$(".time").html(" ，晚上好！");
		};

		$(".recharge_option > li").click(function() {
			$(".recharge_option > li").removeClass();
			$(this).addClass("active");
			var amount = $(this).attr("data-amount");
			var pay = 0;
			var value = 0;
			if (amount != 0) {
				pay = amount;
				$(".payment").html(pay + " 元");
				$("#num_input").val("");
				$(".payment").attr("data-pay", pay);
			} else {
				value = $("#num_input").val();
				if (value == "") {
					$(".payment").html(pay + " 元");
					$("#num_input").keyup(function() {
						var check = /^[1-9]\d{0,4}$|99999/;
						if (!check.test($("#num_input").val())) {
							$(".warn").html("请输入1-99999的正整数！");
						} else {
							$(".warn").html("");
							pay = $("#num_input").val();;
							$(".payment").html(pay + " 元");
							$(".payment").attr("data-pay", pay);
						}
					});
				} else {
					pay = value;
					$(".payment").html(pay + " 元");
					$(".payment").attr("data-pay", pay);
				}
				
			}
			
		});
		
	})
	
	function rechargeNow(){
		var pay = $(".payment").attr("data-pay");
		$.ajax({
			url : "${pageContext.request.contextPath}/userservlet?method=recharge",
			data : {"pay":pay},
			async : true,
			dataType : "json",
			type : "post",
			success : function(data) {
				var isSuccess = data.isSuccess;
				if (isSuccess == true) {
					parent.location.href = "${pageContext.request.contextPath}/privilege/recharge.jsp";
				} else {
					alert("服务器异常，请重新注册。");
				}
			}

		})
	}
</script>
</head>
<body>
	<div class="balance" style="width: auto; height: auto; display: block;">
		<div class="user_balance">
			<c:if test="${!empty user }">
				<div
					style="height: 60px; font-size: 19px; color: rgb(110, 126, 141);">${user.uname }<span
						class="time" style="color: black;"></span>
				</div>
				<div
					style="height: 60px; font-size: 19px; color: rgb(110, 126, 141);">
					<span>您的余额为： </span>${user.money }</div>
			</c:if>
		</div>
		<div class="recharge">
			<div style="height: 60px; font-size: 24px;">余额充值:</div>
			<div style="display: inline-block;">
				<ul class="recharge_option">
					<li data-amount="50">50元</li>
					<li data-amount="100">100元</li>
					<li data-amount="200">200元</li>
					<li data-amount="500">500元</li>
					<li data-amount="0" style="width: 205px; padding: 0 30px;"><span><input
							type="text" placeholder="其他金额" id="num_input" maxlength="5"> </span> <span
						style="float: right; display: inline;">元</span>
						<div class="warn"
							style="position: absolute; left: 45px; bottom: 195px; color: red; display: block;">
						</div></li>
				</ul>
			</div>

			<div style="display: inline-block; float: none; margin-top: 10px;">
				<div>
					<span style="height: 60px; font-size: 24px; display: inline;">支付金额：</span>
					<span class="payment"
						style="height: 60px; font-size: 24px; display: inline; color: rgb(241, 55, 53);">0
						元</span>
				</div>
				<div class="pay_now" onclick = "rechargeNow()">立即支付</div>
			</div>
		</div>
	</div>
</body>
</html>