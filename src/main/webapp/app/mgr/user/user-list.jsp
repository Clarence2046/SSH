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
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pure ��̨����  ����">
<title>���˲��ͺ�̨����</title>
<link rel="stylesheet" href="pure/pure-release-0.6.2/pure-min.css">
<link rel="stylesheet" href="pure/side-menu/css/layouts/side-menu.css">


</head>
<script type="text/javascript">
	var queryUrl = "#";

	$(document).ready(function() {
		backUser();
		queryUrl  ="user";
	});


	function goAddUser() {
		$("#add_div").show();
		$("#list_div").hide();
		$("#backBtn").show();
		$("#add_frm").validate({
			submitHandler : function(form) {
				//alert("�ύ�¼�!");   
				addUser();
			},
			errorPlacement : function(error, element) {
				var spn = $("<span style='color:red;'></span>");
			
				error.appendTo(spn);
				spn.appendTo(element.parent());
			}
		});
	}
	function backUser() {
		$("#backBtn").hide();
		$("#add_frm")[0].reset();
		$("#add_div").hide();
		$("#list_div").show();
	}

	function addUser() {
		$.ajax({
			url : $("#add_frm").attr("action") + "?t=" + Math.random(),
			type : "post",
			data : $("#add_frm").serialize(),
			success : function(data) {
				var ret = JSON.parse(data);
				if (ret) {
					alert("��ӳɹ���");
					reloadList();
				} else {
					alert("���ʧ��!");
				}
			}

		});
	}
	function deleteUser(id) {
		if(confirm("��ȷ��Ҫɾ����")){
			$.ajax({
				url : "user/delete.action?t=" + Math.random(),
				type : "post",
				data : {
					"systemUser.id" : id
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
			url : "app/mgr/user.action?t=" + Math.random(),
			type : "post",
			success : function(data) {
				$("#main").html(data);
			}
		})
	}
</script>
<style>
<!--
.button-error{
background: rgb(202, 60, 60); /* this is a maroon */
font-size: 50%;
}

.pure-form div{
	margin-top: 2px;
}

.cus_tip{
	background-color: rgb(230, 230, 230);
	height: 120%;
	border-radius:5px  5px; 
	color: #44D61F;
	margin-bottom: 10px;
}
.cus_page{
	background-color: rgb(230, 230, 230);
	height: 120%;
	border-radius:5px  5px; 
	color: gray;
	margin-bottom: 10px;
	text-align: center;
	position: relative;
}

#add_div{
	border-left: 1px solid rgb(230, 230, 230);
	border-right: 1px solid rgb(230, 230, 230);
	min-height: 366px;
}

.cus_required{
	color: red;
}

-->
</style>
<body>

	<div class="header">
		<div align="left">
			<a  onclick="goAddUser()" class="btn btn-success btn-md"><label class="fa fa-user fa-lg"></label> ����û�</a>
			<a id="backBtn"  onclick="backUser()" class="btn btn-primary"><label class="fa fa-mail-reply"></label> ����</a>
		</div>
	</div>

	<div id="list_div" class="content">
		<div class="cus_tip">
			<label > ϵͳ�û��б� </label>
		</div>
		<table  class="table table-striped">
			<tr>
				<td>&nbsp;#</td>
				<td>�û���</td>
				<td>����</td>
				<td>����</td>
			</tr>
			<c:forEach items="${result.pageList }" var="sysuser">
				<tr>
					<td >${sysuser.id }</td>
					<td >${sysuser.username }</td>
					<td >${sysuser.type=="1"?"�߼�����Ա":"��ͨ����Ա" }</td>
					<td ><a class="btn btn-danger btn-sm"  onclick="deleteUser('${sysuser.id }')"><li class="fa fa-trash"></li></a></td>
				</tr>
			</c:forEach>
		</table>
		<div class="cus_page">
			<div style="float: left;margin-left: 20px;">
				<label class="btn btn-sm fa fa-fast-backward" onclick="gotopage(${result.firstPage})"></label>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<label class="btn btn-sm fa fa-step-backward" onclick="gotopage(${result.prePage})"></label>
			</div>
			<label>
					  ��ǰ${result.page }ҳ/��${result.totalPage }ҳ
					  ÿҳ
					 <select name="pageSize" >
					 	<option value="5" <c:if test="${result.pageSize==5 }">selected</c:if>>5</option>
					 	<c:forEach begin="2" end="8" step="2" var="t">
					 		${t }
						 	<option value="${t*5 }" <c:if test="${result.pageSize==(t*5) }">selected</c:if>>${t * 5 }</option>
					 	</c:forEach>
					 </select> 
					  ��
					  /��${result.size }��
			
			</label>
			<div style="float: right;margin-right: 20px;">
				<label class="btn btn-sm fa fa-step-forward" onclick="gotopage(${result.nextPage})"></label>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<label class="btn btn-sm fa fa-fast-forward" onclick="gotopage(${result.lastPage})"></label>
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
	</div>
	<div id="add_div" class="content">
		<div class="cus_tip">
			<label > ��ʾ���������������ӹ���Ա</label>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-2-3">
				<form id="add_frm" action="user/add.action"
					class="pure-form pure-form-aligned" method="post">
					<div>
						<label>�û���</label> <input type="text" id="username" name="systemUser.username" required="required"/>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>��&nbsp;&nbsp;��</label> <input type="password" id="password" required="required" minlength="6"
							name="systemUser.password" />
							<label class="cus_required">*</label>
					</div>
					<div>
						<label>��&nbsp;&nbsp;��</label> <select name="systemUser.type" id="type" required
							>
							<option value="">��ѡ��</option>
							<option value="1">�߼�����Ա</option>
							<option value="2">��ͨ����Ա</option>
						</select>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>��&nbsp;&nbsp;��</label> 
						<textarea name="systemUser.description" cols="27" rows="5" style="resize:none" ></textarea>
					</div>
					<div style="margin-top: 5px;margin-left: 20%">
						<button name="���" type="submit" class="btn btn-success" >���</button>
						<button name="����" type="reset" class="btn " >����</button>
					</div>
				</form>
			</div>
			<!-- <div class="pure-u-1-3"></div> -->
		</div>
	</div>

</body>
</html>