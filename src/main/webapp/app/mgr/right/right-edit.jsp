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
		$("#edit_frm").validate({
			submitHandler : function(form) {
				//alert("�ύ�¼�!");   
				updateRight();
			},
			errorPlacement : function(error, element) {
				var spn = $("<span style='color:red;'></span>");
			
				error.appendTo(spn);
				spn.appendTo(element.parent());
			}
		});
	});

	function updateRight() {
		$.ajax({
			url : $("#edit_frm").attr("action") + "?t=" + Math.random(),
			type : "post",
			data : $("#edit_frm").serialize(),
			success : function(data) {
				var ret = JSON.parse(data);
				if (ret) {
					layer.alert("���³ɹ���",function(){
						parent.layer.closeAll();
						parent.reloadList();
					});
				} else {
					layer.alert("����ʧ��!");
				}
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

.header{
	margin-bottom: 10px;
}
-->
</style>
<body>

	<div id="edit_div" class="content">
		<div class="cus_tip">
			<label > ��ʾ������������Ը���Ȩ����Ϣ</label>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-5"></div>
			<div class="pure-u-4-5">
				<form id="edit_frm" action="app/mgr/right/edit.action"
					class="pure-form pure-form-aligned" method="post">
					<div>
						<label>Ȩ�ޱ��</label> <input type="hidden" id="authId" name="systemRight.authId" value="${systemRight.authId }" required="required" onblur="checkField(this)"/>
						<label>${systemRight.authId }</label>
					</div>
					<div>
						<label>�ϼ����</label> <input type="hidden" id="parentAuthId" name="systemRight.parentAuthId" value="${systemRight.parentAuthId }" required="required"/>
						<label >${systemRight.parentAuthId }</label>
					</div>
					<div>
						<label>Ȩ������</label> 
						<input type="text" id="authName" required="required" name="systemRight.authName" value="${systemRight.authName }"/>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>Ȩ��·��</label> 
						<input type="text" id="authUrl" required="required"  name="systemRight.authUrl" value="${systemRight.authUrl }"/>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>����·��</label> 
						<input type="text" id="visitUrl" required="required"  name="systemRight.visitUrl" value="${systemRight.visitUrl }"/>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>Ȩ�޵ȼ�</label> 
						<select name="systemRight.authLevel" value="${systemRight.authLevel }" required>
							<option value="">��ѡ��</option>
							<option value="1" <c:if test="${systemRight.authLevel==1 }">selected</c:if>>1</option>
							<option value="2" <c:if test="${systemRight.authLevel==2 }">selected</c:if>>2</option>
							<option value="3" <c:if test="${systemRight.authLevel==3 }">selected</c:if>>3</option>
						</select>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>�Ƿ�����</label> 
						<select name="systemRight.authStatus" value="${ systemRight.authStatus}" required>
							<option value="0" <c:if test="${systemRight.authStatus==0 }">selected</c:if>>����</option>
							<option value="1" <c:if test="${systemRight.authStatus==1 }">selected</c:if>>������</option>
						</select>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>��&nbsp;&nbsp;&nbsp;&nbsp;��</label> 
						<textarea name="systemRight.description" cols="27" rows="5" style="resize:none" ></textarea>
					</div>
					<div style="margin-top: 5px;margin-left: 20%">
						<button name="���" type="submit" class="btn btn-success" >����</button>
						<button name="����" type="reset" class="btn " >����</button>
					</div>
				</form>
			</div>
			<!-- <div class="pure-u-1-3"></div> -->
		</div>
	</div>

</body>
</html>