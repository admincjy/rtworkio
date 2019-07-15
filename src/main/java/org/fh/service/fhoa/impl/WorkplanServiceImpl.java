package org.fh.service.fhoa.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.mapper.dsno1.fhoa.WorkplanMapper;
import org.fh.service.fhoa.WorkplanService;

/** 
 * 说明： 工作计划流程接口实现类
 * 作者：FH Admin Q313596790
 * 时间：2019-05-05
 *  ：www.fhadmin.org
 * @version
 */
@Service
@Transactional //开启事物
public class WorkplanServiceImpl implements WorkplanService{

	@Autowired
	private WorkplanMapper workplanMapper;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		workplanMapper.save(pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		workplanMapper.delete(pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		workplanMapper.edit(pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception{
		return workplanMapper.datalistPage(page);
	}
	
	public List<PageData> listReportPage(Page page)throws Exception{
		return workplanMapper.reportPage(page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return workplanMapper.listAll(pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return workplanMapper.findById(pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		workplanMapper.deleteAll(ArrayDATA_IDS);
	}
	
}

