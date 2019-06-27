<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
    <title>${sessionScope.sysName}</title>
    <!-- HTML5 Shim and Respond.js IE10 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 10]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="author" content="FH Admin QQ313596790" />

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="assets/fonts/fontawesome/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/plugins/animation/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    
    <!-- select插件 -->
    <link rel="stylesheet" href="assets/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="assets/plugins/multi-select/css/multi-select.css">

</head>

<body style="background-color: white">
    
    <!-- [加载状态 ] start -->
    <div class="loader-bg">
        <div class="loader-track">
            <div class="loader-fill"></div>
        </div>
    </div>
    <!-- [ 加载状态  ] End -->

    <!-- [ 主内容区 ] start -->
        <div class="pcoded-wrapper">
            <div class="pcoded-content">
                <div class="pcoded-inner-content">
                    <div class="main-body">
                        <div class="page-wrapper">
                            <!-- [ Main Content ] start -->
                            <div class="row">
					
								<form action="timingbackup/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
									<input type="hidden" name="TIMINGBACKUP_ID" id="TIMINGBACKUP_ID" value="${pd.TIMINGBACKUP_ID}"/>
									<div id="showform" style="padding-top:0px;">
							            <div class="input-group input-group-sm mb-3">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">备份对象</span></span>
		                                    </div>
		                                    <div style="width:572px;margin-left: 3px;">
			                                    <select class="js-example-placeholder-multiple col-sm-12" name="TABLENAME" id="TABLENAME" data-placeholder="请选择">
													<option value="all">整库</option>
													<c:if test="${dbtype != 'sqlserver' }">
													<c:forEach items="${varList}" var="varTab">
														<option value="${varTab }" <c:if test="${pd.TABLENAME==varTab}">selected</c:if>>${varTab }</option>
													</c:forEach>
												 	</c:if>
												</select>
											</div>
		                                </div>
							            
							            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">时间规则</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="FHTIME" id="FHTIME" value="${pd.FHTIME }" maxlength="32" placeholder="这里输入时间规则" title="时间规则">
		                                </div>
		                                
		                                <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">备注说明</span></span>
		                                    </div>
		                                    <input class="form-control" type="text" name="BZ" id="BZ"  value="${pd.BZ }"  maxlength="50" placeholder="这里输入备注说明" title="备注说明" >
		                                </div>
									
										<table class="table table-hover" style="margin-top:3px;">
											<tr>
												<td style="text-align: right;" id="setFHTIME">设定：</td>
												<td>
													<select onchange="setTimegz(this.value,'month')">
														<option value="*">每</option>
														<option value="1">一</option>
														<option value="2">二</option>
														<option value="3">三</option>
														<option value="4">四</option>
														<option value="5">五</option>
														<option value="6">六</option>
														<option value="7">七</option>
														<option value="8">八</option>
														<option value="9">九</option>
														<option value="10">十</option>
														<option value="11">十一</option>
														<option value="12">十二</option>
													</select>
													月
												</td>
												<td>
													<select onchange="setTimegz(this.value,'week')" id="weekId">
														<option value="*">每</option>
														<option value="MON">一</option>
														<option value="TUES">二</option>
														<option value="WED">三</option>
														<option value="THUR">四</option>
														<option value="FTI">五</option>
														<option value="SAT">六</option>
														<option value="SUN">七</option>
													</select>
													周
												</td>
												<td>
													<select onchange="setTimegz(this.value,'day')" id="dayId">
														<option value="*">每</option>
														<option value="1">1</option>
														<option value="2">2</option>
														<option value="3">3</option>
														<option value="4">4</option>
														<option value="5">5</option>
														<option value="6">6</option>
														<option value="7">7</option>
														<option value="8">8</option>
														<option value="9">9</option>
														<option value="10">10</option>
														<option value="11">11</option>
														<option value="12">12</option>
														<option value="13">13</option>
														<option value="14">14</option>
														<option value="15">15</option>
														<option value="16">16</option>
														<option value="17">17</option>
														<option value="18">18</option>
														<option value="19">19</option>
														<option value="20">20</option>
														<option value="21">21</option>
														<option value="22">22</option>
														<option value="23">23</option>
														<option value="24">24</option>
														<option value="25">25</option>
														<option value="26">26</option>
														<option value="27">27</option>
														<option value="28">28</option>
													</select>
													日
												</td>
												<td>
													<select onchange="setTimegz(this.value,'hour')">
														<option value="*">每</option>
														<option value="1">1</option>
														<option value="2">2</option>
														<option value="3">3</option>
														<option value="4">4</option>
														<option value="5">5</option>
														<option value="6">6</option>
														<option value="7">7</option>
														<option value="8">8</option>
														<option value="9">9</option>
														<option value="10">10</option>
														<option value="11">11</option>
														<option value="12">12</option>
														<option value="13">13</option>
														<option value="14">14</option>
														<option value="15">15</option>
														<option value="16">16</option>
														<option value="17">17</option>
														<option value="18">18</option>
														<option value="19">19</option>
														<option value="20">20</option>
														<option value="21">21</option>
														<option value="22">22</option>
														<option value="23">23</option>
													</select>
													时
												</td>
											</tr>
										</table>
										<div style="text-align: center;background-color: #F4F7FA;"><b>规则说明</b></div>
										<div class="input-group input-group-sm mb-3" style="margin-top: 10px;">
		                                    <input type="text" class="form-control" name="TIMEEXPLAIN" id="TIMEEXPLAIN" value="${pd.TIMEEXPLAIN}" maxlength="100" placeholder="这里是规则说明" title="规则说明" readonly="readonly"/>
		                                </div>
							            <div class="input-group" style="margin-top:16px;background-color: white;" >
							            	<span style="width: 100%;text-align: center;">
							            		<a class="btn btn-light btn-sm" onclick="save();">保存</a>
							            		<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">取消</a>
							            	</span>
							            </div>
						            </div>
						           <div id="jiazai" style="display:none;width: 100%;text-align: center;" class="page-loader" >
									   <div class="page-loader__spinner">
									        <svg viewBox="25 25 50 50">
									            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2" stroke-miterlimit="10"></circle>
									        </svg>
									   </div>
									   <br/>
								   </div>
								</form>
													
                            </div>
                            <!-- [ Main Content ] end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <!-- [ 主内容区 ] end -->
    
<script type="text/javascript" src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>

<!-- select插件 -->
<script src="assets/plugins/select2/js/select2.full.min.js"></script>
<script src="assets/plugins/multi-select/js/jquery.quicksearch.js"></script>
<script src="assets/plugins/multi-select/js/jquery.multi-select.js"></script>
<script src="assets/js/pages/form-select-custom.js"></script>

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
  	
	<script type="text/javascript">
		
		var hour = "*";
		var day = "*";
		var week = "*";
		var month = "*";
		//设置时间规则
		function setTimegz(value,type){
			if('hour' == type){
				hour = value;
			}else if('day' == type){
				day = value;
			}else if('week' == type){
				week = value;
			}else{
				month = value;
			}
			var strM = "";
			var strW = "";
			var strD = "";
			var strH = "";
			if("*" == month){
				strM = "每个月";
			}else{
				strM = "每年 "+month + " 月份";
			}
			if("?" != week){
				if("*" == week){
					strW = "每周";
					strD = "每天";
					$("#dayId").removeAttr("disabled");  
					$("#dayId").css("background","#FFFFFF");
				}else{
					$("#dayId").attr("disabled","disabled"); 
					$("#dayId").css("background","#F5F5F5");
					day = "?";
					strD = "";
					strW = "每个星期"+getWeek(week);
				}
			}
			if("?" != day){
				if("*" == day){
					strD = "每天";
					strW = "每周";
					$("#weekId").removeAttr("disabled");
					$("#weekId").css("background","#FFFFFF");
				}else{
					$("#weekId").attr("disabled","disabled"); 
					$("#weekId").css("background","#F5F5F5");
					week = "?";
					strW = "";
					strD = day + "号";
				}
			}
			if("*" == hour){
				strH = "每小时";
			}else{
				strH = hour + "点时";
			}
			if("*" == day && "*" == week){
				day = "*";
				week = "?";
			}
			$("#FHTIME").val("0 0 "+hour + " " + day + " " + month + " " + week);
			$("#TIMEEXPLAIN").val(strM+"的 "+strW+" "+strD+" "+strH+"执行一次");
		}
		
		//获取星期汉字
		function getWeek(value){
			var arrW = new Array("MON","TUES","WED","THUR","FTI","SAT","SUN");
			var arrH = new Array("一","二","三","四","五","六","日");
			for(var i=0;i<arrW.length;i++){
				if(value == arrW[i]) return arrH[i];
			}
		}
		
		//保存
		function save(){
			if($("#FHTIME").val()==""){
				$("#setFHTIME").tips({
					side:3,
		            msg:'请设置时间规则',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FHTIME").focus();
			return false;
			}
			if($("#BZ").val()==""){
				$("#BZ").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BZ").focus();
			return false;
			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}

	</script>
</body>
</html>