<%@ page language="java" pageEncoding="UTF-8"%>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
	$(function() {
		//页面加载完毕后去异步获得分类数据
		$
				.post(
						"${pageContext.request.contextPath}/admin?method=findAllCategory",
						function(data) {
							var content = "";
							for (var i = 0; i < data.length; i++) {
								content += "<option value='"+data[i].cid+"'>"
										+ data[i].cname + "</option>";
							}
							$("#cid").html(content);
						}, "json");

	});
</script>
<style>
table {
	background-color: transparent;
	color: #adadad;
}

td {
	background-color: transparent;
}

input {
	background-color: rgb(63, 74, 83);
	border: 0;
	color: #adadad;
}

textarea {
	background-color: rgb(63, 74, 83);
	border: 0;
}
button{
	background-color: rgb(128, 128, 128);
	border:0;
}
</style>
</HEAD>

<body>
	<!--  -->
	<form id="userAction_save_do" name="Form1"
		action="${pageContext.request.contextPath}/adminAddProduct"
		method="post" enctype="multipart/form-data">
		&nbsp;



		<table cellSpacing="1" cellPadding="5" width="100%" align="center"
			bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
			<tr>
				<td class="ta_01" align="center" bgColor="rgb(72, 83, 92)"
					colSpan="4" height="26"><strong><STRONG>添加商品</STRONG>
				</strong></td>
			</tr>

			<tr>
				<td width="18%" align="center" class="ta_01">商品名称：</td>
				<td class="ta_01" colspan="3"><input type="text" name="pname"
					value="" id="userAction_save_do_logonName" class="bg" /></td>

			</tr>
			<tr>
				<td width="18%" align="center" class="ta_01">市场价格：</td>
				<td class="ta_01"><input type="text" name="price" value=""
					id="userAction_save_do_logonName" class="bg" /></td>
			</tr>
			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					库存数量：</td>
				<td class="ta_01"><input type="number" name="amount" value=""
					id="userAction_save_do_logonName" class="bg" /></td>
			</tr>
			<tr>
				<td width="18%" align="center" class="ta_01">商品图片：</td>
				<td class="ta_01" colspan="3"><input type="file" name="upload" /></td>
			</tr>
			<tr>
				<td width="18%" align="center" class="ta_01">所属分类：</td>
				<td class="ta_01" bgColor="#ffffff" colspan="3"><select
					id="cid" name="cid">

				</select></td>
			</tr>
			<tr>
				<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
					商品描述：</td>
				<td class="ta_01" colspan="3"><textarea name="pdesc" rows="5"
						cols="30"></textarea></td>
			</tr>
			<tr>
				<td class="ta_01" style="WIDTH: 100%" align="center"
					bgColor="#f5fafe" colSpan="4">
					<button type="submit" id="userAction_save_do_submit" value="确定"
						class="button_ok">&#30830;&#23450;</button> <FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
					<button type="reset" value="重置" class="button_cancel">&#37325;&#32622;</button>

					<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT> <INPUT
					class="button_ok" type="button" onclick="history.go(-1)" value="返回"  style="background-color: rgb(128, 128, 128);color:#000"/>
					<span id="Label1"></span>
				</td>
			</tr>
		</table>
	</form>
</body>
</HTML>