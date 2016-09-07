package com.fh.controller.query.agequery;

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
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.query.agequery.AgequeryManager;
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
@RequestMapping(value="/agequery")
public class AgequeryController extends BaseController {
	
	String menuUrl = "agequery/listAgequery.do"; //菜单地址(权限用)
	@Resource(name="agequeryService")
	private AgequeryManager agequeryService;
	
	/**显示用户列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/listAgequery")
	public ModelAndView listUsers(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String keywords = pd.getString("keywords");	//检索条件 关键词
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
			}
			String userage = pd.getString("usersage");	//检索条件 单位
//			if(null != userage && !"".equals(userage)){
//				pd.put("USERAGE", userage.trim());
//			}
			page.setPd(pd);
			List<PageData>	agequeryList1 = agequeryService.listPdPageUser(page);//列出会员列表
			List<PageData>	agequeryList = new ArrayList<PageData>(); //列出会员列表
			for (PageData tmp : agequeryList1) {
				//年龄对比
				String age = getAge(tmp.getString("BIRTH_DATE"));
				if(age.equals(userage)){
					// 年龄
					tmp.put("AGE", getAge(tmp.getString("BIRTH_DATE")));
					// 工龄
					tmp.put("SENIORITY", getSeniority(tmp.getString("WORK_DATE")));
					// 是否国名教育（TODO 需要关联到学历情况表）
					tmp.put("EDUCATION_STATUS", "是");
					agequeryList.add(tmp);
				}else{
					// 年龄
					tmp.put("AGE", getAge(tmp.getString("BIRTH_DATE")));
					// 工龄
					tmp.put("SENIORITY", getSeniority(tmp.getString("WORK_DATE")));
					// 是否国名教育（TODO 需要关联到学历情况表）
					tmp.put("EDUCATION_STATUS", "是");
				}
			}
			mv.setViewName("query/agequery/agequery_list");
			if(null != userage && !"".equals(userage)){
				mv.addObject("agequeryList", agequeryList);
			}else{
				mv.addObject("agequeryList", agequeryList1);
			}
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
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
			pd = agequeryService.findByUiId(pd); //根据ID读取
			// 工龄
			pd.put("AGE", getAge(pd.getString("BIRTH_DATE")));
			// 年龄
			pd.put("SENIORITY", getSeniority(pd.getString("WORK_DATE")));
			// 是否国名教育（TODO 需要关联到学历情况表）
			pd.put("EDUCATION_STATUS", "是");
			mv.setViewName("query/agequery/agequery_detail");
			mv.addObject("msg", "editU");//由于详细页面无需后台操作，此处msg随便写就行
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
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
				List<PageData> userList = agequeryService.listAllUser(pd);
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
