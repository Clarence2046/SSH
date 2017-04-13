<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>My JSP 'home.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!-- <link rel="stylesheet" href="custom/css/my_front.css">
<script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="custom/js/front.js"></script>
<script type="text/javascript" src="custom/js/front_extra.js"></script> -->
</head>
  <body>
	<div class="vic_c_banner">
		<ul class="vic_pic_banner">
			<li>
				<img alt="" src="custom/imgs/times.jpg">
				<label class="vic_desc_pic">文字</label>
			</li>
			<li>
				<img alt="" src="custom/imgs/tea.jpg">
				<label class="vic_desc_pic">文字</label>
			</li>
			<li>
				<img alt="" src="custom/imgs/times.jpg">
				<label class="vic_desc_pic">文字</label>
			</li>
			<li>
				<img alt="" src="custom/imgs/tea.jpg">
				<label class="vic_desc_pic">闲暇时光</label>
			</li>
		</ul>
	</div>
  </body>
</html>
