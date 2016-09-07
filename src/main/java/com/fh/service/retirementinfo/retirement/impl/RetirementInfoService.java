package com.fh.service.retirementinfo.retirement.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.retirementinfo.retirement.RetirementInfoManager;

@Service("retirementInfoService")
public class RetirementInfoService implements RetirementInfoManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 按单位查询离退休
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllRetireInfoByUserUnit(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("RetirementInfoMapper.listAllRetireInfoByUserUnit", pd);
	}

	/**
	 * 离退休列表
	 * 
	 * @param page
	 * @return  
	 * @throws Exception
	 *  //TODO 
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPageRetirement(Page pd) throws Exception {
		return (List<PageData>) dao.findForList("RetirementInfoMapper.listPageRetirement", pd);
	}

	/**
	 * 通过用户名获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUsername(PageData pd) throws Exception {
		return (PageData) dao.findForObject("RetirementInfoMapper.findByUsername", pd);
	}

	/**
	 * 通过编号获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByNumber(PageData pd) throws Exception {
		return (PageData) dao.findForObject("RetirementInfoMapper.findByNumber", pd);
	}

	/**
	 * 保存用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void saveR(PageData pd) throws Exception {
		dao.save("RetirementInfoMapper.saveR", pd);
	}

	/**
	 * 删除用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void deleteR(PageData pd) throws Exception {
		dao.delete("RetirementInfoMapper.deleteR", pd);
	}

	/**
	 * 修改用户
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editR(PageData pd) throws Exception {
		dao.update("RetirementInfoMapper.editR", pd);
	}

	/**
	 * 批量删除离退休
	 * 
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllRetirement(String[] USER_IDS) throws Exception {
		dao.delete("RetirementInfoMapper.deleteAllR", USER_IDS);
	}

	/**
	 * 获取总数
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData getRetirementInfoCount(String value) throws Exception {
		return (PageData) dao.findForObject("RetirementInfoMapper.getRetirementInfoCount", value);
	}

}
