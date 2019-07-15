package org.fh.mapper.dsno1.act;

import java.util.List;

import org.fh.entity.Page;
import org.fh.entity.PageData;

/** 
 * 说明： 流程管理Mapper
 * 作者：FH Admin 
 * @version
 */
public interface ProcdefMapper{
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	List<PageData> datalistPage(Page page);
	
}

