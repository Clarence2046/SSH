<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>

<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>">
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Pure 后台管理  博客">
    <title>个人博客后台管理</title>
    <link rel="stylesheet" href="pure/pure-release-0.6.2/pure-min.css">
    <link rel="stylesheet" href="pure/side-menu/css/layouts/side-menu.css">
    
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
    
    <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    
    <link rel="stylesheet" href="bootstrap-3.3.5-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="js/jqueryvalidate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/jqueryvalidate/messages_zh.js"></script>
	
	
</head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".pure-menu-list .pure-menu-link").each(function(){
			var action = $(this).attr("action");
			//alert(action);
			if(action!=undefined){
				$(this).click(function(){
					$.ajax({
						url:action,
						type:"post",
						success:function(data){
							$("#main").html(data);
						}
					})
				});
			}
		});
	});



</script>

<body>
<div id="layout">
    <!-- Menu toggle -->
    <a href="#menu" id="menuLink" class="menu-link">
        <!-- Hamburger icon -->
        <span></span>
    </a>
    <div id="menu">
        <div class="pure-menu">
            <a class="pure-menu-heading" href="#">&nbsp;&nbsp;银河系</a>

            <ul class="pure-menu-list">
                <li class="pure-menu-item"><a href="javascript:;" class="pure-menu-link" action="app/mgr/user.action">用户</a></li>
                <li class="pure-menu-item"><a href="javascript:;" class="pure-menu-link">权限</a></li>

                <li class="pure-menu-item" class="menu-item-divided pure-menu-selected">
                    <a href="javascript:;" class="pure-menu-link">Services</a>
                </li>

                <li class="pure-menu-item"><a href="javascript:;" class="pure-menu-link">Contact</a></li>
                <li class="pure-menu-item"><a href="logout" class="pure-menu-link">Exit</a></li>
            </ul>
        </div>
    </div>

    <div id="main">
      	<!-- 填充内容 -->
    </div>
</div>




<script src="pure/side-menu/js/ui.js"></script>

</body>
</html>