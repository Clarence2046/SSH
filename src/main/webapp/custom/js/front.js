//获取球父窗口的宽和高，初始随机一个角度运动
$(document).ready(function() {
	/*
	 * flows($(".vic_ball"),0,0); flows($(".vic_ball_1"),0,0);
	 * flows($(".vic_ball_2"),0,0);
	 */
	// var t1,t2,t3;
	var intIds = {};
	$(".vic_pic_area").find(".vic_balls").each(function() {
		var theid = $(this).attr("id");
		var time = $(this).attr("time");
		var changeback = $(this).attr("changeback");
		if (time == undefined) {
			time = 2000;
		}
		if (changeback == undefined) {
			changeback = true;
		}
		// console.log($(this));
		var ele = $(this);
		var tid = setInterval(function() {
			flows(ele, 0, 0, changeback);
		}, time);

		intIds[theid] = tid;

		$(this).hover(function() {
			// 鼠标进入方法，清除定时任务
			clearInterval(intIds[theid]);
		}, function() {
			clearInterval(intIds[theid]);
			intIds[theid] = setInterval(function() {
				flows(ele, 0, 0, changeback);
			}, time);
		});

		flows(ele, 0, 0, changeback);
	});
	// console.log(intIds);
});

function flows(ele, lminus, tminus, changeback) {
	// 初始左上角 margin-left：0 margin-top：0
	// 第一次随机坐标应该位于下或右两个边上
	// 左上右下： 0 1 2 3
	// 获取父元素高度和宽度
	var pw = parseInt($(ele).parent(".vic_pic_area").width());
	var ph = parseInt($(ele).parent(".vic_pic_area").height());
	var ballr = parseInt($(ele).width());
	var ballh = parseInt($(ele).height());
	// console.log("球半径： "+ballr);
	// 球实际运动范围
	pwstart = 0;
	phstart = 0;
	pw = pw - ballr - lminus;
	ph = ph - ballh - tminus;
	// console.log("宽度："+pw+", 高度： "+ph);

	// 改为相对父元素的位置
	var top = parseInt($(ele).position().top);
	var left = parseInt($(ele).position().left);
	/*
	 * var top = parseInt($(ele).css("marginTop")); var left =
	 * parseInt($(ele).css("marginLeft"));
	 */
	/*
	 * top = top + tminus; left = left + lminus;
	 */
	// console.log("顶部："+top+", 左边： "+left);
	// 下一步运动的方向选择
	var direction = [ 0, 1, 2, 3 ];
	// 距离范围有1个px的误差
	if ((top == 0 || top == 1) && (left == 0 || left == 1)) {
		direction = [ 2, 3 ];
	} else if (top > 1 && top < ph - 1 && (left == 0 || left == 1)) {
		direction = [ 1, 2, 3 ];
	} else if (top >= ph - 1 && (left == 0 || left == 1)) {
		direction = [ 1, 2 ];
	} else if (top >= ph - 1 && left > 1) {
		direction = [ 0, 1, 2 ];
	} else if (top >= ph - 1 && left >= pw - 1) {
		direction = [ 0, 1 ];
	} else if (top > 1 && top < ph - 1 && left >= pw - 1) {
		direction = [ 0, 1, 3 ];
	} else if ((top == 0 || top == 1) && left >= pw - 1) {
		direction = [ 0, 3 ];
	} else if ((top == 0 || top == 1) && left > 1 && left < pw - 1) {
		direction = [ 0, 2, 3 ];
	}
	// 随机0到 direction的长度的数字
	// console.log("长度： "+direction.length);
	var sub = Math.round(Math.random() * (direction.length - 1));
	// console.log("随机数【0，"+(direction.length - 1)+"】： "+sub);
	// 获取是哪个边
	var theD = direction[sub];
	// console.log("本次运动的目标边： "+theD);
	// 产生对应边上的随机坐标
	var marginl = 0;
	var margint = 0;
	if (theD == 0) {
		marginl = pwstart;
		margint = randommn(phstart, ph - phstart);
	} else if (theD == 1) {
		marginl = randommn(pwstart, pw - pwstart);
		margint = phstart;
	} else if (theD == 2) {
		marginl = pw;
		margint = randommn(phstart, ph - phstart);
	} else if (theD == 3) {
		marginl = randommn(pwstart, pw - pwstart);
		margint = ph;
	}
	// console.log("本次运动的目的坐标：【 "+marginl+","+margint+"]");

	$(ele).css("top", margint + "px");
	$(ele).css("left", marginl + "px");
	$(ele).position().top = margint + "px";
	$(ele).position().left = marginl + "px";

	// 产生随机颜色 #000000-#ffffff,即6个0-f的值
	var colors = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'a', 'b', 'c', 'd', 'e',
			'f' ];
	var color = "#";
	for ( var i = 0; i < 6; i++) {
		var colorsub = randommn(0, colors.length - 1);
		color = color + colors[colorsub];
	}
	if (changeback===true) {
		//console.log("本次改变颜色： " + color + " " + changeback);
		$(ele).css("backgroundColor", color);
	}
	$(ele).css("color", color);
	
	//如果球之间碰撞了怎么办？能不能终止动画，然后进行下一次动画？先测试走一半时改变坐标
	
	
}

function randommn(from, to) {
	// 随机1到ph-1的数字
	return Math.round(Math.random() * (to - from) + from);
}

//-------------------------------------------------------------------------//