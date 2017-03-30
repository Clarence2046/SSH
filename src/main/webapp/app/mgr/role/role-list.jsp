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
		queryUrl  ="/app/mgr/role/list";
	});


	function goAdd() {
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
	function backList() {
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
			url:"/app/mgr/role/editpage.action",
			type:"POST",
			data:{"systemRight.authId" : id},
			success:function(data){
				layer.open({
					  type: 1,
					  title:"权限编辑",
					  skin: 'layui-layer-rim', //加上边框
					  area: ['600px', '560px'], //宽高
					  content: data
					});
				}
		});
	}
	function relateRight(id){
		//ajax 获取编辑页面，使用layer弹窗插件弹出
		$.ajax({
			url:"app/mgr/role/role_right_page.action",
			type:"POST",
			data:{"authId" : id},
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
							url:"app/mgr/role/role_right.action",
							type:"POST",
							data:{"roleId":id,"rights":str},
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
	
	function deleteRole(id) {
		layer.confirm("你确定要删除吗？",function(){
			$.ajax({
				url : "app/mgr/role/delete.action?t=" + Math.random(),
				type : "post",
				data : {
					"entity.roleId" : id
				},
				success : function(data) {
					var ret = JSON.parse(data);
					if (ret) {
						layer.alert("删除成功！",function(){
							reloadList();
						});
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
		});
	}

	function reloadList() {
		$.ajax({
			url : "app/mgr/role/list.action?t=" + Math.random(),
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

table tr td{
	text-align: center;
}
-->
</style>
<body>

	<div class="header">
		<div align="left">
	<!-- 		<a  onclick="goAdd()" class="btn btn-success btn-md"><label class="fa fa-user fa-lg"></label> 添加角色</a>
			<a id="backBtn"  onclick="backList()" class="btn btn-primary"><label class="fa fa-mail-reply"></label> 返回</a>
		 --></div>
	</div>

	<div id="list_div" class="content">
		<div class="cus_tip">
			<label > 系统权限列表 </label>
		</div>
		<table  class="table table-striped">
			<tr>
				<td>编号</td>
				<td>角色名称</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${result.pageList }" var="vo">
				<tr>
					<td >${vo.roleId }</td>
					<td >${vo.roleName }</td>
					<td >
					<a class="btn btn-danger btn-sm glyphicon glyphicon-trash"  onclick="deleteRole('${vo.roleId }')">
						删除
					</a>
					| 
					<a class="btn btn-warning btn-sm glyphicon glyphicon-link"  onclick="relateRight('${vo.roleId }')">
						关联权限
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
					  当前${result.page }页/共${result.totalPage }页
					  每页
					 <select name="pageSize" onchange="gotopage(1)">
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


</body>
</html>