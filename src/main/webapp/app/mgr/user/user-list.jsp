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
		backUser();
		queryUrl  ="app/mgr/user/list";
	});


	function goAddUser() {
		$("#add_div").show();
		$("#list_div").hide();
		$("#backBtn").show();
		$("#add_frm").validate({
			submitHandler : function(form) {
				//alert("提交事件!");   
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
					alert("添加成功！");
					reloadList();
				} else {
					alert("添加失败!");
				}
			}

		});
	}
	function deleteUser(id) {
		if(confirm("你确定要删除吗？")){
			$.ajax({
				url : "app/mgr/user/delete.action?t=" + Math.random(),
				type : "post",
				data : {
					"systemUser.id" : id
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
			url : "app/mgr/user/list.action?pageRequest.page=${result.page}&t=" + Math.random(),
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
		//ajax 校验用户名是否存在
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
					$("label[cfor="+fieldId+"]").html("<font color='red'>编号已存在</font>");
				}else{
					$("label[cfor="+fieldId+"]").html("");
				}
			}
		});
		
		return passed;
	}
	
	
	function relateRole(id){
		//ajax 获取编辑页面，使用layer弹窗插件弹出
		$.ajax({
			url:"app/mgr/user/user_role_page.action",
			type:"POST",
			data:{"userId" : id},
			success:function(data){
				layer.open({
					  type: 1,
					  title:"权限编辑",
					  btn:["保存","取消"],
					  success:function(layero){
					  	
					  },
					  yes:function(index,layero){
					  	var str = "";
						$(layero).find("#role_right_div").find("input[type=checkbox]").each(function(){
							if($(this).is(":checked")){
								str += $(this).attr("id");
							}
						});
						//执行保存操作
						$.ajax({
							url:"app/mgr/user/user_role.action",
							type:"POST",
							data:{"userId":id,"roles":str},
							success:function(data){
								var ret = JSON.parse(data);
								if (ret) {
									layer.alert("保存成功！",function(){
										layer.closeAll();
									});
								} else {
									alert("保存失败!");
								}
							}
						
						});
					  },
					  no:function(index){},
					  skin: 'layui-layer-rim', //加上边框
					  area: ['300px', '400px'], //宽高
					  content: data
					});
				}
		});
	}
	
</script>

<body>

	<div class="header">
		<div class="cus_list_btn">
			<a  onclick="goAddUser()" class="btn btn-success btn-sm"><label class="fa fa-user fa-lg"></label> 添加用户</a>
			<a id="backBtn"  onclick="backUser()" class="btn btn-primary"><label class="fa fa-mail-reply"></label> 返回</a>
		</div>
	</div>

	<div id="list_div" class="content">
		<div class="cus_tip">
			<label > 系统用户列表 </label>
		</div>
		<table  class="table table-striped table-bordered">
			<tr>
				<td>&nbsp;#</td>
				<td>用户名</td>
				<td>类型</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${result.pageList }" var="sysuser">
				<tr>
					<td >${sysuser.id }</td>
					<td >${sysuser.username }</td>
					<td >${sysuser.type=="1"?"高级管理员":"普通管理员" }</td>
					<td >
					<a class="btn btn-danger btn-sm glyphicon glyphicon-trash"  onclick="deleteUser('${sysuser.id }')">
					删除
					</a>
					|
					<a class="btn btn-warning btn-sm glyphicon glyphicon-link"  onclick="relateRole('${sysuser.id }')">
						关联角色
					</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 引入分页栏 -->
		<jsp:include page="../common/page.jsp">
			<jsp:param value="app/mgr/user/list" name="queryurl"/>
		</jsp:include>
	</div>
	<div id="add_div" class="content">
		<div class="cus_tip">
			<label > 提示：在这里你可以添加管理员</label>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-2-3">
				<form id="add_frm" action="app/mgr/user/add.action"
					class="pure-form pure-form-aligned" method="post">
					<div>
						<label>用户名</label> <input type="text" id="username" name="systemUser.username" required="required" onblur="checkField(this,true)"/>
						<label class="cus_required">*</label>
						<label cfor="username"></label>
					</div>
					<div>
						<label>密&nbsp;&nbsp;码</label> <input type="password" id="password" required="required" minlength="6"
							name="systemUser.password" />
							<label class="cus_required">*</label>
					</div>
					<div>
						<label>分&nbsp;&nbsp;组</label> <select name="systemUser.type" id="type" required
							>
							<option value="">请选择</option>
							<option value="1">高级管理员</option>
							<option value="2">普通管理员</option>
						</select>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>描&nbsp;&nbsp;述</label> 
						<textarea name="systemUser.description" cols="27" rows="5" style="resize:none" ></textarea>
					</div>
					<div style="margin-top: 5px;margin-left: 20%">
						<button name="添加" type="submit" class="btn btn-success" >添加</button>
						<button name="重置" type="reset" class="btn " >重置</button>
					</div>
				</form>
			</div>
			<!-- <div class="pure-u-1-3"></div> -->
		</div>
	</div>

</body>
</html>