package com.shark.ocean.service;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shark.ocean.model.Hemel;

@Service("hemelService")
public class HemelService implements IHemel{

	@Autowired
	private com.shark.ocean.dao.IHemel hemelDao;

	public HemelService() {
		System.out.println("Service instantial...");
		System.out.println("Injection of HemelDao: " + hemelDao);

	}

	public void add(Hemel hemel) {
		hemelDao.add(hemel);
	}

	public Hemel get(Serializable id) {
		Hemel hemel = hemelDao.get(id);
		return hemel;
	}

	public List<Hemel> getAll() {
		List<Hemel> hemel = hemelDao.getAll();
		return hemel;
	}
}
