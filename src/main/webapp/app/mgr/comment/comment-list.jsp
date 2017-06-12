<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pure ��̨����  ����">
<title>���˲��ͺ�̨����</title>


</head>
<script type="text/javascript">
	var queryUrl = "#";

	$(document).ready(function() {
		queryUrl  ="app/mgr/comment/list";
	});
	
	function edit(id){
		//ajax ��ȡ�༭ҳ�棬ʹ��layer�����������
		$.ajax({
			url:"app/mgr/comment/editpage.action",
			type:"POST",
			data:{"entity.id" : id},
			success:function(data){
				layer.open({
					  type: 1,
					  title:"���±༭",
					  skin: 'layui-layer-rim', //���ϱ߿�
					  area: ['900px', '600px'], //���
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
		layer.confirm("��ȷ��Ҫɾ����",function(){
			$.ajax({
				url : "app/mgr/comment/delete.action?t=" + Math.random(),
				type : "post",
				data : {
					"entity.id" : id
				},
				success : function(data) {
					var ret = JSON.parse(data);
					if (ret) {
						layer.alert("ɾ���ɹ���",function(){
							reloadList();
							layer.closeAll();
						});
					} else {
						alert("ɾ��ʧ��!");
					}
				},
				complete : function(xhr, textStatus) {
					if (xhr.status == 403) {
						alert("Ȩ�޲���");
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
		//��ѡ��
		if(ids!=""){
			layer.confirm("��ȷ��Ҫɾ����",function(){
				$.ajax({
					url : "app/mgr/comment/deleteBatch.action?t=" + Math.random(),
					type : "post",
					data : {
						"ids" : ids
					},
					success : function(data) {
						var ret = JSON.parse(data);
						if (ret) {
							layer.alert("ɾ���ɹ���",function(){
								reloadList();
								layer.closeAll();
							});
						} else {
							alert("ɾ��ʧ��!");
						}
					},
					complete : function(xhr, textStatus) {
						if (xhr.status == 403) {
							alert("Ȩ�޲���");
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
							<label for="searchTitle">���±��� </label>
							<input type="text" class="form-control" name="searchTitle" id="searchTitle" value="${title }">
							</div>
						</td>
						<td>
							<input type="button"  class="btn btn-info" style="width: 100px" onclick="search()" value="��ѯ">
							<input type="button"  class="btn btn-default" style="width: 100px" onclick="myreset()" value="����">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="margin-top: 10px;text-align: left;">
			<input type="button"  class="btn btn-danger" style="width: 100px" onclick="deleteSelected()" value="����ɾ��">
		</div>
	</div>

	<div id="list_div" class="content" style="max-width: 1100px;">
		<div class="cus_tip">
			<label > ���������б�  </label>
		</div>
		<table  class="table table-striped table-condensed">
			<tr>
				<td style="width: 2%"><input type="checkbox" name="allids" id="allids" onclick="checkAllOrNot()"></td>
				<td style="width: 5%">���</td>
				<td style="width: 10%">�û�</td>
				<td style="width: 35%">����</td>
				<td style="width: 15%">��������</td>
				<td style="width: 15%">����ʱ��</td>
				<td style="width: 18%">����</td>
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
		<!-- �����ҳ�� -->
		<jsp:include page="../common/page.jsp">
			<jsp:param value="app/mgr/comment/list?title=${title }" name="queryurl"/>
		</jsp:include>
	</div>
</body>
</html>