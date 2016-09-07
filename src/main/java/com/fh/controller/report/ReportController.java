package com.fh.controller.report;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.service.persinfo.userinfo.UserInfoManager;
import com.fh.util.PageData;

/** 
 * 类名称：统计报表
 * 创建人：admin
 * 修改时间：2014年11月17日
 * @version
 */
@Controller
@RequestMapping(value="/report")
public class ReportController extends BaseController {
	
	String menuUrl = "report/listCadres.do"; //菜单地址(权限用)
	@Resource(name="userInfoService")
	private UserInfoManager userInfoService;
	
	/**显示用户列表
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/listCadres")
	public ModelAndView listCadres(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd.put("ztCount", Integer.parseInt(userInfoService.getCadreCount("正厅").get("cadreCount").toString()));		//系统用户数
			pd.put("ftCount", Integer.parseInt(userInfoService.getCadreCount("副厅").get("cadreCount").toString()));	//会员数
			pd.put("zcCount", Integer.parseInt(userInfoService.getCadreCount("正处").get("cadreCount").toString()));	//会员数
			pd.put("fcCount", Integer.parseInt(userInfoService.getCadreCount("副处").get("cadreCount").toString()));	//会员数
			pd.put("zkCount", Integer.parseInt(userInfoService.getCadreCount("正科").get("cadreCount").toString()));	//会员数
			pd.put("fkCount", Integer.parseInt(userInfoService.getCadreCount("副科").get("cadreCount").toString()));	//会员数
			mv.addObject("pd",pd);
			mv.setViewName("report/cadre_count");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
}
