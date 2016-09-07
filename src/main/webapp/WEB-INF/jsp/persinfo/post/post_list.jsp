<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
#maincontent {
    position: relative;
}
#simple-table {
    table-layout: fixed;
    background-color: #fff;
}
#simple-table th {
    font-size: 13px;
    color: #000002;
    cursor: pointer;
}
#simple-table th, td {
}
#box {
    position: absolute;
    display: none;
    background: #fff;
    text-align: center;
    top: 0;
    background-color: #6FB3E0;
    height: 100%;
    cursor: move;
}
#box p {
    line-height: 2;
}
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
						<form action="post/listPost.do" method="post" name="userForm" id="userForm">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="userunit" id="userunit" data-placeholder="请选择单位" style="vertical-align:top;width: 240px;">
									<option value=""></option>
									<option value="">全部</option>
									<option value="局机关">局机关</option>
									<option value="云南省地质调查院">云南省地质调查院</option>
									<option value="云南省地质环境监测院">云南省地质环境监测院</option>
									<option value="云南省国土规划研究院">云南省国土规划研究院</option>
									<option value="云南省地质技术信息中心">云南省地质技术信息中心</option>
								  	</select>
								</td>
								<!-- 
                                <td style="vertical-align:top;padding-left:2px;">
                                    <select class="chosen-select form-control" name="userstatus" id="userstatus" data-placeholder="请选择专业技术职务/工人技术等级" style="vertical-align:top;width: 120px;">
	                                    <option value=""></option>
	                                    <option value="">全部</option>
	                                    <option value="00">00</option>
	                                    <option value="01">10</option>
	                                    <option value="02">20</option>
                                    </select>
                                </td>
                                 <td style="vertical-align:top;padding-left:2px;">
                                    <select class="chosen-select form-control" name="userstatus" id="userstatus" data-placeholder="请选择专业/工种" style="vertical-align:top;width: 120px;">
	                                    <option value=""></option>
	                                    <option value="">全部</option>
	                                    <option value="00">00</option>
	                                    <option value="01">10</option>
	                                    <option value="02">20</option>
                                    </select>
                                </td>
                                 -->
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
								</c:if>
							</tr>
						</table>
						<div style="overflow:auto;" id="maincontent">
						<!-- 检索  -->
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
								<tr>
									<th class="center" style="width:35px;line-height:17.57px;padding-bottom: 1px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">序号</th>
									<th class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">姓名</th>
									<th class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">身份证号</th>
									<th class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">单位</th>
									<th class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">聘任时间</th>
									<th class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">聘任岗位类别</th>
									<th class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">聘任岗位等级</th>
									<th class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">聘用单位</th>
									<th class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">操作</th>
								</tr>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty postList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${postList}" var="post" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;line-height:17.57px;padding-bottom: 1px;">
												<label><input type='checkbox' name='ids' value="${post.ID_NUM }" id="${post.ID_NUM }" alt="${post.ID_NUM }" class="ace"/><span class="lbl"></span></label>
											</td>
                                            <td class='center' style="width:50px;line-height:17.57px;padding-bottom: 1px;">${vs.index+1}</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;"><a href="javascript:void(0)" onclick="detailUser('${post.ID_NUM }');">${post.USER_NAME }</a></td>
                                            <td class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">${post.ID_NUM }</td>
                                            <td class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">${post.USER_UNIT }</td>
                                            <td class="center" style="width:50px;line-height:17.57px;padding-bottom: 1px;">${post.APPOINT_DATE }</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">${post.POST_TYPE }</td>
                                            <td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;">${post.POST_LEVEL }</td>
                                            <td class="center" style="width:120px;line-height:17.57px;padding-bottom: 1px;">${post.APPOINT_UNIT }</td>
											<td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
												    <!-- 
													<c:if test="${QX.email == 1 }">
													<a class="btn btn-xs btn-info" title='发送电子邮件' onclick="sendEmail('${user.EMAIL }');">
														<i class="ace-icon fa fa-envelope-o bigger-120" title="发送电子邮件"></i>
													</a>
													</c:if>
													<c:if test="${QX.sms == 1 }">
													<a class="btn btn-xs btn-warning" title='发送短信' onclick="sendSms('${user.PHONE }');">
														<i class="ace-icon fa fa-envelope-o bigger-120" title="发送短信"></i>
													</a>
													</c:if>
													 -->
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="editPost('${post.ID_NUM}','${post.APPOINT_DATE }');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="delPost('${post.ID_NUM}','${post.APPOINT_DATE }');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<!-- 
															<c:if test="${QX.email == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="sendEmail('${user.EMAIL }');" class="tooltip-info" data-rel="tooltip" title="发送电子邮件">
																	<span class="blue">
																		<i class="ace-icon fa fa-envelope bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.sms == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="sendSms('${user.PHONE }');" class="tooltip-success" data-rel="tooltip" title="发送短信">
																	<span class="blue">
																		<i class="ace-icon fa fa-envelope-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															 -->
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="editPost('${post.ID_NUM}','${post.POST_TYPE }','${post.POST_LEVEL }');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="delPost('${post.ID_NUM}','${post.POST_TYPE }','${post.POST_LEVEL }');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>
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
						</table>
						</div>
						<div id="pagenavigation" class="page-header position-relative" style="padding-bottom: 1px;">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									</c:if>
									<!-- 
									<c:if test="${QX.email == 1 }"><a title="批量发送电子邮件" class="btn btn-mini btn-info" onclick="makeAll('确定要给选中的用户发送邮件吗?');"><i class="ace-icon fa fa-envelope bigger-120"></i></a></c:if>
									<c:if test="${QX.sms == 1 }"><a title="批量发送短信" class="btn btn-mini btn-warning" onclick="makeAll('确定要给选中的用户发送短信吗?');"><i class="ace-icon fa fa-envelope-o bigger-120"></i></a></c:if>
									 -->
									<c:if test="${QX.del == 1 }">
									<a title="批量删除" class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
								</td>
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
	</body>
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
		
		//检索
		function searchs(){
			top.jzts();
			$("#userForm").submit();
		}
		
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送电子邮件";
			 diag.URL = '<%=basePath%>head/goSendEmail.do?EMAIL='+EMAIL+'&msg=appuser';
			 diag.Width = 660;
			 diag.Height = 470;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//去发送短信页面
		function sendSms(phone){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="发送短信";
			 diag.URL = '<%=basePath%>head/goSendSms.do?PHONE='+phone+'&msg=appuser';
			 diag.Width = 600;
			 diag.Height = 265;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();
		}
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增岗位";
			 diag.URL = '<%=basePath%>post/goAddU.do';
			 diag.Width = 500;
			 diag.Height = 619;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function editPost(id_num,appoint_date){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="修改资料";
			 diag.URL = '<%=basePath%>post/goEditU.do?ID_NUM='+id_num+'&APPOINT_DATE='+encodeURI(encodeURI(appoint_date));
			 diag.Width = 500;
			 diag.Height = 619;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
	    //修改
        function detailPost(id_num){
             top.jzts();
             var diag = new top.Dialog();
             diag.Drag=true;
             diag.Title ="修改资料";
             diag.URL = '<%=basePath%>post/goDetailU.do?ID_NUM='+id_num;
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
		
		//删除
		function delPost(id_num,appoint_date){
			bootbox.confirm("确定要删除["+id_num+","+appoint_date+"]吗?", function(result) {
				if(result) {
					top.jzts();
					var url = '<%=basePath%>post/deleteU.do?ID_NUM='+id_num+'&APPOINT_DATE='+encodeURI(encodeURI(appoint_date));
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//修改
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
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					var emstr = '';
					var phones = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  	
						  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
						  	else emstr += ';' + document.getElementsByName('ids')[i].id;
						  	
						  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
						  	else phones += ';' + document.getElementsByName('ids')[i].alt;
						  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>post/deleteAllU.do?tm='+new Date().getTime(),
						    	data: {USER_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}else if(msg == '确定要给选中的用户发送邮件吗?'){
							sendEmail(emstr);
						}else if(msg == '确定要给选中的用户发送短信吗?'){
							sendSms(phones);
						}
						
					}
				}
			});
		}
		
		//导出excel
		function toExcel(){
			var keywordsVal = $("#nav-search-input").val();
			var userunitVal = $("#userunit").val();
			window.location.href="<%=basePath%>post/excel.do?keywords=" + encodeURI(encodeURI(keywordsVal)) + "&userunit=" + encodeURI(encodeURI(userunitVal));
		}
		</script>
</html>
