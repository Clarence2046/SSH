package com.shark.ocean.dao;

import java.util.List;

public interface IBaseDao<T> {
	public void add(T entity);

	public void update(T entity);
	
	public List<T> getAll();

	public List<T> getByField(String fieldName, Object fieldValue);
	public List<T> getByField(String fieldName, Object fieldValue,String[] orderBy,boolean[] descs);

	public void delete(T entity);
}
