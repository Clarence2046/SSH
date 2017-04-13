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
<c:set value="<%=basePath%>" var="basepath"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pure ��̨����  ����">
<title>���˲��ͺ�̨����</title>
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
		    <label for="blog_title"  class="col-sm-2 control-label">����</label>
		    <div class="col-sm-10">
		    	<input type="text" class="form-control" id="blog_title" name="entity.title" placeholder="����">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="blog_subtitle"  class="col-sm-2 control-label">������</label>
		   	<div class="col-sm-10">
		    	<input type="text" class="form-control" id="blog_subtitle" name="entity.subTitle" placeholder="������">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="blog_label"  class="col-sm-2 control-label">��ǩ</label>
		   	<div class="col-sm-10" id="mylabels">
		    	<c:forEach items="${labels }" var="label">
		    		<span class="btn btn-sm cus_label_btn" onclick="chooseLabel(this,'${label['id'] }')" id="label_${label['name'] }">${label['name'] }</span>
		    	</c:forEach>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="blog_desc"  class="col-sm-2 control-label">ժҪ</label>
		   	<div class="col-sm-10" >
		    	<textarea style="width: 100%;height: 100px;resize:none;" name="entity.description" id="blog_description" placeholder="ժҪ��������ǰ̨����չʾ���ܵģ��������д"></textarea>
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
	      <button type="button" class="btn btn-default" onclick="save()">����</button>
	      <button type="button" class="btn btn-default" onclick="saveAndPublish()">���沢����</button>
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
				layer.alert("��������⣡");
				return;
			}
			var subtitle = $("#blog_subtitle").val();
			if(!ue.hasContents()){
				layer.alert("�������������ݣ�");
				return;
			}
			var content= ue.getContent();
			var labelnames = "";
			//��ȡѡ�е�labels
			$("#mylabels").find(".active").each(function(){
				labelnames+=$(this).attr("id").substr(6)+",";
			});
			labelnames = labelnames.substr(0,labelnames.length-1);
			var params = {};
			params["entity.title"] = title;
			params["entity.subTitle"] = subtitle;
			params["entity.labels"] = labelnames;
			params["entity.description"] = $("#blog_description").val();
			params["content"] = content;
			
			$.ajax({
				url:url,
				type:"POST",
				data:params,
				success:function(data){
					var ret = JSON.parse(data);
					if(ret){
						layer.alert("��ӳɹ�");
					}else{
						layer.alert("���ʧ��");
					}
				}
			
			});
			
		}
		function saveAndPublish(){
		
		}
		
		function chooseLabel(ele,labelId){
			if($(ele).hasClass("active")){
				$(ele).removeClass("active");
			}else{
				$(ele).addClass("active");
			}
		}
	</script>
</body>

</html>