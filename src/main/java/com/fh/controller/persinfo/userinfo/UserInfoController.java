package com.fh.controller.persinfo.userinfo;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.persinfo.userinfo.UserInfoManager;
import com.fh.util.AppUtil;
import com.fh.util.DateUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 类名称：会员管理
 * 创建人：admin
 * 修改时间：2014年11月17日
 * @version
 */
@Controller
@RequestMapping(value="/userinfo")
public class UserInfoController extends BaseController {
	
	String menuUrl = "userinfo/listUserInfos.do"; //菜单地址(权限用)
	@Resource(name="userInfoService")
	private UserInfoManager userInfoService;
	
	/**显示在职用户列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/listActiveUsers")
	public ModelAndView listActiveUsers(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
		    pd.put("userstatus", "在职");
			page.setPd(pd);
			List<PageData>	userList = userInfoService.listPdPageUser(page);//列出会员列表
			for (PageData tmp : userList) {
				// 工龄
				tmp.put("AGE", getAge(tmp.getString("BIRTH_DATE")));
				// 年龄
				tmp.put("SENIORITY", getSeniority(tmp.getString("WORK_DATE")));
				// 是否国名教育（TODO 需要关联到学历情况表）
				tmp.put("EDUCATION_STATUS", "是");
			}
			mv.setViewName("persinfo/userinfo/userinfo_list");
			mv.addObject("userList", userList);
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**显示用户列表（页面检索按钮用）
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/listUserInfos")
	public ModelAndView listUsers(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String keywords = pd.getString("keywords");	//检索条件 关键词
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
			}
			String userunit = pd.getString("userunit");	//检索条件 单位
			if(null != userunit && !"".equals(userunit)){
				pd.put("USER_UNIT", userunit.trim());
			}
			String userstatus = pd.getString("userstatus");	//检索条件 状态
			if(null != userstatus && !"".equals(userstatus)){
				pd.put("USER_STATUS", userstatus.trim());
			}
			page.setPd(pd);
			List<PageData>	userList = userInfoService.listPdPageUser(page);//列出会员列表
			for (PageData tmp : userList) {
				// 工龄
				tmp.put("AGE", getAge(tmp.getString("BIRTH_DATE")));
				// 年龄
				tmp.put("SENIORITY", getSeniority(tmp.getString("WORK_DATE")));
				// 是否国名教育（TODO 需要关联到学历情况表）
				tmp.put("EDUCATION_STATUS", "是");
			}
			mv.setViewName("persinfo/userinfo/userinfo_list");
			mv.addObject("userList", userList);
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**去新增用户页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/goAddU")
	public ModelAndView goAddU() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("persinfo/userinfo/userinfo_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**用户详情
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goDetailU")
	public ModelAndView goDetailU(){
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = userInfoService.findByUiId(pd); //根据ID读取
			// 工龄
			pd.put("AGE", getAge(pd.getString("BIRTH_DATE")));
			// 年龄
			pd.put("SENIORITY", getSeniority(pd.getString("WORK_DATE")));
			// 是否国名教育（TODO 需要关联到学历情况表）
			pd.put("EDUCATION_STATUS", "是");
			mv.setViewName("persinfo/userinfo/userinfo_detail");
			mv.addObject("msg", "editU");//由于详细页面无需后台操作，此处msg随便写就行
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**保存用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveU")
	public ModelAndView saveU() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增会员");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(null == userInfoService.findByUiId(pd)){
			userInfoService.saveU(pd);			//判断新增权限
			mv.addObject("msg","success");
		}else{
			mv.addObject("msg","failed");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**判断用户名是否存在
	 * @return
	 */
	@RequestMapping(value="/hasU")
	@ResponseBody
	public Object hasU(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(null != userInfoService.findByUiId(pd)){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**判断用户名是否存在
	 * @return
	 */
	@RequestMapping(value="/hasUForUpadte")
	@ResponseBody
	public Object hasUForUpadte(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(null == userInfoService.findByUiId(pd)){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**判断用户名是否存在
	 * @return
	 */
	@RequestMapping(value="/hasE")
	@ResponseBody
	public Object hasE(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(null != userInfoService.findByUiId(pd)){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**删除用户
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteU")
	public void deleteU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除会员");
		PageData pd = new PageData();
		pd = this.getPageData();
		userInfoService.deleteU(pd);
		out.write("success");
		out.close();
	}
	
	/**修改用户
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editU")
	public ModelAndView editU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改职员");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		userInfoService.editU(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去修改用户页面
	 * @return
	 */
	@RequestMapping(value="/goEditU")
	public ModelAndView goEditU(){
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = userInfoService.findByUiId(pd); //根据ID读取
			mv.setViewName("persinfo/userinfo/userinfo_edit");
			mv.addObject("msg", "editU");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**批量删除
	 * @return
	 */
	@RequestMapping(value="/deleteAllU")
	@ResponseBody
	public Object deleteAllU() {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"批量删除会员");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String USER_IDS = pd.getString("USER_IDS");
			if(null != USER_IDS && !"".equals(USER_IDS)){
				String ArrayUSER_IDS[] = USER_IDS.split(",");
				userInfoService.deleteAllU(ArrayUSER_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/**导出会员信息到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, Jurisdiction.getUsername()+"导出人事资料");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){	
				String keywords = pd.getString("keywords");
				if(null != keywords && !"".equals(keywords)){
					pd.put("keywords", URLDecoder.decode(keywords.trim(), "UTF-8"));
				}
				String userunit = pd.getString("userunit");	//检索条件 单位
				if(null != userunit && !"".equals(userunit)){
					pd.put("userunit", URLDecoder.decode(userunit.trim(), "UTF-8"));
				}
				String userstatus = pd.getString("userstatus");	//检索条件 状态
				if(null != userstatus && !"".equals(userstatus)){
					pd.put("userstatus", URLDecoder.decode(userstatus.trim(), "UTF-8"));
				}
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("姓名");
				titles.add("身份证号");
				titles.add("单位");
				titles.add("性别");
				titles.add("民族");
				titles.add("籍贯");
				titles.add("出生地");
				titles.add("出生年月");
				titles.add("年龄");
				titles.add("工龄");
				titles.add("政治面貌");
				titles.add("入党时间");
				titles.add("民主党派");
				titles.add("参加工作时间");
				titles.add("健康状况");
				titles.add("初始学历");
				titles.add("初始学位");
				titles.add("初始专业");
				titles.add("毕业院校");
				titles.add("毕业时间");
				titles.add("学习形式");
				titles.add("是否国民教育");
				titles.add("进入地调局的方式");
				titles.add("进入地调局的时间");
				titles.add("状态");
				titles.add("行政级别");
				titles.add("职务");
				dataMap.put("titles", titles);
				List<PageData> userList = userInfoService.listAllUser(pd);
				for (PageData tmp : userList) {
					// 工龄
					tmp.put("AGE", getAge(tmp.getString("BIRTH_DATE")));
					// 年龄
					tmp.put("SENIORITY", getSeniority(tmp.getString("WORK_DATE")));
					// 是否国名教育（TODO 需要关联到学历情况表）
					tmp.put("EDUCATION_STATUS", "是");
				}
				List<PageData> varList = new ArrayList<PageData>();
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("USER_NAME"));
					vpd.put("var2", userList.get(i).getString("ID_NUM"));
					vpd.put("var3", userList.get(i).getString("USER_UNIT"));
					vpd.put("var4", userList.get(i).getString("USER_SEX"));
					vpd.put("var5", userList.get(i).getString("USER_NATION"));
					vpd.put("var6", userList.get(i).getString("ORIGIN_PLACE"));
					vpd.put("var7", userList.get(i).getString("BIRTH_PLACE"));
					vpd.put("var8", userList.get(i).getString("BIRTH_DATE"));
					vpd.put("var9", userList.get(i).getString("AGE")+"岁");
					vpd.put("var10", userList.get(i).getString("SENIORITY")+"年");
					vpd.put("var11", userList.get(i).getString("USER_POLIT"));
					vpd.put("var12", userList.get(i).getString("PARTY_DATE"));
					vpd.put("var13", userList.get(i).getString("NATION_PARTY"));
					vpd.put("var14", userList.get(i).getString("WORK_DATE"));
					vpd.put("var15", userList.get(i).getString("HEALTH_STATUS"));
					vpd.put("var16", userList.get(i).getString("INIT_EDUCATION"));
					vpd.put("var17", userList.get(i).getString("INIT_DEGREE"));
					vpd.put("var18", userList.get(i).getString("INIT_MAJOR"));
					vpd.put("var19", userList.get(i).getString("GRADU_UNIVERS"));
					vpd.put("var20", userList.get(i).getString("GRADU_DATE"));
					vpd.put("var21", userList.get(i).getString("STUDY_TYPE"));
					vpd.put("var22", userList.get(i).getString("EDUCATION_STATUS"));
					vpd.put("var23", userList.get(i).getString("JOIN_TYPE"));
					vpd.put("var24", userList.get(i).getString("JOIN_DATE"));
					vpd.put("var25", userList.get(i).getString("USER_STATUS"));
					vpd.put("var26", userList.get(i).getString("ADMIN_LEVEL"));
					vpd.put("var27", userList.get(i).getString("USER_POST"));
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView();
				mv = new ModelAndView(erv,dataMap);
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	// 计算年龄
	private String getAge(String birthday) {
		if (StringUtils.isEmpty(birthday)) {
			return "0";
		}
		int age = DateUtil.getDiffYear(birthday.replace("年", "-")
				.replace("月", "-").replace("日", "-"), DateUtil.getDay());
		return String.valueOf(age + 1);
	}
	// 计算工龄
	private String getSeniority(String workday) {
		if (StringUtils.isEmpty(workday)) {
			return "0";
		}
		int seniority = DateUtil.getDiffYear(workday.replace("年", "-")
				.replace("月", "-") + "-01", DateUtil.getDay());
		return String.valueOf(seniority + 1);
	}
}
