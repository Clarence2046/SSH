package com.shark.ocean.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shark.ocean.dao.IBlogDao;
import com.shark.ocean.model.Blog;
import com.shark.ocean.service.IBlogService;

@Service("blogService")
public class BlogServiceImpl implements IBlogService {

	@Autowired
	private IBlogDao  blogDao;
	
	public void add(Blog entity) {
		blogDao.add(entity);
	}

	public void update(Blog entity) {
		blogDao.update(entity);
	}

	public List<Blog> getAll() {
		return blogDao.getAll();
	}

	public List<Blog> getByField(String fieldName, Object fieldValue) {
		return blogDao.getByField(fieldName, fieldValue);
	}

	public void delete(Blog entity) {
		blogDao.delete(entity);
	}

	public void saveOrUpdateBlog(Blog blog) {
		blogDao.saveOrUpdateBlog(blog);
	}

	public Blog getBlog(Blog blog) {
		return blogDao.getBlog(blog);
	}

}
