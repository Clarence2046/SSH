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
		queryUrl  ="app/mgr/blog/list";
	});
	
	function edit(id){
		//ajax 获取编辑页面，使用layer弹窗插件弹出
		$.ajax({
			url:"app/mgr/blog/editpage.action",
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
	
	function deleteUser(id) {
		if(confirm("你确定要删除吗？")){
			$.ajax({
				url : "app/mgr/blog/delete.action?t=" + Math.random(),
				type : "post",
				data : {
					"systemRight.authId" : id
				},
				success : function(data) {
					var ret = JSON.parse(data);
					if (ret) {
						alert("删除成功！");
						reloadList();
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
		}
	}

	function reloadList() {
		$.ajax({
			url : "app/mgr/blog/list.action?pageRequest.page=${result.page}&t=" + Math.random(),
			type : "post",
			success : function(data) {
				$("#main").html(data);
			}
		})
	}
	
	function swichVisible(ele,id){
		var visible = 0;
		if($(ele).hasClass("fa-toggle-on")){
			visible = 1;
		}
		$.ajax({
			url:"app/mgr/blog/updatevisible",
			type:"POST",
			data:{"id":id,"visible":visible},
			success:function(data){
			 	var d = JSON.parse(data);
				if(d){
					if($(ele).hasClass("fa-toggle-on")){
						$(ele).removeClass("fa-toggle-on");
						$(ele).addClass("fa-toggle-off");
					}else{
						$(ele).addClass("fa-toggle-on");
						$(ele).removeClass("fa-toggle-off");
					}
				}else{
					layer.alert("操作失败");
				}
			}
		});
	}

	function swichLockComment(ele,id){
		var lock = 0;
		if($(ele).hasClass("fa-toggle-on")){
			lock = 1;
		}
		$.ajax({
			url:"app/mgr/blog/updatelock",
			type:"POST",
			data:{"id":id,"lock":lock},
			success:function(data){
			 	var d = JSON.parse(data);
				if(d){
					if($(ele).hasClass("fa-toggle-on")){
						$(ele).removeClass("fa-toggle-on");
						$(ele).addClass("fa-toggle-off");
					}else{
						$(ele).addClass("fa-toggle-on");
						$(ele).removeClass("fa-toggle-off");
					}
				}else{
					layer.alert("操作失败");
				}
			}
		});
	}
	
	
</script>

<body>

	<div class="header">
		<div class="cus_list_btn">
		</div>
	</div>

	<div id="list_div" class="content" style="max-width: 1100px;">
		<div class="cus_tip">
			<label > 我的博客列表  </label>
		</div>
		<table  class="table table-striped table-bordered">
			<tr>
				<td style="width: 5%">编号</td>
				<td style="width: 8%">作者</td>
				<td style="width: 30%">标题</td>
				<td style="width: 11%">分类</td>
				<td style="width: 15%">创建时间</td>
				<td style="width: 15%">修改时间</td>
				<td style="width: 8%">前台可见</td>
				<td style="width: 8%">评论启闭</td>
			</tr>
			<c:forEach items="${result.pageList }" var="vo">
				<tr>
					<td >${vo.id }</td>
					<td >${vo.author }</td>
					<td ><a href="javascript:;" onclick="edit('${vo.id }')">${vo.title }<span class="" style="font-size: 10px;">(${vo.subTitle })</span></a></td>
					<td ></td>
					<td ><fmt:formatDate value="${vo.createDate }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
					<td ><fmt:formatDate value="${vo.modifyDate }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
					<td >
						<c:if test="${vo.visible==0}">
						<label class="fa fa-toggle-on fa-2x" onclick="swichVisible(this,'${vo.id}')"></label>
						</c:if>
						<c:if test="${vo.visible==1}">
						<label class="fa fa-toggle-off fa-2x"  onclick="swichVisible(this,'${vo.id}')"></label>
						</c:if>
					
					</td>
					<td >
						<c:if test="${vo.lockComment==0}">
						<label class="fa fa-toggle-on fa-2x"  onclick="swichLockComment(this,'${vo.id}')"></label>
						</c:if>
						<c:if test="${vo.lockComment==1}">
						<label class="fa fa-toggle-off fa-2x" onclick="swichLockComment(this,'${vo.id}')"></label>
						</c:if>
					
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 引入分页栏 -->
		<jsp:include page="../common/page.jsp">
			<jsp:param value="app/mgr/blog/list" name="queryurl"/>
		</jsp:include>
	</div>
</body>
</html>