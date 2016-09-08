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
								<form action="assess/${msg }.do" name="userForm" id="userForm" method="post">
									<input type="hidden" name="exsit_num" id="exsit_num" value="${pd.ID_NUM }"/>
									<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">姓名:</td>
											<td><input type="text" name="USER_NAME" id="USER_NAME"  value="${pd.USER_NAME }"  maxlength="32" placeholder="这里输入姓名" title="姓名" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">身份证号:</td>
											<td><input type="text" name="ID_NUM" id="ID_NUM"  value="${pd.ID_NUM }"  maxlength="32" placeholder="这里输入身份证号" title="身份证号码" style="width:98%;"/></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">考核年度:</td>
											<td><input class="span10 date-picker-y" name="ASSESS_DATE" id="ASSESS_DATE" value="${pd.ASSESS_DATE}" type="text" data-date-format="yyyy年" placeholder="考核年度"  title="考核年度" style="width:98%;" /></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">考核结果:</td>
											<td>
                                        		<select name="ASSESS_RESULT" title="状态">
                                        		<option value="优秀" <c:if test="${pd.ASSESS_RESULT == '优秀' }">selected</c:if> >优秀</option>
                                        		<option value="合格" <c:if test="${pd.ASSESS_RESULT == '合格' }">selected</c:if> >合格</option>
                                        		<option value="基本合格" <c:if test="${pd.ASSESS_RESULT == '基本合格' }">selected</c:if> >基本合格</option>
                                        		<option value="不合格" <c:if test="${pd.ASSESS_RESULT == '不合格' }">selected</c:if> >不合格</option>
                                        		<option value="考核不计等次" <c:if test="${pd.ASSESS_RESULT == '考核不计等次' }">selected</c:if> >考核不计等次</option>
                                        		<option value="未参加考核" <c:if test="${pd.ASSESS_RESULT == '未参加考核' }">selected</c:if> >未参加考核</option>
                                        		</select>
                                    		</td>
										</tr>
										<tr>
											<td style="text-align: center;" colspan="10">
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
			$("#ASSESS_DATE").attr("readonly","readonly");
			$("#ASSESS_DATE").css("color","gray");
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
		 
		if($("#USER_NAME").val()==""){
			$("#USER_NAME").tips({
				side:3,
	            msg:'输入姓名',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#USER_NAME").focus();
			return false;
		}
		
		
		if($("#ASSESS_RESULT").val()==""){
			$("#ASSESS_RESULT").tips({
				side:3,
	            msg:'输入考核结果',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#ASSESS_RESULT").focus();
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
		var ID_NUM = $.trim($("#ID_NUM").val());
		var ASSESS_DATE = $.trim($("#ASSESS_DATE").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>assess/hasU.do',
	    	data: {ID_NUM:ID_NUM,ASSESS_DATE:ASSESS_DATE,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" == data.result){
					$("#userForm").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				 }else{
					 $("#ID_NUM").tips({
	                        side:3,
	                        msg:'身份证号1'+ID_NUM+'不存在',
	                        bg:'#AE81FF',
	                        time:3
	                 });
				 }
			}
		});
	}
	
	//判断用户名是否存在(修改用)
    function hasUForUpadte(){
        var ID_NUM = $("#ID_NUM").val();
        var ASSESS_DATE = $.trim($("#ASSESS_DATE").val());
        $.ajax({
            type: "POST",
            url: '<%=basePath%>assess/hasUForUpadte.do',
            data: {ID_NUM:ID_NUM,ASSESS_DATE:ASSESS_DATE,tm:new Date().getTime()},
            dataType:'json',
            cache: false,
            success: function(data){
                 if("success" == data.result){
                    $("#userForm").submit();
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
	
	
	
	
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
	}
	
	//判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $.trim($("#EMAIL").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasE.do',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#EMAIL").tips({
							side:3,
				            msg:'邮箱 '+EMAIL+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#EMAIL").val('');
				 }
			}
		});
	}
	
	//判断编码是否存在
	function hasN(USERNAME){
		var NUMBER = $.trim($("#NUMBER").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasN.do',
	    	data: {NUMBER:NUMBER,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#NUMBER").tips({
							side:3,
				            msg:'编号 '+NUMBER+' 已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					 $("#NUMBER").val('');
				 }
			}
		});
	}
	$(function() {
		//日期框
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