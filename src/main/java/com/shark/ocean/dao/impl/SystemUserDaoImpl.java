package com.shark.ocean.dao.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
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

	public SystemUser getByUsername(String username) {
		Session session = getSessionFactory().getCurrentSession();
		Criteria criteria = session.createCriteria(SystemUser.class);
		criteria.add(Expression.like("username","'" +username+"'"));
		List list = criteria.list();
		if(list!=null && list.size()>0){
			return (SystemUser) list.get(0);
		}
		return null;
	}


	public List<SystemUser> getByField(String fieldName, Object fieldValue) {
		Session session = getSessionFactory().getCurrentSession();
		Criteria criteria = session.createCriteria(SystemUser.class);
		criteria = criteria.add(Expression.like(fieldName,fieldValue));
		List list = criteria.list();
		System.out.println(list);
		return list;
	}

}
