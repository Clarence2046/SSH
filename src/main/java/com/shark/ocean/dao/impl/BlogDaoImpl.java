package com.shark.ocean.dao.impl;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.ObjectNotFoundException;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.expression.Expression;
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

		} catch(ObjectNotFoundException on){
			System.out.println("没有找到对应的记录");
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

	public List<Blog> getRecentBlogs(int num) {
		Criteria criteria = getSession().createCriteria(entityName);
		criteria.add(Restrictions.eq("visible", 0));
		criteria.addOrder(Order.desc("createDate"));
		if(num>0){
			criteria.setMaxResults(num);
		}
		List list = criteria.list();
		return this.decorate(list);
	}

}
