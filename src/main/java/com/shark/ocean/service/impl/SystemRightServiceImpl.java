package com.shark.ocean.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shark.ocean.dao.ISystemRight;
import com.shark.ocean.model.SystemRight;
import com.shark.ocean.service.ISystemRightService;

@Service("systemRightService")
public class SystemRightServiceImpl implements ISystemRightService {

	@Autowired
	private ISystemRight systemRightDao;

	public void add(SystemRight right) {
		systemRightDao.add(right);

	}

	public List<SystemRight> getAll() {
		return systemRightDao.getAll();
	}

	public void delete(SystemRight entity) {
		systemRightDao.delete(entity);
	}

	public List<SystemRight> getByField(String fieldName, Object fieldValue) {
		return systemRightDao.getByField(fieldName, fieldValue);
	}

	public void update(SystemRight right) {
		systemRightDao.update(right);
	}

}
