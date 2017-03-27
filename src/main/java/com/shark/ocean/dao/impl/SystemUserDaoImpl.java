package com.shark.ocean.dao.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.shark.ocean.dao.ISystemUser;
import com.shark.ocean.model.SystemUser;

@Repository("systemUserDao")
public class SystemUserDaoImpl extends BaseDaoImpl implements ISystemUser {

	public void add(SystemUser user) {
		getSessionFactory().getCurrentSession().save(user);
	}

	public List<SystemUser> getAll() {
		Session session = getSessionFactory().getCurrentSession();
		Criteria criteria = session.createCriteria(SystemUser.class);
		List list = criteria.list();
		return list;
	}

	public void deleteById(Long id) {
		SystemUser systemUser = new SystemUser();
		systemUser.setId(id);
		getSessionFactory().getCurrentSession().delete(systemUser);

	}

}
