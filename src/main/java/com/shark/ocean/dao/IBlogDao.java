package com.shark.ocean.dao;

import java.util.List;

import com.shark.ocean.model.Blog;

public interface IBlogDao extends IBaseDao<Blog> {
	
	void saveOrUpdateBlog(Blog blog);
	
	Blog getBlog(Blog blog);
	/**
	 * 获取最新的几篇文章
	 * @return
	 */
	List<Blog> getRecentBlogs(int num);
}
