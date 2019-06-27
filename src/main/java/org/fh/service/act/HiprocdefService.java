package org.fh.service.act;

import java.util.List;

import org.fh.entity.Page;
import org.fh.entity.PageData;

/** 
 * 说明： 历史流程任务接口
 * 创建人：FH 
 * 官网：
 */
public interface HiprocdefService {
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**历史流程变量列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> hivarList(PageData pd)throws Exception;
	
	public PageData selectToName(String PROC_INST_ID_)throws Exception;

	
}
