package org.fh.mapper.dsno1.${packageName};

import java.util.List;
import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.entity.${packageName}.${objectName};

/** 
 * 说明： ${TITLE}Mapper
 * 时间：${nowDate?string("yyyy-MM-dd")}
 * @version
 */
public interface ${objectName}Mapper{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	void save(PageData pd);
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	void delete(PageData pd);
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	void edit(PageData pd);
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	List<PageData> datalistPage(Page page);
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	List<PageData> listAll(PageData pd);
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	PageData findById(PageData pd);
	
	/**
	 * 通过ID获取其子级列表
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	List<${objectName}> listByParentId(String parentId);
	
}

