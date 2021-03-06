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
	background: -webkit-linear-gradient(white, white,#ccc);
	background: -o-linear-gradient(white, white,#ccc);
	background: -moz-linear-gradient(white,white, #ccc);
	background: linear-gradient(white, white,#ccc); 
	background-size: cover;
	background-color: black;
}

.pure-table {
	width: 100%;
/* 	box-shadow:5px 5px 3px,
				5px -5px 3px,
				-5px 5px 3px,
				-5px -5px 3px; */
	border:1px solid transparent;			
	border-top: 1px solid #777777;
	-webkit-border-image:url(custom/imgs/tea.jpg) 10 10 round;
	-moz-border-image:url(custom/imgs/tea.jpg) 10 10 round;
	-o-border-image:url(custom/imgs/tea.jpg) 10 10 round;
	border-image:url(custom/imgs/tea.jpg) 10 10 round;
}
.pure-table:HOVER {
	/* box-shadow:3px 3px 2px,
				3px -3px 2px,
				-3px 3px 2px,
				-3px -3px 2px; */
}

.login_banner {
	width: 411px;
	height: 50px;
	border-radius: 14px 14px 0px 0px;
	text-align:center;
	margin-left:0px;
	border: 3px solid white;
}
.login_bottom {
	width: 411px;
	height: 220px;
	text-align:center;
	margin-left:-25px;
	border: 3px solid white;
	border-radius: 0px 0px 14px 14px;
}

.login_banner .login_title {
	margin-left: 0px;
	font-size: x-large;
	font-style: normal;
	font-weight: bold;
}

.login_form {
	z-index: 9999;
	width: 351px;
	height:200px;
	z-index: 9999;
    width: 351px;
    height: 200px;
    position: absolute;
    top: 20%;
    left: 7%;
	position: absolute;
}

.login_bg {
	background-color: transparent;
}

.login_div {
	position: absolute;
	top: 26%;
	left: 37%;
	width: 411px;
    height: 300px;
    background: -webkit-linear-gradient(#ccc,white, white);
	background: -o-linear-gradient(#ccc,white, white);
	background: -moz-linear-gradient( #ccc,white, white);
	background: linear-gradient(#ccc,white, white); 
    background-color: white;
    box-shadow: 3px 1px 2px;
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

.input-group-addon,.form-control{
	height: 45px;
}
.pure-button{
	width: 100px;
	height: 36px;
	font-size: 18px;
}

.login_title{
	font-size: 26px;
    margin-left: 10%;
    margin-top: 18px;
    font-weight: bold;
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
									.html("<label style='color:red;margin:0;'>账号或密码错误</label>");
						}
					});
</script>

<body class="back">
	<div class="login_div">
		<!-- <div class="login_banner login_bg">
			<label class="login_title">后台管理系统</label>
			<div class="left_trangle">
			</div>
			<div class="right_trangle">
			</div>
		</div> -->
		<div class="login_title">后台管理</div>
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
		<!-- <div class="parallelogram_1">
			<div class="parallelogram">
			</div>
		</div> -->
		<!-- <div class="login_bottom login_bg">
			<label class="login_title">后台管理系统</label>
			<div class="left_trangle">
			</div>
			<div class="right_trangle">
			</div>
		</div> -->
	</div>

</body>
</html>