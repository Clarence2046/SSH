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
<style>
<!--
.cus_for_label{
    height: 0px;
    width: 0px;
    border: 15px solid #9aa278;
    border-right-color: white;
    border-right-width: 25px;
    float: right;
    margin-left: -5px;
}
.cus_label{
    border: 0px;
    height: 30px;
    /* vertical-align: middle; */
    padding-top: 3px;
    padding-left:20px;
    background-color:#9aa278;
    color: rgba(4, 60, 55, 0.79);
}

.cus_for_label_circle{
    border: 5px solid white;
    border-radius: 10px 10px;
    float: right;
    margin-top: 10px;
    margin-left: 3px;
    z-index: 9999;
    position: absolute;
}

.cus_div{
    float: left;
   /*  transform: rotate(90deg);
    margin-top: 120px; */
}

.cus_for_label_delete{
    position: absolute;
    margin-left: -5px;
    margin-top: -5px;
    color: gray;
    cursor: pointer;
}


-->
</style>
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
			<div  class="cus_div">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<label class="cus_for_label_delete fa fa-times-circle-o" onclick="deleteLabel('${label['id'] }')"></label>
				<label class="cus_for_label_circle"></label>
				<label class="cus_label">${label["name"] }</label>
				<label class="cus_for_label"></label>
			</div>	
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
						reloadList();
					}else{
						layer.alert("添加失败");
					}
				}
			});
		}
		function reloadList() {
			$.ajax({
				url : "app/mgr/blog/labelpage.action?t=" + Math.random(),
				type : "post",
				success : function(data) {
					$("#main").html(data);
				}
			});
		}
		
		function deleteLabel(labelId){
			$.ajax({
				url:"app/mgr/blog/labeldelete",
				type:"post",
				data:{"labelId":labelId},
				success:function(data){
					if(data){
						reloadList();
					}else{
						layer.alert("添加失败");
					}
				}
			});
		}
	</script>
</body>

</html>