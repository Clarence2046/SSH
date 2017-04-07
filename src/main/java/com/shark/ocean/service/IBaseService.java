package com.shark.ocean.service;

import java.util.List;

public interface IBaseService<T> {
	public void add(T right);
	public void update(T right);
	public List<T> getAll();

	public void delete(T entity);

	public List<T> getByField(String fieldName, Object fieldValue);
	
	public List<T> getByField(String fieldName, Object fieldValue,String[] orderBy,boolean[] descs);
}
