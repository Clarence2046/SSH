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
	});

	function add() {
		var  r = checkField($("#roleName"),false);
		if(!r){
			$("#roleName").focus();
			return;
		}
		$.ajax({
			url : $("#add_frm").attr("action") + "?t=" + Math.random(),
			type : "post",
			data : $("#add_frm").serialize(),
			success : function(data) {
				var ret = JSON.parse(data);
				if (ret) {
					alert("��ӳɹ���");
					$("#roleName").val("");
				} else {
					alert("���ʧ��!");
				}
			}

		});
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
			url:"app/mgr/ajaxrole/checkField",
			type:"POST",
			async:defaultAsync,
			data:{"fieldId":fieldId,"fieldValue":fieldValue},
			success:function(data){
				var ret = JSON.parse(data);
				passed = true;
				if(!ret){
					passed = false;
					$("label[cfor="+fieldId+"]").html("<font color='red'>��ɫ�Ѵ���</font>");
				}else{
					$("label[cfor="+fieldId+"]").html("");
				}
			}
		});
		
		return passed;
	}
</script>

<body>
<div class="header">
		<div align="left">
	<!-- 		<a  onclick="goAdd()" class="btn btn-success btn-md"><label class="fa fa-user fa-lg"></label> ��ӽ�ɫ</a>
			<a id="backBtn"  onclick="backList()" class="btn btn-primary"><label class="fa fa-mail-reply"></label> ����</a>
		 --></div>
	</div>
	<div id="add_div" class="content">
		<div class="cus_tip">
			<label > ��ʾ�����������������µĽ�ɫ</label>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-2-3">
				<form id="add_frm" action="app/mgr/role/add.action"
					class="pure-form pure-form-aligned" method="post">
					<div>
						<label>����</label> 
						<input type="text" id="roleName" required="required" name="entity.roleName" onblur="checkField(this,true)"/>
						<label class="cus_required">*</label>
						<label cfor="roleName"></label>
					</div>
				
					<div style="margin-top: 5px;margin-left: 20%">
						<button name="���" type="button" class="btn btn-success" onclick="add()">���</button>
						<button name="����" type="reset" class="btn " >����</button>
					</div>
				</form>
			</div>
			<!-- <div class="pure-u-1-3"></div> -->
		</div>
	
	</div>

</body>
</html>