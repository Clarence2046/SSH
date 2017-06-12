<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A layout example that shows off a blog page with a list of posts.">
    <title>光阴易逝 &ndash; 岁月无回</title>

</head>

<body>
		<div class="cus_line">最新评论</div>
     	<div class="cus_comment_list">
     		<!-- 评论列表 -->
			<c:forEach items="${page.pageList }" var="comment">
				<div class="cus_comment">
					<div class="cus_comment_head">
						<label id="comment_user_${comment.id }" user="${comment.username }">#${comment.floor} ${comment.username }
							<c:if test="${not empty comment.replyId  }">
								回复[#${comment.replyFloor} ${comment.replyUsername }]
							</c:if>
						</label>
						<label >${comment.createDateStr }</label>
					</div>
					<div class="cus_comment_detail" id="comment_${comment.id }">
						${comment.strContent }
					</div>
					<div class="cus_comment_action">
						<a onclick="replyComment('${comment.id }')">回复</a>
						<span style="color: #eee;">|</span>
						<a onclick="watchReplyComment('${comment.id }')">查看回复(${comment.replyCount })</a>
					</div>
				</div>
			</c:forEach>
		    <!-- 引入分页栏 -->
		    <c:if test="${page.totalPage > 1 }">
				<jsp:include page="page.jsp">
					<jsp:param value="app/front/comments" name="queryurl"/>
				</jsp:include>
		    </c:if>
		    <c:if test="${page.totalPage <= 1 }">
				<div style="text-align: center;font-size: 12px;color: gray;">
					-评论已加载完毕-
				</div>
		    </c:if>
        </div>
        <!-- 评论框 --> 
        <div class="cus_comment_form">   	
	      	<form action="">
	      		<input type="hidden" id="replyId" value="">
	      		<div class="form-group">
		        	<!-- <label for="comment_area" style="margin-bottom: 10px;border-bottom:1px solid; ">留言</label> -->
		        	<div>
		        		<textarea  id="comment_area" maxlength="100" onkeyup="checkCount(this)" onblur="ableSubmit()" placeholder="留下你想说的话吧"></textarea>
		        		<label class="cus_commenttip">你当前还可以输入100个字
		        		</label>
	        			<button type="button" class="cus_comment_add cus_comment_add_disable" disabled="disabled"  onclick="submitComment()" id="addComment" >发布</button>
		        	</div>
	      		</div>
	      	</form>
      	</div>
      	<script type="text/javascript">
            function loadComments(blogId){
      			$.ajax({
      				url:"app/front/comments",
      				type:"Post",
      				data:{"blogId":blogId},
      				success:function(data){
      					$(".cus_comment_section").html(data);
      				}
      			});
      		}
      		//检查评论输入的字数
      		function checkCount(ele){
      			var txt = $(ele).val();
      			if(txt.length>100 || txt.length<5){
      				return false;
      			}
      			var remain = 100 - txt.length;
      			$(".cus_commenttip").text("你当前还可以输入"+remain+"个字");
      			return true;
      		}
      		//判断是否可以进行提交
      		function ableSubmit(){
      			var txt = $("#comment_area").val();
      			if(txt.length>100 || txt.length<5){
      				$("#addComment").removeClass("cus_comment_add_enable");
      				$("#addComment").attr("disabled",true);
      				$("#addComment").addClass("cus_comment_add_disable");
      				$("#comment_area").focus();
      				return false;
      			}else{
       				$("#addComment").removeAttr("disabled");
      				$("#addComment").removeClass("cus_comment_add_disable");
      				$("#addComment").addClass("cus_comment_add_enable");
      			}
      		}
      		//点击回复事件
    		function replyComment(commentId){
	    		var comment = $("#comment_"+commentId).text().trim();
	    		var username = $("#comment_user_"+commentId).attr("user");
	    		$("#replyId").val(commentId);
	    		$("#comment_area").attr("placeholder","回复【"+username+"】:"+comment);
	    		$("#comment_area").focus();
	    	}
	    	//提交评论
      		function submitComment(){
      			var comment = $("#comment_area").val();
      			if(comment.length<5){
      				layer.alert("请至少输入5个字符");
      				return;
      			}
      			var params = {};
      			params["comment.blogId"] = blogId;
      			params["commentContent"] = comment;
      			params["comment.replyId"] = $("#replyId").val();
      			
      			$.ajax({
      				url:"app/front/comment",
      				type:"Post",
      				data:params,
      				success:function(data){
      					var ret = JSON.parse(data);
      					if(ret){
      						loadComments(blogId);
      					}
      				}
      			});
      		}
      		
      		function watchReplyComment(){}
      	</script>
</body>
</html>
