<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="pure/pure-release-0.6.2/pure-min.css">
<link rel="stylesheet" href="pure/side-menu/css/layouts/side-menu.css">
<link rel="stylesheet"
	href="font-awesome-4.7.0/css/font-awesome.min.css">
</head>
<style>
<!--
html,body{
    width:100%;
    height:100%;
}
.back{
	background: -webkit-linear-gradient(#0C0C0C, #3C3F56); /* Safari 5.1 - 6.0 */
    background: -o-linear-gradient(#0C0C0C, #3C3F56); /* Opera 11.1 - 12.0 */
    background: -moz-linear-gradient(#0C0C0C, #3C3F56); /* Firefox 3.6 - 15 */
    background: linear-gradient(#0C0C0C, #3C3F56); /* 标准的语法（必须放在最后） */
	background-size: cover;
}
.pure-table {
    border: 1px solid #777777;
}
.pure-table td {
    border-left: 1px solid #777777;
}
-->
</style>
<body class="back">
	<div >
		<form class="pure-form " action="login.action" method="post"
			style="position: absolute; top: 40%; left: 35%;">
			<table class="pure-table">
				<tr>
					<td>用户名：</td>
					<td><input type="text" name="username" /></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input type="password" name="password" /></td>
				</tr>
				<tr style="margin-top: 3px;">
					<td colspan="2" align="center"><input type="submit"
						class="pure-button" value=" 登录 " /> <input type="reset"
						class="pure-button" value=" 重置 " /></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>