package org.fh.service.fhoa.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.mapper.dsno1.fhoa.WorkplanMxMapper;
import org.fh.service.fhoa.WorkplanMxService;

/** 
 * 说明： 工作计划流程(明细)接口实现类
 * 作者：FH Admin 
 * 时间：2019-05-05
 * 官网：www.fhadmin.org
 * @version
 */
@Service
@Transactional //开启事物
public class WorkplanMxServiceImpl implements WorkplanMxService{

	@Autowired
	private WorkplanMxMapper workplanmxMapper;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		workplanmxMapper.save(pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		workplanmxMapper.delete(pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		workplanmxMapper.edit(pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception{
		return workplanmxMapper.datalistPage(page);
	}
	
	/**未完成列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listNoEnd(Page page)throws Exception{
		List<PageData> pageDatas=workplanmxMapper.datalistNoEndPage(page);
		for(int i=0;i<pageDatas.size();i++) {
			if(i>0) {
				if (pageDatas.get(i).get("BASE_WORKPLAN_ID").equals(pageDatas.get(i-1).get("BASE_WORKPLAN_ID"))) {
					pageDatas.remove(pageDatas.get(i));
				}
			}
		}
		return workplanmxMapper.datalistNoEndPage(page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return workplanmxMapper.listAll(pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return workplanmxMapper.findById(pd);
	}
	
	
	public PageData findTitleById(PageData pd)throws Exception{
		return workplanmxMapper.findTitleById(pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		workplanmxMapper.deleteAll(ArrayDATA_IDS);
	}
	
	/**查询明细总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData findCount(PageData pd)throws Exception{
		return workplanmxMapper.findCount(pd);
	}
	
	public PageData findNoEndCount(PageData pd)throws Exception{
		return workplanmxMapper.findNoEndCount(pd);
	}
	
	public void batchUpdate(List<PageData> pageDatas)throws Exception{
		workplanmxMapper.batchUpdate(pageDatas);
	}
	
	public List<PageData> selectIds(String[] ids)throws Exception{
		return workplanmxMapper.selectIds(ids);
	}
	
	public int insertBatch(List<PageData> pageDatas)throws Exception{
		return workplanmxMapper.insertBatch(pageDatas);
	}
	
}

