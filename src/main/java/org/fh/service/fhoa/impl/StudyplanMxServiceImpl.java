package org.fh.service.fhoa.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.mapper.dsno1.fhoa.StudyplanMxMapper;
import org.fh.service.fhoa.StudyplanMxService;

/** 
 * 说明： 学习计划流程(明细)接口实现类
 * 作者：FH Admin Q313596790
 * 时间：2019-05-05
 *  ：www.fhadmin.org
 * @version
 */
@Service
@Transactional //开启事物
public class StudyplanMxServiceImpl implements StudyplanMxService{

	@Autowired
	private StudyplanMxMapper studyplanmxMapper;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		studyplanmxMapper.save(pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		studyplanmxMapper.delete(pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		studyplanmxMapper.edit(pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception{
		return studyplanmxMapper.datalistPage(page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return studyplanmxMapper.listAll(pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return studyplanmxMapper.findById(pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		studyplanmxMapper.deleteAll(ArrayDATA_IDS);
	}
	
	/**查询明细总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData findCount(PageData pd)throws Exception{
		return studyplanmxMapper.findCount(pd);
	}
	
	
	public void batchUpdate(List<PageData> pageDatas)throws Exception{
		studyplanmxMapper.batchUpdate(pageDatas);
	}

    public int sumByMId(PageData pd)throws Exception{
        return studyplanmxMapper.sumByMId(pd);
    }

    public List<PageData> findByName(PageData pd)throws Exception{
        return studyplanmxMapper.findByName(pd);
    }
}

