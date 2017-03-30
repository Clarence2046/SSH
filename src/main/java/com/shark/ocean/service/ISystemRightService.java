package com.shark.ocean.service;

import java.util.List;

import com.shark.ocean.model.SystemRight;

public interface ISystemRightService {
	public void add(SystemRight right);

	public void update(SystemRight right);
	
	public List<SystemRight> getAll();

	public void delete(SystemRight entity);

	public List<SystemRight> getByField(String fieldName, Object fieldValue);
}
