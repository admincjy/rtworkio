//发送
function sendEmail(){
	if($("#TYPE").val()=="1"){
		$("#CONTENT").val(getContentTxt());
	}else{
		$("#CONTENT").val(getContent());
	}
	if($("#EMAIL").val()==""){
		$("#EMAIL").tips({
			side:3,
            msg:'请输入邮箱',
            bg:'#AE81FF',
            time:2
        });
		$("#EMAIL").focus();
		return false;
	}
	if($("#TITLE").val()==""){
		$("#TITLE").tips({
			side:1,
            msg:'请输入标题',
            bg:'#AE81FF',
            time:3
        });
		$("#TITLE").focus();
		return false;
	}
	if($("#CONTENT").val()==""){
		$("#nr").tips({
			side:1,
            msg:'请输入内容',
            bg:'#AE81FF',
            time:3
        });
		return false;
	}
	$("#showform").hide();
	$("#jiazai").show();
	var EMAIL = $("#EMAIL").val();
	var CONTENT = $("#CONTENT").val();
	var TITLE = $("#TITLE").val();
	var TYPE = $("#TYPE").val();
	btimer(60);
	$.ajax({
		type: "POST",
		url: local+'head/sendEmail?tm='+new Date().getTime(),
    	data: {EMAIL:EMAIL,CONTENT:CONTENT,TITLE:TITLE,TYPE:TYPE},
		dataType:'json',
		cache: false,
		success: function(data){
			 if(data.msg == 'ok'){
				 var count = data.count;
				 var ecount = data.ecount;
				 $("#msg").tips({
					side:3,
		            msg:'成功发出'+count+'封邮件,失败'+ecount+'封',
		            bg:'#68B500',
		            time:6
			      });
			 }else{
				 $("#msg").tips({
						side:3,
			            msg:'发送失败,请联系管理员!',
			            bg:'#FF0000',
			            time:6
				 });
			 }
			 $('#bsecond_shows').hide();
			 setTimeout("close()",6000);
			 timer(5);
		}
	});
	
}

//倒计时
function timer(intDiff){
	window.setInterval(function(){
	$('#second_shows').html('<s></s>'+intDiff+'秒');
	intDiff--;
	}, 1000);
}

//倒计时
function btimer(intDiff){
	window.setInterval(function(){
	$('#bsecond_shows').html('<s></s>'+intDiff+'秒');
	intDiff--;
	}, 1000);
} 

function setType(value){
	$("#TYPE").val(value);
}
function close(){
	top.Dialog.close();
}

//打开查看
function dialog_open(){
	$("#EMAILS").val($("#EMAIL").val());
	$("#dialog-add").css("display","block");
}
//关闭查看
function cancel_pl(){
	$("#EMAIL").val($("#EMAILS").val());
	$("#dialog-add").css("display","none");
}
//ueditor纯文本
function getContentTxt() {
    var arr = [];
    arr.push(UE.getEditor('editor').getContentTxt());
    return arr.join("");
}
//ueditor有标签文本
function getContent() {
    var arr = [];
    arr.push(UE.getEditor('editor').getContent());
    return arr.join("");
}

setTimeout("ueditor()",500);
function ueditor(){
	var ue = UE.getEditor('editor');
}