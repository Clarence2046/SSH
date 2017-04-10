<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title>My JSP 'home.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".showOrHideBanner").click(function() {
			var h = $(".vic_c_banner").css("height");
			if(h!="0px"){
				$(".vic_c_banner").css("height", "0px");
			}else{
				$(".vic_c_banner").css("height", "150px");
			}
		});

	});
</script>
</head>

<style>
<!--
@keyframes mfs{
	0% {-webkit-transform:rotateZ(0deg);}

	100% {-webkit-transform:rotateZ(360deg);}
}
@-webkit-keyframes mfs{
	0% {-webkit-transform:rotateZ(0deg);}

	100% {-webkit-transform:rotateZ(360deg);}
}
@-moz-keyframes mfs{
	0% {-webkit-transform:rotateZ(0deg);}

	100% {-webkit-transform:rotateZ(360deg);}
}
@-o-keyframes mfs{
	0% {-webkit-transform:rotateZ(0deg);}

	100% {-webkit-transform:rotateZ(360deg);}
}

.xx{
	transform:rotate(90deg);
}

.vic_body{
	width: 100%;
	height: auto;
	min-height:600px;
	background-color: #eee;
}
.vic_top{
    width: 100%;
    height: 50px;
    background-color: #eee;
    position: relative;
    top: 0;
    left: 0;
}
.vic_content{
	margin-top: 5px;
	position: relative;
	margin-left: 4%;
	margin-right: 4%;
	
}
.vic_footer{
	width: 100%;
	height: 30px;
	line-height: 30px;
	background-color: #eee;
	position: fixed;
	bottom: 0px;
	left:0;
	text-align: center;
	font-size: 12px;
	text-transform: capitalize;
	z-index: 9999;
}

.vic_c_banner{
	height: 150px;
	width: 100%;
	max-width:1100px;
	/* position: absolute; */
	
	transition: width 2s,height 2s;
	-moz-transition: width 2s,height 2s;
	-webkit-transition: width 2s,height 2s;
	-o-transition: width 2s,height 2s;
}

/* .vic_c_banner:HOVER{
	width: 0px;
	height: 0px;
}

.vic_c_banner:VISITED{
	height: 0px;
} */


.vic_c_banner div{
	float: left;
	width: 23%;
	height: 100%;
	/* background-color: gray; */
	border-radius:5px 5px;
	margin-left: 1%;
	margin-right: 1%;
}


.vic_c_banner div img{
	width: 100%;
	height: 100%;
	border-radius:5px 5px;
/* 	animation:mfs 5s;
	-moz-animation:mfs 5s;
	-webkit-animation:mfs 5s;
	-o-animation:mfs 5s; */
	transition: width 2s,height 2s;
	-moz-transition: width 2s,height 2s;
	-webkit-transition: width 1s,height 1s,margin-left 1s,margin-top 1s;
	-o-transition: width 2s,height 2s;
}

.vic_c_banner div img:HOVER{
	width: 110%;
	height: 110%;
	margin-left: -5%;
	margin-top: -5%;
	z-index: 9999;
}

.vic_c_main{
	width: 100%;
	height: auto;
	margin-top: 3px;
	max-width: 1120px;
	/* top:205px;
	position: absolute; */
}

.vic_c_left{
	height: auto;
	min-height:500px;
	max-width:250px;
	width: 24%;
	margin-left: 1%;
	background-color: #eee;
	float: left;
}

.vic_c_center{
	height: auto;
	min-height: 500px;
	background-color: #eee;
	width: 73%;
	float: left;
	margin-left: 1%;
	margin-right: 1%;
	max-width: 1000px;
}
.vic_c_right{
	height: auto;
	min-height: 500px;
	width: auto;
	background-color: #eee;
	float: left;
}

.showOrHideBanner{
	width: 0px;
	height: 0px;
	background-color: yellow;
	border: 10px solid gray;
	border-radius:10px 10px;
	position: absolute;
	top: 20px;
	left: 5px;
}

.showOrHideBanner:HOVER {
	cursor: pointer;
}

.vic_line{
	width: 98%;
    margin-left: 1%;
    height:25px;
    line-height:25px;
    background: -webkit-linear-gradient(30deg,gray, white); /* Safari 5.1 - 6.0 */
  	background: -o-linear-gradient(30deg,gray, white); /* Opera 11.1 - 12.0 */
  	background: -moz-linear-gradient(30deg,gray, white); /* Firefox 3.6 - 15 */
  	background: linear-gradient(30deg,gray, white); /* 标准的语法 */
    margin-top: 5px;
    box-shadow: 2px 2px 1px #dbded8;
    border-radius: 4px 4px;
}
.vic_line_colorful{
	width: 100%;
    height:15px;
    line-height:15px;
    background: -webkit-linear-gradient(30deg,gray, white,gray, white,gray); /* Safari 5.1 - 6.0 */
  	background: -o-linear-gradient(30deg,gray, white,gray, white,gray); /* Opera 11.1 - 12.0 */
  	background: -moz-linear-gradient(30deg,gray, white,gray, white,gray); /* Firefox 3.6 - 15 */
  	background: linear-gradient(30deg,gray, white,gray, white,gray); /* 标准的语法 */
    margin-top: 8px;
    margin-bottom: 8px;
    box-shadow: 2px 2px 1px #dbded8;
    border-radius: 4px 4px;
    max-width: 1100px;
}
.vic_line_s{
	width: 98%;
    margin-left: 1%;
    border-bottom: 1px solid #7e867e;
    margin-top: 5px;
    margin-bottom: 5px;
}
.vic_line_s1{
    width: 98%;
    margin-left: 1%;
    border-bottom: 1px solid #d6dcd6;
    margin-top: 5px;
    margin-bottom: 5px;
    float: left;
}
.vic_block{
	width: 96%;
    margin-left: 2%;
    min-height:100px;
    background-color: #e2e4df;
    margin-top: 5px;
    box-shadow: 2px 2px 1px #b3bdb8;
}
.vic_block_2x{
	width: 96%;
    margin-left: 2%;
    min-height:200px;
    background-color: #e2e4df;
    margin-top: 5px;
    box-shadow: 2px 2px 1px #b3bdb8;
}

.vic_title{
	font-size: 14px;
	-webkit-transition:font-size  1s,margin-left 1s;
	color: brown;
    background-color: #bdc5c5;
}
.vic_title:HOVER{
	font-size:15px;
	margin-left: 2%;
}
.vic_c_holder{
	width: 100%;
	height: auto;
}
.vic_pic_area{
	width: 50%;
	height: 196px;
	border: 2px solid green;
	float: left;
	-webkit-transition:border 1s,width 1s,height 1s;
}
.vic_pic_area img{
	width: 100%;
	height: 100%;
}
.vic_pic_area:HOVER{
	width: 48%;
	height: 184px;
	border: 8px solid green;
}
.vic_pic_title{
	width: 50%;
	margin-left: 2%;
	height: 200px;
	float: left;
}
-->
</style>
  <body>
	<div class="vic_top">
		<label class="showOrHideBanner"></label>
	</div>
	<article style="max-width: 1200px;margin: 0 auto;">
		<div class="vic_content">
			<div class="vic_c_banner">
				<div class="vic_c_banner1"><img alt="" src="custom/imgs/back1.jpg"></div>
				<div class="vic_c_banner2"><img alt="" src="custom/imgs/back2.jpg"></div>
				<div class="vic_c_banner3"><img alt="" src="custom/imgs/back1.jpg"></div>
				<div class="vic_c_banner4"><img alt="" src="custom/imgs/back2.jpg"></div>
			</div>
			
			<div class="vic_line_colorful"></div>
			
			<div class="vic_c_main">
				<div class="vic_c_left">
					<div class="vic_line">标题</div>
					<div class="vic_block">content 1</div>
					<div class="vic_line">科学博览</div>
					<div class="vic_block_2x">
						<div class="vic_title">
							地球的起源
						</div>
						<div class="vic_line_s"></div>
						<div class="vic_title">
								真空爆炸的研究
						</div>
						<div class="vic_line_s"></div>
						<div class="vic_title">
								视界线--看见未来
						</div>
					</div>
				</div>
				<div class="vic_c_center">
					<div class="vic_c_holder">
						<div class="vic_pic_area"><img alt="" src="custom/imgs/mgr_banner1.jpg"></div>
						<div class="vic_pic_title"></div>
						<div class="vic_line_s1"></div>
					</div>
				</div>
				<div class="vic_c_right">
				</div>
			</div>
		
		</div>
	</article>
	<div class="vic_footer">
		备案号： x-2017-03-25-1002516520
	</div>
  </body>
</html>
