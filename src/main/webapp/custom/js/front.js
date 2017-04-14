//��ȡ�򸸴��ڵĿ�͸ߣ���ʼ���һ���Ƕ��˶�
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
			// �����뷽���������ʱ����
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
	// ��ʼ���Ͻ� margin-left��0 margin-top��0
	// ��һ���������Ӧ��λ���»�����������
	// �������£� 0 1 2 3
	// ��ȡ��Ԫ�ظ߶ȺͿ��
	var pw = parseInt($(ele).parent(".vic_pic_area").width());
	var ph = parseInt($(ele).parent(".vic_pic_area").height());
	var ballr = parseInt($(ele).width());
	var ballh = parseInt($(ele).height());
	// console.log("��뾶�� "+ballr);
	// ��ʵ���˶���Χ
	pwstart = 0;
	phstart = 0;
	pw = pw - ballr - lminus;
	ph = ph - ballh - tminus;
	// console.log("��ȣ�"+pw+", �߶ȣ� "+ph);

	// ��Ϊ��Ը�Ԫ�ص�λ��
	var top = parseInt($(ele).position().top);
	var left = parseInt($(ele).position().left);
	/*
	 * var top = parseInt($(ele).css("marginTop")); var left =
	 * parseInt($(ele).css("marginLeft"));
	 */
	/*
	 * top = top + tminus; left = left + lminus;
	 */
	// console.log("������"+top+", ��ߣ� "+left);
	// ��һ���˶��ķ���ѡ��
	var direction = [ 0, 1, 2, 3 ];
	// ���뷶Χ��1��px�����
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
	// ���0�� direction�ĳ��ȵ�����
	// console.log("���ȣ� "+direction.length);
	var sub = Math.round(Math.random() * (direction.length - 1));
	// console.log("�������0��"+(direction.length - 1)+"���� "+sub);
	// ��ȡ���ĸ���
	var theD = direction[sub];
	// console.log("�����˶���Ŀ��ߣ� "+theD);
	// ������Ӧ���ϵ��������
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
	// console.log("�����˶���Ŀ�����꣺�� "+marginl+","+margint+"]");

	$(ele).css("top", margint + "px");
	$(ele).css("left", marginl + "px");
	$(ele).position().top = margint + "px";
	$(ele).position().left = marginl + "px";

	// ���������ɫ #000000-#ffffff,��6��0-f��ֵ
	var colors = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'a', 'b', 'c', 'd', 'e',
			'f' ];
	var color = "#";
	for ( var i = 0; i < 6; i++) {
		var colorsub = randommn(0, colors.length - 1);
		color = color + colors[colorsub];
	}
	if (changeback===true) {
		//console.log("���θı���ɫ�� " + color + " " + changeback);
		$(ele).css("backgroundColor", color);
	}
	$(ele).css("color", color);
	
	//�����֮����ײ����ô�죿�ܲ�����ֹ������Ȼ�������һ�ζ������Ȳ�����һ��ʱ�ı�����
	
	
}

function randommn(from, to) {
	// ���1��ph-1������
	return Math.round(Math.random() * (to - from) + from);
}

//-------------------------------------------------------------------------//