<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="third/pure/pure-release-0.6.2/pure-min.css">
<link rel="stylesheet"
	href="third/pure/side-menu/css/layouts/side-menu.css">
<link rel="stylesheet"
	href="third/font-awesome-4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
<link rel="stylesheet"
	href="third/bootstrap-3.3.5-dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="third/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
</head>
<style>
<!--
html,body {
	width: 100%;
	height: 100%;
}

.back {
	background: -webkit-linear-gradient(#efe4e4, #3C3F56);
	/* Safari 5.1 - 6.0 */
	background: -o-linear-gradient(#efe4e4, #3C3F56);
	/* Opera 11.1 - 12.0 */
	background: -moz-linear-gradient(#efe4e4, #3C3F56);
	/* Firefox 3.6 - 15 */
	background: linear-gradient(#efe4e4, #3C3F56); /* 标准的语法（必须放在最后） */
	background-size: cover;
}

.pure-table {
	border-top: 1px solid #777777;
}

.login_banner {
	width: 284px;
	height: 40px;
	border-radius: 14px 14px 0px 0px;
	margin-left: -12px;
	border: 3px solid white;
}

.login_banner .login_title {
	margin-left: 25px;
	font-size: x-large;
	font-style: normal;
	font-weight: bold;
}

.login_form {
	z-index: 9999;
	width: 261px;
	border-left-width: 5px;
	border-left-style: dashed;
	border-right-width: 5px;
	border-right-style: dashed;
	border-bottom-style: solid;
	border-bottom-width: 20px;
	border-bottom-color: #8734f7;;
	position: absolute;
}

.login_bg {
	background-color: white;
}

.login_div {
	position: absolute;
	top: 30%;
	left: 42%;
}

.parallelogram {
    width: 300px;
    height: 100px;
    margin-top: 120px;
    margin-left: -20px;
    background: #8734f7;
    -webkit-transform: skew(-30deg);
    -moz-transform: skew(-30deg);
    -o-transform: skew(-30deg);
    transform: skew(-30deg);
}  
-->
</style>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var errors = '${param.ERROR_LOGIN_PASSWORD_OR_ACCOUNT}';
						console.log(errors);
						if (errors != undefined && errors.length > 0) {
							$("#login_error")
									.html(
											"<label style='color:red;margin:0;'>账号或密码错误</label>");
						}
					});
</script>

<body class="back">
	<div class="login_div">
		<div class="login_banner login_bg">
			<label class="login_title">后台管理系统</label>
		</div>
		<div class="login_form login_bg">
			<form class="pure-form " action="login.action" method="post">
				<table class="pure-table ">
					<tr>
						<td>
							<div class="input-group margin-bottom-sm" id="login_error">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="input-group margin-bottom-sm">
								<span class="input-group-addon"><i
									class="fa fa-user-o fa-fw"></i></span> <input class="form-control"
									name="username" type="text" placeholder="用户名">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="input-group">
								<span class="input-group-addon"><i
									class="fa fa-key fa-fw"></i></span> <input class="form-control"
									type="password" name="password" placeholder="密码">
							</div>
						</td>
					</tr>

					<tr style="margin-top: 3px;">
						<td align="center"><input type="submit" class="pure-button"
							value=" 登录 " /> <input type="reset" class="pure-button"
							value=" 重置 " /></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="parallelogram">
		
		</div>
	</div>

</body>
</html>