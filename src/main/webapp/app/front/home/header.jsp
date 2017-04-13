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
<link rel="stylesheet" href="custom/css/my_front_list.css">
<script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="custom/js/front.js"></script>
<script type="text/javascript" src="custom/js/front_extra.js"></script> -->
<script type="text/javascript">
	$(document).ready(function() {
		$(".vic_menu li").click(function() {
			var action = $(this).attr("action");
			if(action!=undefined){
				window.location.href = "<%=basePath%>"+action;
			}
		});

	});
</script>
</head>

<style>
<!--



-->
</style>
  <body>
	<div class="vic_top">
		<div>
		<ul class="vic_menu">
			<li action="app/front/index">首页</li>
			<li>博览世界</li>
			<li>外语角</li>
			<li>记录</li>
			<li>关于我</li>
		</ul>
		</div>
		<label class="vic_introduce_0">禅</label>
		<label class="vic_introduce_1">乘风破浪会有时</label>
		<label class="vic_introduce_2">直挂云帆济沧海</label>
		<label class="showOrHideBanner"></label>
	</div>
  </body>
  <script type="text/javascript">
  	window.onscroll=function(){
  		var top = $(".vic_menu").offset().top;
  		var sctop = $(window).scrollTop();
  		var ptop = $(".showOrHideBanner").offset().top;
  		console.log(top-sctop);
  		console.log(ptop-sctop);
  		if(top-sctop<=0 && ptop-sctop<=0){
  			//固定到顶部
  			$(".vic_menu").addClass("vic_fix_top");
  		}else{
  			$(".vic_menu").removeClass("vic_fix_top");
  		}
  	};
  </script>
</html>
