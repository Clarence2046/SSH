package com.shark.ocean.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shark.ocean.dao.IBaseDao;
import com.shark.ocean.service.IBaseService;

@Service("baseService")
public class BaseServiceImpl<T> implements IBaseService<T> {
	
	@Autowired
	private IBaseDao<T>  baseDao;

	public void add(T entity) {
		baseDao.add(entity);
	}

	public List<T> getAll() {
		
		return baseDao.getAll();
	}

	public void delete(T entity) {
		
		baseDao.delete(entity);
	}

	public List<T> getByField(String fieldName, Object fieldValue) {
		
		return baseDao.getByField(fieldName, fieldValue);
	}

	public void update(T entity) {
		baseDao.update(entity);
	}

}
