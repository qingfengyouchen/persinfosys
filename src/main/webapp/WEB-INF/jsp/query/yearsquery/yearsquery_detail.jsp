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
									<td style="width:79px;text-align: right;padding-top: 13px;">性别:</td>
									<td style="padding-top: 13px;">${pd.USER_SEX}</td>
								</tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">民族:</td>
                                    <td style="padding-top: 13px;">${pd.USER_NATION }</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">籍贯:</td>
                                    <td style="padding-top: 13px;">${pd.ORIGIN_PLACE }</td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">出生地:</td>
                                    <td style="padding-top: 13px;">${pd.BIRTH_PLACE }</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">出生年月:</td>
                                    <td style="padding-top: 13px;">${pd.BIRTH_DATE}</td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">年龄:</td>
                                    <td style="padding-top: 13px;">${pd.AGE}岁
                                    </td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">工龄:</td>
                                    <td style="padding-top: 13px;">${pd.SENIORITY }年</td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">政治面貌:</td>
                                    <td style="padding-top: 13px;">${pd.USER_POLIT }</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">入党时间:</td>
                                    <td style="padding-top: 13px;">${pd.PARTY_DATE}</td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">民主党派:</td>
                                    <td style="padding-top: 13px;">${pd.NATION_PARTY}</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">参加工作时间:</td>
                                    <td style="padding-top: 13px;">${pd.WORK_DATE}</td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">健康状况:</td>
                                    <td style="padding-top: 13px;">${pd.HEALTH_STATUS }</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">当前学历:</td>
                                    <td style="padding-top: 13px;">${pd.INIT_EDUCATION }
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">当前学位:</td>
                                    <td style="padding-top: 13px;">${pd.INIT_DEGREE }</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">当前专业:</td>
                                    <td style="padding-top: 13px;">${pd.INIT_MAJOR }</td>
                                </tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">毕业院校:</td>
									<td style="padding-top: 13px;">${pd.GRADU_UNIVERS }</td>
									<td style="width:79px;text-align: right;padding-top: 13px;">毕业时间:</td>
                                    <td style="padding-top: 13px;">${pd.GRADU_DATE}</td>
								</tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">学习形式:</td>
                                    <td style="padding-top: 13px;">${pd.STUDY_TYPE }</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">是否国民教育:</td>
                                    <td style="padding-top: 13px;">${pd.EDUCATION_STATUS }</td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">进入地调局的方式:</td>
                                    <td style="padding-top: 13px;">${pd.JOIN_TYPE }</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">进入地调局的时间:</td>
                                    <td style="padding-top: 13px;">${pd.JOIN_DATE}</td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">状态:</td>
                                    <td style="padding-top: 13px;">${pd.USER_STATUS }</td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">行政级别:</td>
                                    <td style="padding-top: 13px;">${pd.ADMIN_LEVEL}</td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">职务:</td>
                                    <td style="padding-top: 13px;">${pd.USER_POST }</td>
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