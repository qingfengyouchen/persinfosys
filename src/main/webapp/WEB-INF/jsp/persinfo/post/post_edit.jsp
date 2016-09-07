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
						<form action="post/${msg }.do" name="postForm" id="postForm" method="post">
							<input type="hidden" name="exsit_num" id="exsit_num" value="${pd.ID_NUM }"/>
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">身份证号:</td>
									<td><input type="text" name="ID_NUM" id="ID_NUM" value="${pd.ID_NUM }" placeholder="这里输入身份证号" title="身份证号" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">姓名:</td>
									<td><input type="text" name="USER_NAME" id="USER_NAME" value="${pd.USER_NAME }" placeholder="这里输入姓名" title="姓名" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">聘任时间:</td>
									<td><input class="span10 date-picker" name="APPOINT_DATE" id="APPOINT_DATE" value="${pd.APPOINT_DATE}" type="text" data-date-format="yyyy年mm月dd日" placeholder="聘任时间"  title="聘任时间" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">聘任岗位类别:</td>
									<td>
                                        <select name="POST_TYPE" id="POST_TYPE" title="聘任岗位类别">
											<option value="管理" <c:if test="${pd.POST_TYPE == '管理' }">selected</c:if> >管理</option>
											<option value="专业技术" <c:if test="${pd.POST_TYPE == '专业技术' }">selected</c:if> >专业技术</option>
											<option value="工勤" <c:if test="${pd.POST_TYPE == '工勤' }">selected</c:if> >工勤</option>
                                        </select>
                                    </td>
								</tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">聘任岗位等级:</td>
									<td>
                                        <select name="POST_LEVEL" id="POST_LEVEL" title="聘任岗位类别">
											<option value="一级" <c:if test="${pd.POST_LEVEL == '一级' }">selected</c:if> >一级</option>
											<option value="二级" <c:if test="${pd.POST_LEVEL == '二级' }">selected</c:if> >二级</option>
											<option value="三级" <c:if test="${pd.POST_LEVEL == '三级' }">selected</c:if> >三级</option>
											<option value="四级" <c:if test="${pd.POST_LEVEL == '四级' }">selected</c:if> >四级</option>
											<option value="四级及以下" <c:if test="${pd.POST_LEVEL == '四级及以下' }">selected</c:if> >四级及以下</option>
											<option value="五级" <c:if test="${pd.POST_LEVEL == '五级' }">selected</c:if> >五级</option>
											<option value="六级" <c:if test="${pd.POST_LEVEL == '六级' }">selected</c:if> >六级</option>
											<option value="七级" <c:if test="${pd.POST_LEVEL == '七级' }">selected</c:if> >七级</option>
											<option value="八级" <c:if test="${pd.POST_LEVEL == '八级' }">selected</c:if> >八级</option>
											<option value="九级" <c:if test="${pd.POST_LEVEL == '九级' }">selected</c:if> >九级</option>
											<option value="九级及以下" <c:if test="${pd.POST_LEVEL == '九级及以下' }">selected</c:if> >九级及以下</option>
                                        	<option value="十级" <c:if test="${pd.POST_LEVEL == '十级' }">selected</c:if> >十级</option>
                                        	<option value="十一级" <c:if test="${pd.POST_LEVEL == '十一级' }">selected</c:if> >十一级</option>
                                        	<option value="十二级" <c:if test="${pd.POST_LEVEL == '十二级' }">selected</c:if> >十二级</option>
                                        	<option value="十三级" <c:if test="${pd.POST_LEVEL == '十三级' }">selected</c:if> >十三级</option>
                                        </select>
                                    </td>
								</tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">聘用单位:</td>
									<td>
                                        <select name="APPOINT_UNIT" id="APPOINT_UNIT" title="聘用单位">
                                        <option value="局机关" <c:if test="${pd.APPOINT_UNIT == '局机关' }">selected</c:if> >局机关</option>
                                        <option value="云南省地质调查院" <c:if test="${pd.APPOINT_UNIT == '云南省地质调查院' }">selected</c:if> >云南省地质调查院</option>
                                        <option value="云南省地质环境监测院" <c:if test="${pd.APPOINT_UNIT == '云南省地质环境监测院' }">selected</c:if> >云南省地质环境监测院</option>
                                        <option value="云南省国土规划研究院" <c:if test="${pd.APPOINT_UNIT == '云南省国土规划研究院' }">selected</c:if> >云南省国土规划研究院</option>
                                        <option value="云南省地质技术信息中心" <c:if test="${pd.APPOINT_UNIT == '云南省地质技术信息中心' }">selected</c:if> >云南省地质技术信息中心</option>
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
			$("#USER_UNIT").attr("readonly","readonly");
			$("#USER_UNIT").css("color","gray");
			$("#USER_NAME").attr("readonly","readonly");
			$("#USER_NAME").css("color","gray");
			$("#APPOINT_DATE").attr("readonly","readonly");
			$("#APPOINT_DATE").css("color","gray");
			$("#APPOINT_UNIT").attr("readonly","readonly");
			$("#APPOINT_UNIT").css("color","gray");
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
	        if($("#APPOINT_DATE").val()=="") {
	            $("#APPOINT_DATE").tips({
	                side:3,
	                msg:'聘任时间',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#APPOINT_DATE").focus();
	            $("#APPOINT_DATE").val('');
	            $("#APPOINT_DATE").css("background-color","white");
	            return false;
	        }
	        if($("#POST_TYPE").val()=="") {
	            $("#POST_TYPE").tips({
	                side:3,
	                msg:'聘任岗位类别',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#POST_TYPE").focus();
	            $("#POST_TYPE").val('');
	            $("#POST_TYPE").css("background-color","white");
	            return false;
	        }
	        if($("#POST_LEVEL").val()=="") {
	            $("#POST_LEVEL").tips({
	                side:3,
	                msg:'聘任岗位等级',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#POST_LEVEL").focus();
	            $("#POST_LEVEL").val('');
	            $("#POST_LEVEL").css("background-color","white");
	            return false;
	        }
	        if($("#APPOINT_UNIT").val()=="") {
	            $("#APPOINT_UNIT").tips({
	                side:3,
	                msg:'聘任单位',
	                bg:'#AE81FF',
	                time:2
	            });
	            $("#APPOINT_UNIT").focus();
	            $("#APPOINT_UNIT").val('');
	            $("#APPOINT_UNIT").css("background-color","white");
	            return false;
	        }
		}
        
        
        if($("#exsit_num").val()=="") {
            hasU();
        } else {
            // 修改
            hasUForUpadte();
        }
	}
	
	//判断用户名是否存在(保存用)
	function hasU(){
		var ID_NUM = $("#ID_NUM").val();
		var APPOINT_DATE = $("#APPOINT_DATE").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>post/hasU.do',
	    	data: {ID_NUM:ID_NUM,APPOINT_DATE:APPOINT_DATE,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#postForm").submit();
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
        var APPOINT_DATE = $("#APPOINT_DATE").val();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>post/hasUForUpadte.do',
            data: {ID_NUM:ID_NUM,APPOINT_DATE:APPOINT_DATE,tm:new Date().getTime()},
            dataType:'json',
            cache: false,
            success: function(data){
                 if("success" == data.result){
                    $("#postForm").submit();
                    $("#zhongxin").hide();
                    $("#zhongxin2").show();
                 }else{
                    $("#ID_NUM").tips({
                        side:3,
                        msg:'身份证号'+ID_NUM+'不存在'+'聘任时间'+APPOINT_DATE+'不存在',
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