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
						
						<!-- 检索  -->
						<form action="assess/listAssess.do" method="post" name="userForm" id="userForm">
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
								<td style="vertical-align:top;padding-left:2px;">
	                            <td><input class="span10 date-picker-y" name="assess_date" id="assess_date" value="${pd.ASSESS_DATE}" type="text" data-date-format="yyyy年" placeholder="考核年度"  title="考核年度" style="width:98%;" /></td>
                                <td style="vertical-align:top;padding-left:2px;">
                                    <select class="chosen-select form-control" name="assessresult" id="assessresult" data-placeholder="请选择考核结果" style="vertical-align:top;width: 130px;">
	                                    <option value=""></option>
	                                    <option value="">全部</option>
	                                    <option value="优秀">优秀</option>
	                                    <option value="合格">合格</option>
	                                    <option value="合格">基本合格</option>
	                                    <option value="合格">不合格</option>
	                                    <option value="合格">考核不计等次</option>
	                                    <option value="合格">未参加考核</option>
	                                    
                                    </select>
                                </td>
								<td style="vertical-align:top;padding-left:2px;">
                                    <select class="chosen-select form-control" name="assessstatus" id="assessstatus" data-placeholder="请选择状态" style="vertical-align:top;width: 120px;">
	                                    <option value=""></option>
	                                    <option value="">全部</option>
	                                    <option value="在职">在职</option>
	                                    <option value="退休">退休</option>
	                                    <option value="调出">调出</option>
	                                    <option value="病退">病退</option>
	                                    <option value="已故">已故</option>
                                    </select>
                                </td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								<c:if test="${QX.toExcel == 1 }">
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center" style="width:150px;">姓名</th>
									<th class="center" style="width:150px;">身份证号</th>
									<th class="center" style="width:150px;">单位</th>
									<th class="center" style="width:150px;">考核年度</th>
									<th class="center" style="width:150px;">考核结果</th>
									<th class="center" style="width:150px;">操作</th>
								</tr>
							</thead>
													
							<tbody>
								
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty assessList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${assessList}" var="assess" varStatus="vs">
												
										<tr>
											<td class='center' style="width: 30px;">
												<label><input type='checkbox' name='ids' value="${assess.ID_NUM }:${assess.ASSESS_DATE }" id="${assess.ID_NUM }" alt="${assess.ID_NUM }" class="ace"/><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class="center" style="width:100px;line-height:17.57px;padding-bottom: 1px;"><a href="javascript:void(0)" onclick="detailUser('${assess.ID_NUM }');">${assess.USER_NAME }</a></td>
											<td class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">${assess.ID_NUM}</td>
											<td class="center" style="width:160px;line-height:17.57px;padding-bottom: 1px;">${assess.USER_UNIT}</td>
											<td class="center" style="width:80px;line-height:17.57px;padding-bottom: 1px;">${assess.ASSESS_DATE}</td>
											<td class="center" style="width:90px;line-height:17.57px;padding-bottom: 1px;">${assess.ASSESS_RESULT}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="editAssess('${assess.ID_NUM}','${assess.ASSESS_DATE}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" title="删除" onclick="delAssess('${assess.ID_NUM }','${assess.ASSESS_DATE }');">
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
                                                            <c:if test="${QX.edit == 1 }">
                                                            <li>
                                                                <a style="cursor:pointer;" onclick="editAssess('${assess.ID_NUM}','${assess.ASSESS_DATE}');" class="tooltip-success" data-rel="tooltip" title="修改">
                                                                    <span class="green">
                                                                        <i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
                                                                    </span>
                                                                </a>
                                                            </li>
                                                            </c:if>
                                                            <c:if test="${QX.del == 1 }">
                                                            <li>
                                                                <a style="cursor:pointer;" onclick="delAssess('${assess.ID_NUM }','${assess.ASSESS_DATE }');">
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
										<td colspan="100" class="center">没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
					<div class="page-header position-relative">
					<table style="width:100%;">
						<tr>
							<td style="vertical-align:top;">
								<c:if test="${QX.add == 1 }">
								<a class="btn btn-mini btn-success" onclick="add();">新增</a>
								</c:if>
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
	
 	<script type="text/javascript">
    $(top.hangge());

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
	
	//删除
	function delAssess(id_num,assess_date){
		bootbox.confirm("确定要删除:["+id_num+"]吗?", function(result) {
			if(result) {
				top.jzts();
				var url = "<%=basePath%>assess/deleteU.do?ID_NUM="+id_num+"&ASSESS_DATE="+encodeURI(encodeURI(assess_date))+"&tm="+new Date().getTime();
				$.get(url,function(data){
					nextPage(${page.currentPage});
				});
			}
		});
	}
	
	//新增
	function add(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增";
		 diag.URL = '<%=basePath%>assess/goAddU.do';
		 diag.Width = 469;
		 diag.Height = 310;
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
	function editAssess(id_num,assess_date){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="资料";
		 diag.URL = '<%=basePath%>assess/goEditU.do?ID_NUM='+id_num+'&ASSESS_DATE='+encodeURI(encodeURI(assess_date));
		 diag.Width = 469;
		 diag.Height = 310;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage(${page.currentPage});
			 }
			diag.close();
		 };
		 diag.show();
	}
	
	 //详细资料
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
				var username = '';
				for(var i=0;i < document.getElementsByName('ids').length;i++)
				{
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  	
					  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
					  	else emstr += ';' + document.getElementsByName('ids')[i].id;
					  	
					  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
					  	else phones += ';' + document.getElementsByName('ids')[i].alt;
					  	
					  	if(username=='') username += document.getElementsByName('ids')[i].title;
					  	else username += ';' + document.getElementsByName('ids')[i].title;
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
							url: '<%=basePath%>assess/deleteAllU.do?tm='+new Date().getTime(),
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
	};
	
	//导出excel
	function toExcel(){
		var keywordsVal = $("#nav-search-input").val();
		var userunitVal = $("#userunit").val();
		var assess_dateVal = $("#assess_date").val();
		var assessresultVal = $("#assessresult").val();
		var assessstatusVal = $("#assessstatus").val();
		window.location.href="<%=basePath%>assess/excel.do?keywords=" + encodeURI(encodeURI(keywordsVal)) + "&userunit="+ encodeURI(encodeURI(userunitVal)) +"&assess_date="+ encodeURI(encodeURI(assess_dateVal)) +"&assessresult=" + encodeURI(encodeURI(assessresultVal)) + "&assessstatus="+ encodeURI(encodeURI(assessstatusVal));
	}

	</script>
	</body>
</html>
