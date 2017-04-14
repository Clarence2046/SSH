<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）: 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<link rel="stylesheet" href="custom/css/my_front_index.css">
<script type="text/javascript" src="third/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="custom/js/front.js"></script>
<script type="text/javascript" src="custom/js/front_extra.js"></script>
</head>
<style>
<!--
.vic_ball_test{
	width: 20px;
	height: 20px;
	border-radius:10px 10px;
	background-color: green; 
	/* -webkit-transition:margin-left 3s, margin-top 3s,background-color 2s; */
	transition:left 1s, top 1s,background-color 1s;
	-webkit-transition:left 1s, top 1s,background-color 1s;
	-moz-transition:left 1s, top 1s,background-color 1s;
	-o-transition:left 1s, top 1s,background-color 1s;
	position: absolute;
	top:0px;
	left:0px;
	float: left;
}
-->
</style>
  <body>
<div class="vic_pic_area" style="width: 520px;height: 220px;">
	<!-- 最开始设计成放置图片的，但不知道有什么用，所以变了个js动画在这里 -->
	<!-- <img alt="" src="#"> -->
	<div class="vic_ball_test "  id="ballx" time="3000"></div>
	<!--操作在 front.js-->
	<script type="text/javascript">
		//ballx的运动轨迹
		var allPoints = new Array();
		var tana;
		var width = 500;
		var height = 200;
		var total = 0;
		var prePoint = {x:0,y:0};
		var nextPoint = {};
		var sideW = 0;
		var stop = false;
		var flag = false;//false 为逆时针 下右上左
		var nextMethod = "";
		var time = 1000; //运行速度
		var pointsToRun = 20;
		
		$(document).ready(function(){
		
			var a = 60;
			//初始运动角度
			var degree = a * Math.PI/180;
			//此角度正切值
			tana = Math.tan(degree);
			console.log("tan30:"+tana);
			//运动范围的矩形数据
			width = 500;
			height = 200;
			//则   0 < x < 500, 0 < y < 200
			//出发点
			prePoint = {x:0,y:0};
			nextPoint = {};
			sideW = 0;
		
			//第一次运动终点
			nextPoint.x = Math.floor(height / tana);
			nextPoint.y = height;
			console.log("第1次目标点："+nextPoint.x+","+nextPoint.y);
			
			
			prePoint.x = nextPoint.x;
			prePoint.y = nextPoint.y;
			allPoints[0] = {x:nextPoint.x,y:nextPoint.y};
			
			sideW = prePoint.x;
			//第2...n次
			var nwth = Math.ceil(width/sideW);
			//console.log("nwth: "+nwth+", W="+sideW);
			
			//点在下边  , 上下运动直到撞击右边
			for(var i=1;i<nwth;i++){
				nextPoint.x = prePoint.x + sideW;
				if(nextPoint.x < width){
					//运行到上边
					if(i%2==0){
						nextPoint.y = height;
					}else{
						nextPoint.y = 0;
					}
				}else{
					if(i%2==0){
						//运动到了右边	,向下变化
						nextPoint.x = width;
						
						sidew1 = width - prePoint.x;
						sideW = Math.floor(sidew1 * tana);
						nextPoint.y = sideW;
						
						flag = true;
					}else{
						//运动到了右边	,向上变化
						nextPoint.x = width;
						
						//侧边宽度
						sidew1 = width - prePoint.x;
						sideW =Math.floor( sidew1 * tana);
						nextPoint.y = height - sideW;
					}
				
				}
				//console.log("上次目标点："+prePoint.x+","+prePoint.y);
				console.log("第"+(i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				
				allPoints[i] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = nwth - 1;
			stopMe(total);
			if(stop){
				return;
			}
			console.log(flag);
			if(flag){
				rightReverse(prePoint,nextPoint);
			}else{
				right(prePoint,nextPoint);
			}
			
			
			//加载时，先在加载50个点，运行完成再进行继续获取点
			console.log("第一次运动点数："+allPoints.length);
			console.log(allPoints);
			ff(0);
			
			//继续获取pointsToRun个点,需要之前保存接下来执行的方法
			nextPoints(pointsToRun+3);
			
			
		});
		
		function  ff(index){
			if(allPoints.length<=index){
				return;
			}
			if(allPoints[index]==undefined){
			return;
			}
			setTimeout(function(){
				console.log("执行:"+index+" (x:"+allPoints[index].x+",y:"+allPoints[index].y+")");
				$("#ballx").css("top",allPoints[index].y+"px");
				$("#ballx").css("left",allPoints[index].x+"px");
				//运行过的点，进行置空
				//allPoints[index] = null;
				index++;
				ff(index);
			},time);
		}
		function  nextPoints(num){
			setTimeout(function(){
				count = 0;
				total = 0;
				stop = false;
				var func = eval(nextMethod);
				prePoint.x = allPoints[allPoints.length-1].x;
				prePoint.y = allPoints[allPoints.length-1].y;
				nextPoint.x = allPoints[allPoints.length-1].x;
				nextPoint.y = allPoints[allPoints.length-1].y;
				allPoints = new Array();
				allPoints[0] = {x:nextPoint.x,y:nextPoint.y};
				console.log("prePoint: "+prePoint.x+","+prePoint.y);
				console.log("nextPoint: "+nextPoint.x+","+nextPoint.y);
				
				func(prePoint,nextPoint);
				console.log("后续运动点数: ");
				console.log(allPoints);
				ff(0);
				nextPoints(pointsToRun+3);
			},num*time);
		}
		
		
		function sleep(ms){
			var dat = new Date().getTime();
			var dat_end = new Date().getTime();
			var x = dat_end - dat;
			while(x<ms){
				dat_end = new Date().getTime();
				x = dat_end - dat;
			}
		}
		
		function up(prePoint,nextPoint){
			//此时运动到上边
			flag = false;
			//此时运动的sideW = height / tana;
			sideW =Math.floor( height / tana);
			var tempWidth = prePoint.x;
			nwth = Math.ceil(tempWidth/sideW);
			//console.log("changeSide up: "+ nwth+",sideW="+sideW);
			for(var i=0;i<nwth;i++){
				nextPoint.x = nextPoint.x - sideW;
				if(nextPoint.x > 0){
					//运动到左边
					if((i+1)%2==0){
						nextPoint.y = 0;
					}else{
						nextPoint.y = height;
					}
				}else{
					//运动到左边
					if((i+1)%2==0){
						//运动到左边,向y减小方向运行
						nextPoint.x = 0;
						//剩余距离
						sidew1 = prePoint.x;
						nextPoint.y =height -  Math.floor( sidew1 * tana);
						flag = true;
					}else{
						//运动到左边,向y增大方向运行
						nextPoint.x = 0;
						//剩余距离
						sidew1 = prePoint.x;
						nextPoint.y = Math.floor( sidew1 * tana);
					}
				}
				console.log("--u--第"+(total+i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				
				allPoints[total+i+1] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = total + nwth;
			stopMe(total,flag?"leftReverse":"left");
			if(stop){
				return;
			}
			if(flag){
				leftReverse(prePoint,nextPoint);
			}else{
				left(prePoint,nextPoint);
			}
			
		}
		
		//出发点在上，  顺时针
		function upReverse(prePoint,nextPoint){
			flag = false;
			//此时运动到上边
			//此时运动的sideW = height / tana;
			sideW =Math.floor( height / tana);
			var tempWidth = width - prePoint.x;
			nwth = Math.ceil(tempWidth/sideW);
			console.log(tempWidth+" changeSide up: "+ nwth+",sideW="+sideW);
			for(var i=0;i<nwth;i++){
				nextPoint.x = nextPoint.x + sideW;
				if(nextPoint.x < width){
					//上下运动
					if((i+1)%2==0){
						nextPoint.y = 0;
					}else{
						nextPoint.y = height;
					}
				}else{
					if((i+1)%2==0){
						//运动到左边,向y减小方向运行
						nextPoint.x = width;
						//剩余距离
						sidew1 = width - prePoint.x;
						nextPoint.y = height - Math.floor( sidew1 * tana);
					}else{
						//运动到左边,向y增大方向运行
						nextPoint.x = width;
						//剩余距离
						sidew1 = width - prePoint.x;
						nextPoint.y = Math.floor( sidew1 * tana);
						flag = true;
					}
				}
				console.log("--ur--第"+(total+i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				allPoints[total+i+1] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = total + nwth;
			stopMe(total,flag?"rightReverse":"right");
			if(stop){
				return;
			}
			if(flag){
				rightReverse(prePoint,nextPoint);
			}else{
				right(prePoint,nextPoint);
			}
			
		}
		
		//点在下边 逆时针
		function down(prePoint,nextPoint){
			//此时运动到下边，与第一次不同
			flag = false;
			//此时运动的sideW = height / tana;
			sideW = Math.floor(height / tana);
			var tempWidth = width - prePoint.x;
			nwth = Math.ceil(tempWidth/sideW);
			//console.log("changeSide down: "+ nwth+",sideW="+sideW);
			for(var i=0;i<nwth;i++){
				nextPoint.x = nextPoint.x + sideW;
				if(nextPoint.x < width){
					//运动到上
					if((i+1)%2==0){
						nextPoint.y = height;
					}else{
						nextPoint.y = 0;
					}
				}else{
					if((i+1)%2==0){
						//运动到右边，y增大方向
						nextPoint.x = width;
						//剩余距离
						sidew1 = width - prePoint.x;
						nextPoint.y = Math.floor( sidew1 * tana);
						flag = true;
					}else{
						//运动到右边,y减小
						nextPoint.x = width;
						//剩余距离
						sidew1 = width - prePoint.x;
						nextPoint.y = height - Math.floor( sidew1 * tana);
					}
					
				}
				console.log("--d--第"+(total+i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				allPoints[total+i+1] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = total + nwth;
			stopMe(total,flag?"rightReverse":"right");
			if(stop){
				return;
			}
			if(flag){
				rightReverse(prePoint,nextPoint);
			}else{
				right(prePoint,nextPoint);
			}
		}
		
		//下边，右边-》左边变化
		function downReverse(prePoint,nextPoint){
			flag = false;
			//此时运动的sideW = height / tana;
			sideW = Math.floor(height / tana);
			var tempWidth = prePoint.x;
			nwth = Math.ceil(tempWidth/sideW);
			//console.log("changeSide down: "+ nwth+",sideW="+sideW);
			for(var i=0;i<nwth;i++){
				nextPoint.x = nextPoint.x - sideW;
				if(nextPoint.x > 0){
					//上下运动
					if(i%2==0){
						nextPoint.y = 0;
					}else{
						nextPoint.y = height;
					}
				}else{
					if((i+1)%2==0){
						//运动到左边,来自上
						nextPoint.x = 0;
						//剩余距离
						sidew1 = prePoint.x;
						nextPoint.y = Math.floor( sidew1 * tana);
					}else{
						//运动到左边,来自下
						nextPoint.x = 0;
						//剩余距离
						sidew1 = prePoint.x;
						nextPoint.y = height - Math.floor( sidew1 * tana);
						flag = true;//此标记为逆时针
					}
				}
				console.log("--dr--第"+(total+i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				allPoints[total+i+1] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = total + nwth;
			stopMe(total,flag?"leftReverse":"left");
			if(stop){
				return;
			}
			if(flag){
				leftReverse(prePoint,nextPoint);
			}else{
				left(prePoint,nextPoint);
			}
			
		}
		
		function left(prePoint,nextPoint){
			//此时运动到左边
			flag = false;
			//此时运动的sideW = width * tana;
			sideW = Math.floor(width * tana);
			var tempWidth = height - prePoint.y;
			nwth = Math.ceil(tempWidth/sideW);
			//console.log("changeSide Left: "+ nwth+",sideW="+sideW);
			for(var i=0;i<nwth;i++){
				nextPoint.y = nextPoint.y + sideW;
				if(nextPoint.y < height){
					//运动到左边
					if((i+1)%2==0){
						nextPoint.x = 0;
					}else{
						nextPoint.x = width;
					}
				}else{
					//运动到下边,
					if((i+1)%2==0){
						//向y减小方向运行
						nextPoint.y = height;
						//剩余距离
						sidew1 = height - prePoint.y;
						nextPoint.x = width -  Math.floor( sidew1 / tana);
						flag = true;
					}else{
						//向y增大方向运行
						nextPoint.y = height;
						//剩余距离
						sidew1 = height - prePoint.y;
						nextPoint.x = Math.floor( sidew1 / tana);
					}
				}
				console.log("--l--第"+(total+i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				allPoints[total+i+1] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = total + nwth;
			stopMe(total,flag?"downReverse":"down");
			if(stop){
				return;
			}
			if(flag){
				downReverse(prePoint,nextPoint);
			}else{
				down(prePoint,nextPoint);
			}
		}
		function leftReverse(prePoint,nextPoint){
			//此时运动到左边
			flag = false;
			//此时运动的sideW = width * tana;
			sideW = Math.floor(width * tana);
			var tempWidth = prePoint.y;
			nwth = Math.ceil(tempWidth/sideW);
			//console.log("changeSide Left: "+ nwth+",sideW="+sideW);
			for(var i=0;i<nwth;i++){
				nextPoint.y = nextPoint.y - sideW;
				if(nextPoint.y > 0){
					//左右运动
					if((i+1)%2==0){
						nextPoint.x = width;
					}else{
						nextPoint.x = 0;
					}
				}else{
					if((i+1)%2==0){
						//运动到上边 ，false
						nextPoint.y = 0;
						//剩余距离
						sidew1 = prePoint.y;
						nextPoint.x = width - Math.floor( sidew1 / tana);
					}else{
						//运动到上边  ，true
						nextPoint.y = 0;
						//剩余距离
						sidew1 = prePoint.y;
						nextPoint.x = Math.floor( sidew1 / tana);
						flag = true;
					}
				}
				console.log("--lr--第"+(total+i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				allPoints[total+i+1] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = total + nwth;
			stopMe(total,flag?"upReverse":"up");
			if(stop){
				return;
			}
			if(flag){
				upReverse(prePoint,nextPoint);
			}else{
				up(prePoint,nextPoint);
			}
			
		}
		
		function right(prePoint,nextPoint){
			//此时点运动到了右边,左右运动，直到撞击上边
			flag  = false;
			//此时运动的sideW = width * tana;
			sideW = Math.floor(width * tana);
			var tempWidth = prePoint.y;
			nwth = Math.ceil(tempWidth/sideW);
			//console.log("changeSide Right: "+ nwth+",sideW="+sideW);
			for(var i=0;i<nwth;i++){
				nextPoint.y = nextPoint.y - sideW;
				if(nextPoint.y > 0){
					//左右运动
					if((i+1)%2==0){
						nextPoint.x = width;
					}else{
						nextPoint.x = 0;
					}
				}else{
					//运动到上边
					if((i+1)%2==0){
						//向x增大方向运行
						nextPoint.y = 0;
						//剩余距离
						sidew1 = prePoint.y;
						nextPoint.x = Math.floor( sidew1 / tana);
						flag = true;
					}else{
						//运动到上边,向x减小方向运行
						nextPoint.y = 0;
						//剩余距离
						sidew1 = prePoint.y;
						nextPoint.x = width - Math.floor( sidew1 / tana);
					}
				}
				console.log("--r--第"+(total+i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				allPoints[total+i+1] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = total + nwth;
			
			stopMe(total,flag?"upReverse":"up");
			if(stop){
				return;
			}
			
			if(flag){
				upReverse(prePoint,nextPoint);
			}else{
				up(prePoint,nextPoint);
			}
		}
		
		function rightReverse(prePoint,nextPoint){
			//此时点运动到了右边,左右运动，直到撞击下边
			flag = false;
			//此时运动的sideW = width * tana;
			sideW = Math.floor(width * tana);
			var tempWidth = height - prePoint.y;
			nwth = Math.ceil(tempWidth/sideW);
			//console.log("changeSide Right: "+ nwth+",sideW="+sideW);
			for(var i=0;i<nwth;i++){
				nextPoint.y = nextPoint.y + sideW;
				if(nextPoint.y < height){
					//左右运动
					if((i+1)%2==0){
						nextPoint.x = width;
					}else{
						nextPoint.x = 0;
					}
				}else{
					//运动到下边
					if((i+1)%2==0){
						//向y增大方向运行
						nextPoint.y = height;
						//剩余距离
						sidew1 = height - prePoint.y;
						nextPoint.x = Math.floor( sidew1 / tana);
					}else{
						//向y减小方向运行
						nextPoint.y = height;
						//剩余距离
						sidew1 = height - prePoint.y;
						nextPoint.x =width -  Math.floor( sidew1 / tana);
						flag = true;
					}
				}
				console.log("--rr--第"+(total+i+1)+"次目标点："+nextPoint.x+","+nextPoint.y);
				prePoint.x = nextPoint.x;
				prePoint.y = nextPoint.y;
				allPoints[total+i+1] = {x:nextPoint.x,y:nextPoint.y};
			}
			total = total + nwth;
			
			stopMe(total,flag?"downReverse":"down");
			if(stop){
				return;
			}
			if(flag){
				downReverse(prePoint,nextPoint);
			}else{
				down(prePoint,nextPoint);
			}
			
		}
		
		function stopMe(count,methodName){
			console.log("count="+count + ", methodName:"+methodName);
			if(count>pointsToRun){
				stop = true; 
			}
			nextMethod = methodName;
		}
	
	</script>
</div>
  </body>
</html>
