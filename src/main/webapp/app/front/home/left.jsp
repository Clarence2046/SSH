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
</head>
  <body>
		<!-- 左边分栏 -->
		<div class="vic_c_left">
			<div class="vic_line">简介</div>
			<div class="vic_block">
				<label>Taylor Lee 的个人网站</label>
				<label>爱好：美剧、英剧</label>
				<label>最近在看：《灵异之城》</label>
			</div>
				<div class="vic_line">标签</div>
			<div class="vic_block vic_label_v">
				<label>数据库</label>
				<label>mysql</label>
				<label>Javascript</label>
				<label>Oracle</label>
				<label>前端开发</label>
			</div>
			<script type="text/javascript">
				$(document).ready(function(){
					//ajax获取标签列表
					ajaxGetLabels();
				
				});
				
				//ajax获取标签列表
				function ajaxGetLabels(){
					$.ajax({
						url:"app/front/ajax/labels.action",
						type:"POST",
						data:{},
						success:function(data){
							$(".vic_label_v").html("");
							var labelName = '${labelName}';
							for(var i=0;i<data.length;i++){
								console.log(data[i].name);
								if(labelName ==data[i].name){
									$(".vic_label_v").append("<label class=\"vic_label_active\" >"+data[i].name+"</label>");
								}else{
									$(".vic_label_v").append("<label onclick=\"listblog('"+data[i].name+"')\">"+data[i].name+"</label>");
								}
							}
						}
					});
				}
				function listblog(label) {
					var url = encodeURI("app/front/list?labelName=" + label, "utf-8");
					window.location.href = url;
					//window.open(url,"_blank");
				}
			</script>
			<div class="vic_line">全站搜索</div>
			<div class="vic_block vic_search">
				<form action="app/front/globalsearch.action" method="post" >
					<label>
						<input type="text" name="term" placeholder="输入关键字" value="${term }">
						<input type="submit" value="Search" >
					</label>
				</form>
			</div>
			
			<div class="vic_line">文章推荐</div>
			<div class="vic_block_2x">
				<div class="vic_title">
					地球的起源
				</div>
				<div class="vic_line_s"></div>
				<div class="vic_title">
						真空爆炸的研究
				</div>
				<div class="vic_line_s"></div>
				<div class="vic_title">
						视界线--看见未来
				</div>
			</div>
		
			
			<div class="vic_line">友情链接</div>
			<div class="vic_block">
				<label>数据库</label>
				<label>mysql</label>
				<label>Javascript</label>
				<label>Oracle</label>
				<label>前端开发</label>
			</div>
		</div>
  </body>
</html>
