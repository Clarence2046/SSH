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
		queryUrl  ="app/mgr/right/list";
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
		var  r = checkField($("#authId"),false);
		if(!r){
			$("#authId").focus();
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
	
	function edit(id){
		//ajax 获取编辑页面，使用layer弹窗插件弹出
		$.ajax({
			url:"app/mgr/right/editpage.action",
			type:"POST",
			data:{"systemRight.authId" : id},
			success:function(data){
				layer.open({
					  type: 1,
					  title:"权限编辑",
					  skin: 'layui-layer-rim', //加上边框
					  area: ['600px', '600px'], //宽高
					  content: data
					});
				}
		});
	}
	
	function deleteUser(id) {
		if(confirm("你确定要删除吗？")){
			$.ajax({
				url : "app/mgr/right/delete.action?t=" + Math.random(),
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
			url : "app/mgr/right/list.action?pageRequest.page=${result.page}&t=" + Math.random(),
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
			url:"app/mgr/ajaxright/checkField",
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
	
</script>

<body>

	<div class="header">
		<div class="cus_list_btn">
			<a  onclick="goAddUser()" class="btn btn-success btn-sm"><label class="fa fa-mortar-board fa-lg"></label> 添加权限</a>
			<a id="backBtn"  onclick="backUser()" class="btn btn-primary"><label class="fa fa-mail-reply"></label> 返回</a>
		</div>
	</div>

	<div id="list_div" class="content" style="max-width: 1100px;">
		<div class="cus_tip">
			<label > 系统权限列表 </label>
		</div>
		<table  class="table table-striped table-condensed">
			<tr>
				<td>编号</td>
				<td>父权限编号</td>
				<td>权限名称</td>
				<td>权限路径</td>
				<td>访问路径</td>
				<td>权限等级</td>
				<td>权限状态</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${result.pageList }" var="vo">
				<tr>
					<td >${vo.authId }</td>
					<td >${vo.parentAuthId }</td>
					<td >${vo.authName }</td>
					<td >${vo.authUrl }</td>
					<td >${vo.visitUrl }</td>
					<td >${vo.authLevel==1?"一级菜单":(vo.authLevel==2?"二级菜单":"页面内权限") }</td>
					<td >${vo.authStatus==0?"启用":"关闭" }</td>
					<td ><a class="btn btn-danger btn-xs"  onclick="deleteUser('${vo.authId }')"><li class="fa fa-trash"></li></a>
					|<a class="btn btn-primary btn-xs"  onclick="edit('${vo.authId}')"><li class="fa fa-edit"></li></a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 引入分页栏 -->
		<jsp:include page="../common/page.jsp">
			<jsp:param value="app/mgr/right/list" name="queryurl"/>
		</jsp:include>
	</div>
	<div id="add_div" class="content">
		<div class="cus_tip">
			<label > 提示：在这里你可以添加权限信息</label>
		</div>
		<div class="pure-g">
			<div class="pure-u-1-3"></div>
			<div class="pure-u-2-3">
				<form id="add_frm" action="app/mgr/right/add.action"
					class="pure-form pure-form-aligned" method="post">
					<div>
						<label>权限编号</label> <input type="text" id="authId" name="systemRight.authId" required="required" onblur="checkField(this)"/>
						<label class="cus_required">*</label>
						<label cfor="authId"></label>
					</div>
					<div>
						<label>上级编号</label> <input type="text" id="parentAuthId" name="systemRight.parentAuthId" required="required"/>
						<label class="cus_required">*</label>
						<label for="parentAuthId"></label>
					</div>
					<div>
						<label>权限名称</label> 
						<input type="text" id="authName" required="required" name="systemRight.authName" />
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>权限路径</label> 
						<input type="text" id="authUrl" required="required"  name="systemRight.authUrl" />
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>访问路径</label> 
						<input type="text" id="visitUrl" required="required"  name="systemRight.visitUrl" />
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>权限等级</label> 
						<select name="systemRight.authLevel" required>
							<option value="">请选择</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>是否启用</label> 
						<select name="systemRight.authStatus" required>
							<option value="0">启用</option>
							<option value="1">不启用</option>
						</select>
						<label class="cus_required">*</label>
					</div>
					<div>
						<label>描&nbsp;&nbsp;&nbsp;&nbsp;述</label> 
						<textarea name="systemRight.description" cols="27" rows="5" style="resize:none" ></textarea>
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