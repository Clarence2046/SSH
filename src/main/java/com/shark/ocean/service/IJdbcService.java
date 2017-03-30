package com.shark.ocean.service;

import java.util.List;
import java.util.Map;

import com.shark.ocean.util.MenuUtil;

public interface IJdbcService {
	public List<MenuUtil> getAllMenus();

	public void saveRoleRights(String roleId, String[] rightIds);

	public List<Map<String, String>> getBySql(String sql);
	
	public List<MenuUtil>  getAllRoles();
	
	public void saveUserRoles(String userId,String[] roleIds);


}
