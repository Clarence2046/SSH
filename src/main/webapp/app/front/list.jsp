<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A layout example that shows off a blog page with a list of posts.">
    <title>光阴易逝 &ndash; 岁月无回</title>
    
<!--     <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/pure-min.css" integrity="sha384-" crossorigin="anonymous"> -->
    <link rel="stylesheet" href="third/pure/pure-release-0.6.2/pure-min.css" integrity="sha384-" crossorigin="anonymous">
    
    <!--[if lte IE 8]>
        <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/grids-responsive-old-ie-min.css">
    <![endif]-->
    <!--[if gt IE 8]><!-->
<!--         <link rel="stylesheet" href="https://unpkg.com/purecss@0.6.2/build/grids-responsive-min.css"> -->
        <link rel="stylesheet" href="third/pure/pure-release-0.6.2/grids-responsive-min.css">
    <!--<![endif]-->
    
    
        <!--[if lte IE 8]>
            <link rel="stylesheet" href="css/layouts/blog-old-ie.css">
        <![endif]-->
        <!--[if gt IE 8]><!-->
            <link rel="stylesheet" href="third/pure/blog/css/layouts/blog.css">
        <!--<![endif]-->
        <script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
    	<script type="text/javascript" src="third/js/layer-v2.4/layer/layer.js"></script>
        <link rel="stylesheet" href="third/bootstrap-3.3.5-dist/css/bootstrap.min.css">
		<script type="text/javascript" src="third/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
	    <link rel="stylesheet" href="third/font-awesome-4.7.0/css/font-awesome.min.css">
	    <link rel="stylesheet" href="custom/css/front.css">
</head>

<body>

<div id="layout" class="pure-g">
     <jsp:include page="sidebar.jsp"></jsp:include>

    <div class="content pure-u-1 pure-u-md-3-5">
        <div>
            <div class="posts" >
                <h1 class="content-subhead">
                	<a href="app/front/index">首页</a> > ${labelName }${listdescription }
                
                </h1>
                <c:forEach items="${page.pageList }" var="blog">
	                <section class="post" style="border-bottom: 1px dashed gray;padding-bottom: 0;">
	                   	<a href="app/front/blog?id=${blog['id'] }">${blog['title'] }</a> 
	                   	<div style="float: right;">${fn:substring(blog['createdate'],0,19) }</div>
	                </section>
                </c:forEach>
               
            </div>
		     <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
</div>

</body>
</html>
