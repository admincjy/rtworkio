package org.fh.mapper.dsno1.act;

import java.util.List;

import org.fh.entity.Page;
import org.fh.entity.PageData;

/** 
 * 说明： 正在运行的流程Mapper
 * 作者：FH Admin 
 * @version
 */
public interface RuprocdefMapper {
	
	/**待办任务 or正在运行任务列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> datalistPage(Page page)throws Exception;
	
	/**流程变量列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> varList(PageData pd)throws Exception;
	
	/**历史任务节点列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> hiTaskList(PageData pd)throws Exception;
	
	/**已办任务列表列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> hitaskdatalistPage(Page page)throws Exception;
	
	/**激活or挂起任务(指定某个任务)
	 * @param pd
	 * @throws Exception
	 */
	public void onoffTask(PageData pd)throws Exception;
	
	/**激活or挂起任务(指定某个流程的所有任务)
	 * @param pd
	 * @throws Exception
	 */
	public void onoffAllTask(PageData pd)throws Exception;
	
	
	public List<PageData> selectByPIId(PageData pd)throws Exception;

	public PageData selectTaskID(PageData pd)throws Exception;

	public PageData selectToName(PageData pd)throws Exception;

	public PageData selectEndTime(PageData pd)throws Exception;

	public PageData selectState(PageData pd)throws Exception;

	public PageData selectOpinpons(PageData pd)throws Exception;
}
