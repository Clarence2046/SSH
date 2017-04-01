<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	// �����Ŀ��ȫ·�������������Ŀ��MyApp����ô��õ��ĵ�ַ���� http://localhost:8080/MyApp/��: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<c:set value="<%=basePath%>" var="basepath"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pure ��̨����  ����">
<title>���˲��ͺ�̨����</title>
</head>
<body>
	<div class="header">
		<div class="cus_list_btn">
		</div>
	</div>

	<div id="add_div" class="content">
		<form action="" class="form form-inline">
		  <div class="form-group">
		    <input type="text" class="form-control" id="newlabel" placeholder="�������ǩ��">
		    <label class="btn btn-md btn-success" onclick="addLabel()">����Ϊ�µı�ǩ</label>
		  </div>
		</form>
		
		<div class="cus_labels" id="labels">
			<c:forEach items="${labels }" var="label">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<label class="cus_label">${label["name"] }</label>
			</c:forEach>
		</div>
	</div>
	<script type="text/javascript">
		function addLabel(){
			var name = $("#newlabel").val();
			if(name.length<1){
				layer.alert("�������ǩ��");
				return;
			}
			$.ajax({
				url:"app/mgr/blog/labeladd",
				type:"post",
				data:{"labelName":name},
				success:function(data){
					if(data){
						$("#newlabel").val("");
						$("#labels").append('&nbsp;&nbsp;&nbsp;&nbsp;<label class="cus_label">'+name+'</label>');
					}else{
						layer.alert("���ʧ��");
					}
				}
			});
		}
	</script>
</body>

</html>