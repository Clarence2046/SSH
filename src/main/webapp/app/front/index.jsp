<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <script type="text/javascript">
	        $(document).ready(function(){
	        	$(".post-title").click(function(){
	        		var id = $(this).attr("aid");
	        		/* $.ajax({
	        			url:"app/front/blog",
	        			type:"POST",
	        			data:{"id":id},
	        			success:function(data){
	        				$(".content").html(data);
	        			}
	        		}); */
	        		window.location.href="app/front/blog?id="+id;
	        	
	        	});
	        
	        });
	        
	        function listblog(label){
	        	console.log(encodeURI("app/front/list?labelName="+label,"utf-8"));
	        	var url = encodeURI("app/front/list?labelName="+label,"utf-8");
	        	window.location.href=url;
	        }
	        function listall(){
	        	var url = encodeURI("app/front/listall");
	        	window.location.href=url;
	        }
        </script>
        <style type="text/css">
        .post-title:HOVER{
        	cursor: pointer;
        	color: green;
        }
        
        </style>
</head>
<body>

<div id="layout" class="pure-g">
    <jsp:include page="sidebar.jsp"></jsp:include>

    <div class="content pure-u-1 pure-u-md-3-5">
        <div>
            <!-- A wrapper for all the blog posts -->
            <div class="posts">
                <h1 class="content-subhead">简介</h1>

                <!-- A single blog post -->
                <section class="post">
                    <!-- <header class="post-header">
                        <img width="48" height="48" alt="Tilo Mitra&#x27;s avatar" class="post-avatar" src="third/pure/blog/img/common/tilo-avatar.png">

                        <h2 class="post-title" aid="1">Introducing Pure</h2>

                        <p class="post-meta">
                            By <a href="#" class="post-author">Tilo Mitra</a> under <a class="post-category post-category-design" href="#">CSS</a> <a class="post-category post-category-pure" href="#">Pure</a>
                        </p>
                    </header> -->

                    <div class="post-description">
                        <div>作者：Taylor</div>
                        <div>框架：ssh+spring Security+bootstrap + pure </div>
                        <div>数据库：MySQL 5</div>
                        <div>文章统计：（<a href="javascript:;" onclick="listall()">${fn:length(blogs) }篇</a>）</div>
                    </div>
                </section>
            </div>

            <div class="posts">
                <h1 class="content-subhead">最新文章 </h1>
				<c:forEach items="${blogs }" var="blog">
				
                <section class="post">
                    <header class="post-header">
                        <img width="48" height="48" alt="Eric Ferraiuolo&#x27;s avatar" class="post-avatar" src="third/pure/blog/img/common/tilo-avatar.png">

                        <h2 class="post-title" aid="${blog.id }">${blog.title }</h2>

                        <p class="post-meta">
                                                                                    作者 ：<a class="post-author" href="javascript:;">${blog.author }</a> 
                                                                                    阅读(${blog.views })
                                                                                    标签： 
                           	<c:forEach items="${blog.labelsList }" var="label">
                            	<a class="post-category post-category-js" href="javascript:;" onclick="listblog('${label}')" >${label }</a> 
                           	</c:forEach>
                        </p>
                    </header>

                    <div class="post-description">
                        <p>
                            ${blog.description}
                        </p>
                    </div>
                </section>

				</c:forEach>
            </div>
		    <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
</div>

</body>
</html>
