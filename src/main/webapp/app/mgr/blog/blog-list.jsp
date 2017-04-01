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
		queryUrl  ="app/mgr/blog/list";
	});
	
	function edit(id){
		//ajax ��ȡ�༭ҳ�棬ʹ��layer�����������
		$.ajax({
			url:"app/mgr/blog/editpage.action",
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
	
	function deleteUser(id) {
		if(confirm("��ȷ��Ҫɾ����")){
			$.ajax({
				url : "app/mgr/blog/delete.action?t=" + Math.random(),
				type : "post",
				data : {
					"systemRight.authId" : id
				},
				success : function(data) {
					var ret = JSON.parse(data);
					if (ret) {
						alert("ɾ���ɹ���");
						reloadList();
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
					layer.alert("����ʧ��");
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
					layer.alert("����ʧ��");
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
			<label > �ҵĲ����б�  </label>
		</div>
		<table  class="table table-striped table-bordered">
			<tr>
				<td style="width: 5%">���</td>
				<td style="width: 8%">����</td>
				<td style="width: 30%">����</td>
				<td style="width: 11%">����</td>
				<td style="width: 15%">����ʱ��</td>
				<td style="width: 15%">�޸�ʱ��</td>
				<td style="width: 8%">ǰ̨�ɼ�</td>
				<td style="width: 8%">��������</td>
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
		<!-- �����ҳ�� -->
		<jsp:include page="../common/page.jsp">
			<jsp:param value="app/mgr/blog/list" name="queryurl"/>
		</jsp:include>
	</div>
</body>
</html>