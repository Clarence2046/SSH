<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="vic_posts" style="min-height: 700px;background-color: white;">
<div class="vic_post_header">
	<!-- <div class="vic_trangle_l"></div> -->
	<div class="vic_trangle_r"></div>
	<div class="vic_header1">
	<a href="app/front/index">首页</a> >
	<c:if test="${not empty labelName }">
		标签 >
	</c:if>
	${labelName }${listdescription }
	</div>
</div>
<c:forEach items="${page.pageList }" var="blog">
	<div class="vic_post">
		<label class="vic_p_pic">
			<img alt="" src="custom/imgs/default.jpg">
		</label>
		<label class="vic_p_title">
			<a href="javascript:;" onclick="goDetail('app/front/blog?id=${blog.id }&cls=${labelName }')">${blog.title }-${blog.subTitle }</a>
		</label>
		<label class="vic_p_desc">
			${blog.description }
		</label>
		<label class="vic_p_more" onclick="goDetail('app/front/blog?id=${blog.id }&cls=${labelName }')">
			阅读更多
		</label>
	</div>
</c:forEach>
<jsp:include page="../common/page_1.jsp">
	<jsp:param value="app/front/listpage?labelName=${labelName }" name="queryurl"/>
</jsp:include>
</div>