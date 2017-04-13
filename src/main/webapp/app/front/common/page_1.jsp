<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pure 后台管理  博客">
<title>个人博客后台管理</title>
<script type="text/javascript">
	var queryUrl='${param.queryurl}';
</script>

</head>
<div class="cus_page">
	<c:if test="${page.prePage<page.page}">
		<label  class="cus_page_btn" onclick="gotopage('${page.prePage}')">上一页</label>
	</c:if>
	<c:if test="${page.nextPage>page.page}">
		<label class="cus_page_btn" onclick="gotopage('${page.nextPage}')">下一页</label>
	</c:if>
	<input type="hidden" name="pageSize" value="${page.pageSize }">
	<script type="text/javascript">
		function gotopage(page){
			var size = 10;
			var psize = $("input[name=pageSize]").val();
			if(psize){
				size = psize;
			}
			
			queryUrl = encodeURI(queryUrl, "utf-8");
			$.ajax({
				url:queryUrl,
				type:"post",
				data:{"pageRequest.pageSize":size,"pageRequest.page":page},
				success:function(data){
					$(".vic_c_center").html(data);
				}
			});
		}
	</script>
</div>

</body>
</html>