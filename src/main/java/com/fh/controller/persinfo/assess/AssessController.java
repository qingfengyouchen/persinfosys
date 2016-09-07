package com.fh.controller.persinfo.assess;

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
import com.fh.service.persinfo.assess.AssessManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 类名称：考核管理
 * 创建人：李飞飞
 * 修改时间：2016年8月25日
 * @version
 */
@Controller
@RequestMapping(value="/assess")
public class AssessController extends BaseController {
	
	String menuUrl = "assess/listAssess.do"; //菜单地址(权限用)
	@Resource(name="assessService")
	private AssessManager assessService;
	
	/**显示考核列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/listAssess")
	public ModelAndView listAssess(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String keywords = pd.getString("keywords");	
			String userunit = pd.getString("userunit");	
			String assess_date = pd.getString("assess_date");	
			String assessresult = pd.getString("assessresult");	
			String assessstatus = pd.getString("assessstatus");	
			//检索条件 关键词
			if(null != keywords && !"".equals(keywords)){
				pd.put("keywords", keywords.trim());
			}
			if(null != userunit && !"".equals(userunit)){
				pd.put("userunit", userunit.trim());
			}
			if(null != assess_date && !"".equals(assess_date)){
				pd.put("assess_date", assess_date.trim());
			}
			if(null != assessresult && !"".equals(assessresult)){
				pd.put("assessresult", assessresult.trim());
			}
			if(null != assessstatus && !"".equals(assessstatus)){
				pd.put("assessstatus", assessstatus.trim());
			}
			page.setPd(pd);
			List<PageData> assessList = assessService.listPdPageUser(page);		//列出考核列表
			mv.setViewName("persinfo/assess/assess_list");
			mv.addObject("assessList", assessList);
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 新增考核
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goAddU")
	public ModelAndView goAddU()throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("persinfo/assess/assess_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"新增考核");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(null == assessService.findByUiId(pd)){
			assessService.saveU(pd);			//判断新增权限
			mv.addObject("msg","success");
		}else{
			mv.addObject("msg","failed");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**修改考核表
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editU")
	public ModelAndView editU(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改考核");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		assessService.editU(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去修改考核页面
	 * @return
	 */
	@RequestMapping(value="/goEditU")
	public ModelAndView goEditU(){
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			String assessdate = pd.getString("ASSESS_DATE");	//检索条件 单位
			if(null != assessdate && !"".equals(assessdate)){
				pd.remove("ASSESS_DATE");
				pd.put("ASSESS_DATE", URLDecoder.decode(assessdate.trim(), "UTF-8"));
			}
			pd = assessService.findByUiId(pd); //根据ID读取
			mv.setViewName("persinfo/assess/assess_edit");
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
		PageData pdDel = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String USER_IDS = pd.getString("USER_IDS");
			if(null != USER_IDS && !"".equals(USER_IDS)){
				String ArrayUSER_IDS[] = USER_IDS.split(",");
				for (String temp: ArrayUSER_IDS) {
					pdDel = new PageData();
					String[] key = temp.split(":");
					pdDel.put("ID_NUM", key[0]);
					pdDel.put("ASSESS_DATE", key[1]);
					assessService.deleteU(pdDel);
				}
				
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
			if(null != assessService.findByUiId(pd)){
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
			if(null == assessService.findByUiId(pd)){
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
		String assessdate = pd.getString("ASSESS_DATE");	//检索条件 单位
		if(null != assessdate && !"".equals(assessdate)){
			pd.remove("ASSESS_DATE");
			pd.put("ASSESS_DATE", URLDecoder.decode(assessdate.trim(), "UTF-8"));
		}
		assessService.deleteU(pd);
		out.write("success");
		out.close();
	}
	
	/**导出会员信息到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, Jurisdiction.getUsername()+"导出考核资料");
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
				String assessresult = pd.getString("assessresult");	//检索条件 状态
				if(null != assessresult && !"".equals(assessresult)){
					pd.put("assessresult", URLDecoder.decode(assessresult.trim(), "UTF-8"));
				}
				String assess_date = pd.getString("assess_date");	//检索条件 状态
				if(null != assess_date && !"".equals(assess_date)){
					pd.put("assess_date", URLDecoder.decode(assess_date.trim(), "UTF-8"));
				}
				String assessstatus = pd.getString("assessstatus");	//检索条件 状态
				if(null != assessstatus && !"".equals(assessstatus)){
					pd.put("assessstatus", URLDecoder.decode(assessstatus.trim(), "UTF-8"));
				}
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("身份证号");
				titles.add("姓名");
				titles.add("单位");
				titles.add("考核年度");
				titles.add("考核结果");
				dataMap.put("titles", titles);
				List<PageData> userList = assessService.listAllAssess(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("ID_NUM"));
					vpd.put("var2", userList.get(i).getString("USER_NAME"));
					vpd.put("var3", userList.get(i).getString("USER_UNIT"));
					vpd.put("var4", userList.get(i).getString("ASSESS_DATE"));
					vpd.put("var5", userList.get(i).getString("ASSESS_RESULT"));
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
