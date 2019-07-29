package org.fh.service.financial.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.mapper.dsno1.financial.FinancialModelMapper;
import org.fh.service.financial.FinancialModelService;

/** 
 * 说明： 金融模型 接口实现类
 * 作者：FH Admin
 * 时间：2019-07-24
 *  ：www.fhadmin.org
 * @version
 */
@Service
@Transactional //开启事物
public class FinancialModelServiceImpl implements FinancialModelService{

	@Autowired
	private FinancialModelMapper financialmodelMapper;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		financialmodelMapper.save(pd);
	}

	public void savedataf(PageData pd)throws Exception{
		financialmodelMapper.savedataf(pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		financialmodelMapper.delete(pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		financialmodelMapper.edit(pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception{
		return financialmodelMapper.datalistPage(page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return financialmodelMapper.listAll(pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return financialmodelMapper.findById(pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		financialmodelMapper.deleteAll(ArrayDATA_IDS);
	}


	public PageData findDatabyDay(PageData pd)throws Exception{
		return financialmodelMapper.findDatabyDay(pd);
	}
}

