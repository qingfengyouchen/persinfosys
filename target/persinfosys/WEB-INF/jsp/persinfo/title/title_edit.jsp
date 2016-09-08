<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						<form action="title/${msg }.do" name="titleForm" id="titleForm" method="post">
							<input type="hidden" name="exsit_num" id="exsit_num" value="${pd.ID_NUM }"/>
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">身份证号:</td>
									<td><input type="text" name="ID_NUM" id="ID_NUM" value="${pd.ID_NUM }" placeholder="这里输入身份证号" title="身份证号" style="width:98%;"  /></td>
								</tr>
								<tr>	
									<td style="width:79px;text-align: right;padding-top: 13px;">姓名:</td>
									<td><input type="text" name="USER_NAME" id="USER_NAME" value="${pd.USER_NAME }" placeholder="这里输入姓名" title="姓名" style="width:98%;" /></td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">认定时间:</td>
                                    <td><input class="span10 date-picker" name="IDENTI_DATE" id="IDENTI_DATE" value="${pd.IDENTI_DATE}" type="text" data-date-format="yyyy年mm月dd日" placeholder="认定时间"  title="认定时间" style="width:98%;" /></td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">专业技术职务/工人技术等级:</td>
                                    <td>
                                        <select name="TITLE_LEVEL" id="IDENTI_DATE" title="专业技术职务/工人技术等级">
                                            <option value="无" <c:if test="${pd.TITLE_LEVEL == '无' }">selected</c:if> >无</option>
                                            <option value="初职" <c:if test="${pd.TITLE_LEVEL == '初职' }">selected</c:if> >初职</option>
                                            <option value="中职" <c:if test="${pd.TITLE_LEVEL == '中职' }">selected</c:if> >中职</option>
                                            <option value="副高" <c:if test="${pd.TITLE_LEVEL == '副高' }">selected</c:if> >副高</option>
                                            <option value="正高" <c:if test="${pd.TITLE_LEVEL == '正高' }">selected</c:if> >正高</option>
                                            <option value="初级工" <c:if test="${pd.TITLE_LEVEL == '初级工' }">selected</c:if> >初级工</option>
                                            <option value="中级工" <c:if test="${pd.TITLE_LEVEL == '中级工' }">selected</c:if> >中级工</option>
                                            <option value="高级工" <c:if test="${pd.TITLE_LEVEL == '高级工' }">selected</c:if> >高级工</option>
                                            <option value="技师" <c:if test="${pd.TITLE_LEVEL == '技师' }">selected</c:if> >技师</option>
                                            <option value="高级技师" <c:if test="${pd.TITLE_LEVEL == '高级技师' }">selected</c:if> >高级技师</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">专业/工种:</td>
                                    <td><input type="text" name="TITLE_TYPE" id="TITLE_TYPE"  value="${pd.TITLE_TYPE }" placeholder="这里输入专业/工种" title="专业/工种" style="width:98%;" /></td>
                                </tr>
                                <tr>      
                                    <td style="width:79px;text-align: right;padding-top: 13px;">评审机构:</td>
                                    <td><input type="text" name="IDENTI_UNIT" id="IDENTI_UNIT"  value="${pd.IDENTI_UNIT }" placeholder="这里输入评审机构" title="评审机构" style="width:98%;" /></td>
								<tr>
									<td class="center" colspan="6">
										<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
										<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
									</td>
								</tr>
							</table>
							</div>
							<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>						
<script type="text/javascript">
	$(top.hangge());
	
	$(document).ready(function(){
		if($("#ID_NUM").val()!=""){
			$("#ID_NUM").attr("readonly","readonly");
			$("#ID_NUM").css("color","gray");
			$("#USER_NAME").attr("readonly","readonly");
			$("#USER_NAME").css("color","gray");
			$("#IDENTI_DATE").attr("readonly","readonly");
			$("#IDENTI_DATE").css("color","gray");
		}
	});
	
	//保存
	function save(){
		
		if($("#exsit_num").val()=="") {
			// 新加
	        if($("#ID_NUM").val()=="" || $("#ID_NUM").val()=="此身份证号已存在!"){
	            $("#ID_NUM").tips({
	                side:3,
	                msg:'输入身份证号',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#ID_NUM").focus();
	            $("#ID_NUM").val('');
	            $("#ID_NUM").css("background-color","white");
	            return false;
	        }
	        if($("#USER_NAME").val()=="" || $("#USER_NAME").val()=="认定时间已存在!"){
	            $("#USER_NAME").tips({
	                side:3,
	                msg:'输入姓名',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#USER_NAME").focus();
	            $("#USER_NAME").val('');
	            $("#USER_NAME").css("background-color","white");
	            return false;
	        }
	        if($("#IDENTI_DATE").val()=="" || $("#IDENTI_DATE").val()=="认定时间已存在!"){
	            $("#IDENTI_DATE").tips({
	                side:3,
	                msg:'输入认定时间',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#ID_NUM").focus();
	            $("#ID_NUM").val('');
	            $("#ID_NUM").css("background-color","white");
	            return false;
	        }
	        if($("#TITLE_LEVEL").val()=="" || $("#TITLE_LEVEL").val()=="认定时间已存在!"){
	            $("#TITLE_LEVEL").tips({
	                side:3,
	                msg:'输入专业技术职务/工人技术等级',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#TITLE_LEVEL").focus();
	            $("#TITLE_LEVEL").val('');
	            $("#TITLE_LEVEL").css("background-color","white");
	            return false;
	        }
	        if($("#TITLE_TYPE").val()=="" || $("#TITLE_TYPE").val()=="认定时间已存在!"){
	            $("#TITLE_TYPE").tips({
	                side:3,
	                msg:'输入专业/工种',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#TITLE_TYPE").focus();
	            $("#TITLE_TYPE").val('');
	            $("#TITLE_TYPE").css("background-color","white");
	            return false;
	        }
	        if($("#IDENTI_UNIT").val()=="" || $("#IDENTI_UNIT").val()=="认定时间已存在!"){
	            $("#IDENTI_UNIT").tips({
	                side:3,
	                msg:'输入评审机构',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#IDENTI_UNIT").focus();
	            $("#IDENTI_UNIT").val('');
	            $("#IDENTI_UNIT").css("background-color","white");
	            return false;
	        }
	        
		}
        
		if($("#TITLE_LEVEL").val()=="" || $("#TITLE_LEVEL").val()=="认定时间已存在!"){
            $("#TITLE_LEVEL").tips({
                side:3,
                msg:'输入专业技术职务/工人技术等级',
                bg:'#AE81FF',
                time:2
            });
            $("#TITLE_LEVEL").focus();
            $("#TITLE_LEVEL").val('');
            $("#TITLE_LEVEL").css("background-color","white");
            return false;
        }
        if($("#TITLE_TYPE").val()=="" || $("#TITLE_TYPE").val()=="认定时间已存在!"){
            $("#TITLE_TYPE").tips({
                side:3,
                msg:'输入专业/工种',
                bg:'#AE81FF',
                time:2
            });
            $("#TITLE_TYPE").focus();
            $("#TITLE_TYPE").val('');
            $("#TITLE_TYPE").css("background-color","white");
            return false;
        }
        if($("#IDENTI_UNIT").val()=="" || $("#IDENTI_UNIT").val()=="认定时间已存在!"){
            $("#IDENTI_UNIT").tips({
                side:3,
                msg:'输入评审机构',
                bg:'#AE81FF',
                time:2
            });
            $("#IDENTI_UNIT").focus();
            $("#IDENTI_UNIT").val('');
            $("#IDENTI_UNIT").css("background-color","white");
            return false;
        }
		
        if($("#exsit_num").val()=="") {
            hasU();
        } else {
            // 修改
            hasUForUpadte();
        }
        
	}
	
	//判断用户名是否存在(新增用)
	function hasU(){
		var ID_NUM = $("#ID_NUM").val();
		var IDENTI_DATE = $("#IDENTI_DATE").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>title/hasU.do',
	    	data: {ID_NUM:ID_NUM,IDENTI_DATE:IDENTI_DATE,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#titleForm").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				 }else{
					$("#ID_NUM").css("background-color","#D16E6C");
					setTimeout("$('#ID_NUM').val('此身份证号已存在!')", 500);
				 }
			}
		});
	}
	
	//判断用户名是否存在(修改用)
    function hasUForUpadte(){
        var ID_NUM = $("#ID_NUM").val();
        var IDENTI_DATE = $("#IDENTI_DATE").val();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>title/hasUForUpadte.do',
            data: {ID_NUM:ID_NUM,IDENTI_DATE:IDENTI_DATE,tm:new Date().getTime()},
            dataType:'json',
            cache: false,
            success: function(data){
                 if("success" == data.result){
                    $("#titleForm").submit();
                    $("#zhongxin").hide();
                    $("#zhongxin2").show();
                 }else{
                    $("#ID_NUM").tips({
                        side:3,
                        msg:'身份证号'+ID_NUM+'不存在',
                        bg:'#AE81FF',
                        time:3
                    });
                 }
            }
        });
    }
	
    //判断身份证号是否存在
    function hasE(){
    	if($("#exsit_num").val()=="") {
	        var ID_NUM = $("#ID_NUM").val();
	        $.ajax({
	            type: "POST",
	            url: '<%=basePath%>userinfo/hasE.do',
	            data: {ID_NUM:ID_NUM,tm:new Date().getTime()},
	            dataType:'json',
	            cache: false,
	            success: function(data){
	                if("success" != data.result){
	                    $("#ID_NUM").tips({
	                           side:3,
	                           msg:'身份证号'+ID_NUM+'已存在',
	                           bg:'#AE81FF',
	                           time:3
	                       });
	                    $('#ID_NUM').val('');
	                }
	            }
	        });
        }
    }
	
	$(function() {
		//日期框
		$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		//下拉框
		if(!ace.vars['touch']) {
			$('.chosen-select').chosen({allow_single_deselect:true}); 
			$(window)
			.off('resize.chosen')
			.on('resize.chosen', function() {
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			}).trigger('resize.chosen');
			$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
				if(event_name != 'sidebar_collapsed') return;
				$('.chosen-select').each(function() {
					 var $this = $(this);
					 $this.next().css({'width': $this.parent().width()});
				});
			});
			$('#chosen-multiple-style .btn').on('click', function(e){
				var target = $(this).find('input[type=radio]');
				var which = parseInt(target.val());
				if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
				 else $('#form-field-select-4').removeClass('tag-input-style');
			});
		}
	});
</script>
</html>