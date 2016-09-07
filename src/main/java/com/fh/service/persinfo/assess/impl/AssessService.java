package com.fh.service.persinfo.assess.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.service.persinfo.assess.AssessManager;
import com.fh.util.PageData;


/** 考核管理
 * @author admin
 * 修改时间：2016.8.25
 */
@Service("assessService")
public class AssessService implements AssessManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	

	/**获得考核列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listPdPageUser(Page page)throws Exception{
		return (List<PageData>) dao.findForList("AssessMapper.userlistPage", page);
	}
	
	/**
	 * 获得考核列表
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> assessList(Page page) throws Exception {
		return (List<PageData>) dao.findForList("AssessMapper.listAllAssessByUserUnit", page);
	}
	
	/**保存用户
	 * @param pd
	 * @throws Exception
	 */
	public void saveU(PageData pd)throws Exception{
		dao.save("AssessMapper.saveU", pd);
	}

	/**
	 * 获取修改页面用户数据
	 */
	@Override
	public PageData findByUiId(PageData pd) throws Exception {
		return (PageData)dao.findForObject("AssessMapper.findByUiId", pd);
	}

	/**
	 * 修改后的数据进行保存
	 */
	@Override
	public void editU(PageData pd) throws Exception {
		dao.update("AssessMapper.editU", pd);
		
	}
	
	/**删除用户
	 * @param pd
	 * @throws Exception
	 */
	public void deleteU(PageData pd)throws Exception{
		dao.delete("AssessMapper.deleteU", pd);
	}

	
	/**批量删除用户
	 * @param USER_IDS
	 * @throws Exception
	 */
	public void deleteAllU(String[] USER_IDS)throws Exception{
		dao.delete("AssessMapper.deleteAllU", USER_IDS);
	}
	
	/**全部会员
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAllAssess(PageData pd)throws Exception{
		return (List<PageData>) dao.findForList("AssessMapper.listAllAssess", pd);
	}
	
}
