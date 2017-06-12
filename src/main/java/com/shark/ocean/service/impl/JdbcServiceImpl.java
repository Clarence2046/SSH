package com.shark.ocean.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shark.ocean.dao.IJdbcBaseDao;
import com.shark.ocean.service.IJdbcService;
import com.shark.ocean.util.MenuUtil;

@Service("jdbcService")
public class JdbcServiceImpl implements IJdbcService {

	@Autowired
	private IJdbcBaseDao jdbcDao;
	
	public List<MenuUtil> getAllMenus() {
		return jdbcDao.getAllMenus();
	}

	public void saveRoleRights(String roleId, String[] rightIds) {
		jdbcDao.saveRoleRights(roleId, rightIds);
	}

	public List<Map<String, Object>> getBySql(String sql) {
		return jdbcDao.getBySql(sql);
	}

	public void saveUserRoles(String userId, String[] roleIds) {
		jdbcDao.saveUserRoles(userId, roleIds);
	}

	public List<MenuUtil> getAllRoles() {
		return jdbcDao.getAllRoles();
	}

	public void addLabel(String name) {
		jdbcDao.addLabel(name);
	}

	public void deleteLabel(Integer id) {
		jdbcDao.deleteLabel(id);
	}

	public void updateBlog(Long id, Object[] columns, Object[] params) {
		jdbcDao.updateBlog(id, columns, params);
	}

}
