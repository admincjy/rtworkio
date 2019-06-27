package org.fh.service.fhoa.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.mapper.dsno1.fhoa.StudyplanMapper;
import org.fh.service.fhoa.StudyplanService;

/** 
 * 说明： 学习计划流程接口实现类
 * 作者：FH Admin Q313596790
 * 时间：2019-05-05
 * 官网：www.fhadmin.org
 * @version
 */
@Service
@Transactional //开启事物
public class StudyplanServiceImpl implements StudyplanService{

	@Autowired
	private StudyplanMapper studyplanMapper;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		studyplanMapper.save(pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		studyplanMapper.delete(pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		studyplanMapper.edit(pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception{
		return studyplanMapper.datalistPage(page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return studyplanMapper.listAll(pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return studyplanMapper.findById(pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		studyplanMapper.deleteAll(ArrayDATA_IDS);
	}
	
	public List<PageData> listReportPage(Page page)throws Exception{
		return studyplanMapper.reportPage(page);
	}
	
}

