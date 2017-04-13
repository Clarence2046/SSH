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
<link rel="stylesheet" href="custom/css/my_front.css">
<script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".showOrHideBanner").click(function() {
			var h = $(".vic_c_banner").css("height");
			if(h!="0px"){
				$(".vic_c_banner").css("height", "0px");
				$(".vic_pic_banner").css("height", "0px");
				$(".vic_pic_banner li").css("height", "0px");
				$(".vic_pic_banner li img").css("height", "0px");
				$(".vic_pic_banner li .vic_desc_pic").css("display", "none");
			}else{
				$(".vic_c_banner").css("height", "150px");
				$(".vic_pic_banner").css("height", "150px");
				$(".vic_pic_banner li").css("height", "150px");
				$(".vic_pic_banner li img").css("height", "150px");
				$(".vic_pic_banner li .vic_desc_pic").css("display", "block");
			}
		});

	});
</script>
</head>

<style>
<!--



-->
</style>
  <body>
	<div class="vic_top">
		<div>
		<ul class="vic_menu">
			<li>首页</li>
			<li>科技博览</li>
			<li>萤石</li>
			<li>记录</li>
			<li>关于我</li>
		</ul>
		</div>
		<label class="showOrHideBanner"></label>
	</div>
	<article style="max-width: 1200px;margin: 0 auto;">
		<div class="vic_content">
			<div class="vic_c_banner">
				<ul class="vic_pic_banner">
					<li>
						<img alt="" src="custom/imgs/times.jpg">
						<label class="vic_desc_pic">文字</label>
					</li>
					<li>
						<img alt="" src="custom/imgs/tea.jpg">
						<label class="vic_desc_pic">文字</label>
					</li>
					<li>
						<img alt="" src="custom/imgs/times.jpg">
						<label class="vic_desc_pic">文字</label>
					</li>
					<li>
						<img alt="" src="custom/imgs/tea.jpg">
						<label class="vic_desc_pic">闲暇时光</label>
					</li>
				</ul>
			<!-- 	<div class="vic_c_banner1"><img alt="" src="custom/imgs/back1.jpg"></div>
				<div class="vic_c_banner2"><img alt="" src="custom/imgs/back2.jpg"></div>
				<div class="vic_c_banner3"><img alt="" src="custom/imgs/back1.jpg"></div>
				<div class="vic_c_banner4"><img alt="" src="custom/imgs/back2.jpg"></div> -->
			</div>
			<div>
			
			</div>
			
			<div class="vic_line_colorful"></div>
			
			<div class="vic_c_main">
				<div class="vic_c_left">
					<div class="vic_line">简介</div>
					<div class="vic_block">
						<label>名称：xxx博客</label>
						<label>语言：css + js</label>
						<label>建立日：xx-xx-xx</label>
					</div>
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
					<div class="vic_line">标签</div>
					<div class="vic_block vic_label_v">
						<label>数据库</label>
						<label>mysql</label>
						<label>Javascript</label>
						<label>Oracle</label>
						<label>前端开发</label>
					</div>
					<div class="vic_line">友情链接</div>
					<div class="vic_block">
						<label>数据库</label>
						<label>mysql</label>
						<label>Javascript</label>
						<label>Oracle</label>
						<label>前端开发</label>
					</div>
				</div>
				<div class="vic_c_center">
					<div class="vic_c_holder">
						<div class="vic_pic_area">
							<!-- 最开始设计成放置图片的，但不知道有什么用，所以变了个js动画在这里 -->
							<!-- <img alt="" src="#"> -->
							<div class="vic_ball vic_balls" id="ball1"></div>
							<div class="vic_ball_1 vic_balls"  id="ball2" time="3000"></div>
							<div class="vic_ball_1 vic_balls" id="ball3" time="3000"></div>
							<div class="vic_ball_2 vic_balls" id="ball4" time="4000"></div>
							<div class="vic_ball_2 vic_balls" id="ball5" time="4000"></div>
							<span class="vic_ball_label vic_balls" id="ball6" time="6000" changeback="false">欢迎你的到来！</span>
							<script type="text/javascript">
								//获取球父窗口的宽和高，初始随机一个角度运动
								$(document).ready(function(){
									/* flows($(".vic_ball"),0,0);
									flows($(".vic_ball_1"),0,0);
									flows($(".vic_ball_2"),0,0); */
									//var t1,t2,t3;
									var intIds = {};
									$(".vic_pic_area").find(".vic_balls").each(function(){
										var theid = $(this).attr("id");
										var time = $(this).attr("time");
										var changeback = $(this).attr("changeback");
										if(time==undefined){
											time = 2000;
										}
										if(changeback==undefined){
											changeback = true;
										}
										//console.log($(this));
										var ele = $(this);
										var tid = setInterval(function(){
											flows(ele,0,0,changeback);
										},time);
										
										intIds[theid] = tid;
										
										$(this).hover(function(){
											//鼠标进入方法，清除定时任务
											clearInterval(intIds[theid] );
										},function(){
											clearInterval(intIds[theid] );
											intIds[theid] = setInterval(function(){
																	flows(ele,0,0,changeback);
															},time);
										});
										
										flows(ele,0,0,changeback);
									});
									//console.log(intIds);
								});
								
								
								function flows(ele,lminus,tminus,changeback){
									//初始左上角 margin-left：0  margin-top：0
									//第一次随机坐标应该位于下或右两个边上
									//左上右下： 0 1 2 3
									//获取父元素高度和宽度
									var pw = parseInt($(ele).parent(".vic_pic_area").width());
									var ph = parseInt($(ele).parent(".vic_pic_area").height());
									var ballr = parseInt($(ele).width());
									var ballh = parseInt($(ele).height());
									//console.log("球半径： "+ballr);
									//球实际运动范围
									pwstart = 0 ;
									phstart = 0 ;
									pw = pw - ballr - lminus;
									ph = ph - ballh - tminus;
									//console.log("宽度："+pw+", 高度： "+ph);
									
									//改为相对父元素的位置
									var top = parseInt($(ele).position().top);
									var left = parseInt($(ele).position().left);
/* 									var top = parseInt($(ele).css("marginTop"));
									var left = parseInt($(ele).css("marginLeft")); */
									/* top = top + tminus;
									left = left + lminus; */
									//console.log("顶部："+top+", 左边： "+left);
									//下一步运动的方向选择
									var direction = [0,1,2,3];
									//距离范围有1个px的误差
									if ((top == 0 || top == 1 ) && (left == 0 || left == 1)) {
										direction = [ 2, 3 ];
									} else if (top > 1 && top< ph-1 && (left == 0 || left == 1)) {
										direction = [ 1, 2, 3 ];
									} else if (top>= ph - 1 && (left == 0 || left == 1)) {
										direction = [ 1, 2 ];
									} else if (top>= ph - 1 && left > 1) {
										direction = [ 0, 1, 2 ];
									} else if (top>= ph - 1 && left >= pw - 1) {
										direction = [ 0, 1 ];
									} else if (top > 1 && top< ph -1 && left >= pw - 1) {
										direction = [ 0, 1, 3 ];
									} else if ((top == 0 || top == 1 )  && left >= pw - 1) {
										direction = [ 0, 3 ];
									} else if ((top == 0 || top == 1 )  && left >1 && left < pw -1) {
										direction = [ 0,2, 3 ];
									}
									//随机0到 direction的长度的数字
									//console.log("长度： "+direction.length);
									var sub = Math.round(Math.random() * (direction.length - 1));
									//console.log("随机数【0，"+(direction.length - 1)+"】： "+sub);
									//获取是哪个边
									var theD = direction[sub];
									//console.log("本次运动的目标边： "+theD);
									//产生对应边上的随机坐标
									var marginl = 0;
									var margint = 0;
									if(theD == 0){
										marginl = pwstart;
										margint = randommn(phstart,ph-phstart);
									}else if(theD == 1){
										marginl = randommn(pwstart,pw-pwstart);
										margint = phstart;
									}else if(theD == 2){
										marginl = pw;
										margint = randommn(phstart,ph-phstart);
									}else if(theD == 3){
										marginl = randommn(pwstart,pw-pwstart);
										margint = ph;
									}
									//console.log("本次运动的目的坐标：【 "+marginl+","+margint+"]");
									
									$(ele).css("top",margint+"px");
									$(ele).css("left",marginl+"px");
									$(ele).position().top = margint+"px";
									$(ele).position().left = marginl+"px";
									
									//产生随机颜色 #000000-#ffffff,即6个0-f的值
									var colors = [0,1,2,3,4,5,6,7,8,9,10,'a','b','c','d','e','f'];
									var color = "#";
									for(var i=0;i<6;i++){
										var colorsub = randommn(0,colors.length-1);
										color = color + colors[colorsub];
									}
									if(changeback=="true"){
										console.log("本次改变颜色： "+color+" "+changeback);
										$(ele).css("backgroundColor",color);
									}
									$(ele).css("color",color);
								}
								
								function randommn(from,to){
									//随机1到ph-1的数字
									return Math.round(Math.random() * (to - from ) + from);
								}
							</script>
						</div>
						<div class="vic_pic_title"></div>
					</div>
					<div class="vic_posts">
						<div class="vic_post_header">
							<!-- <div class="vic_trangle_l"></div> -->
							<div class="vic_trangle_r"></div>
							<div class="vic_header1">
							最新文章
							</div>
						</div>
						<div class="vic_post">
							<label class="vic_p_title">文章标题</label>
							<label class="vic_p_info">作者：admin   时间 ：5分钟前   分类： 奇闻</label>
							<p>内容简介</p>
						</div>
						<div class="vic_post">
							<label class="vic_p_title">文章标题</label>
							<label class="vic_p_info">作者：admin   时间 ：5分钟前   分类： 奇闻</label>
							<p>内容简介</p>
						</div>
						<div class="vic_post">
							<label class="vic_p_title">文章标题</label>
							<label class="vic_p_info">作者：admin   时间 ：5分钟前   分类： 奇闻</label>
							<p class="vic_short_content">在window.onscroll上即可添加滚动条滚动事件，在监听函数中的top=document.documentElement.scrollTop||document.body.scrollTop;之所以这么写，就是避免不同浏览器的兼容性，这里我测试了chrom和ff浏览器，前者支持document.body.scrollTop这个属性，后者支持另一个属性，因此可以用‘||’符号糅合这两个属性，兼容不同浏览器。anchorTop就是目标的开始与浏览器顶部的距离，这里还需要注意的是’#anchor‘这个标签的position：absulate，否则top属性值总是是0px。</p>
						</div>
					</div>
				</div>
				<!-- <div class="vic_c_right">
				</div> -->
			</div>
			<div class="vic_footer">
				备案号： x-2017-03-25-1002516520
			</div>
		</div>
	</article>
	<!-- <div class="vic_footer">
		备案号： x-2017-03-25-1002516520
	</div> -->
  </body>
  <script type="text/javascript">
  	window.onscroll=function(){
  		var top = $(".vic_menu").offset().top;
  		var sctop = $(window).scrollTop();
  		var ptop = $(".showOrHideBanner").offset().top;
  		console.log(top-sctop);
  		console.log(ptop-sctop);
  		if(top-sctop<=0 && ptop-sctop<=0){
  			//固定到顶部
  			$(".vic_menu").addClass("vic_fix_top");
  		}else{
  			$(".vic_menu").removeClass("vic_fix_top");
  		}
  	};
  </script>
</html>
