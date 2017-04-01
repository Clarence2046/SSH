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
<c:set value="<%=basePath%>" var="basepath"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pure 后台管理  博客">
<title>个人博客后台管理</title>
<script type="text/javascript">
window.UEDITOR_HOME_URL = "${basepath}/third/ueditor1.4.3.3/";
</script>
</head>
<body>
	<div class="header">
		<div class="cus_list_btn">
		</div>
	</div>

	<div id="add_div" class="content">
		<form class="form-horizontal" action="app/mgr/blog/add" id="add_frm">
		  <div class="form-group">
		    <label for="blog_title"  class="col-sm-2 control-label">主题</label>
		    <div class="col-sm-10">
		    	<input type="text" class="form-control" id="blog_title" name="entity.title" placeholder="主题">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="blog_subtitle"  class="col-sm-2 control-label">副标题</label>
		   	<div class="col-sm-10">
		    	<input type="text" class="form-control" id="blog_subtitle" name="entity.subTitle" placeholder="副标题">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="blog_subtitle"  class="col-sm-2 control-label">标签</label>
		   	<div class="col-sm-10">
		    	
		    </div>
		  </div>
		  <div class="form-group">
		    <!-- <label for="blog_subtitle"  class="col-sm-2 control-label"></label> -->
		   	<div class="col-sm-12">
		    	<script id="blog_content" type="text/plain" style="width:100%;height:500px;"></script>
		    </div>
		  </div>
		</form>
	   <div class="form-group">
	    <div class="col-sm-offset-4 col-sm-8">
	      <button type="button" class="btn btn-default" onclick="save()">保存</button>
	      <button type="button" class="btn btn-default" onclick="saveAndPublish()">保存并发表</button>
	    </div>
	   </div>
	</div>
	<script type="text/javascript" charset="utf-8" src="third/ueditor1.4.3.3/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="third/ueditor1.4.3.3/ueditor.all.js"> </script>
	<script type="text/javascript" charset="utf-8" src="third/ueditor1.4.3.3/lang/zh-cn/zh-cn.js"></script>	
	<script type="text/javascript">
		var ue =  UE.getEditor('blog_content');
		
		function save(){
			
			var url = $("#add_frm").attr("action");
			var title = $("#blog_title").val();
			if(title.length<=1){
				layer.alert("请输入标题！");
				return;
			}
			var subtitle = $("#blog_subtitle").val();
			if(!ue.hasContents()){
				layer.alert("请输入正文内容！");
				return;
			}
			var content= ue.getContent();
			
			var params = {};
			params["entity.title"] = title;
			params["entity.subTitle"] = subtitle;
			params["content"] = content;
			
			$.ajax({
				url:url,
				type:"POST",
				data:params,
				success:function(data){
					layer.alert(data);
				}
			
			});
			
		}
		function saveAndPublish(){
		
		}
	</script>
</body>

</html>