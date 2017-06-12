<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test.jsp' starting page</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <body style="background-color: black;">
    	  <img alt="" id="fish" src="custom/imgs/fish.jpg">
    	  <canvas id="cv1" width="1000px" height="800px">
    	  </canvas>
    	  <canvas id="cv2" width="1000px" height="800px"></canvas>
		  <script type="text/javascript">
		  	var  c = document.getElementById("cv1");
		  	var  c2 = document.getElementById("cv2");
		  	var ctx = c.getContext("2d");
		  	var ctx2 = c2.getContext("2d");
		  	ctx.rect(20,20,100,100);
		  	ctx.stroke();
		  	
		  	//重新定位开始画图
		  	ctx.beginPath();
		  	ctx.lineWidth = "10";
		  	ctx.strokeStyle = "red";
		  	ctx.rect(10,10,200,140);
		  	ctx.stroke();
		  	//填充
		  	ctx.fillStyle = "gray";
		  	ctx.fillRect(10,10,200,140);
		  	
		  	//填充图像
		  	ctx.beginPath();
		  	var img = document.getElementById("fish");
		  	//context.createPattern(image,"repeat|repeat-x|repeat-y|no-repeat");
		  	var pat = ctx.createPattern(img,"repeat");
		  	ctx.rect(250,10,200,100);
		  	//先画矩形，在进行填充
		  	ctx.fillStyle = pat;
		  	ctx.fill();
		  	
		  	//
		  	var grd=ctx.createRadialGradient(75,50,5,90,60,60);
			grd.addColorStop(0,"red");
			grd.addColorStop(1,"white");
			
			// Fill with gradient
			ctx.fillStyle=grd;
			ctx.fillRect(10,10,150,100);
			
			
			//lineCap 属性设置或返回线条末端线帽的样式。  butt,round,square
			ctx.beginPath();
			ctx.lineCap = "round";
			ctx.moveTo(100,100);
			ctx.lineTo(100,200);
			ctx.strokeStyle="black";
			ctx.stroke();
			ctx.beginPath();
			ctx.lineCap = "square";
			ctx.moveTo(130,100);
			ctx.lineTo(130,200);
			ctx.stroke();
			ctx.beginPath();
			ctx.lineCap = "butt";
			ctx.moveTo(150,100);
			ctx.lineTo(150,200);
			ctx.stroke();
			
			//相交 round,bevel,miter
			ctx.beginPath();
			ctx.lineJoin = "round";
			ctx.moveTo(20,100);
			ctx.lineTo(80,150);
			ctx.lineTo(20,180);
			ctx.stroke();
			ctx.lineJoin = "bevel";
			ctx.moveTo(80,220);
			ctx.lineTo(20,250);
			ctx.lineTo(80,280);
			ctx.stroke();
			ctx.beginPath();
			ctx.lineJoin = "miter";
			ctx.miterLimit = 30;
			ctx.moveTo(80,320);
			ctx.lineTo(20,350);
			ctx.lineTo(80,380);
			ctx.stroke();
			
			//划一个圆
			ctx.beginPath();
			ctx.lineWidth = "1";
			ctx.arc(300,300,50,0,2*Math.PI);
			ctx.stroke();
			ctx.fillStyle="green";
			ctx.fill();
			ctx.beginPath();
			ctx.arc(350,300,50,0,2*Math.PI,true);
			ctx.stroke();
			ctx.fillStyle="red";
			ctx.fill();
			ctx.beginPath();
			ctx.arc(320,250,50,0,2*Math.PI,true);
			ctx.stroke();
			ctx.fillStyle="yellow";
			ctx.fill();
			
			ctx.fillStyle="green";
			ctx.fillRect(20,20,100,5);
			ctx.transform(1,0.5,0.5,1,0,-10);
			ctx.fillStyle="blue";
			ctx.fillRect(20,20,100,5);
			ctx.transform(1,0.5,0.5,1,0,-10);
			ctx.fillStyle="red";
			ctx.fillRect(20,20,100,5);
			
			//缩放scale
			ctx.beginPath();
			ctx.translate(150,150);//重新定位原点
			ctx.strokeRect(5,5,20,10);
			ctx.scale(2,2);
			ctx.strokeRect(5,5,20,10);
			ctx.scale(2,2);
			ctx.strokeRect(5,5,20,10);
			//ctx.stroke();
			//transform
			c.style.display="none";
			
			ctx2.fillStyle = "white";
			ctx2.arc(0,0,5,0,2*Math.PI);
			ctx2.stroke();
			ctx2.fill();
			var i = 1;
			var t = setInterval(function(){
				ctx2.beginPath();
				ctx2.fillStyle = "black";
				var x = i-1;
				var y = 2*x+1;
				ctx2.arc(x,y,5,0,2*Math.PI);
				ctx2.stroke();
				ctx2.fill();
				
				ctx2.beginPath();
				ctx2.fillStyle = "white";
				x = i;
				y = 2*x+1;
				ctx2.arc(x,y,5,0,2*Math.PI);
				ctx2.stroke();
				ctx2.fill();
				i++;
				if(i>800){
					clearInterval(t);
				}
			},50);
			
		  </script>
		  <audio src="http://music.163.com/#/song?id=461518895" autoplay="autoplay" controls="controls">Your browser does not support audio tag </audio>
		  
  </body>
</html>
