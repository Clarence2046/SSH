package com.shark.ocean.dao;

import java.io.Serializable;
import java.util.List;

import com.shark.ocean.model.Hemel;

public interface IHemel {
	public void add(Hemel hemel);

	public Hemel get(Serializable id);

	public List<Hemel> getAll();
}
