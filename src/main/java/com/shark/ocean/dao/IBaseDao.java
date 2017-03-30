package com.shark.ocean.dao;

import java.util.List;

public interface IBaseDao<T> {
	public void add(T entity);

	public void update(T entity);
	
	public List<T> getAll();

	public List<T> getByField(String fieldName, Object fieldValue);

	public void delete(T entity);
}
