package com.fh.service.persinfo.assess;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;


/** 考核接口类
 * @author 李飞飞
 * 修改时间：2016.8.25
 */
public interface AssessManager {
	
	/**
	 * 获取考核列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> assessList(Page page)throws Exception;
	
	public List<PageData> listPdPageUser(Page page)throws Exception;
	
	/**保存用户
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUiId(PageData pd)throws Exception;

	/**修改用户
	 * @param pd
	 * @throws Exception
	 */
	public void editU(PageData pd)throws Exception;
	
	/**删除用户
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception;
	
	public void deleteAllU(String[] USER_IDS)throws Exception;
	
	/**全部会员
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllAssess(PageData pd)throws Exception;
	
}
