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
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pure 后台管理  博客">
<title>个人博客后台管理</title>


</head>
<script type="text/javascript">
	var queryUrl = "#";

	$(document).ready(function() {
		$("#edit_frm").validate({
			submitHandler : function(form) {
				//alert("提交事件!");   
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
					layer.alert("更新成功！",function(){
						parent.layer.closeAll();
						parent.reloadList();
					});
				} else {
					layer.alert("更新失败!");
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
			<label > 提示：在这里你可以更新权限信息</label>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-5"></div>
			<div class="pure-u-4-5">
				<form id="edit_frm" action="app/mgr/right/edit.action"
					class="pure-form pure-form-aligned" method="post">
					<div>
						<label>权限编号</label> <input type="hidden" id="authId" name="systemRight.authId" value="${systemRight.authId }" required="required" onblur="checkField(this)"/>
						<label>${systemRight.authId }</label>
					</div>
					<div>
						<label>上级编号</label> <input type="hidden" id="parentAuthId" name="systemRight.parentAuthId" value="${systemRight.parentAuthId }" required="required"/>
						<label >${systemRight.parentAuthId }</label>
					</div>
					<div>
						<label>权限名称</label> 
						<input type="text" id="authName" required="required" name="systemRight.authName" value="${systemRight.authName }"/>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>权限路径</label> 
						<input type="text" id="authUrl" required="required"  name="systemRight.authUrl" value="${systemRight.authUrl }"/>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>访问路径</label> 
						<input type="text" id="visitUrl" required="required"  name="systemRight.visitUrl" value="${systemRight.visitUrl }"/>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>权限等级</label> 
						<select name="systemRight.authLevel" value="${systemRight.authLevel }" required>
							<option value="">请选择</option>
							<option value="1" <c:if test="${systemRight.authLevel==1 }">selected</c:if>>1</option>
							<option value="2" <c:if test="${systemRight.authLevel==2 }">selected</c:if>>2</option>
							<option value="3" <c:if test="${systemRight.authLevel==3 }">selected</c:if>>3</option>
						</select>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>是否启用</label> 
						<select name="systemRight.authStatus" value="${ systemRight.authStatus}" required>
							<option value="0" <c:if test="${systemRight.authStatus==0 }">selected</c:if>>启用</option>
							<option value="1" <c:if test="${systemRight.authStatus==1 }">selected</c:if>>不启用</option>
						</select>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>描&nbsp;&nbsp;&nbsp;&nbsp;述</label> 
						<textarea name="systemRight.description" cols="27" rows="5" style="resize:none" ></textarea>
					</div>
					<div style="margin-top: 5px;margin-left: 20%">
						<button name="添加" type="submit" class="btn btn-success" >更新</button>
						<button name="重置" type="reset" class="btn " >重置</button>
					</div>
				</form>
			</div>
			<!-- <div class="pure-u-1-3"></div> -->
		</div>
	</div>

</body>
</html>