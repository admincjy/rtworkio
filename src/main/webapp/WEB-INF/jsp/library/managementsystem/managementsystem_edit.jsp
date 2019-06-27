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
    <link rel="stylesheet" href="assets/css/fileinput/fileinput.css">
    
    <!-- 日期插件 -->
    <link rel="stylesheet" href="assets/plugins/material-datetimepicker/css/bootstrap-material-datetimepicker.css">
    
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
					
								<form action="managementsystem/${msg }" name="Form" id="Form" method="post" style="width: 100%;">
									<input type="hidden" name="MANAGEMENTSYSTEM_ID" id="MANAGEMENTSYSTEM_ID" value="${pd.MANAGEMENTSYSTEM_ID}"/>
									<div id="showform">
							            <div class="input-group input-group-sm mb-3" style="margin-top: -10px;">
		                                    <div class="input-group-prepend">
		                                        <span class="input-group-text" style="width: 79px;"><span style="width: 100%;">文件名</span></span>
		                                    </div>
		                                    <input type="text" class="form-control" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入文件名" title="文件名">
		                                </div>
						                <div class="modal-body">
						                   <!-- <a href="~/Data/ExcelTemplate/Order.xlsx" class="form-control" style="border:none;">下载导入模板</a>-->
						                    <input type="file" name="txt_file" id="txt_file" multiple class="file-loading" />
						                </div>
							            <div class="input-group" style="margin-top:10px;background-color: white" >
							            	<span style="width: 100%;text-align: center;">
							            		<a class="btn btn-light btn-sm" onclick="save();">保存</a>
							            		<a class="btn btn-light btn-sm" onclick="top.Dialog.close();">取消</a>
							            	</span>
							            </div>
							       </div>
    <!--<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">请选择Excel文件</h4>
                </div>
                <div class="modal-body">
                    <a href="~/Data/ExcelTemplate/Order.xlsx" class="form-control" style="border:none;">下载导入模板</a>
                    <input type="file" name="txt_file" id="txt_file" multiple class="file-loading" />
                </div></div>
        </div>
    </div>-->
						           <!-- [加载状态 ] start -->
								    <div id="jiazai" style="display:none;margin-top:50px;">
								    	<div class="d-flex justify-content-center">
	                                        <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
                                                <span class="sr-only">Loading...</span>
                                            </div>
                                        </div>
                                    </div>
								    <!-- [ 加载状态  ] End -->
								</form>
	    
                            </div>
                            <!-- [ Main Content ] end -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <!-- [ 主内容区 ] end -->
    
<script type="text/javascript" src="assets/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="assets/js/pre-loader.js"></script>

<!-- 日期插件 -->
<script src="assets/js/pages/moment-with-locales.min.js"></script>
<script src="assets/plugins/material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>
<script src="assets/js/pages/form-picker-custom.js"></script>

<!-- 文件上传插件  -->
<script src="assets/plugins/fileinput/fileinput.js"></script>

<!-- select插件 -->
<script src="assets/plugins/select2/js/select2.full.min.js"></script>
<script src="assets/plugins/multi-select/js/jquery.quicksearch.js"></script>
<script src="assets/plugins/multi-select/js/jquery.multi-select.js"></script>
<script src="assets/js/pages/form-select-custom.js"></script>

<!-- 表单验证提示 -->
<script src="assets/js/jquery.tips.js"></script>
<script type="text/javascript">
		//初始化fileinput
		var FileInput = function () {
		    var oFile = new Object();
		
		    //初始化fileinput控件（第一次初始化）
		    oFile.Init = function(ctrlName, uploadUrl) {
		    var control = $('#' + ctrlName);
		    //初始化上传控件的样式
		    control.fileinput({
		        language: 'zh', //设置语言
		        uploadUrl: '<%=basePath%>managementsystem/fileUp', //上传的地址
		        allowedFileExtensions: ['pdf'],//接收的文件后缀
		        showUpload: true, //是否显示上传按钮
		        showCaption: false,//是否显示标题
		        browseClass: "btn btn-primary", //按钮样式     
		        //dropZoneEnabled: false,//是否显示拖拽区域
		        //minImageWidth: 50, //图片的最小宽度
		        //minImageHeight: 50,//图片的最小高度
		        //maxImageWidth: 1000,//图片的最大宽度
		        //maxImageHeight: 1000,//图片的最大高度
		        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
		        //minFileCount: 0,
		        maxFileCount: 10, //表示允许同时上传的最大文件个数
		        enctype: 'multipart/form-data',
		        validateInitialCount:true,
		        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
		        msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
		    });
		
		    //导入文件上传完成之后的事件
		    $("#txt_file").on("fileuploaded", function (event, data, previewId, index) {
		       console.log(666)
		       $("#myModal").modal("hide");
		        var data = data.response.lstOrderImport;
		        if (data == undefined) {
		            toastr.error('文件格式类型不正确');
		            return;
		        }
		        //1.初始化表格
		        var oTable = new TableInit();
		        oTable.Init(data);
		        $("#div_startimport").show();
		    });
		}
		    return oFile;
		};
	    $(function () {
	    //0.初始化fileinput
		    var oFileInput = new FileInput();
		    oFileInput.Init("txt_file", "/api/OrderApi/ImportOrder");
		});
		//保存
		function save(){
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入文件名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			$("#Form").submit();
			$("#showform").hide();
			$("#jiazai").show();
		}
		
		$(function() {
			

		});
</script>

</body>
</html>