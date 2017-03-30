<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
    <script type="text/javascript" src="js/layer-v2.4/layer/layer.js"></script>
    
    <link rel="stylesheet" href="bootstrap-3.3.5-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="js/jqueryvalidate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/jqueryvalidate/messages_zh.js"></script>
	
	
</head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".pure-menu-list .pure-menu-link").each(function(){
			$(this).addClass("fa fa-paper-plane-o");
			var action = $(this).attr("action");
			//alert(action);
			$(this).click(function(){
				$(".pure-menu-list .pure-menu-link").removeClass("cus_active");
				$(this).addClass("cus_active");
				var hasSecond = $(this).attr("for");
				if(hasSecond!=undefined){
					$(this).removeClass("fa fa-paper-plane-o");
					if($("#"+hasSecond).css("display")=="none"){
						$("#"+hasSecond).show("normal");
						$(this).removeClass("fa fa-folder-o");
						$(this).addClass("fa fa-folder-open-o");
					}else{
						$("#"+hasSecond).hide("normal");
						$(this).removeClass("fa fa-folder-open-o");
						$(this).addClass("fa fa-folder-o");
					}
				}else{
					if(action!= undefined){
						$.ajax({
							url:action,
							type:"post",
							success:function(data){
								$("#main").html(data);
							}
						})
					}
				}
			
			});
		});
	});

	
	function alert(msg){
		layer.alert(msg);
	}
	function confirm(msg){
		var m = true;
		layer.confirm(msg,function(){
			m = true;;
		},function(){
			m = false;
		});
		return m;
	}

</script>
<style>
<!--
#menu{
	background-color: #E6E6E6
}
#menu .pure-menu-selected, #menu .pure-menu-heading {
    background: #3B3D3E;
}

.pure-menu-list li:HOVER{
	cursor: auto;
	/* background-color: #3B3D3E; */
}

.cus_active{
	/* background-color: #3B3D3E; */
	color: red;
}

.pure-menu-list-second{
	margin-left: -20px;

}
ul li label{
	width: 100%;
}

.header {
    margin-bottom: 10px;
    height: 100px;
    background-color: lightslategray;
 }
 
-->
</style>
<body>
<div id="layout">
    <!-- Menu toggle -->
    <a href="#menu" id="menuLink" class="menu-link">
        <!-- Hamburger icon -->
        <span></span>
    </a>
    <div id="menu">
        <div class="pure-menu">
            <label class="pure-menu-heading" >&nbsp;&nbsp;银河系</label>

            <ul class="pure-menu-list">
            	<c:forEach items="${menus }" var="menu">
            		<c:set value="${fn:length(menu.childrenMenu)}" var="leng"></c:set>
            		<c:choose>
            			<c:when test="${leng+1>1 }">
		            	 	<li class="pure-menu-item">
		            	 		<label href="javascript:;" class="pure-menu-link" for="${menu.id }" >&nbsp;&nbsp;${menu.title }</label>
		            	 		<ul class="pure-menu-list-second" id="${menu.id }" style="display: none;">
			            	 		<c:forEach items="${menu.childrenMenu }" var="childMenu">
						                <li class="pure-menu-item">
						                <label href="javascript:;" class="pure-menu-link" id="${childMenu.id }" action="<%=basePath %>/${childMenu.url }">&nbsp;&nbsp;${childMenu.title }</label>
						                </li>
			            	 		</c:forEach>
					            </ul>
		            	 	</li>
            			</c:when>
            			<c:otherwise>
		            	 	<li class="pure-menu-item">
		            	 		<label href="javascript:;" class="pure-menu-link" id="${menu.id }" action="<%=basePath %>/${menu.url }">&nbsp;&nbsp;${menu.title }</label>
		            	 	</li>
            			</c:otherwise>
            		</c:choose>
            	</c:forEach>
               <!--  <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link" action="app/mgr/user/list.action">用户</label></li>
                <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link" action="app/mgr/right/list.action">权限</label></li>

                <li class="pure-menu-item" class="menu-item-divided pure-menu-selected">
                    <label href="javascript:;" class="pure-menu-link" for="second">1级菜单</label>
                    <ul class="pure-menu-list-second" id="second" style="display: none;">
		                <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link" action="app/mgr/user/list.action">2级菜单</label></li>
		                <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link" action="app/mgr/right/list.action">2级菜单</label></li>
		
		                <li class="pure-menu-item" class="menu-item-divided pure-menu-selected">
		                    <label href="javascript:;" class="pure-menu-link" for="third"> 2级菜单</label>
		                    
		                    <ul class="pure-menu-list-second" id="third" style="display: none;">
				                <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link" action="app/mgr/user/list.action">3级菜单</label></li>
				                <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link" action="app/mgr/right/list.action">3级菜单</label></li>
				
				                <li class="pure-menu-item" class="menu-item-divided pure-menu-selected">
				                    <label href="javascript:;" class="pure-menu-link">3级菜单</label>
				                </li>
				
				                <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link">3级菜单</label></li>
				            </ul>
		                </li>
		
		                <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link">2级菜单</label></li>
		            </ul>
                </li>
                <li class="pure-menu-item"><label href="javascript:;" class="pure-menu-link">1级菜单</label></li> -->
                <li class="pure-menu-item"><label href="logout" action="logout" class="pure-menu-link">退出</label></li>
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