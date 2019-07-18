package org.fh.service.system.impl;

import org.fh.service.system.UsersService;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.fh.entity.Page;
import org.fh.entity.PageData;
import org.fh.entity.system.User;
import org.fh.mapper.dsno1.system.RoleMapper;
import org.fh.mapper.dsno1.system.UsersMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 说明：用户服务接口实现类
 * 作者：FH Admin Q313596790
 *  ：www.fhadmin.org
 */
@Service
@Transactional //开启事物
public class UsersServiceImpl implements UsersService {
	
	@Autowired
	private UsersMapper usersMapper;
	
	@Autowired
	private RoleMapper roleMapper;
	
	/**通过用户名获取用户信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByUsername(PageData pd) throws Exception {
		return	usersMapper.findByUsername(pd);
	}
	
	/**通过用户ID获取用户信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return	usersMapper.findById(pd);
	}

	/**用户列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> userlistPage(Page page) throws Exception {
		return	usersMapper.userlistPage(page);
	}
	
	/**通过用户ID获取用户信息和角色信息
	 * @param USER_ID
	 * @return
	 * @throws Exception
	 */
	public User getUserAndRoleById(String USER_ID) throws Exception {
		return	usersMapper.getUserAndRoleById(USER_ID);
	}

	/**保存用户IP
	 * @param pd
	 * @throws Exception
	 */
	public void saveIP(PageData pd) throws Exception {
		usersMapper.saveIP(pd);
	}

	/**通过邮箱获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByEmail(PageData pd) throws Exception {
		return usersMapper.findByEmail(pd);
	}
	
	/**通过编码获取数据
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findByNumbe(PageData pd) throws Exception {
		return usersMapper.findByNumbe(pd);
	}
	
	/**列出某角色下的所有用户
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllUserByRoldId(PageData pd) throws Exception{
		return usersMapper.listAllUserByRoldId(pd);
	}
	
	/**用户列表(全部)
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listAllUser(PageData pd)throws Exception{
		return usersMapper.listAllUser(pd);
	}

	/**用户列表(弹窗选择用)
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listUsersBystaff(Page page)throws Exception{
		return usersMapper.userBystafflistPage(page);
	}
	
	/**保存用户
	 * @param pd
	 * @throws Exception
	 */
	public void saveUser(PageData pd)throws Exception {
		usersMapper.saveUser(pd);
	}
	
	/**保存用户系统皮肤
	 * @param pd
	 * @throws Exception
	 */
	public void saveSkin(PageData pd)throws Exception{
		usersMapper.saveSkin(pd);
	}
	
	/**修改用户
	 * @param pd
	 * @throws Exception
	 */
	public void editUser(PageData pd)throws Exception{
		usersMapper.editUser(pd);
	}

	/**删除用户
	 * @param pd
	 * @throws Exception
	 */
	public void deleteUser(PageData pd)throws Exception{
		usersMapper.deleteUser(pd);
	}
	
	/**批量删除用户
	 * @param
	 * @throws Exception
	 */
	public void deleteAllUser(String[] USER_IDS)throws Exception{
		usersMapper.deleteAllUser(USER_IDS);
	}
	
	/*
	 * 通过用户名或者角色编码查询真实姓名
	 */
	public String selectNames(String ASSIGNEE)throws Exception{
		Pattern p = Pattern.compile("[0-9]");
        Matcher m = p.matcher(ASSIGNEE);
		PageData pdData=new PageData();
		String pdName="";
		if (m.find()) {
			pdData.put("RNUMBER", ASSIGNEE);
			PageData pdRole=roleMapper.getRoleByRnumber(pdData);
			List<PageData> pdNames=usersMapper.listAllUserByRoldId(pdRole);
			for(PageData pData:pdNames) {
				if (pdName=="") {
					pdName=pData.getString("NAME");
				}else {
					pdName+=","+pData.getString("NAME");
				}
			}
		} else {
			pdData.put("USERNAME", ASSIGNEE);
			PageData pdNames=usersMapper.findByUsername(pdData);
			    pdName=pdNames.getString("NAME");
        }
		return pdName;
	}
	
}
