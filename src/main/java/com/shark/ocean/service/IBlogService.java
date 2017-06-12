package com.shark.ocean.service;

import java.util.List;

import com.shark.ocean.model.Blog;

public interface IBlogService {
	public void add(Blog entity);

	public void update(Blog entity);
	
	public List<Blog> getAll();
	
	/**
	 * 获取最新的几篇文章
	 * num >0 时才查询具体几条，否则查询所有
	 * @return
	 */
	public List<Blog> getRecentBlogs(int num);

	public List<Blog> getByField(String fieldName, Object fieldValue);

	public void delete(Blog entity);
	
	void saveOrUpdateBlog(Blog blog);
	Blog getBlog(Blog blog);
}
