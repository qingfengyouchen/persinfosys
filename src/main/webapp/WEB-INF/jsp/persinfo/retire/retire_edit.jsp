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
						<form action="retire/${msg }.do" name="userInfoForm" id="userInfoForm" method="post">
							<input type="hidden" name="exsit_num" id="exsit_num" value="${pd.ID_NUM }"/>
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">身份证号:</td>
									<td><input type="text" name="ID_NUM" id="ID_NUM" value="${pd.ID_NUM }" placeholder="这里输入身份证号" title="身份证号" style="width:98%;"/></td>
								</tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">姓名:</td>
									<td><input type="text" name="USER_NAME" id="USER_NAME" value="${pd.USER_NAME }" placeholder="这里输入姓名" title="姓名" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">退休时间:</td>
                                    <td><input class="span10 date-picker" name="RETIRE_TIME" id="RETIRE_TIME" value="${pd.RETIRE_TIME}" type="text" data-date-format="yyyy年mm月dd日" placeholder="退休时间"  title="退休时间" style="width:98%;" /></td>
								</tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">状态:</td>
                                    <td>
                                        <select name="USER_STATUS" title="学习形式">
                                            <option value="在职" <c:if test="${pd.USER_STATUS == '在职' }">selected</c:if> >在职</option>
                                            <option value="退休" <c:if test="${pd.USER_STATUS == '退休' }">selected</c:if> >退休</option>
                                            <option value="调出" <c:if test="${pd.USER_STATUS == '调出' }">selected</c:if> >调出</option>
                                            <option value="病退" <c:if test="${pd.USER_STATUS == '病退' }">selected</c:if> >病退</option>
                                            <option value="已故" <c:if test="${pd.USER_STATUS == '已故' }">selected</c:if> >已故</option>
                                        </select>
                                    </td>
                                </tr>
                                
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
		}

        if($("#USER_NAME").val()=="") {
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
        if($("#exsit_num").val()=="") {
            hasU();
        } else {
            // 修改
            hasUForUpadte();
        }
	}
	
	//判断用户名是否存在
	function hasU(){
		var ID_NUM = $("#ID_NUM").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>retire/hasU.do',
	    	data: {ID_NUM:ID_NUM,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#userInfoForm").submit();
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
        $.ajax({
            type: "POST",
            url: '<%=basePath%>retire/hasUForUpadte.do',
            data: {ID_NUM:ID_NUM,tm:new Date().getTime()},
            dataType:'json',
            cache: false,
            success: function(data){
                 if("success" == data.result){
                    $("#userInfoForm").submit();
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
		// 日期框只选择年月
	    $('.date-picker-ym').datepicker({
	        autoclose: true,
	        startView: 2,
	        maxViewMode: 1,
	        minViewMode:1,
	        todayBtn: false,
	        startView: 'year',
	        minView:'year'
	        });
	    // 日期框只选择年
        $('.date-picker-y').datepicker({
            autoclose: true,
            startView: 2,
            maxViewMode: 2,
            minViewMode:2,
            todayBtn: false,
            startView: 'year',
            minView:'year'
            });
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