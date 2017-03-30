package com.shark.ocean.dao;

import java.util.List;

import com.shark.ocean.model.SystemUser;

public interface ISystemUser {
	public void add(SystemUser user);
	
	
	public List<SystemUser> getAll();
	
	public List<SystemUser> getByField(String fieldName,Object fieldValue);
	
	public void deleteById(Long id);
}
