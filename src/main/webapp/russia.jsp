<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>Canvas</title>
  </head>
  <body>
  Direct:<label id="t" style="width: 100px"></label>
  PRE:<label id="pre" style="width: 200px"></label>
  NOW:<label id="now" style="width: 200px"></label>
  	得分:<label id="score" style="width: 200px">0&nbsp;分</label>
  <br>
 	<button onclick="draw()">画图</button>
 	<button onclick="clearR()">清除</button>
 	<button onclick="moveLeft()">左移</button>
 	<button onclick="moveRight()">右移</button>
 	<button onclick="moveUp()">上移</button>
 	<button onclick="moveDown()">下移</button>
  <br/>
  <canvas id="cv1" width="1000px" height="600px" style="border: 1px solid red;background-color: black;"></canvas>
  <script type="text/javascript">
	  	var cv = document.getElementById("cv1");
	  	var ctx = cv.getContext("2d");
	  	//俄罗斯方块
	  	//图形一,以正中间的矩形为基准
	  	var point1 = {x:50,y:30};
	    var preShape = "up";
	  	function upShape1(point){
	  		ctx.beginPath();
	  		preShape = "up";
	  		var startx = point.x;
	  		var starty = point.y;
  			ctx.rect(startx,starty,20,20);
  			ctx.rect(startx-20,starty,20,20);
  			ctx.rect(startx,starty-20,20,20);
  			ctx.rect(startx+20,starty,20,20);
		  	ctx.fillStyle = "red";
		  	ctx.fill();
	  	}
	  	function clearUp(point){
	  		var startx = point.x;
	  		var starty = point.y;
		  	ctx.clearRect(startx,starty,20,20);
			ctx.clearRect(startx-20,starty,20,20);
			ctx.clearRect(startx,starty-20,20,20);
			ctx.clearRect(startx+20,starty,20,20);
	  	}
	  	function rightShape1(point){
	  		ctx.beginPath();
	  		preShape = "right";
	  		var startx = point.x;
	  		var starty = point.y;
  			ctx.rect(startx,starty,20,20);
  			ctx.rect(startx,starty-20,20,20);
  			ctx.rect(startx+20,starty,20,20);
  			ctx.rect(startx,starty+20,20,20);
		  	ctx.fillStyle = "red";
		  	ctx.fill();
	  	}
	  	function clearRight(point){
	  		var startx = point.x;
	  		var starty = point.y;
		  	ctx.clearRect(startx,starty,20,20);
  			ctx.clearRect(startx,starty-20,20,20);
  			ctx.clearRect(startx+20,starty,20,20);
  			ctx.clearRect(startx,starty+20,20,20);
	  	}
	  	function downShape1(point){
	  		ctx.beginPath();
		  	preShape = "down";
	  		var startx = point.x;
	  		var starty = point.y;
  			ctx.rect(startx,starty,20,20);
  			ctx.rect(startx-20,starty,20,20);
  			ctx.rect(startx,starty+20,20,20);
  			ctx.rect(startx+20,starty,20,20);
		  	ctx.fillStyle = "red";
		  	ctx.fill();
	  	}
  	 	function clearDown(point){
	  		var startx = point.x;
  			var starty = point.y;
	  	  	ctx.clearRect(startx,starty,20,20);
  			ctx.clearRect(startx-20,starty,20,20);
  			ctx.clearRect(startx,starty+20,20,20);
  			ctx.clearRect(startx+20,starty,20,20);
	  	}
	  	function leftShape1(point){
	  		ctx.beginPath();
	  		preShape = "left";
	  		var startx = point.x;
	  		var starty = point.y;
			ctx.rect(startx,starty,20,20);
  			ctx.rect(startx,starty-20,20,20);
  			ctx.rect(startx-20,starty,20,20);
  			ctx.rect(startx,starty+20,20,20);
		  	ctx.fillStyle = "red";
		  	ctx.fill();
	  	}
  	 	function clearLeft(point){
	  		var startx = point.x;
  			var starty = point.y;
	  	 	ctx.clearRect(startx,starty,20,20);
  			ctx.clearRect(startx,starty-20,20,20);
  			ctx.clearRect(startx-20,starty,20,20);
  			ctx.clearRect(startx,starty+20,20,20);
	  	}
	  	
	  	function changeShape1(){
	  		pre.innerHTML=point1.x+","+point1.y;
	  		if(preShape=="up"){
	  			clearUp(point1);
	  			leftShape1(point1);
	  		}else if(preShape=="left"){
	  			clearLeft(point1);
	  			downShape1(point1);
	  		}else if(preShape=="down"){
	  			clearDown(point1);
	  			rightShape1(point1);
	  		}else{
	  			clearRight(point1);
	  			upShape1(point1);
	  		}
	  		now.innerHTML=point1.x+","+point1.y;
		  	t.innerHTML=preShape;
	  	}
	  	function clearShape1(){
	  		pre.innerHTML=point1.x+","+point1.y;
	  		if(preShape=="up"){
	  			clearUp(point1);
	  		}else if(preShape=="left"){
	  			clearLeft(point1);
	  		}else if(preShape=="down"){
	  			clearDown(point1);
	  		}else{
	  			clearRight(point1);
	  		}
	  		now.innerHTML=point1.x+","+point1.y;
		  	t.innerHTML=preShape;
	  	}
	  	function moveShape1(){
	  		pre.innerHTML=point1.x+","+point1.y;
	  		if(preShape=="up"){
	  			upShape1(point1);
	  		}else if(preShape=="left"){
	  			leftShape1(point1);
	  		}else if(preShape=="down"){
	  			downShape1(point1);
	  		}else{
	  			rightShape1(point1);
	  		}
	  		now.innerHTML=point1.x+","+point1.y;
		  	t.innerHTML=preShape;
	  	}
	  	var t = document.getElementById("t");
	  	var pre = document.getElementById("pre");
	  	var now = document.getElementById("now");
	  	changeShape1();
	  	
	  	function draw(){
	  		leftShape1(point1);
	  	}
	  	function clearR(){
	  		clearLeft(point1);
	  	}
	  	function moveRight(){
	  		if(point1.x>560){
	  			return;
	  		}
	  		clearShape1();
	  		point1.x = point1.x + 20;
	  		moveShape1();
	  	}
	  	function moveLeft(){
	  		if(point1.x<40){
	  			return;
	  		}
	  		clearShape1();
	  		point1.x = point1.x - 20;
	  		moveShape1();
	  	}
	  	function moveDown(){
	  		if(point1.y>540){
	  			return;
	  		}
	  		clearShape1();
	  		point1.y = point1.y + 20;
	  		moveShape1();
	  	}
	  	function moveUp(){
	  		if(point1.y<40){
	  			return;
	  		}
	  		clearShape1();
	  		point1.y = point1.y - 20;
	  		moveShape1();
	  	}
		</script>
		<script type="text/javascript">
			var score = document.getElementById("score");
			//产生随机方向子弹
			var bullet = {x:0,y:0,r:10};
			function buildBullet(bullet){
				ctx.beginPath();
				ctx.arc(bullet.x,bullet.y,bullet.r,0,2*Math.PI);
				ctx.fillStyle="white";
				ctx.fill();
			}
			function clearBullet(bullet){
				ctx.beginPath();
				ctx.clearRect(bullet.x-bullet.r-1,bullet.y-bullet.r-1,bullet.r*2+2,bullet.r*2+2);
			}
			
			function fireBullet(bullet,degree){
				var tand = Math.tan(degree * Math.PI/180);
				//x=y*tand   y=[0,560]
				clearBullet(bullet);
				bullet.x = bullet.x +1;
				bullet.y = bullet.y + 1 / tand;
				//console.log(bullet.x+","+bullet.y);
				buildBullet(bullet);
			}
			
			function autoFireBullet(bullet,time){
				//随机初始点，只从左边发出x=0   y=[0,560]
				var y = getRandomInt(20,500);
				bullet.x = 0;
				bullet.y = y;
				var d = getRandomInt(30,150);
				//d=90;
				console.log("degree:"+d);
				var t  = setInterval(function(){
					fireBullet(bullet,d);
					if(bullet.y>560 || bullet.y<=20 || bullet.x>=560){
						clearInterval(t);
						clearBullet(bullet);
						if(time>10){
							time = time -10;
						}else{
							time = 1;
						}
						autoFireBullet(bullet,time);
						count++;
						if(count<=100){
							var bulletx = {x:0,y:0,r:10};
							autoFireBullet(bulletx,time);
						}
						
						//消失得分
						score.innerHTML = count+"&nbsp;分";
						countClear++;
					}
				},time);
			}
			var count = 1;
			var countClear = 0;
			var time = 100;
			autoFireBullet(bullet,time);
			var bullet = {x:0,y:0,r:10};
			autoFireBullet(bullet,time);
			function getRandomInt(min, max){
			 	return Math.floor(Math.random() * (max - min + 1)) + min;
			}
		</script>
		<script type="text/javascript">
		if (navigator.userAgent.indexOf("MSIE") > 0) {
			//IE  
			document.onkeydown = function() {
				if (37 == event.keyCode) {//left
					alert('browser is ie and enter key down');
				}
				if (39 == event.keyCode) {//right
					alert('browser is not ie and enter key down');
				}
			};
		} else {
			//非IE           
			window.onkeydown = function() {
				if (67 == event.keyCode) {//c C  //change shape
					changeShape1();
				}
				if (38 == event.keyCode) {//up
					moveUp();
				}
				if (40 == event.keyCode) {//down
					moveDown();
				}
				if (37 == event.keyCode) {//left
					moveLeft();
				}
				if (39 == event.keyCode) {//right
					moveRight();
				}
			};
		}
		</script>
  </body>
</html>
