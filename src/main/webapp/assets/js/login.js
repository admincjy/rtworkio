
//页面加载完执行
$(document).ready(function(){
	$($("#USERNAME").focus());
});

//键盘回车事件，执行登录
$(document).keyup(function(event) {
	if(event.keyCode == 13) {
		$("#to-login").trigger("click");
	}
});

//服务端校验
function check() {
	if (notNull()) {
		var USERNAME = $("#USERNAME").val();
		var PASSWORD = $("#PASSWORD").val();
		var CODE = "qq313596790fh" + USERNAME + ",fh," + PASSWORD;
		$.ajax({
			type : "POST",
			url : local+'admin/check',
			data : {
				KEYDATA : CODE,
				tm : new Date().getTime()
			},
			dataType : 'json',
			cache : false,
			success : function(data) {
				if ("success" == data.result) {
					saveCookie();
					$("#USERNAME").tips({
						side : 2,
						msg : '正在登录 , 请稍后 ...',
						bg : '#68B500',
						time : 10
					});
					window.location.href = local+"main/index";
				} else if ("usererror" == data.result) {
					$("#USERNAME").tips({
						side : 2,
						msg : "用户名或密码有误",
						bg : '#FF5080',
						time : 15
					});
					$("#USERNAME").focus();
				} else {
					$("#USERNAME").tips({
						side : 2,
						msg : "缺少参数",
						bg : '#FF5080',
						time : 15
					});
					$("#USERNAME").focus();
				}
			}
		});
	}
}

//客户端校验
function notNull() {
	if ($("#USERNAME").val() == "") {
		$("#USERNAME").tips({
			side : 2,
			msg : '用户名不得为空',
			bg : '#AE81FF',
			time : 3
		});
		$("#USERNAME").focus();
		return false;
	} else {
		$("#USERNAME").val(jQuery.trim($('#USERNAME').val()));
	}
	if ($("#PASSWORD").val() == "") {
		$("#PASSWORD").tips({
			side : 2,
			msg : '密码不得为空',
			bg : '#AE81FF',
			time : 3
		});
		$("#PASSWORD").focus();
		return false;
	}
	return true;
}

//记住密码?
function savePaw() {
	if(!$("#checkbox-fill-a1").is(':checked')) {
		$.cookie('USERNAME', '', {
			expires : -1
		});
		$.cookie('password', '', {
			expires : -1
		});
		$("#USERNAME").val('');
		$("#PASSWORD").val('');
	}
}

//记住密码到Cookie
function saveCookie() {
	if ($("#checkbox-fill-a1").is(':checked')) {
		$.cookie('USERNAME', $("#USERNAME").val(), {
			expires : 7
		});
		$.cookie('PASSWORD', $("#PASSWORD").val(), {
			expires : 7
		});
	}
}

//从Cookie读取用户名密码
jQuery(function() {
	var USERNAME = $.cookie('USERNAME');
	var PASSWORD = $.cookie('PASSWORD');
	if (typeof(USERNAME) != "undefined"
			&& typeof(PASSWORD) != "undefined") {
		$("#USERNAME").val(USERNAME);
		$("#PASSWORD").val(PASSWORD);
		$("#checkbox-fill-a1").attr("checked", true);
	}
});

//重启之后 点击左侧列表跳转登录首页 
if (window != top) {
	top.location.href = location.href;
}

// 3-1-3-5-9-6-7-9-0-QQ