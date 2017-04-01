package com.shark.ocean.dao;

import com.shark.ocean.model.Blog;

public interface IBlogDao extends IBaseDao<Blog> {
	
	void saveOrUpdateBlog(Blog blog);
	
	Blog getBlog(Blog blog);
}
