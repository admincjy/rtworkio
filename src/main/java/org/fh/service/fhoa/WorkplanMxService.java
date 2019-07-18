package org.fh.service.fhoa;

import java.util.List;
import org.fh.entity.Page;
import org.fh.entity.PageData;

/** 
 * 说明： 工作计划流程(明细)接口
 * 作者：FH Admin 
 * @version
 */
public interface WorkplanMxService{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**未完成列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> listNoEnd(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	public PageData findTitleById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	/**查询明细总数
	 * @param pd
	 * @throws Exception
	 */
	public PageData findCount(PageData pd)throws Exception;
	
	public PageData findNoEndCount(PageData pd)throws Exception;
	
	public  void batchUpdate(List<PageData> pageDatas)throws Exception;
	
	
	public  List<PageData> selectIds(String[] ids)throws Exception;
	
	public  int insertBatch(List<PageData> pageDatas)throws Exception;

	public  String[] finddelNoEnd(String[] ids)throws Exception;
	
}

