
var tab;
$(function() {
	tab = new TabView({
		containerId : 'tab_menu',
		pageid : 'page',
		cid : 'tab1',
		position : "top"
	});
	tab.add({
		id : 'tab1_index1',
		title : "主页",
		url : "main/default",
		isClosed : false
	});
	
	 $('#tab_menu').contextPopup({
         title: '',
         items: [
           {label:'关闭全部标签', action:function() { top.indexTabClose('all'); } },
           {label:'关闭当前标签', action:function() { top.indexTabClose('own'); } },
           {label:'关闭其它标签', action:function() { top.indexTabClose('other'); } }
         ]
      });
});

//添加标签
function tabAddHandler(mid, mtitle, murl) {
	tab.update({
		id : mid,
		title : mtitle,
		url : murl,
		isClosed : true
	});
	tab.add({
		id : mid,
		title : mtitle,
		url : murl,
		isClosed : true
	});
	tab.activate(mid);
}

//关闭标签
function tabClose(mid){
	tab.close(mid);
}

//3-1-3-5-9-6-7-9-0-QQ
function cmainFrameT() {
	var hmainT = document.getElementById("page");
	var bheightT = document.documentElement.clientHeight;
	hmainT.style.width = '100%';
	hmainT.style.height = (bheightT - 41) + 'px';
}
cmainFrameT();
window.onresize = function() {
	cmainFrameT();
};