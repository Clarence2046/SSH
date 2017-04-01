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
	<div style="float: left;margin-left: 20px;">
		<label class="btn btn-sm fa fa-fast-backward" onclick="gotopage('${result.firstPage}')"></label>
		&nbsp;&nbsp;&nbsp;&nbsp; 
		<label class="btn btn-sm fa fa-step-backward" onclick="gotopage('${result.prePage}')"></label>
	</div>
	<label> ��ǰ${result.page }ҳ/��${result.totalPage }ҳ ÿҳ 
	<select name="pageSize" onchange="gotopage(1)">
			<option value="5" <c:if test="${result.pageSize==5 }">selected</c:if>>5</option>
			<c:forEach begin="2" end="8" step="2" var="t">${t }
				<option value="${t*5 }" <c:if test="${result.pageSize==(t*5) }">selected</c:if>>
					${t * 5 }
				</option>
			</c:forEach>
	</select> �� /��${result.size }��
	</label>
	<div style="float: right;margin-right: 20px;">
		<label class="btn btn-sm fa fa-step-forward" onclick="gotopage('${result.nextPage}')"></label>
		&nbsp;&nbsp;&nbsp;&nbsp; 
		<label class="btn btn-sm fa fa-fast-forward" onclick="gotopage('${result.lastPage}')"></label>
	</div>
	<script type="text/javascript">
				function gotopage(page){
					var size = 10;
					var psize = $("select[name=pageSize]").val();
					if(psize){
						size = psize;
					}
					$.ajax({
						url:queryUrl,
						type:"post",
						data:{"pageRequest.pageSize":size,"pageRequest.page":page},
						success:function(data){
							$("#main").html(data);
						}
					});
				}
			</script>
</div>

</body>
</html>