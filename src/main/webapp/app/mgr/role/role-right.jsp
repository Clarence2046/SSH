<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
		<script type="text/javascript">
			$(document).ready(function() {
				$("#role_right_div .pure-menu .pure-menu-list .pure-menu-item")
					.find("input[type=checkbox]")
					.each(function(){
						$(this).click(function(){
							var checked = $(this).is(":checked");
							//��ǰ�˵�ֱ�Ӹ��˵�
							var parent = $(this).attr("parent");
							//���˵�ѡ�������
							checkingParent(parent,checked);
							//��������ͬʱѡ�л�ȡ��
							var id = $(this).attr("id");
							chooseChildren(id,checked);
							
							
							/* if(checked){
								//��ǰ�˵��ĸ���ѡ��
								checkParent(parent);
								
								//��������ѡ��
								var id = $(this).attr("id");
								chooseChildren(id,true);
							}else{
							
								//�������಻ѡ��
								var id = $(this).attr("id");
								chooseChildren(id,false);
								
								//������е��Ӳ˵�ȡ��ѡ���ˣ���ȡ�����˵���ѡ��״̬
								uncheckParent(parent);
							} */
						});
					
					
					});
					
					
					//ѡ���Ѿ�ӵ�е�Ȩ��
					var hasrights = ${hasRights};
					for(var i=0;i<hasrights.length;i++){
						//console.log(hasrights[i]);
						$("#right_"+hasrights[i]).prop("checked",true);
					}
			});
			
			function checkingParent(parentId,checked){
				if(checked){
					checkParent(parentId);
				}else{
					uncheckParent(parentId);
				}
			}
			
			/*
			*	ֻҪ��ǰ�˵�ѡ�У���˲˵��������ϼ��˵�ѡ��
			*
			*/
			function checkParent(parentId){
				if(parentId!= undefined){
					console.log($("#"+parentId));
					$("#"+parentId).prop("checked",true);
					var grandParent = $("#"+parentId).attr("parent");
					checkParent(grandParent);
				}
			}
			/*
			*	��������Ӳ˵���ȡ���ˣ����Ӧ�ĸ��˵�Ҳȡ��ѡ��
			*
			*/
			function uncheckParent(parentId){
				var allchecked = false;
				if(parentId!=undefined){
					$("input[type=checkbox][parent="+parentId+"]").each(function(){
						var ischecked = $(this).is(":checked");
						if(ischecked){
							allchecked = true;
						}
					});
					
					if(!allchecked){
						$("#"+parentId).prop("checked",false);
						var grandParent = $("#"+parentId).attr("parent");
						uncheckParent(grandParent);
					}
				}
			}
			
			/*
			* ѡ�л���ȡ��ѡ������˵�	
			*/
			function chooseChildren(parentId,checked){
				if(parentId!= undefined){
					$("input[type=checkbox][parent="+parentId+"]").each(function(){
						$(this).prop("checked",checked);
						chooseChildren($(this).attr("id"),checked);
					});
				}
			}
		
		</script>
		<div id="role_right_div" style="margin-left: 20%">
			<div class="pure-menu">
				<ul class="pure-menu-list">
					<c:forEach items="${allRights }" var="right">
						<c:choose>
							<c:when test="${fn:length(right.childrenMenu)+1>1 }">
								<!-- һ���˵� -->
								<li class="pure-menu-item">
									<input type="checkbox" id="right_${right.id }" style="">${right.title }
									<ul class="pure-menu-list-second" for="right_${right.id }">
										<c:forEach items="${right.childrenMenu }" var="right2">
											<c:choose>
												<c:when test="${fn:length(right2.childrenMenu)+1>1 }">
													<li class="pure-menu-item">
														<input type="checkbox" id="right_${right2.id }"  parent="right_${right.id }" style="">${right2.title }
														<ul class="pure-menu-list-second" for="right_${right2.id }">
															<c:forEach items="${right2.childrenMenu }" var="right3">
																<li class="pure-menu-item">
																	<input type="checkbox" id="right_${right3.id }" parent="right_${right2.id }" style="">${right3.title }
																</li>
															</c:forEach>
														</ul>
													</li>
												</c:when>
												<c:otherwise>
													<li class="pure-menu-item">
														<input type="checkbox" id="right_${right2.id }" parent="right_${right.id }" style="">${right2.title }
													</li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</ul>
								</li>
							</c:when>
							<c:otherwise>
								<li class="pure-menu-item">
									<input type="checkbox" id="right_${right.id }" style="">${right.title }
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				<!-- 
					<li class="pure-menu-item">
						<input type="checkbox" id="1000" style="">Ȩ��һ
						<ul class="pure-menu-list-second" for="1000">
							<li class="pure-menu-item"><input type="checkbox" id="1001" parent="1000">Ȩ�� 1.1</li>
							<li class="pure-menu-item"><input type="checkbox" id="1002" parent="1000">Ȩ�� 1.2</li>
							<li class="pure-menu-item"><input type="checkbox" id="1003" parent="1000">Ȩ�� 1.3</li>
						</ul>
					</li>
					<li class="pure-menu-item">
						<input type="checkbox" id="2000">Ȩ��2
						<ul class="pure-menu-list-second" for="2000">
							<li class="pure-menu-item">
								<input type="checkbox" id="2010" parent="2000">Ȩ�� 2.1
								<ul class="pure-menu-list-second" for="2010">
									<li class="pure-menu-item"><input type="checkbox" id="2011" parent="2010">Ȩ�� 2.1.1</li>
									<li class="pure-menu-item"><input type="checkbox" id="2012" parent="2010">Ȩ�� 2.1.2</li>
									<li class="pure-menu-item"><input type="checkbox" id="2013" parent="2010">Ȩ�� 2.1.3</li>
								</ul>
							</li>
							<li class="pure-menu-item"><input type="checkbox" id="2020" parent="2000">Ȩ�� 2.2</li>
							<li class="pure-menu-item"><input type="checkbox" id="2030" parent="2000">Ȩ�� 2.3</li>
						</ul>
					</li> -->
				</ul>
			</div>

		</div>

</body>
</html>