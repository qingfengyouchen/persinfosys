package com.fh.controller.retirementinfo.retirement;

import java.io.PrintWriter;
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
import com.fh.entity.system.Role;
import com.fh.service.persinfo.userinfo.UserInfoManager;
import com.fh.service.system.role.RoleManager;
import com.fh.service.retirementinfo.retirement.RetirementInfoManager;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 类名称：离退休管理
 * 创建人：admin
 * 修改时间：2014年11月17日
 * @version
 */
@Controller
@RequestMapping(value="/retirement")
public class RetirementController extends BaseController {
	
	String menuUrl = "retirement/retirementinfo.do"; //菜单地址(权限用)
	@Resource(name="retirementInfoService")
	private RetirementInfoManager retirementInfoService;
	
	/**显示离退休列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/listRetirementInfos")
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
			List<PageData>	retireList = retirementInfoService.listPageRetirement(page);//列出会员列表
			mv.setViewName("retirementinfo/retirement/retirementinfo_list");
			mv.addObject("retireList", retireList);
			mv.addObject("pd", pd);
			mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**新增退休用户页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/AddR")
	public ModelAndView AddR() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("retirementinfo/retirement/retirementinfo_edit");
		mv.addObject("msg", "saveR");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**保存用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveR")
	public ModelAndView saveR() throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增离退休人员");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		retirementInfoService.saveR(pd);
		//pd.put("USER_NAME", this.get32UUID());	//ID
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**判断用户是否存在
	 * @return
	 */
	@RequestMapping(value={"/hasR"})
	@ResponseBody
	public Object hasR(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(retirementInfoService.findByNumber(pd)!= null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**判断用户是否存在
	 * @return
	 */
	@RequestMapping(value="/hasRForUpdate")
	@ResponseBody
	public Object hasRForUpdate(){
		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			if(retirementInfoService.findByNumber(pd) == null){
				errInfo = "error";
			}
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	/**删除离退休用户
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deleteR")
	public void deleteR(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"删除离退休记录");
		PageData pd = new PageData();
		pd = this.getPageData();
		retirementInfoService.deleteR(pd);
		out.write("success");
		out.close();
	}
	
	/**修改离退休用户
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/editR")
	public ModelAndView editR(PrintWriter out) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"修改离退休记录");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();		
		retirementInfoService.editR(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**去修改离退休用户
	 * @return
	 */
	@RequestMapping(value="/goEditR")
	public ModelAndView goEditR(){
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = retirementInfoService.findByNumber(pd); //根据ID读取
			mv.setViewName("retirementinfo/retirement/retirementinfo_edit");
			mv.addObject("msg", "editR");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/**批量删除
	 * @return
	 */
	@RequestMapping(value="/deleteAllR")
	@ResponseBody
	public Object deleteAllR() {
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"批量删除离退休人员");
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String USER_IDS = pd.getString("USER_IDS");
			if(null != USER_IDS && !"".equals(USER_IDS)){
				String ArrayUSER_IDS[] = USER_IDS.split(",");
				retirementInfoService.deleteAllRetirement(ArrayUSER_IDS);
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
	
	/**用户详情
	 * @param out
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/goDetailR")
	public ModelAndView goDetailR(){
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = retirementInfoService.findByNumber(pd); //根据ID读取			
			mv.setViewName("retirementinfo/retirement/retirementinfo_detail");
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
		logBefore(logger, Jurisdiction.getUsername()+"导出离退休人员资料");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			if(Jurisdiction.buttonJurisdiction(menuUrl, "cha")){	
				String keywords = pd.getString("keywords");
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
				Map<String,Object> dataMap = new HashMap<String,Object>();
				List<String> titles = new ArrayList<String>();
				titles.add("身份证号");
				titles.add("姓名");
				titles.add("单位");
				titles.add("退休时间");
				titles.add("状态");
				dataMap.put("titles", titles);
				List<PageData> userList = retirementInfoService.listAllRetireInfoByUserUnit(pd);
				List<PageData> varList = new ArrayList<PageData>();
				for(int i=0;i<userList.size();i++){
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("ID_NUM"));
					vpd.put("var2", userList.get(i).getString("USER_NAME"));
					vpd.put("var3", userList.get(i).getString("USER_UNIT"));
					vpd.put("var4", userList.get(i).getString("RETIRE_DATE"));
					vpd.put("var5", userList.get(i).getString("USER_STATUS"));
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
