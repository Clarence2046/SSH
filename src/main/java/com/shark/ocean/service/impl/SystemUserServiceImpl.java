package com.shark.ocean.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shark.ocean.dao.ISystemUser;
import com.shark.ocean.model.SystemUser;
import com.shark.ocean.service.ISystemUserService;

@Service("systemUserService")
public class SystemUserServiceImpl implements ISystemUserService {

	@Autowired
	private ISystemUser systemUserDao;

	public void add(SystemUser user) {
		systemUserDao.add(user);
	}

	public List<SystemUser> getAll() {
		return systemUserDao.getAll();
	}

	public void deleteById(Long id) {
		systemUserDao.deleteById(id);
	}

}
