package com.fh.controller.persinfo.title;

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

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.persinfo.title.TitleManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 类名称：职称管理
 * 创建人：admin
 * 修改时间：2016年8月27日
 * @version
 */

@Controller
@RequestMapping(value="/title")
public class TitleController extends BaseController {
	
	String menuUrl = "title/listTitle.do"; //菜单地址(权限用)
	@Resource(name="titleService")
	private TitleManager titleService;
	
	/**显示用户列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/listTitle")
	public ModelAndView listTitle(Page page){
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
			String titlelevel = pd.getString("titlelevel");	//检索条件 专业技术职务/工人技术等级
			if(null != titlelevel && !"".equals(titlelevel)){
				pd.put("TITLE_LEVEL", titlelevel.trim());
			}
			String titletype = pd.getString("titletype");	//检索条件 专业/工种
			if(null != titletype && !"".equals(titletype)){
				pd.put("TITLE_TYPE", titletype.trim());
			}
			String userstatus = pd.getString("userstatus");	//检索条件 状态
			if(null != userstatus && !"".equals(userstatus)){
				pd.put("USER_STATUS", userstatus.trim());
			}
			page.setPd(pd);
			List<PageData>	titleList = titleService.listPdPageTitle(page);//列出所有员工的职称列表
			mv.setViewName("persinfo/title/title_list");
			mv.addObject("titleList", titleList);
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
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
		mv.setViewName("persinfo/title/title_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
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
		if(null == titleService.findByUiId(pd)){
			titleService.saveU(pd);			//判断新增权限
			mv.addObject("msg","success");
		}else{
			mv.addObject("msg","failed");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**判断用户名是否存在(新增用)
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
			if(null != titleService.findByUiId(pd)){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**判断用户名是否存在(修改用)
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
			if(null == titleService.findByUiId(pd)){
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
			if(null != titleService.findByUiId(pd)){
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
		String identi_date = pd.getString("IDENTI_DATE");	//认定时间
		if(null != identi_date && !"".equals(identi_date)){
			pd.remove("IDENTI_DATE");
			pd.put("IDENTI_DATE", URLDecoder.decode(identi_date.trim(), "UTF-8"));
		}
		titleService.deleteU(pd);
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
		titleService.editU(pd);
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
			
			String IDENTI_DATE = pd.getString("IDENTI_DATE");	//检索条件 单位
			if(null != IDENTI_DATE && !"".equals(IDENTI_DATE)){
				pd.put("IDENTI_DATE", URLDecoder.decode(IDENTI_DATE.trim(), "UTF-8"));
			}
			pd = titleService.findByUiId(pd); //根据ID读取
			mv.setViewName("persinfo/title/title_edit");
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
				titleService.deleteAllU(ArrayUSER_IDS);
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
				titles.add("身份证号");
				titles.add("姓名");
				titles.add("性别");
				titles.add("民族");
				titles.add("籍贯");
				titles.add("出生地");
				titles.add("出生年月");
				titles.add("单位");
				titles.add("所在部门");
				titles.add("政治面貌");
				titles.add("入党时间");
				titles.add("民主党派");
				titles.add("参加工作时间");
				titles.add("健康状况");
				titles.add("婚姻状况");
				titles.add("初始学历");
				titles.add("初始学位");
				titles.add("初始专业");
				titles.add("毕业院校");
				titles.add("毕业时间");
				titles.add("学习形式");
				titles.add("进入地调局的方式");
				titles.add("进入地调局的时间");
				titles.add("状态");
				titles.add("行政级别");
				titles.add("职务");
				dataMap.put("titles", titles);
				List<PageData> userList = titleService.listAllUser(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("ID_NUM"));
					vpd.put("var2", userList.get(i).getString("USER_NAME"));
					vpd.put("var3", userList.get(i).getString("USER_SEX"));
					vpd.put("var4", userList.get(i).getString("USER_NATION"));
					vpd.put("var5", userList.get(i).getString("ORIGIN_PLACE"));
					vpd.put("var6", userList.get(i).getString("BIRTH_PLACE"));
					vpd.put("var7", userList.get(i).getString("BIRTH_DATE"));
					vpd.put("var8", userList.get(i).getString("USER_UNIT"));
					vpd.put("var9", userList.get(i).getString("USER_DEPART"));
					vpd.put("var10", userList.get(i).getString("USER_POLIT"));
					vpd.put("var11", userList.get(i).getString("PARTY_DATE"));
					vpd.put("var12", userList.get(i).getString("NATION_PARTY"));
					vpd.put("var13", userList.get(i).getString("WORK_DATE"));
					vpd.put("var14", userList.get(i).getString("HEALTH_STATUS"));
					vpd.put("var15", userList.get(i).getString("MARRIAGE_STATUS"));
					vpd.put("var16", userList.get(i).getString("INIT_EDUCATION"));
					vpd.put("var17", userList.get(i).getString("INIT_DEGREE"));
					vpd.put("var18", userList.get(i).getString("INIT_MAJOR"));
					vpd.put("var19", userList.get(i).getString("GRADU_UNIVERS"));
					vpd.put("var20", userList.get(i).getString("GRADU_DATE"));
					vpd.put("var21", userList.get(i).getString("STUDY_TYPE"));
					vpd.put("var22", userList.get(i).getString("JOIN_TYPE"));
					vpd.put("var23", userList.get(i).getString("JOIN_DATE"));
					vpd.put("var24", userList.get(i).getString("USER_STATUS"));
					vpd.put("var25", userList.get(i).getString("ADMIN_LEVEL"));
					vpd.put("var26", userList.get(i).getString("USER_POST"));
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
	

}
