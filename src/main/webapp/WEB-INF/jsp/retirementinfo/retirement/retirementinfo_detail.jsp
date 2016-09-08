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
						<form action="#" name="userInfoForm" id="userInfoForm" method="post">
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
								    <td style="width:140px;text-align: right;padding-top: 13px;">姓名:</td>
                                    <td style="width:180px;padding-top: 13px;">${pd.USER_NAME }</td>
									<td style="width:140px;text-align: right;padding-top: 13px;">身份证号:</td>
									<td style="width:180px;padding-top: 13px;">${pd.ID_NUM }</td>
								</tr>
								<tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">单位:</td>
                                    <td style="padding-top: 13px;">${pd.USER_UNIT}</td>
									<td style="width:79px;text-align: right;padding-top: 13px;">状态:</td>
                                    <td style="padding-top: 13px;">${pd.USER_STATUS }</td> 
								</tr>
								<tr>
                              		<td style="width:79px;text-align: right;padding-top: 13px;">离退休日期:</td>
                                    <td style="padding-top: 13px;">${pd.RETIRE_DATE}</td>                                                                      
                                </tr>                                
							</table>
							</div>
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
		}
	});
</script>
</html>