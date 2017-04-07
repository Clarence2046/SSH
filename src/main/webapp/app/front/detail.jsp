<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
<script type="text/javascript">
 			function listblog(label){
	        	console.log(encodeURI("app/front/list?labelName="+label,"utf-8"));
	        	var url = encodeURI("app/front/list?labelName="+label,"utf-8");
	        	window.location.href=url;
	        }

</script>
<body>
<div id="layout" class="pure-g">
     <jsp:include page="sidebar.jsp"></jsp:include>

    <div class="content pure-u-1 pure-u-md-3-5">
        <div>
            <div class="posts">
                <h1 class="content-subhead">
                	<a href="app/front/index">首页</a> >
                	${blog.title }
                
                </h1>
                <!-- 博客文章详情展示处 -->
                <section class="post">
                    <header class="post-header">
                        <img width="48" height="48" alt="Eric Ferraiuolo&#x27;s avatar" class="post-avatar" src="third/pure/blog/img/common/tilo-avatar.png">

                        <h2 class="post-title" aid="${blog.id }">${blog.title }</h2>

                        <p class="post-meta">
							作者 ：<a class="post-author" href="javascript:;">${blog.author }</a> 
                                                                                    阅读(${blog.views })
                                                                                    标签： 
                           	<c:forEach items="${blog.labelsList }" var="label">
                            	<a class="post-category post-category-js" href="javascript:;" onclick="listblog('${label}')">${label }</a> 
                           	</c:forEach>
                        </p>
                    </header>

                    <div class="post-description">
                        <p>
                            ${blog.contentHtml }
                        </p>
                    </div>
                </section>
                <c:if test="${blog.lockComment==0 }">
	                <section class="cus_comment_section">
					<!-- 评论框展示处 -->
	                </section>
	               	<script type="text/javascript">
	               		var blogId = '${blog.id}';
	               		$(document).ready(function(){
	               			loadComments(blogId);
	               		});
	               		function loadComments(blogId){
			      			$.ajax({
			      				url:"app/front/comments",
			      				type:"Post",
			      				data:{"blogId":blogId},
			      				success:function(data){
			      					$(".cus_comment_section").html(data);
			      				}
			      			});
			      		}
	               	</script>
                </c:if>
            </div>
		     <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
</div>

</body>
</html>
