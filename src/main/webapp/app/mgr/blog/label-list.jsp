<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
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
<meta name="description" content="Pure 后台管理  博客">
<title>个人博客后台管理</title>
</head>
<body>
	<div class="header">
		<div class="cus_list_btn">
		</div>
	</div>

	<div id="add_div" class="content">
		<form action="" class="form form-inline">
		  <div class="form-group">
		    <input type="text" class="form-control" id="newlabel" placeholder="请输入标签名">
		    <label class="btn btn-md btn-success" onclick="addLabel()">保存为新的标签</label>
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
				layer.alert("请输入标签名");
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
						layer.alert("添加失败");
					}
				}
			});
		}
	</script>
</body>

</html>