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
	background: -webkit-linear-gradient(rgba(1, 26, 33, 0.68), #2d2f2d);
	/* Safari 5.1 - 6.0 */
	background: -o-linear-gradient(rgba(1, 26, 33, 0.68), #2d2f2d);
	/* Opera 11.1 - 12.0 */
	background: -moz-linear-gradient(rgba(1, 26, 33, 0.68), #2d2f2d);
	/* Firefox 3.6 - 15 */
	background: linear-gradient(rgba(1, 26, 33, 0.68), #2d2f2d); /* 标准的语法（必须放在最后） */
	background-size: cover;
}

.pure-table {
	border-top: 1px solid #777777;
}

.login_banner {
	width: 311px;
	height: 50px;
	border-radius: 14px 14px 0px 0px;
	text-align:center;
	margin-left:-25px;
	border: 3px solid white;
}

.login_banner .login_title {
	margin-left: 0px;
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
	border-bottom-color: #121213;;;
	position: absolute;
}

.login_bg {
	background-color: white;
}

.login_div {
	position: absolute;
	top: 26%;
	left: 41%;
}

.parallelogram {
    width: 300px;
    height: 100px;
    background: #121213;
    margin-left:20px;
    margin-top:5px;
    -webkit-transform: skew(-0deg);
    -moz-transform: skew(-0deg);
    -o-transform: skew(-0deg);
    transform: skew(-0deg);
}  
.parallelogram_1 {
    width: 340px;
    height: 120px;
    margin-top: 120px;
    margin-left: -45px;
    background: #4f5165;
    -webkit-transform: skew(-30deg);
    -moz-transform: skew(-30deg);
    -o-transform: skew(-30deg);
    transform: skew(-30deg);
    position: absolute;
    border-radius:15px 15px; 
    box-shadow:5px 6px 5px;
}  

.right_trangle{
    width: 0px;
    height: 0px;
    /* border-left: 10px solid red; */
    border: 25px solid;
    margin-left: 283px;
    /* border-right: 10px solid red; */
    /* border-bottom-width: 10px; */
    border-bottom-color: yellow;
    border-top-color: blue;
    border-left-color: #807c7c;
    border-top-color: transparent;
    border-right-color: transparent;
    border-bottom-color: transparent;
    float: right;
    margin-top: -16px;
    position: absolute;
    z-index: -10;
}
.left_trangle{
    width: 0px;
    height: 0px;
    /* border-left: 10px solid red; */
    border: 25px solid;
    margin-left: -27px;
    /* border-right: 10px solid red; */
    /* border-bottom-width: 10px; */
    border-bottom-color: yellow;
    border-top-color: blue;
    border-left-color: transparent;
    border-top-color: transparent;
    border-right-color: #696a6b;
    border-bottom-color: transparent;
    float: right;
    margin-top: -16px;
    position: absolute;
    z-index: -10;
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
			<div class="left_trangle">
			</div>
			<div class="right_trangle">
			</div>
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
		<div class="parallelogram_1">
			<div class="parallelogram">
			</div>
		</div>
	</div>

</body>
</html>