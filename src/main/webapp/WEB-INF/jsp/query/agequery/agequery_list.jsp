﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<style>
 table{table-layout: fixed;}
 td{word-break: break-all; word-wrap:break-word;}
 </style>
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
						<!-- 检索  -->
						<form action="agequery/listAgequery.do" method="post" name="userForm" id="userForm">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入名字" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
                                <td style="vertical-align:top;padding-left:2px;">
                                    <select class="chosen-select form-control" name="usersage" id="usersage" data-placeholder="请选择年龄" style="vertical-align:top;width: 120px;">
	                                    <option value="">全部</option>
	                                    <option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option>
	                                    <option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option>
	                                    <option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option>
	                                    <option value="30">30</option><option value="31">31</option><option value="32">32</option><option value="33">33</option>
	                                    <option value="34">34</option><option value="35">35</option><option value="36">36</option><option value="37">37</option>
	                                    <option value="38">38</option><option value="39">39</option><option value="40">40</option><option value="41">41</option>
	                                    <option value="42">42</option><option value="43">43</option><option value="44">44</option><option value="45">45</option>
	                                    <option value="46">46</option><option value="47">47</option><option value="48">48</option><option value="49">49</option>
	                                    <option value="50">50</option><option value="51">51</option><option value="52">52</option><option value="53">53</option>
	                                    <option value="54">54</option><option value="55">55</option><option value="56">56</option><option value="57">57</option>
	                                    <option value="58">58</option><option value="59">59</option><option value="60">60</option><option value="61">61</option>
	                                    <option value="62">62</option><option value="63">63</option><option value="64">64</option><option value="65">65</option>
	                                    <option value="67">67</option><option value="68">68</option><option value="69">69</option><option value="70">70</option>
	                                    <option value="80">80</option><option value="81">81</option><option value="82">82</option><option value="83">83</option>
	                                    <option value="84">84</option><option value="85">85</option><option value="86">86</option><option value="87">87</option>
	                                    <option value="88">88</option><option value="88">88</option><option value="90">90</option><option value="91">91</option>
	                                    <option value="92">92</option><option value="93">93</option><option value="94">94</option><option value="95">95</option>
	                                    <option value="96">96</option><option value="97">97</option><option value="98">98</option><option value="99">99</option>
                                    </select>
                                </td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
								</c:if>
							</tr>
						</table>
						<div style="overflow:auto;" id="maincontent">
						<!-- 检索  -->
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;line-height:17.57px;padding-bottom: 1px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">序号</th>
                                    <th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">姓名</th>
									<th class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">身份证号</th>
									<th class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">单位</th>
									<th class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">性别</th>
									<th class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">民族</th>
									<th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">籍贯</th>
									<th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">出生地</th>
									<th class="center" style="width:120px;line-height:17.57px;padding-bottom: 1px;">出生年月</th>
									<th class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">年龄</th>
									<th class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">工龄</th>
									<th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">政治面貌</th>
									<th class="center" style="width:90px;line-height:17.57px;padding-bottom: 1px;">入党时间</th>
									<th class="center" style="width:150px;line-height:17.57px;padding-bottom: 1px;">民主党派</th>
									<th class="center" style="width:130px;line-height:17.57px;padding-bottom: 1px;">参加工作时间</th>
									<th class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">健康状况</th>
									<th class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">当前学历</th>
									<th class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">当前学位</th>
									<th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">当前专业</th>
									<th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">毕业院校</th>
									<th class="center" style="width:90px;line-height:17.57px;padding-bottom: 1px;">毕业时间</th>
									<th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">学习形式</th>
									<th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">是否国民教育</th>
									<th class="center" style="width:150px;line-height:17.57px;padding-bottom: 1px;">进入地调局的方式</th>
									<th class="center" style="width:150px;line-height:17.57px;padding-bottom: 1px;">进入地调局的时间</th>
									<th class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">状态</th>
									<th class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">行政级别</th>
									<th class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">职务</th>
								</tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty agequeryList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${agequeryList}" var="user" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;line-height:17.57px;padding-bottom: 1px;">
												<label><input type='checkbox' name='ids' value="${user.ID_NUM }" id="${user.ID_NUM }" alt="${user.ID_NUM }" class="ace"/><span class="lbl"></span></label>
											</td>
                                            <td class='center' style="width:50px;line-height:17.57px;padding-bottom: 1px;">${vs.index+1}</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;"><a href="javascript:void(0)" onclick="detailUser('${user.ID_NUM }');">${user.USER_NAME }</a></td>
                                            <td class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">${user.ID_NUM }</td>
                                            <td class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">${user.USER_UNIT }</td>
                                            <td class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">${user.USER_SEX }</td>
                                            <td class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">${user.USER_NATION }</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">${user.ORIGIN_PLACE }</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">${user.BIRTH_PLACE}</td>
                                            <td class="center" style="width:120px;line-height:17.57px;padding-bottom: 1px;">${user.BIRTH_DATE}</td>
                                            <td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">${user.AGE}岁</td>
                                            <td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">${user.SENIORITY}年</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">${user.USER_POLIT}</td>
                                            <td class="center" style="width:90px;line-height:17.57px;padding-bottom: 1px;">${user.PARTY_DATE}</td>
                                            <td class="center" style="width:150px;line-height:17.57px;padding-bottom: 1px;">${user.NATION_PARTY}</td>
                                            <td class="center" style="width:130px;line-height:17.57px;padding-bottom: 1px;">${user.WORK_DATE}</td>
                                            <td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">${user.HEALTH_STATUS}</td>
                                            <td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">${user.INIT_EDUCATION}</td>
                                            <td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">${user.INIT_DEGREE}</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">${user.INIT_MAJOR}</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">${user.GRADU_UNIVERS}</td>
                                            <td class="center" style="width:90px;line-height:17.57px;padding-bottom: 1px;">${user.GRADU_DATE}</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">${user.STUDY_TYPE}</td>
                                            <td class="center" style="width:120px;line-height:17.57px;padding-bottom: 1px;">${user.EDUCATION_STATUS}</td>
                                            <td class="center" style="width:150px;line-height:17.57px;padding-bottom: 1px;">${user.JOIN_TYPE}</td>
                                            <td class="center" style="width:150px;line-height:17.57px;padding-bottom: 1px;">${user.JOIN_DATE}</td>
                                            <td class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">${user.USER_STATUS}</td>
                                            <td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">${user.ADMIN_LEVEL}</td>
                                            <td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">${user.USER_POST}</td>
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						</div>
						
						<div id="pagenavigation" class="page-header position-relative" style="padding-bottom: 1px;">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>

 	<script type="text/javascript">
		$(top.hangge());
		
		$(function() {
			$("#maincontent").width($("#pagenavigation").width() - 2);
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
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		//点击姓名获取详细信息
        function detailUser(user_id){
             top.jzts();
             var diag = new top.Dialog();
             diag.Drag=true;
             diag.Title ="职员资料";
             diag.URL = '<%=basePath%>userinfo/goDetailU.do?ID_NUM='+user_id;
             diag.Width = 700;
             diag.Height = 619;
             diag.CancelEvent = function(){ //关闭事件
                 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                     nextPage(${page.currentPage});
                }
                diag.close();
             };
             diag.show();
        }
		
		//检索
		function searchs(){
			top.jzts();
			$("#userForm").submit();
		}
		 
		
		//导出excel
		function toExcel(){
			var keywordsVal = $("#nav-search-input").val();
			var userunitVal = $("#userunit").val();
			var userstatusVal = $("#userstatus").val();
			window.location.href="<%=basePath%>userinfo/excel.do?keywords=" + encodeURI(encodeURI(keywordsVal)) + "&userunit=" + encodeURI(encodeURI(userunitVal)) + "&userstatus=" + encodeURI(encodeURI(userstatusVal));
		}
		</script>
    </body>
</html>
