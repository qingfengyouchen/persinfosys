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
						<form action="userinfo/${msg }.do" name="userInfoForm" id="userInfoForm" method="post">
							<input type="hidden" name="exsit_num" id="exsit_num" value="${pd.ID_NUM }"/>
							<div id="zhongxin" style="padding-top: 13px;">
							<table id="table_report" class="table table-striped table-bordered table-hover">
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">身份证号:</td>
									<td><input type="text" name="ID_NUM" id="ID_NUM" value="${pd.ID_NUM }" placeholder="这里输入身份证号" title="身份证号" style="width:98%;" onblur="hasE('${pd.ID_NUM }')" /></td>
									<td style="width:79px;text-align: right;padding-top: 13px;">姓名:</td>
									<td><input type="text" name="USER_NAME" id="USER_NAME" value="${pd.USER_NAME }" placeholder="这里输入姓名" title="姓名" style="width:98%;" /></td>
								</tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">性别:</td>
									<td>
                                        <select name="USER_SEX" title="状态">
                                        <option value="男" <c:if test="${pd.USER_SEX == '男' }">selected</c:if> >男</option>
                                        <option value="女" <c:if test="${pd.USER_SEX == '女' }">selected</c:if> >女</option>
                                        </select>
                                    </td>
									<td style="width:79px;text-align: right;padding-top: 13px;">民族:</td>
									<td><input type="text" name="USER_NATION" id="USER_NATION"  value="${pd.USER_NATION }" maxlength="32" placeholder="这里输入民族" title="民族" style="width:98%;" /></td>
								</tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">籍贯:</td>
                                    <td><input type="text" name="ORIGIN_PLACE" id="ORIGIN_PLACE"  value="${pd.ORIGIN_PLACE }" maxlength="32" placeholder="这里输入籍贯" title="籍贯" style="width:98%;" /></td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">出生地:</td>
                                    <td><input type="text" name="BIRTH_PLACE" id="BIRTH_PLACE"  value="${pd.BIRTH_PLACE }" maxlength="32" placeholder="这里输入出生地" title="出生地"  style="width:98%;" /></td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">出生年月:</td>
                                    <td><input class="span10 date-picker" name="BIRTH_DATE" id="BIRTH_DATE" value="${pd.BIRTH_DATE}" type="text" data-date-format="yyyy年mm月dd日" placeholder="出生年月"  title="出生年月" style="width:98%;" /></td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">参加工作时间:</td>
                                    <td><input class="span10 date-picker-ym" name="WORK_DATE" id="BIRTH_DATE" value="${pd.WORK_DATE}" type="text" data-date-format="yyyy年mm月" placeholder="参加工作时间"  title="参加工作时间" style="width:98%;" /></td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">单位:</td>
                                    <td>
                                        <select name="USER_UNIT" title="单位">
                                        <option value="局机关" <c:if test="${pd.USER_UNIT == '局机关' }">selected</c:if> >局机关</option>
                                        <option value="云南省地质调查院" <c:if test="${pd.USER_UNIT == '云南省地质调查院' }">selected</c:if> >云南省地质调查院</option>
                                        <option value="云南省地质环境监测院" <c:if test="${pd.USER_UNIT == '云南省地质环境监测院' }">selected</c:if> >云南省地质环境监测院</option>
                                        <option value="云南省国土规划研究院" <c:if test="${pd.USER_UNIT == '云南省国土规划研究院' }">selected</c:if> >云南省国土规划研究院</option>
                                        <option value="云南省地质技术信息中心" <c:if test="${pd.USER_UNIT == '云南省地质技术信息中心' }">selected</c:if> >云南省地质技术信息中心</option>
                                        </select>
                                    </td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">所在部门:</td>
                                    <td><input type="text" name="USER_DEPART" id="USER_DEPART"  value="${pd.USER_DEPART }" maxlength="32" placeholder="这里输入所在部门" title="所在部门"  style="width:98%;" /></td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">政治面貌:</td>
                                    <td>
                                        <select name="USER_POLIT" title="政治面貌">
											<option value="中共党员" <c:if test="${pd.USER_POLIT == '中共党员' }">selected</c:if> >中共党员</option>
											<option value="群众" <c:if test="${pd.USER_POLIT == '群众' }">selected</c:if> >群众</option>
											<option value="中共预备党员" <c:if test="${pd.USER_POLIT == '中共预备党员' }">selected</c:if> >中共预备党员</option>
											<option value="共青团员" <c:if test="${pd.USER_POLIT == '共青团员' }">selected</c:if> >共青团员</option>
											<option value="民革党员" <c:if test="${pd.USER_POLIT == '民革党员' }">selected</c:if> >民革党员</option>
											<option value="民盟盟员" <c:if test="${pd.USER_POLIT == '民盟盟员' }">selected</c:if> >民盟盟员</option>
											<option value="民进会员" <c:if test="${pd.USER_POLIT == '民进会员' }">selected</c:if> >民进会员</option>
											<option value="农工党党员" <c:if test="${pd.USER_POLIT == '农工党党员' }">selected</c:if> >农工党党员</option>
											<option value="致公党党员" <c:if test="${pd.USER_POLIT == '致公党党员' }">selected</c:if> >致公党党员</option>
											<option value="九三学社社员" <c:if test="${pd.USER_POLIT == '九三学社社员' }">selected</c:if> >九三学社社员</option>
											<option value="台盟盟员" <c:if test="${pd.USER_POLIT == '台盟盟员' }">selected</c:if> >台盟盟员</option>
											<option value="无党派人士" <c:if test="${pd.USER_POLIT == '无党派人士' }">selected</c:if> >无党派人士</option>
                                        </select>
                                    </td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">入党时间:</td>
                                    <td>
                                    <input class="span10 date-picker-ym" name="PARTY_DATE" id="PARTY_DATE" value="${pd.PARTY_DATE}" type="text" data-date-format="yyyy年mm月" placeholder="入党时间"  title="入党时间" style="width:98%;" /></td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">民主党派:</td>
                                    <td>
                                        <select name="NATION_PARTY" title="民主党派">
	                                        <option value="无" <c:if test="${pd.NATION_PARTY == '无' }">selected</c:if> >无</option>
											<option value="中国国民党革命委员会" <c:if test="${pd.NATION_PARTY == '中国国民党革命委员会' }">selected</c:if> >中国国民党革命委员会</option>
											<option value="中国民主同盟" <c:if test="${pd.NATION_PARTY == '中国民主同盟' }">selected</c:if> >中国民主同盟</option>
											<option value="中国民主建国会" <c:if test="${pd.NATION_PARTY == '中国民主建国会' }">selected</c:if> >中国民主建国会</option>
											<option value="中国民主促进会" <c:if test="${pd.NATION_PARTY == '中国民主促进会' }">selected</c:if> >中国民主促进会</option>
											<option value="中国农工民主党" <c:if test="${pd.NATION_PARTY == '中国农工民主党' }">selected</c:if> >中国农工民主党</option>
											<option value="中国致公党" <c:if test="${pd.NATION_PARTY == '中国致公党' }">selected</c:if> >中国致公党</option>
											<option value="九三学社" <c:if test="${pd.NATION_PARTY == '九三学社' }">selected</c:if> >九三学社</option>
											<option value="台湾民主自治同盟" <c:if test="${pd.NATION_PARTY == '台湾民主自治同盟' }">selected</c:if> >台湾民主自治同盟</option>
                                        </select>
                                    </td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">健康状况:</td>
                                    <td>
                                        <select name="HEALTH_STATUS" title="健康状况">
                                        <option value="健康" <c:if test="${pd.HEALTH_STATUS == '健康' }">selected</c:if> >健康</option>
                                        <option value="一般" <c:if test="${pd.HEALTH_STATUS == '一般' }">selected</c:if> >一般</option>
                                        <option value="较差" <c:if test="${pd.HEALTH_STATUS == '较差' }">selected</c:if> >较差</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">婚姻状况:</td>
                                    <td>
                                        <select name="MARRIAGE_STATUS" title="婚姻状况">
                                            <option value="已婚" <c:if test="${pd.MARRIAGE_STATUS == '已婚' }">selected</c:if> >已婚</option>
                                           <option value="未婚" <c:if test="${pd.MARRIAGE_STATUS == '未婚' }">selected</c:if> >未婚</option>
                                           <option value="离异" <c:if test="${pd.MARRIAGE_STATUS == '离异' }">selected</c:if> >离异</option>
                                           <option value="丧偶" <c:if test="${pd.MARRIAGE_STATUS == '丧偶' }">selected</c:if> >丧偶</option>
                                        </select>
                                    </td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">初始学历:</td>
                                    <td>
                                        <select name="INIT_EDUCATION" title="初始学历">
	                                        <option value="小学" <c:if test="${pd.INIT_EDUCATION == '小学' }">selected</c:if> >小学</option>
	                                        <option value="初中" <c:if test="${pd.INIT_EDUCATION == '初中' }">selected</c:if> >初中</option>
	                                        <option value="高中" <c:if test="${pd.INIT_EDUCATION == '高中' }">selected</c:if> >高中</option>
	                                        <option value="技校" <c:if test="${pd.INIT_EDUCATION == '技校' }">selected</c:if> >技校</option>
	                                        <option value="专科" <c:if test="${pd.INIT_EDUCATION == '专科' }">selected</c:if> >专科</option>
	                                        <option value="本科" <c:if test="${pd.INIT_EDUCATION == '本科' }">selected</c:if> >本科</option>
	                                        <option value="硕士" <c:if test="${pd.INIT_EDUCATION == '硕士' }">selected</c:if> >硕士</option>
	                                        <option value="博士" <c:if test="${pd.INIT_EDUCATION == '博士' }">selected</c:if> >博士</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">初始学位:</td>
                                    <td>
                                        <select name="INIT_DEGREE" title="初始学位">
                                            <option value="无" <c:if test="${pd.INIT_DEGREE == '无' }">selected</c:if> >无</option>
                                            <option value="学士" <c:if test="${pd.INIT_DEGREE == '学士' }">selected</c:if> >学士</option>
                                             <option value="硕士" <c:if test="${pd.INIT_DEGREE == '硕士' }">selected</c:if> >硕士</option>
                                             <option value="博士" <c:if test="${pd.INIT_DEGREE == '博士' }">selected</c:if> >博士</option>
                                        </select>
                                    </td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">初始专业:</td>
                                    <td><input type="text" name="INIT_MAJOR" id="INIT_MAJOR"  value="${pd.INIT_MAJOR }" placeholder="这里输入初始专业" title="初始专业" style="width:98%;" /></td>
                                </tr>
								<tr>
									<td style="width:79px;text-align: right;padding-top: 13px;">毕业院校:</td>
									<td><input type="text" name="GRADU_UNIVERS" id="GRADU_UNIVERS"  value="${pd.GRADU_UNIVERS }" placeholder="这里输入毕业院校" title="毕业院校" style="width:98%;" /></td>
									<td style="width:79px;text-align: right;padding-top: 13px;">毕业时间:</td>
                                    <td><input class="span10 date-picker-ym" name="GRADU_DATE" id="GRADU_DATE" value="${pd.GRADU_DATE}" type="text" data-date-format="yyyy年mm月" placeholder="毕业时间"  title="毕业时间" style="width:98%;" /></td>
								</tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">进入地调局的方式:</td>
                                    <td>
                                        <select name="JOIN_TYPE" title="进入地调局的方式">
                                            <option value="毕业生招聘" <c:if test="${pd.JOIN_TYPE == '毕业生招聘' }">selected</c:if> >毕业生招聘</option>
                                           <option value="成建制转入" <c:if test="${pd.JOIN_TYPE == '成建制转入' }">selected</c:if> >成建制转入</option>
                                           <option value="调入" <c:if test="${pd.JOIN_TYPE == '调入' }">selected</c:if> >调入</option>
                                           <option value="复转军人" <c:if test="${pd.JOIN_TYPE == '复转军人' }">selected</c:if> >复转军人</option>
                                        </select>
                                    </td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">学习形式:</td>
                                    <td>
                                        <select name="STUDY_TYPE" title="学习形式">
                                            <option value="全日制教育" <c:if test="${pd.STUDY_TYPE == '全日制教育' }">selected</c:if> >全日制教育</option>
                                            <option value="在职教育" <c:if test="${pd.STUDY_TYPE == '在职教育' }">selected</c:if> >在职教育</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">进入地调局的时间:</td>
                                    <td><input class="span10 date-picker-ym" name="JOIN_DATE" id="JOIN_DATE" value="${pd.JOIN_DATE}" type="text" data-date-format="yyyy年mm月" placeholder="进入地调局的时间"  title="进入地调局的时间" style="width:98%;" /></td>
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
                                    <td style="width:79px;text-align: right;padding-top: 13px;">行政级别:</td>
                                    <td>
                                        <select name="ADMIN_LEVEL" title="行政级别">
                                            <option value="职工" <c:if test="${pd.ADMIN_LEVEL == '职工' }">selected</c:if> >职工</option>
                                            <option value="副科" <c:if test="${pd.ADMIN_LEVEL == '副科' }">selected</c:if> >副科</option>
                                             <option value="正科" <c:if test="${pd.ADMIN_LEVEL == '正科' }">selected</c:if> >正科</option>
                                             <option value="副处" <c:if test="${pd.ADMIN_LEVEL == '副处' }">selected</c:if> >副处</option>
                                            <option value="正处" <c:if test="${pd.ADMIN_LEVEL == '正处' }">selected</c:if> >正处</option>
                                            <option value="副厅" <c:if test="${pd.ADMIN_LEVEL == '副厅' }">selected</c:if> >副厅</option>
                                            <option value="正厅" <c:if test="${pd.ADMIN_LEVEL == '正厅' }">selected</c:if> >正厅</option>
                                        </select>
                                    </td>
                                    <td style="width:79px;text-align: right;padding-top: 13px;">职务:</td>
                                    <td><input type="text" name="USER_POST" id="USER_POST"  value="${pd.USER_POST }" placeholder="这里输入职务" title="职务" style="width:98%;" /></td>
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
			url: '<%=basePath%>userinfo/hasU.do',
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
            url: '<%=basePath%>userinfo/hasUForUpadte.do',
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