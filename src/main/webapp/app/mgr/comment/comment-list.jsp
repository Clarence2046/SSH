<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pure 后台管理  博客">
<title>个人博客后台管理</title>


</head>
<script type="text/javascript">
	var queryUrl = "#";

	$(document).ready(function() {
		queryUrl  ="app/mgr/comment/list";
	});
	
	function edit(id){
		//ajax 获取编辑页面，使用layer弹窗插件弹出
		$.ajax({
			url:"app/mgr/comment/editpage.action",
			type:"POST",
			data:{"entity.id" : id},
			success:function(data){
				layer.open({
					  type: 1,
					  title:"文章编辑",
					  skin: 'layui-layer-rim', //加上边框
					  area: ['900px', '600px'], //宽高
					  content: data
					});
				}
		});
	}
	

	function reloadList() {
		$.ajax({
			url : "app/mgr/comment/list.action?pageRequest.page=${result.page}&t=" + Math.random(),
			type : "post",
			success : function(data) {
				$("#main").html(data);
			}
		})
	}
	
	function deleteComment(id) {
		layer.confirm("你确定要删除吗？",function(){
			$.ajax({
				url : "app/mgr/comment/delete.action?t=" + Math.random(),
				type : "post",
				data : {
					"entity.id" : id
				},
				success : function(data) {
					var ret = JSON.parse(data);
					if (ret) {
						layer.alert("删除成功！",function(){
							reloadList();
							layer.closeAll();
						});
					} else {
						alert("删除失败!");
					}
				},
				complete : function(xhr, textStatus) {
					if (xhr.status == 403) {
						alert("权限不足");
					}
				}
	
			});
		});
	}
	
	function search(){
		var term = $("#searchTitle").val();
		queryUrl = "app/mgr/comment/list.action?title="+term;
		gotopage(1);
		
	}
	function myreset(){
		$("#searchTitle").val("");
		queryUrl = "app/mgr/comment/list.action";
		gotopage(1);
	}
	
	function checkAllOrNot(){
		if($("#allids").is(":checked")){
			$("input[name=ids]").prop("checked",true);
		}else{
			$("input[name=ids]").prop("checked",false);
		}
	
	}
	function deleteSelected(){
		var ids = "";
		$("input[name=ids]:checked").each(function(){
			ids = ids+","+ $(this).val();
		});
		if(ids.length>1){
			ids = ids.substring(1);
		}
		//有选中
		if(ids!=""){
			layer.confirm("你确定要删除吗？",function(){
				$.ajax({
					url : "app/mgr/comment/deleteBatch.action?t=" + Math.random(),
					type : "post",
					data : {
						"ids" : ids
					},
					success : function(data) {
						var ret = JSON.parse(data);
						if (ret) {
							layer.alert("删除成功！",function(){
								reloadList();
								layer.closeAll();
							});
						} else {
							alert("删除失败!");
						}
					},
					complete : function(xhr, textStatus) {
						if (xhr.status == 403) {
							alert("权限不足");
						}
					}
		
				});
			});
		}
	}
	
</script>

<body>

	<div class="header">
		<div class="cus_list_btn" >
			<form action="" class="form-inline" id="searchFrm">
				<table class="cus_search_table" style="float: right;">
					<tr>
						<td>
							<div class="form-group">
							<label for="searchTitle">文章标题 </label>
							<input type="text" class="form-control" name="searchTitle" id="searchTitle" value="${title }">
							</div>
						</td>
						<td>
							<input type="button"  class="btn btn-info" style="width: 100px" onclick="search()" value="查询">
							<input type="button"  class="btn btn-default" style="width: 100px" onclick="myreset()" value="重置">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="margin-top: 10px;text-align: left;">
			<input type="button"  class="btn btn-danger" style="width: 100px" onclick="deleteSelected()" value="批量删除">
		</div>
	</div>

	<div id="list_div" class="content" style="max-width: 1100px;">
		<div class="cus_tip">
			<label > 所有评论列表  </label>
		</div>
		<table  class="table table-striped table-condensed">
			<tr>
				<td style="width: 2%"><input type="checkbox" name="allids" id="allids" onclick="checkAllOrNot()"></td>
				<td style="width: 5%">编号</td>
				<td style="width: 10%">用户</td>
				<td style="width: 35%">内容</td>
				<td style="width: 15%">所属博客</td>
				<td style="width: 15%">创建时间</td>
				<td style="width: 18%">操作</td>
			</tr>
			<c:forEach items="${result.pageList }" var="vo">
				<tr>
					<td ><input type="checkbox" name="ids" value="${vo.id }"></td>
					<td >${vo.id }</td>
					<td >${vo.username }</td>
					<td >${vo.strContent }</td>
					<td >${vo.blogName }</td>
					<td ><fmt:formatDate value="${vo.createDate }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
					<td >
						<a class="btn btn-danger btn-sm glyphicon glyphicon-trash"  style="border-radius:15px 15px;" onclick="deleteComment('${vo.id }')">
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 引入分页栏 -->
		<jsp:include page="../common/page.jsp">
			<jsp:param value="app/mgr/comment/list?title=${title }" name="queryurl"/>
		</jsp:include>
	</div>
</body>
</html>