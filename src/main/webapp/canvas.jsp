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
  <canvas id="cv1" width="1000px" height="600px" style="border: 1px solid red;background-color: black;"></canvas>
  <canvas id="cv2" width="1000px" height="600px" style="border: 1px solid red;background-color: black;"></canvas>
  <script type="text/javascript">
	  	var cv = document.getElementById("cv1");
	  	var ctx = cv.getContext("2d");
	    waterdrop();
	    //划一个圆
	    function waterdrop(){
	    	ctx.beginPath();
		    ctx.fillStyle="white";
		    ctx.arc(100,100,20,0,2*Math.PI);
		    ctx.fill();
		    var r = 20;
		    var x0 = 100;
		    var y0 = 20;
		    //x:100 y:100  -->  圆外一点x:100 y<80 取20，求两个切点
		    //Math.pow(x - x0) + Math.pow(y - y0) + y0*y0 = (100-y0)*(100-y0);
		    //Math.pow(x - 100) + Math.pow(y - 100) = 20*20;
		    //求得y = 95  x = 119  81
		    var y = 95;
		    var xa = Math.floor(Math.sqrt(Math.pow(100-y0,2) - Math.pow(r,2) -Math.pow(y - 20,2))) + x0; 
		    var xb = -Math.floor(Math.sqrt(Math.pow(100-y0,2) - Math.pow(r,2) -Math.pow(y - 20,2))) + x0; 
		    ctx.moveTo(100,20);
		    ctx.lineTo(81,95);
		    ctx.lineTo(119,95);
		    ctx.closePath();
		    ctx.fillStyle="white";
		    ctx.fill();
		    
	    }
	    
	
	    lineCircle();
		quadratic();
		function lineCircle(){
		    //划一条线  19y-15x=2000
		    ctx.beginPath();
		    ctx.moveTo(120,200);
		    ctx.lineTo(500,500);
		    //ctx.globalCompositeOperation="lighter";
		    ctx.strokeStyle="white";
		    ctx.stroke();
		    
		    var x = 120;
		    var y = (2000+15*x)/19;
		    var prex = 120;
		    var prey = (2000+15*prex)/19;
		    var back = false;
		    setInterval(function(){
		    	ctx.beginPath();
		    	if(back){
			    	prex = x+1;
		    	}else{
			    	prex = x-1;
		    	}
		    	prey = (2000+15*prex)/19;
			    ctx.fillStyle="black";
			    ctx.strokeStyle="black";
			    ctx.arc(prex,prey,20,0,2*Math.PI);
			    ctx.stroke();
			    ctx.fill();
			    
			    ctx.beginPath();
			    ctx.moveTo(120,200);
			    ctx.lineTo(500,500);
			    ctx.strokeStyle="white";
			    ctx.stroke();
			    
			    ctx.beginPath();
			    ctx.fillStyle="white";
			    ctx.arc(x,y,20,0,2*Math.PI);
			    ctx.fill();
			    if(x<500 && !back){
		    		x = x + 1;
			    }else if(x<=120 && back){
			    	back = false;
			    }else{
			    	back = true;
		    		x = x - 1;
			    }
			    y = (2000+15*x)/19;
		    },50);
		}
	
	
  		function quadratic(){
		  	//context.quadraticCurveTo(cpx,cpy,x,y);
		  	//x=200+600*t*t    y=20+160*t-160*t*t  1>=x>=0
		  	ctx.moveTo(200,20);
		  	ctx.quadraticCurveTo(200,100,800,20);
		  	ctx.strokeStyle = "green";
		  	ctx.stroke();
	  		var x1 = 200;
	  		var y1 = 20;
	  		var prex1 = 200;
	  		var prey1 = 20;
	  		var index = 0;
	  	 	var back1 = false;
	  	 	var tempIndex = 0;
		    setInterval(function(){
		    	ctx.beginPath();
		    	tempIndex = index;
		    	if(back1){
		    		tempIndex = tempIndex + 0.01;
		    	}else{
		    		tempIndex = tempIndex - 0.01;
		    	}
		    	prex1 = 200+600*tempIndex*tempIndex;
		    	prey1 = 20+160*tempIndex-160*tempIndex*tempIndex;
			    ctx.fillStyle="black";
			    ctx.strokeStyle="black";
			    ctx.arc(prex1,prey1,20,0,2*Math.PI);
			    ctx.stroke();
			    ctx.fill();
			    
			    ctx.beginPath();
			    ctx.moveTo(200,20);
			  	ctx.quadraticCurveTo(200,100,800,20);
			  	ctx.strokeStyle = "green";
			  	ctx.stroke();
			    
			    ctx.beginPath();
			    ctx.fillStyle="white";
			    ctx.arc(x1,y1,20,0,2*Math.PI);
			    ctx.fill();
			    if(index<=1 && !back1){
		    		index = index + 0.01;
			    }else if(index<=0 && back1){
			    	back1 = false;
			    }else{
			    	back1 = true;
		    		index = index - 0.01;
			    }
			    x1 = 200+600*index*index;
		    	y1 = 20+160*index-160*index*index;
		    },80);
  		}
  		
  		roundCircle();
	    function roundCircle(){
		    var grd=ctx.createRadialGradient(500,260,0,500,260,80);
			grd.addColorStop(0,"red");
			grd.addColorStop(0.5,"red");
			grd.addColorStop(0.9,"red");
			grd.addColorStop(1,"yellow");
		    //一个圆  x*x + y * y = 100 * 100
		    //  (x-500)^2 + (y-260)^2  = 10000
		    ctx.beginPath();
		    ctx.arc(500,260,80,0,2*Math.PI);
		    ctx.strokeStyle="white";
		    ctx.stroke();
		   
		   
		    var startx = 400;// 400-600
		    var starty = 260;//160-360
		    var prex = startx;
		    var prey = starty;
		    var down = false;
		    setInterval(function(){
		    	//覆盖前一个元素
		    	ctx.beginPath();
			    ctx.arc(prex,prey,20,0,2*Math.PI);
			    ctx.fillStyle="black";
			    ctx.fill();
			    ctx.strokeStyle="black";
			    ctx.stroke();
			    
			    //重新绘制轨迹线
			    ctx.beginPath();
			    ctx.arc(500,260,80,0,2*Math.PI);
			    ctx.strokeStyle="black";
			    ctx.stroke();
			    ctx.fillStyle=grd;
			    ctx.fill();
			    //绘制运行的元素
		    	ctx.beginPath();
			    ctx.fillStyle="white";
			    ctx.arc(startx,starty,20,0,2*Math.PI);
			    ctx.fill();
			    prex = startx;
		    	prey = starty;
		    	//计算运行的中心点
		    	if(startx ==400 && !down){//左边起点，y>=260
		    		down = true;
		    	}else if(startx == 600){
		    		down = false;
		    	}
		    	if(down){
		    		startx = startx + 1;
		    		starty = Math.sqrt(10000 - (startx-500)* (startx-500))+260;
		    	}else{
		    		startx = startx - 1;
		    		starty = -Math.sqrt(10000 - (startx-500)* (startx-500))+260;
		    	}
		    	
		    },50);
		}
		   
		bracket();
		function  bracket(){
			ctx.moveTo(0,500);
			ctx.lineTo(380,500);
			ctx.strokeStyle="red";
			ctx.stroke();
			//画一个正方形
			ctx.beginPath();
			ctx.rect(20,180,20,20);
			ctx.strokeStyle="red";
			ctx.stroke();
			help1();
		}   
		 function getRandomInt(min, max)
		 {
		 	return Math.floor(Math.random() * (max - min + 1)) + min;
		 }
		var tbracket ;
		var x;
		var y;
		var map = {};
		function help1(){
			var rand = getRandomInt(1,10);
			x= 20 + 20 * rand;
			y = 180;
			var prex = x;
			var prey =y;
			tbracket = setInterval(function(){
				ctx.beginPath();
			/* 	ctx.rect(prex,prey,20,20);
				ctx.fillStyle="black";
				ctx.lineWidth="2";
				ctx.fill(); */
				ctx.clearRect(prex-1,prey-1,22,22);
				
				ctx.beginPath();
				ctx.rect(x,y,20,20);
				ctx.strokeStyle="yellow";
				ctx.stroke();
				prex = x;
			    prey =y;
				y = y + 20;
				if(map["x"+x]==undefined){
					map["x"+x] = 500;
				}
				if(y>=map["x"+x]){
					map["x"+x] = map["x"+x] - 20;
					clearInterval(tbracket);
					if(map["x"+x]>=180){
						help1();
					}
				}
			},500);
		}
		function help2(tx,px){
			x= tx;
			var prex = px;
			var prey =y - 20;
			tbracket = setInterval(function(){
				ctx.beginPath();
				/* ctx.rect(prex,prey,20,20);
				ctx.fillStyle="black";
				ctx.lineWidth="2";
				ctx.fill(); */
				ctx.clearRect(prex-1,prey-1,22,22);
				
				ctx.beginPath();
				ctx.rect(x,y,20,20);
				ctx.strokeStyle="yellow";
				ctx.stroke();
				prex = x;
			    prey =y;
				y = y + 20;
				if(map["x"+x]==undefined){
					map["x"+x] = 500;
				}
				if(y>=map["x"+x]){
					map["x"+x] = map["x"+x] - 20;
					clearInterval(tbracket);
					if(map["x"+x]>=180){
						help1();
					}
				}
			},500);
		}
		   
	
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
				if (37 == event.keyCode) {//left
					if(x>0){
						ctx.beginPath();
						ctx.rect(x,y,20,20);
						ctx.fillStyle="black";
						ctx.lineWidth="2";
						ctx.fill();
						clearInterval(tbracket);
						x = x-20;
						help2(x,x+20);
					}
				}
				if (39 == event.keyCode) {//right
					if(x<500){
						ctx.beginPath();
						ctx.rect(x,y,20,20);
						ctx.fillStyle="black";
						ctx.lineWidth="2";
						ctx.fill();
						clearInterval(tbracket);
						x = x+ 20;
						help2(x,x-20);
					}
				}
			};
		}
		</script>
		<script type="text/javascript">
		document.getElementById("cv1").style.display = "none";
		var cv2 = document.getElementById("cv2");
	  	var ctx2 = cv2.getContext("2d");
		var grd=ctx.createLinearGradient(80,80,120,120);
		grd.addColorStop(0,"white");
		grd.addColorStop(0.25,"white");
		grd.addColorStop(0.5,"red");
		grd.addColorStop(0.75,"white");
		grd.addColorStop(1,"white");
		ctx2.fillStyle=grd;
		ctx2.arc(100,100,20,0,2*Math.PI);
	  	ctx2.fill();
	  	ctx2.beginPath();
		ctx2.fillStyle="black";
		ctx2.arc(100,100,8,0,2*Math.PI);
	  	ctx2.fill();
	  	var i = 1;
	  	var x0 = 80;
	  	var y0 = 80;
	  	var x1 = 120;
	  	var y1 = 120;
	  	setInterval(function(){
	  		if(y0==80 && x0<120){
	  			//x0=[80,120]  x1=[120,80]
	  			x0 = x0+1;
	  			x1 = x1 -1;
	  		}else if(x0==120){
	  			//y0=[80,120]  y1=[120,80]
	  			y0 = y0+1;
	  			y1 = y1-1;
	  			if(y0==120){
	  				x0 = 80;
			  	    y0 = 80;
			  	    x1 = 120;
			  	    y1 = 120;
	  			}
	  		}
	  	
		  	grd=ctx.createLinearGradient(x0,y0,x1,y1);
			grd.addColorStop(0,"white");
			grd.addColorStop(0.25,"white");
			grd.addColorStop(0.5,"red");
			grd.addColorStop(0.75,"white");
			grd.addColorStop(1,"white");
	  	
	  	
	  		ctx2.beginPath(); 
	  		ctx2.fillStyle=grd;
			ctx2.arc(100,100,20,0,2*Math.PI);
		  	ctx2.fill();
		  	ctx2.beginPath();
			ctx2.fillStyle="black";
			ctx2.arc(100,100,8,0,2*Math.PI);
		  	ctx2.fill();
	  		i++;
	  	},50);
	  	
	  	
	  	var grd1=ctx.createLinearGradient(80,250,250,80);
		grd1.addColorStop(0,"white");
		grd1.addColorStop(0.25,"white");
		grd1.addColorStop(0.5,"red");
		grd1.addColorStop(0.75,"white");
		grd1.addColorStop(1,"white");
	  	ctx2.beginPath();
	  	ctx2.moveTo(80,250);
	  	ctx2.lineTo(80,100);
	  	ctx2.arcTo(80,80,100,80,20);
	  	ctx2.lineTo(250,80);
	  	ctx2.strokeStyle = grd1;
	  	ctx2.stroke();
	  	var stops = 0; 
	  	setInterval(function(){
	  		if(stops>=1){
	  			stops = 0;
	  		}else{
	  			stops = stops+0.05;
	  		}
	  		grd1=ctx.createLinearGradient(80,250,250,80);
			grd1.addColorStop(stops<=1?stops:(stops-1),"white");
			grd1.addColorStop((stops+0.25)<=1?(stops+0.25):(stops-0.75),"red");
			grd1.addColorStop((stops+0.5)<=1?(stops+0.5):(stops-0.5),"white");
			grd1.addColorStop((stops+0.75)<=1?(stops+0.75):(stops-0.25),"red");
			grd1.addColorStop((stops+1)<=1?(stops+1):(stops),"white");
		  	ctx2.beginPath();
		  	ctx2.moveTo(80,250);
		  	ctx2.lineTo(80,100);
		  	ctx2.arcTo(80,80,100,80,20);
		  	ctx2.lineTo(250,80);
		  	ctx2.strokeStyle = grd1;
		  	ctx2.stroke();
	  	
	  	},200);
	  	
	  	
	  	//俄罗斯方块
	  	//图形一
	  	ctx2.beginPath();
	  	var startpx = 330;
	  	var startpy = 50;
	  	
	  	ctx2.movoTo(startpx,startpy);
	  	ctx2.lineTo(startpx+20,startpy);
	  	ctx2.lineTo(startpx+20,startpy - 20);
	  	ctx2.lineTo(startpx+40,startpy - 20);
	  	ctx2.lineTo(startpx+40,startpy);
	  	ctx2.lineTo(startpx+60,startpy);
	  	ctx2.lineTo(startpx+60,startpy + 20);
	  	ctx2.lineTo(startpx,startpy + 20);
	  //	ctx2.closePath();
	  	ctx2.strokeStyle = "red";
	  	ctx2.stroke();
	  	
	  	
		</script>
  </body>
</html>
