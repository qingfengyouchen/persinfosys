package com.fh.service.retirementinfo.retirement;

import java.util.List;

import com.fh.entity.Page;
import com.fh.util.PageData;

/** 离退休信息管理接口类
 * @author admin
 * 修改时间：2015.11.2
 */
public interface RetirementInfoManager {
	
	/**列出按单位的离退休信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllRetireInfoByUserUnit(PageData pd) throws Exception;
	
	/**离退休列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageRetirement(Page pd)throws Exception;
	
	/**通过用户名获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUsername(PageData pd)throws Exception;
	
	/**通过编号获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByNumber(PageData pd)throws Exception;
	
	/**保存离退休信息
	 * @param pd
	 * @throws Exception
	 */
	public void saveR(PageData pd)throws Exception;
	
	/**删除离退休信息
	 * @param pd
	 * @throws Exception
	 */
	public void deleteR(PageData pd)throws Exception;
	
	/**修改离退休信息
	 * @param pd
	 * @throws Exception
	 */
	public void editR(PageData pd)throws Exception;
	
    /**批量删除离退休信息
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllRetirement(String[] USER_IDS)throws Exception;
	
	/**获取总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData getRetirementInfoCount(String value)throws Exception;
	
}