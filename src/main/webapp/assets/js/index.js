
//浏览器窗口大小变化时调用
function cmainFrame(){
	var hmain = document.getElementById("mainFrame");
	var bheight = document.documentElement.clientHeight;
	hmain.style.width = '100%';
	hmain.style.height = (bheight-76) + 'px';
}
cmainFrame();
window.onresize=function(){  
	cmainFrame();
};

//点击左侧菜单时调用
var fmid = "fhindex";	//菜单点中状态 
var mid = "fhindex";	//菜单点中状态 
var ids = "";
function siMenu(id,fid,MENU_NAME,MENU_URL){
	ids.replace(id+',','');
	ids += id+',';
	if(id != mid){
		$("#"+mid).attr("class","");
		mid = id;
	}
	if(fid != fmid){
		if(fmid != 'fhindex')$("#"+fmid).attr("class","nav-item pcoded-hasmenu");
		fmid = fid;
	}
	$("#"+id).attr("class","active");
	$("#"+fid).attr("class","nav-item pcoded-hasmenu active pcoded-trigger");
	top.mainFrame.tabAddHandler(id,MENU_NAME,MENU_URL);
}

//关闭标签
function indexTabClose(type){
	if('all' == type && ids != ''){			//关闭所有
		var arrid = ids.split(',');
		for(var i=0;i<ids.length;i++){
			top.mainFrame.tabClose(arrid[i]);
		}
	}else if('own' == type && ids != ''){	//关闭自己
		top.mainFrame.tabClose(top.mainFrame.nowid);
	}else if('other' == type && ids != ''){	//关闭其他
		var arrid = ids.split(',');
		for(var i=0;i<ids.length;i++){
			if (arrid[i] == top.mainFrame.nowid) continue;
			top.mainFrame.tabClose(arrid[i]);
		}
	}
}

//进入后台初始页面信息
var onlineAdress="";	//在线管理地址
var wimadress="";		//即时聊天地址
var user = "FH";		//用于即时通讯（ 当前登录用户）
var uname = "";			//姓名
var fhsmsCount = 0;		//站内信总数
var fhsmsSound = '1';	//站内信提示音效
function getInfo(){
	$.ajax({
		type: "POST",
		url: wlocal+'head/getInfo',
  	data: {tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
		 if("success" == data.result){
			 if('admin' != data.USERNAME){
				 $("#systemset").hide();				//隐藏系统设置
			 }
			 updateUserPhoto(data.userPhoto);			//用户头像
			 $("#user_name").html(data.NAME);			//用户姓名
			 onlineAdress = data.onlineAdress;			//在线管理地址
			 wimadress= data.wimadress;					//即时聊天地址
			 user = data.USERNAME;						//用户名
			 uname = data.NAME;							//用户姓名
			 online();									//加入在线列表
			 topTask();									//刷新待办任务
			 fhsmsCount = Number(data.fhsmsCount);
			 if(fhsmsCount > 0){
				 setTimeout('showNoreadNews()', 2000);
			 }
			 fhsmsSound = data.fhsmsSound;				//站内信提示音效
		 }
		}
	});
}

//刷新用户头像
function updateUserPhoto(value){
	$("#userPhoto").attr("src",value);//用户头像
}

//显示未读消息
function showNoreadNews(){
	$("#fhsmsCount").tips({
		side:3,
        msg:'您有 '+fhsmsCount+' 条未读消息',
        bg:'#AE81FF',
        time:10
    });
}

//加入在线列表
var fwebsocket = null;
function online(){
	if (window.WebSocket) {
		fwebsocket = new WebSocket(encodeURI('ws://'+onlineAdress)); //oladress在main.jsp页面定义
		fwebsocket.onopen = function() {
			fwebsocket.send('[join]'+user); //连接成功
		};
		fwebsocket.onerror = function() {
			//连接失败
		};
		fwebsocket.onclose = function() {
			//连接断开
		};
		//消息接收
		fwebsocket.onmessage = function(message) {
			var message = JSON.parse(message.data);
			if(message.type == 'goOut'){
				$("body").html("");
				goOut("1");
			}else if(message.type == 'thegoout'){
				$("body").html("");
				goOut("2");
			}else if(message.type == 'senFhsms'){
				fhsmsCount = Number(fhsmsCount)+1;
				if('0' != fhsmsSound){
					$("#fhsmsobj").html('<audio style="display: none;" id="fhsmstsy" src="assets/sound/'+fhsmsSound+'.mp3" autoplay controls></audio>');
				}
				$("#fhsmsCount").tips({
					side:3,
			        msg:'收到1条新消息,您还有 '+fhsmsCount+' 条未读消息',
			        bg:'#AE81FF',
			        time:10
			    });
			}else if(message.type == 'fhtask'){
				if(message.RNUMBER == 'no'){
					$("#fhsmsobj").html('<audio style="display: none;" id="fhsmstsy" src="assets/sound/'+fhsmsSound+'.mp3" autoplay controls></audio>');
					topTask();//刷新顶部待办任务列表
				}else{
					$.ajax({
						type: "POST",
						url: wlocal+'/head/isNowRole',
				    	data: {RNUMBER:message.RNUMBER,tm:new Date().getTime()},
						dataType:'json',
						cache: false,
						success: function(data){
							 if('yes' == data.msg){
								$("#fhsmsobj").html('<audio style="display: none;" id="fhsmstsy" src="assets/sound/'+fhsmsSound+'.mp3" autoplay controls></audio>');
								topTask();//刷新顶部待办任务列表
							 }
						}
					});
				}
			}
		};
	}
}

//下线
function goOut(msg){
	window.location.href=wlocal+"main/logout?msg="+msg;
}

//去通知任务待办人有新任务
function fhtaskmsg(USERNAME){
	fwebsocket.send('[fhtask]'+USERNAME);//发送新任务通知
}

//待办任务
function topTask(){
	$.ajax({
		type: "POST",
		url: wlocal+'/rutask/getList?tm='+new Date().getTime(), //待办任务
    	data: encodeURI(""),
		dataType:'json',
		//beforeSend: validateData,
		cache: false,
		success: function(data){
			 var taskCount = Number(data.taskCount);
			 $("#taskCount").html(Number(taskCount));				//待办任务总数
			 if(taskCount == 0){$("#myTask").html('<li class="notification"><div class="media"><div class="media-body"><p>没有需要办理的任务</p></div></div></li>');}
			 $.each(data.list, function(i, list){
				 $("#myTask").append('<li class="notification"><div class="media"><div class="media-body"><p>'+(i+1)+'.'+list.PNAME_+'('+list.NAME_+')</p></div></div></li>');
			 });
			 if(taskCount > 0){
				 $("#taskCount").tips({
						side:3,
			            msg:'您有任务需要办理',
			            bg:'#AE81FF',
			            time:30
			     });
			 }
		}
	});
}

//打开我的待办任务列表
function rutasklist(){
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="我的待办任务";
	 diag.URL = wlocal+'/rutask/list';
	 diag.Width = 1100;
	 diag.Height = 600;
	 diag.Modal = true;				//有无遮罩窗口
	 diag. ShowMaxButton = true;	//最大化按钮
	 diag.ShowMinButton = true;		//最小化按钮
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//修改头像
function editPhoto(){
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="修改头像";
	 diag.URL = wlocal+'photo/editPhoto';
	 diag.Width = 650;
	 diag.Height = 530;
	 diag.Modal = true;				//有无遮罩窗口
	 diag. ShowMaxButton = true;	//最大化按钮
	 diag.ShowMinButton = true;		//最小化按钮
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//站内信
function fhsms(){
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="站内信";
	 diag.URL = wlocal+'fhsms/list?STATUS=2';
	 diag.Width = 900;
	 diag.Height = 600;
	 diag. ShowMaxButton = true;	//最大化按钮
     diag.ShowMinButton = true;		//最小化按钮 
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//去通知收信人有站内信接收
function fhsmsmsg(USERNAME){
	var arrUSERNAME = USERNAME.split(';');
	for(var i=0;i<arrUSERNAME.length;i++){
		fwebsocket.send('[fhsms]'+arrUSERNAME[i]);//发送站内信通知
	}
}

//读取站内信时减少未读总数
function readFhsms(){
	fhsmsCount = Number(fhsmsCount)-1;
	fhsmsCount = Number(fhsmsCount) <= 0 ?'0':fhsmsCount;
	 if(Number(fhsmsCount) > 0){
			$("#fhsmsCount").tips({
				side:3,
				msg:'您还有 '+fhsmsCount+' 条未读消息',
		        bg:'#AE81FF',
		        time:10
		    });
		 }
}

//获取站内信未读总数(在站内信删除未读新信件时调用此函数更新未读数)
function getFhsmsCount(){
	$.ajax({
		type: "POST",
		url: wlocal+'fhsms/getFhsmsCount?tm='+new Date().getTime(),
    	data: encodeURI(""),
		dataType:'json',
		cache: false,
		success: function(data){
			 fhsmsCount = Number(data.fhsmsCount);
			 if(fhsmsCount > 0){
				$("#fhsmsCount").tips({
					side:3,
					msg:'您还有 '+fhsmsCount+' 条未读消息',
			        bg:'#AE81FF',
			        time:10
			    });
			 }
		}
	});
}

//修改个人资料
function goEditMyInfo(){
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="个人资料";
	 diag.URL = wlocal+'user/goEditMyInfo';
	 diag.Width = 600;
	 diag.Height = 355;
	 diag.Modal = true;				//有无遮罩窗口
	 diag. ShowMaxButton = true;	//最大化按钮
	 diag.ShowMinButton = true;		//最小化按钮 
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//系统设置
function sysSet(){
	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="系统设置";
	 diag.URL = wlocal+'head/sysSet';
	 diag.Width = 650;
	 diag.Height = 499;
	 diag.Modal = true;				//有无遮罩窗口
	 diag. ShowMaxButton = true;	//最大化按钮
	 diag.ShowMinButton = true;		//最小化按钮 
	 diag.CancelEvent = function(){ //关闭事件
		diag.close();
	 };
	 diag.show();
}

//保存用户皮肤风格
function saveSkin(){
	var SKIN1 = $("#FHSKIN1").attr('class');
	var SKIN2 = $("#FHSKIN2").attr('class');
	var SKIN3 = $("#FHSKIN3").attr('class');
	var SKIN = SKIN1+','+SKIN2+','+SKIN3
	$.ajax({
		type: "POST",
		url: wlocal+'head/saveSkin',
		data: {SKIN:SKIN,tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			if ("success" == data.result) {
			}
		}
	});
}

//默认风格风格
function saveSkindef(){
	$("#FHSKIN1").attr('class','pcoded-navbar');
	$("#FHSKIN2").attr('class','navbar pcoded-header navbar-expand-lg navbar-light');
	$("#FHSKIN3").attr('class','');
	var SKIN = 'pcoded-navbar,navbar pcoded-header navbar-expand-lg navbar-light,';
	$.ajax({
		type: "POST",
		url: wlocal+'head/saveSkin',
		data: {SKIN:SKIN,tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			if ("success" == data.result) {
			}
		}
	});
}

//用于子窗口获取父页面中的参数(应用于流程信息审批详情内容)
var hdcontent = "";
function handleDetails(value){
	if(value != ''){
		hdcontent = value;
	}else{
		return hdcontent;
	}
}
