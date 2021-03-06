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
	<c:set var="basePath" value="<%=basePath %>"></c:set>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Pure 后台管理  博客">
    <title>个人博客后台管理</title>
    <link rel="stylesheet" href="third/pure/pure-release-0.6.2/pure-min.css">
    <link rel="stylesheet" href="third/pure/side-menu/css/layouts/side-menu.css">
    
    <link rel="stylesheet" href="third/font-awesome-4.7.0/css/font-awesome.min.css">
    
    <script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="third/js/layer-v2.4/layer/layer.js"></script>
    
    <link rel="stylesheet" href="third/bootstrap-3.3.5-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="third/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="third/js/jqueryvalidate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="third/js/jqueryvalidate/messages_zh.js"></script>
	

	<link rel="stylesheet" href="custom/css/custom.css">
</head>
<script type="text/javascript">
	$(document).ready(function(){
		$(".pure-menu-list .pure-menu-link").each(function(){
			$(this).addClass("fa fa-paper-plane-o");
			var action = $(this).attr("action");
			//alert(action);
			var hasSecond = $(this).attr("for");
			if(hasSecond!=undefined){
				$(this).removeClass("fa fa-paper-plane-o");
				$(this).addClass("fa fa-folder-o");
			}
			$(this).click(function(){
				$(".pure-menu-list .pure-menu-link").removeClass("cus_active");
				$(this).addClass("cus_active");
				var hasSecond = $(this).attr("for");
				if(hasSecond!=undefined){
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
							url:action+"?t="+Math.random(),
							type:"post",
							success:function(data){
								$("#main").html(data);
							}
						})
					}
				}
			
			});
		});
		
		
		
		//获取时间
		getCurTime();
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

	function logout(){
		window.location.href="${basePath}/logout";
	}
	function goFront(){
		window.location.href="${basePath}/app/front/index";
	}
	
	//获取当前时间
	function getCurTime(){
		var date = new Date();
		var dd = fmtStr(date.getDate(),2);
		var MM = fmtStr(date.getMonth(),2);
		var YYYY = date.getFullYear();
		var HH = fmtStr(date.getHours(),2); 
		var mm = fmtStr(date.getMinutes(),2);
		var ss = fmtStr(date.getSeconds(),2);
		
		var str = "系统时间：" +YYYY+"-"+MM+"-"+dd+" "+HH+":"+mm+":"+ss+"";
		//console.log("系统时间：" +YYYY+"-"+MM+"-"+dd+" "+HH+":"+mm+":"+ss+"");
		$("#cus_timearea").html(str);
		setTimeout("getCurTime()",1000);
	}
	
	function fmtStr(str,n){
		var s = "000000000"+str; 
		return s.substring(s.length-n,s.length);
	}

</script>

<body>
<div class="cus_nav">
	<div class="cus_area">
		<div  id="cus_loginUser">当前用户：${LOGIN_USERNAME }</div>
		<div id="cus_timearea">系统时间：2017-12-20 11:11:11</div>
	</div>
</div>
<div id="layout">
    <!-- Menu toggle -->
    <a href="#menu" id="menuLink" class="menu-link">
        <!-- Hamburger icon -->
        <span></span>
    </a>
    <div id="menu">
        <div class="pure-menu">
            <div class="pure-menu-heading" >
            		<label class="cus_head_label1">后&nbsp;&nbsp;台</label>
            		<label class="cus_head_label2">管&nbsp;&nbsp;理</label>
            </div>

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
             <li class="pure-menu-item"><label onclick="goFront()" class="pure-menu-link"> 前台</label></li>
             <li class="pure-menu-item"><label onclick="logout()" class="pure-menu-link"> 退出</label></li>
            </ul>
        </div>
    </div>

    <div id="main">
      	<!-- 填充内容 -->
      	<!-- <i class="fa fa-spinner fa-spin"></i>
                        <i class="fa fa-circle-o-notch fa-spin"></i>
                        <i class="fa fa-refresh fa-spin"></i>
                        <i class="fa fa-cog fa-spin"></i>
                        <i class="fa fa-spinner fa-pulse"></i>
                        
         <button class="cus_btn1"></button>               
         <button style="width: 100px;height: 100px;border-radius:100px 0px;"></button>               
         <button style="width: 100px;height: 100px;border-radius:0px 100px;"></button>               
         <button style="width: 100px;height: 100px;border-radius:0px 50px;"></button>               
         <button style="width: 100px;height: 100px;border-radius:0px 25px;"></button>    --> 
         <div class="cus_welcome">欢迎来到${LOGIN_USERNAME }的管理后台</div>           
    </div>
</div>
<script src="third/pure/side-menu/js/ui.js"></script>
</body>
</html>