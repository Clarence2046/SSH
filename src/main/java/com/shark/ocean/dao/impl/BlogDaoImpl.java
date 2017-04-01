package com.shark.ocean.dao.impl;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.shark.ocean.dao.IBlogDao;
import com.shark.ocean.model.Blog;

@Repository("blogDao")
public class BlogDaoImpl extends BaseDaoImpl<Blog> implements IBlogDao {

	private static final Object Blog = null;

	public void saveOrUpdateBlog(Blog blog) {
		Blob blob = getSession().getLobHelper().createBlob(blog.getContent());
		blog.setBlobContent(blob);
		getSession().saveOrUpdate(blog);
	}

	public Blog getBlog(Blog blog) {

		try {
			getSession().load(blog, blog.getId());
			Blob blobContent = blog.getBlobContent();

			byte[] bytes = blobContent.getBytes(1,
					Long.valueOf(blobContent.length()).intValue());
			blog.setContent(bytes);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return blog;
	}

	@Override
	protected List<Blog> decorate(List list) {
		List<Blog> blogs = new ArrayList<Blog>();
		try {
			for (Object o : list) {
				Blog b = (Blog) o;
				b.setContent(b.getBlobContent().getBytes(1,
						Long.valueOf(b.getBlobContent().length()).intValue()));
				blogs.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return blogs;
	}

}
