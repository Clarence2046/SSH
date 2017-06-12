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
<title>TAYLOR-星际旅行</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="custom/css/my_front.css">
<link rel="stylesheet" href="custom/css/my_front_index.css">
<script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="custom/js/front.js"></script>
<script type="text/javascript" src="custom/js/front_extra.js"></script>
</head>
  <body>
	<!-- 顶部图片和菜单 -->
	<jsp:include page="header.jsp"></jsp:include>
	
	<!-- 主内容区域 -->
	<article style="max-width: 1200px;margin: 0 auto;">
		<div class="vic_content">
			
			<!-- 固定图片文章展示区域 -->
			<jsp:include page="banner.jsp"></jsp:include>
			
			<div></div>
			
			<div class="vic_c_main">
				<!-- 左边分栏 -->
				<jsp:include page="left.jsp"></jsp:include>
				<!-- 中部分栏 -->
				<div class="vic_c_center">
					<div class="vic_c_holder">
						<div class="vic_pic_area">
							<!-- 最开始设计成放置图片的，但不知道有什么用，所以变了个js动画在这里 -->
							<!-- <img alt="" src="#"> -->
							<div class="vic_ball vic_balls" id="ball1"></div>
							<div class="vic_ball_1 vic_balls"  id="ball2" time="3000"></div>
							<div class="vic_ball_1 vic_balls" id="ball3" time="3000"></div>
							<div class="vic_ball_2 vic_balls" id="ball4" time="4000"></div>
							<div class="vic_ball_2 vic_balls" id="ball5" time="4000"></div>
							<span class="vic_ball_label vic_balls" id="ball6" time="6000" changeback="false">欢迎你的到来！</span>
							<!--操作在 front.js-->
							<script type="text/javascript">
							</script>
						</div>
						<div class="vic_pic_title"></div>
					</div>
					<div class="vic_posts">
						<div class="vic_post_header">
							<!-- <div class="vic_trangle_l"></div> -->
							<!-- <div class="vic_trangle_r"></div> -->
							<div class="vic_header1">
							最新文章
							</div>
						</div>
						<c:forEach items="${blogs }" var="blog">
							<div class="vic_post">
								<label class="vic_p_pic">
									<img alt="" src="custom/imgs/default.jpg">
								</label>
								<label class="vic_p_title">
									<a href="app/front/blog?id=${blog.id }">${blog.title }-${blog.subTitle }</a>
								</label>
								<label class="vic_p_info">
									作者：${blog.author }&nbsp;  
									时间 ：<fmt:formatDate value="${blog.createDate }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;
									分类：<c:forEach items="${blog.labelsList }" var="label">
			                            	<a  class="vic_label" href="javascript:;" onclick="listblog('${label}')" >${label }</a> 
			                           	</c:forEach>
								</label>
								<p class="vic_p_desc">
									${blog.description }
								</p>
							</div>
						</c:forEach>
						
					</div>
				</div>
				<!-- <div class="vic_c_right">
				</div> -->
				<div class="vic_footer">
					备案号： x-2017-03-25-1002516520
				</div>
			</div>
		</div>
	</article>
	<!-- <div class="vic_footer">
		备案号： x-2017-03-25-1002516520
	</div> -->
  </body>
</html>
