package org.fh.service.fhoa.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.mapper.dsno1.fhoa.StudyMapper;
import org.fh.service.fhoa.StudyService;

/** 
 * 说明： 学习心得流程接口实现类
 * 作者：FH Admin Q313596790
 * 时间：2019-04-30
 *  ：www.fhadmin.org
 * @version
 */
@Service
@Transactional //开启事物
public class StudyServiceImpl implements StudyService{

	@Autowired
	private StudyMapper studyMapper;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		studyMapper.save(pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		studyMapper.delete(pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		studyMapper.edit(pd);
	}
	
	public void editbyPIID(PageData pd)throws Exception{
		studyMapper.editbyPIID(pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception{
		return studyMapper.datalistPage(page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return studyMapper.listAll(pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return studyMapper.findById(pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		studyMapper.deleteAll(ArrayDATA_IDS);
	}
	
	public List<PageData> listReportPage(Page page)throws Exception{
		return studyMapper.reportPage(page);
	}
}

