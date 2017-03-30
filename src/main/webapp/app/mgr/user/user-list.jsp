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

</head>
<script type="text/javascript">
	var queryUrl = "#";

	$(document).ready(function() {
		backUser();
		queryUrl  ="app/mgr/user/list";
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
		var  r = checkField($("#username"),false);
		if(!r){
			$("#id").focus();
			return;
		}
		$.ajax({
			url : $("#add_frm").attr("action") + "?t=" + Math.random(),
			type : "post",
			data : $("#add_frm").serialize(),
			success : function(data) {
				var ret = JSON.parse(data);
				if (ret) {
					alert("���ӳɹ���");
					reloadList();
				} else {
					alert("����ʧ��!");
				}
			}

		});
	}
	function deleteUser(id) {
		if(confirm("��ȷ��Ҫɾ����")){
			$.ajax({
				url : "app/mgr/user/delete.action?t=" + Math.random(),
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
			url : "app/mgr/user/list.action?t=" + Math.random(),
			type : "post",
			success : function(data) {
				$("#main").html(data);
			}
		})
	}
	
	
	function checkField(ele,async){
		var  passed = false;
		var fieldValue = $(ele).val();
		var fieldId = $(ele).attr("id");
		if(fieldId == undefined || fieldValue==""){
			return passed;
		}
		var defaultAsync = true;
		if(!async){
			defaultAsync = false;
		}
		//ajax У���û����Ƿ����
		$.ajax({
			url:"app/mgr/ajaxuser/checkField",
			type:"POST",
			async:defaultAsync,
			data:{"fieldId":fieldId,"fieldValue":fieldValue},
			success:function(data){
				var ret = JSON.parse(data);
				passed = true;
				if(!ret){
					passed = false;
					$("label[cfor="+fieldId+"]").html("<font color='red'>����Ѵ���</font>");
				}else{
					$("label[cfor="+fieldId+"]").html("");
				}
			}
		});
		
		return passed;
	}
	
	
	function relateRole(id){
		//ajax ��ȡ�༭ҳ�棬ʹ��layer�����������
		$.ajax({
			url:"app/mgr/user/user_role_page.action",
			type:"POST",
			data:{"userId" : id},
			success:function(data){
				layer.open({
					  type: 1,
					  title:"Ȩ�ޱ༭",
					  btn:["����","ȡ��"],
					  success:function(layero){
					  	
					  },
					  yes:function(index,layero){
					  	var str = "";
						$(layero).find("#role_right_div").find("input[type=checkbox]").each(function(){
							if($(this).is(":checked")){
								str += $(this).attr("id");
							}
						});
						//ִ�б������
						$.ajax({
							url:"app/mgr/user/user_role.action",
							type:"POST",
							data:{"userId":id,"roles":str},
							success:function(data){
								var ret = JSON.parse(data);
								if (ret) {
									layer.alert("����ɹ���",function(){
										layer.closeAll();
									});
								} else {
									alert("����ʧ��!");
								}
							}
						
						});
					  },
					  no:function(index){},
					  skin: 'layui-layer-rim', //���ϱ߿�
					  area: ['300px', '400px'], //����
					  content: data
					});
				}
		});
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
table tr td{
	text-align: center;
}

-->
</style>
<body>

	<div class="header">
		<div align="left">
			<a  onclick="goAddUser()" class="btn btn-success btn-md"><label class="fa fa-user fa-lg"></label> �����û�</a>
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
					<td >
					<a class="btn btn-danger btn-sm glyphicon glyphicon-trash"  onclick="deleteUser('${sysuser.id }')">
					ɾ��
					</a>
					|
					<a class="btn btn-warning btn-sm glyphicon glyphicon-link"  onclick="relateRole('${sysuser.id }')">
						������ɫ
					</a>
					</td>
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
					 <select name="pageSize" onchange="gotopage(1)">
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
			<label > ��ʾ����������������ӹ���Ա</label>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-2-3">
				<form id="add_frm" action="app/mgr/user/add.action"
					class="pure-form pure-form-aligned" method="post">
					<div>
						<label>�û���</label> <input type="text" id="username" name="systemUser.username" required="required" onblur="checkField(this,true)"/>
						<label class="cus_required">*</label>
						<label cfor="username"></label>
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
						<button name="����" type="submit" class="btn btn-success" >����</button>
						<button name="����" type="reset" class="btn " >����</button>
					</div>
				</form>
			</div>
			<!-- <div class="pure-u-1-3"></div> -->
		</div>
	</div>

</body>
</html>