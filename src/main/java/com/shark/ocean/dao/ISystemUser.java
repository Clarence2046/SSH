package com.shark.ocean.dao;

import java.io.Serializable;
import java.util.List;

import com.shark.ocean.model.SystemUser;

public interface ISystemUser {
	public void add(SystemUser user);
	
	
	public List<SystemUser> getAll();
	
	public void deleteById(Long id);
}
