package com.shark.ocean.service;

import java.util.List;
import java.util.Map;

import com.shark.ocean.util.MenuUtil;

public interface IJdbcService {
	public List<MenuUtil> getAllMenus();

	public void saveRoleRights(String roleId, String[] rightIds);

	public List<Map<String, Object>> getBySql(String sql);

	public List<MenuUtil> getAllRoles();

	public void saveUserRoles(String userId, String[] roleIds);

	public void addLabel(String name);

	public void deleteLabel(Integer id);
	
	public void updateBlog(Long id,Object[] columns,Object[] params);
}
