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
				url : "user/delete.action?t=" + Math.random(),
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
			<a  onclick="goAddUser()" class="btn btn-success btn-md"><label class="fa fa-user fa-lg"></label> 添加用户</a>
			<a id="backBtn"  onclick="backUser()" class="btn btn-primary"><label class="fa fa-mail-reply"></label> 返回</a>
		</div>
	</div>

	<div id="list_div" class="content">
		<div class="cus_tip">
			<label > 系统用户列表 </label>
		</div>
		<table  class="table table-striped">
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
					  当前${result.page }页/共${result.totalPage }页
					  每页
					 <select name="pageSize" >
					 	<option value="5" <c:if test="${result.pageSize==5 }">selected</c:if>>5</option>
					 	<c:forEach begin="2" end="8" step="2" var="t">
					 		${t }
						 	<option value="${t*5 }" <c:if test="${result.pageSize==(t*5) }">selected</c:if>>${t * 5 }</option>
					 	</c:forEach>
					 </select> 
					  条
					  /共${result.size }条
			
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
			<label > 提示：在这里你可以添加管理员</label>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-2-3">
				<form id="add_frm" action="user/add.action"
					class="pure-form pure-form-aligned" method="post">
					<div>
						<label>用户名</label> <input type="text" id="username" name="systemUser.username" required="required"/>
						<label class="cus_required">*</label>
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