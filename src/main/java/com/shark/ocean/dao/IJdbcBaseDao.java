package com.shark.ocean.dao;

import java.util.List;
import java.util.Map;

import com.shark.ocean.util.MenuUtil;

public interface IJdbcBaseDao {
	public List<MenuUtil>  getAllMenus();
	
	public void saveRoleRights(String roleId,String[] rightIds);
	
	public List<MenuUtil>  getAllRoles();
	public void saveUserRoles(String userId,String[] roleIds);
	
	public List<Map<String,String>> getBySql(String sql);
	
	
	public void addLabel(String name);
	
	public void deleteLabel(Integer id);
	
	/**
	 * ���²�����Ϣ
	 * @param id  ����
	 * @param columns  �����ֶ�
	 * @param params  �ֶζ�Ӧ����
	 */
	public void updateBlog(Integer id,Object[] columns,Object[] params);
	
	
}
