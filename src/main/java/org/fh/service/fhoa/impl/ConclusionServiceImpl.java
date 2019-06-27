package org.fh.service.fhoa.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.mapper.dsno1.fhoa.ConclusionMapper;
import org.fh.service.fhoa.ConclusionService;

/** 
 * 说明： 工作总结流程接口实现类
 * 作者：FH Admin Q313596790
 * 时间：2019-04-30
 * 官网：www.fhadmin.org
 * @version
 */
@Service
@Transactional //开启事物
public class ConclusionServiceImpl implements ConclusionService{

	@Autowired
	private ConclusionMapper conclusionMapper;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		conclusionMapper.save(pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		conclusionMapper.delete(pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		conclusionMapper.edit(pd);
	}
	
	public void editbyPIID(PageData pd)throws Exception{
		conclusionMapper.editbyPIID(pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception{
		return conclusionMapper.datalistPage(page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return conclusionMapper.listAll(pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return conclusionMapper.findById(pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		conclusionMapper.deleteAll(ArrayDATA_IDS);
	}
	
	public List<PageData> listReportPage(Page page)throws Exception{
		return conclusionMapper.reportPage(page);
	}
	
}

