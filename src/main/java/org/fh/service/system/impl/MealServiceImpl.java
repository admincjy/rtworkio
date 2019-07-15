package org.fh.service.system.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.mapper.dsno1.system.MealMapper;
import org.fh.service.system.MealService;

/** 
 * 说明： 订餐表接口实现类
 * 作者：FH Admin Q313596790
 * 时间：2019-04-09
 *  ：www.fhadmin.org
 * @version
 */
@Service
@Transactional //开启事物
public class MealServiceImpl implements MealService{

	@Autowired
	private MealMapper mealMapper;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		mealMapper.save(pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		mealMapper.delete(pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		mealMapper.edit(pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception{
		return mealMapper.datalistPage(page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return mealMapper.listAll(pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return mealMapper.findById(pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		mealMapper.deleteAll(ArrayDATA_IDS);
	}
    
	
	/**通过userid获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findByUserId(PageData pd)throws Exception{
		return mealMapper.findByUserId(pd);
	}
}

