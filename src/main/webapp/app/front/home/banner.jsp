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
</head>
  <body>
    <div class="vic_line_colorful"></div>
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
