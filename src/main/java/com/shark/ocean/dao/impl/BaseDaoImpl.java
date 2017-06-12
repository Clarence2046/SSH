package com.shark.ocean.dao.impl;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shark.ocean.dao.IBaseDao;

@Repository("baseDao")
public class BaseDaoImpl<T> implements IBaseDao<T> {

	@Autowired
	private SessionFactory sessionFactory;

	private Class<T> entityClass;

	protected String entityName;

	@SuppressWarnings("unchecked")
	public BaseDaoImpl() {
		Type type = this.getClass().getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			ParameterizedType pt = (ParameterizedType) type;
			this.entityClass = (Class<T>) pt.getActualTypeArguments()[0];
			this.entityName = entityClass.getName();
		}

	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public Session getSession() {
		return this.sessionFactory.getCurrentSession();
	}

	public void add(T entity) {
		getSession().save(entityClass.getSimpleName(), entity);
	}

	public List<T> getAll() {
		Criteria criteria = getSession().createCriteria(entityName);
		List list = criteria.list();
		return decorate(list);
	}

	protected List<T> decorate(List list) {
		return list;
	}

	public List<T> getByField(String fieldName, Object fieldValue) {
		Session session = getSessionFactory().getCurrentSession();
		Criteria criteria = session.createCriteria(entityName);

		// 获取当前实体，当前字段类型？ 怎么获取？
		try {
			Field field = entityClass.getDeclaredField(fieldName);
			Class<?> type = field.getType();
			System.out.println(type.getSimpleName());
			if (StringUtils.isNoneEmpty(fieldValue.toString())) {
				if ("Long".equals(type.getSimpleName())) {
					criteria = criteria.add(Expression.eq(fieldName,
							Long.valueOf(fieldValue.toString())));

				}else if ( "Integer".equals(type.getSimpleName())) {
					criteria = criteria.add(Expression.eq(fieldName,
							Integer.valueOf(fieldValue.toString())));

				}  else {
					criteria = criteria.add(Expression.like(fieldName,
							fieldValue.toString()));
				}
			}
			
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		}

		List list = criteria.list();
		return decorate(list);
	}
	
	public List<T> getByField(String fieldName, Object fieldValue,
			String[] orderBy, boolean[] descs) {
		Session session = getSessionFactory().getCurrentSession();
		Criteria criteria = session.createCriteria(entityName);

		// 获取当前实体，当前字段类型？ 怎么获取？
		try {
			Field field = entityClass.getDeclaredField(fieldName);
			Class<?> type = field.getType();
			System.out.println(type.getSimpleName());
			if (StringUtils.isNoneEmpty(fieldValue.toString())) {
				if ("Long".equals(type.getSimpleName())
						|| "Integer".equals(type.getSimpleName())) {
					criteria = criteria.add(Expression.eq(fieldName,
							Long.valueOf(fieldValue.toString())));

				} else {
					criteria = criteria.add(Expression.like(fieldName,
							fieldValue.toString()));
				}
			}
			if(orderBy!=null && orderBy.length>0){
				for (int i = 0; i < orderBy.length; i++) {
					String orderByField = orderBy[i];
					boolean desc = descs[i];
					if(desc){
						criteria.addOrder(Order.desc(orderByField));
					}else{
						criteria.addOrder(Order.asc(orderByField));
					}
				}
			}
			
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		}

		List list = criteria.list();
		return decorate(list);
	}

	public void delete(T entity) {
		getSession().delete(entity);
	}

	public void update(T entity) {
		try {
			getSession().update(entityClass.getSimpleName(), entity);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
}
