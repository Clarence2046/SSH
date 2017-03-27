package com.shark.ocean.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shark.ocean.model.Hemel;

@Repository("hemelDao")
public class HemelDao implements IHemel {

	@Autowired
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public void add(Hemel hemel) {
		sessionFactory.getCurrentSession().save(hemel);
	}

	public Hemel get(Serializable id) {
		Hemel hemel = (Hemel) sessionFactory.getCurrentSession().get(Hemel.class, id);
		return hemel;
	}

	public List<Hemel> getAll() {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(Hemel.class);
		List list = criteria.list();
		return list;
	}
}
