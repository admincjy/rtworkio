
//提交注册
function register(){
	if(rcheck()){
		var nowtime = date2str(new Date(),"yyyyMMdd");
		$.ajax({
			type: "POST",
			url: 'admin/register',
	    	data: {USERNAME:$("#RUSERNAME").val(),PASSWORD:$("#RPASSWORD").val(),NAME:$("#RNAME").val(),FKEY:$.md5('USERNAME'+nowtime+',fh,'),tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				if("00" == data.result){
					$("#RUSERNAME").tips({
						side : 1,
						msg : '注册成功,请登录',
						bg : '#68B500',
						time : 10
					});
					setTimeout(goLogin, 2000);
				}else if("01" == data.result){
					$("#RUSERNAME").tips({
						side : 1,
						msg : "用户名已存在",
						bg : '#FF5080',
						time : 15
					});
					$("#RUSERNAME").focus();
				}
			}
		});
	}
}

//注册
function rcheck(){
	if($("#RUSERNAME").val()==""){
		$("#RUSERNAME").tips({
			side:3,
            msg:'输入用户名',
            bg:'#AE81FF',
            time:2
        });
		$("#RUSERNAME").focus();
		$("#RUSERNAME").val('');
		return false;
	}else{
		$("#RUSERNAME").val(jQuery.trim($('#RUSERNAME').val()));
	}
	if($("#RPASSWORD").val()==""){
		$("#RPASSWORD").tips({
			side:3,
            msg:'输入密码',
            bg:'#AE81FF',
            time:2
        });
		$("#RPASSWORD").focus();
		return false;
	}
	if($("#RNAME").val()==""){
		$("#RNAME").tips({
			side:3,
            msg:'输入姓名',
            bg:'#AE81FF',
            time:3
        });
		$("#RNAME").focus();
		return false;
	}
	return true;
}

//js  日期格式
function date2str(x,y) {
     var z ={y:x.getFullYear(),M:x.getMonth()+1,d:x.getDate(),h:x.getHours(),m:x.getMinutes(),s:x.getSeconds()};
     return y.replace(/(y+|M+|d+|h+|m+|s+)/g,function(v) {return ((v.length>1?"0":"")+eval('z.'+v.slice(-1))).slice(-(v.length>2?v.length:2))});
};
 
//去登陆页面
function goLogin(){
	window.location.href='admin/login';
}
 	