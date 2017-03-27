package com.shark.ocean.service;

import java.util.List;

import com.shark.ocean.model.SystemUser;

public interface ISystemUserService {
	public void add(SystemUser user);

	public List<SystemUser> getAll();

	public void deleteById(Long id);
}
