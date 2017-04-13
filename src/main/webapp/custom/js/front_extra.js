function listblog(label) {
	console.log(encodeURI("app/front/list?labelName=" + label, "utf-8"));
	var url = encodeURI("app/front/list?labelName=" + label, "utf-8");
	window.location.href = url;
}

function goDetail(url){
	url = encodeURI(url, "utf-8");
	window.location.href = url;
}