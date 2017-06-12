package com.shark.ocean.dao;

import java.util.List;

import com.shark.ocean.model.Blog;

public interface IBlogDao extends IBaseDao<Blog> {
	
	void saveOrUpdateBlog(Blog blog);
	
	Blog getBlog(Blog blog);
	/**
	 * ��ȡ���µļ�ƪ����
	 * @return
	 */
	List<Blog> getRecentBlogs(int num);
}
