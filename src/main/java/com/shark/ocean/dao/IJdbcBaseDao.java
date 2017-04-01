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
	 * 更新博客信息
	 * @param id  主键
	 * @param columns  更新字段
	 * @param params  字段对应参数
	 */
	public void updateBlog(Integer id,Object[] columns,Object[] params);
	
	
}
