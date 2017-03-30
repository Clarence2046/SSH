package com.shark.ocean.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shark.ocean.dao.IRole;
import com.shark.ocean.model.Role;
import com.shark.ocean.service.IRoleService;

@Service("roleService")
public class RoleServiceImpl implements IRoleService {

	@Autowired
	private IRole roleDao;

	public void add(Role entity) {
		roleDao.add(entity);
	}

	public void update(Role entity) {
		roleDao.update(entity);

	}

	public List<Role> getAll() {

		return roleDao.getAll();
	}

	public void delete(Role entity) {
		roleDao.delete(entity);

	}

	public List<Role> getByField(String fieldName, Object fieldValue) {

		return roleDao.getByField(fieldName, fieldValue);
	}
}
