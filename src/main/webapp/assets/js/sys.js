//保存
function save1(){
	if($("#sysName").val()==""){
		$("#sysName").tips({
			side:3,
            msg:'输入系统名称',
            bg:'#AE81FF',
            time:3
        });
		$("#sysName").focus();
		return false;
	}
	if($("#showCount").val()==""){
		$("#showCount").tips({
			side:3,
            msg:'输入每页条数',
            bg:'#AE81FF',
            time:3
        });
		$("#showCount").focus();
		return false;
	}else if(!(Number($("#showCount").val())>0)){
		$("#showCount").tips({
			side:3,
            msg:'每页条数不能小于1',
            bg:'#AE81FF',
            time:3
        });
		$("#showCount").focus();
		return false;
	}
	
	if($("#SMTP").val()==""){
		$("#SMTP").tips({
			side:3,
            msg:'输入SMTP',
            bg:'#AE81FF',
            time:3
        });
		$("#SMTP").focus();
		return false;
	}
	if($("#PORT").val()==""){
		$("#PORT").tips({
			side:3,
            msg:'输入端口',
            bg:'#AE81FF',
            time:3
        });
		$("#PORT").focus();
		return false;
	}else if(!(Number($("#PORT").val())>0)){
		$("#PORT").tips({
			side:3,
            msg:'端口不能小于1',
            bg:'#AE81FF',
            time:3
        });
		$("#PORT").focus();
		return false;
	}
	if($("#EMAIL").val()==""){
		$("#EMAIL").tips({
			side:3,
            msg:'输入邮箱',
            bg:'#AE81FF',
            time:3
        });
		$("#EMAIL").focus();
		return false;
	}
	if($("#PAW").val()==""){
		$("#PAW").tips({
			side:3,
            msg:'输入密码',
            bg:'#AE81FF',
            time:3
        });
		$("#PAW").focus();
		return false;
	}
	
	if($("#onlineIp").val()==""){
		$("#onlineIp").tips({
			side:3,
            msg:'输入IP地址',
            bg:'#AE81FF',
            time:3
        });
		$("#onlineIp").focus();
		return false;
	}
	if($("#onlinePort").val()==""){
		$("#onlinePort").tips({
			side:3,
            msg:'输入端口',
            bg:'#AE81FF',
            time:3
        });
		$("#onlinePort").focus();
		return false;
	}else if(!(Number($("#onlinePort").val())>0)){
		$("#onlinePort").tips({
			side:3,
            msg:'端口不能小于1',
            bg:'#AE81FF',
            time:3
        });
		$("#onlinePort").focus();
		return false;
	}
	
	if($("#imIp").val()==""){
		$("#imIp").tips({
			side:3,
            msg:'输入IP地址',
            bg:'#AE81FF',
            time:3
        });
		$("#imIp").focus();
		return false;
	}
	if($("#imPort").val()==""){
		$("#imPort").tips({
			side:3,
            msg:'输入端口',
            bg:'#AE81FF',
            time:3
        });
		$("#imPort").focus();
		return false;
	}else if(!(Number($("#imPort").val())>0)){
		$("#imPort").tips({
			side:3,
            msg:'端口不能小于1',
            bg:'#AE81FF',
            time:3
        });
		$("#imPort").focus();
		return false;
	}
	
	$("#Form").submit();
	$("#showform").hide();
	$("#jiazai").show();
}

//设置站内信声音提示类型
function setFhsmsSoundType(type){
	$("#fhsmsSound").val(type);
	if('0' != type){
		$("#fhsmsobjsys").html('<audio style="display: none;" id="fhsmstsy" src="assets/sound/'+type+'.mp3" autoplay controls></audio>');
	}
}

//QQ313596790