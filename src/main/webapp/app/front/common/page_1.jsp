<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	// �����Ŀ��ȫ·�������������Ŀ��MyApp����ô��õ��ĵ�ַ���� http://localhost:8080/MyApp/��: 
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
<meta name="description" content="Pure ��̨����  ����">
<title>���˲��ͺ�̨����</title>
<script type="text/javascript">
	var queryUrl='${param.queryurl}';
</script>

</head>
<div class="cus_page">
	<c:if test="${page.totalPage > 1 }">
	<c:choose>
		<c:when test="${page.page <=1 }">
			<label class="cus_page_btn cus_forbidden" >��&nbsp;&nbsp;&nbsp;ҳ</label>
			<label class="cus_page_btn cus_forbidden" >��һҳ</label>
		</c:when>
		<c:otherwise>
			<label class="cus_page_btn" onclick="gotopage('${page.prePage}')">��&nbsp;&nbsp;&nbsp;ҳ</label>
			<label class="cus_page_btn" onclick="gotopage('${page.prePage}')">��һҳ</label>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${page.page >= page.totalPage }">
			<label class="cus_page_btn cus_forbidden" >��һҳ</label>
			<label class="cus_page_btn cus_forbidden" >ĩ&nbsp;&nbsp;&nbsp;ҳ</label>
		</c:when>
		<c:otherwise>
			<label class="cus_page_btn" onclick="gotopage('${page.nextPage}')">��һҳ</label>
			<label class="cus_page_btn" onclick="gotopage('${page.totalPage}')">ĩ&nbsp;&nbsp;&nbsp;ҳ</label>
		</c:otherwise>
	</c:choose>
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