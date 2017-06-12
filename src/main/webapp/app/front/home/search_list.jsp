<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"  %>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>搜索【${term }】的结果-TAYLOR-星际旅行</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="custom/css/my_front.css">
<link rel="stylesheet" href="custom/css/my_front_list.css">
<script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="custom/js/front.js"></script>
<script type="text/javascript" src="custom/js/front_extra.js"></script>
</head>
<body>
	<!-- 顶部图片和菜单 -->
	<jsp:include page="header.jsp"></jsp:include>
	
	<!-- 主内容区域 -->
	<div style="max-width: 1200px;margin: 0 auto;">
		<div class="vic_content">
			<!-- 固定图片文章展示区域 -->
			<%-- <jsp:include page="banner.jsp"></jsp:include> --%>
			
			<div></div>
		
			<div class="vic_line_colorful"></div>
			<div class="vic_c_main" >
				<!-- 左边分栏 -->
				<jsp:include page="left.jsp"></jsp:include>
				<!-- 中部分栏 -->
				<div class="vic_c_center">
					<div class="vic_posts">
						<div class="vic_post_header">
							<!-- <div class="vic_trangle_l"></div> -->
							<!-- <div class="vic_trangle_r"></div> -->
							<div class="vic_header1">
								<a href="app/front/index">首页</a> >
								查询【${term }】的结果，共找到${size }条满足条件的数据：
							</div>
						</div>
						<c:forEach items="${searchResults }" var="blog">
							<div class="vic_post">
								<label class="vic_p_pic">
									<img alt="" src="custom/imgs/default.jpg">
								</label>
								<label class="vic_p_title">
									<a href="javascript:;" onclick="goDetail('app/front/blog?id=${blog.id }')">${blog.title }</a>
								</label>
								<label class="vic_p_info">
									作者：${blog.author }&nbsp;  
									时间 ：${blog.createDate }&nbsp;
								</label>
								<label class="vic_p_desc">
									${blog.description }
								</label>
								<label class="vic_p_more" onclick="goDetail('app/front/blog?id=${blog.id }')">
									阅读更多
								</label>
							</div>
						</c:forEach>
						<jsp:include page="../common/page_1.jsp">
							<jsp:param value="app/front/listpage" name="queryurl"/>
						</jsp:include>
					</div>
				</div>
				<!-- <div class="vic_c_right">
				</div> -->
				<div class="vic_footer">
					备案号： x-2017-03-25-1002516520
				</div>
			</div>
		</div>
	</div>
	<!-- <div class="vic_footer">
		备案号： x-2017-03-25-1002516520
	</div> -->
  </body>
</html>
