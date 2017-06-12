package com.shark.ocean.service;

import java.util.List;

import com.shark.ocean.model.Blog;

public interface IBlogService {
	public void add(Blog entity);

	public void update(Blog entity);
	
	public List<Blog> getAll();
	
	/**
	 * ��ȡ���µļ�ƪ����
	 * num >0 ʱ�Ų�ѯ���弸���������ѯ����
	 * @return
	 */
	public List<Blog> getRecentBlogs(int num);

	public List<Blog> getByField(String fieldName, Object fieldValue);

	public void delete(Blog entity);
	
	void saveOrUpdateBlog(Blog blog);
	Blog getBlog(Blog blog);
}
