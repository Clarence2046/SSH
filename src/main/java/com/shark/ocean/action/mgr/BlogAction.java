package com.shark.ocean.action.mgr;

import java.io.InputStream;
import java.io.Reader;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.type.BlobType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.model.Blog;
import com.shark.ocean.service.IBlogService;
import com.shark.ocean.service.impl.JdbcServiceImpl;
import com.shark.ocean.util.PageUtil;

@ParentPackage("json-default")
public class BlogAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4992708782889102001L;

	@Autowired
	private IBlogService blogService;

	private Blog entity;

	public Blog getEntity() {
		return entity;
	}

	public void setEntity(Blog entity) {
		this.entity = entity;
	}

	@Action(value = "/app/mgr/blog/list", results = { @Result(name = SUCCESS, location = "/app/mgr/blog/blog-list.jsp") })
	public String blogList() {
		List<Blog> all = blogService.getAll();
		PageUtil  page = new PageUtil(all, pageRequest.getPageSize(), pageRequest.getPage(), all.size());
		request.setAttribute("result", page);
		return SUCCESS;
	}

	@Action(value = "/app/mgr/blog/addpage", results = { @Result(name = SUCCESS, location = "/app/mgr/blog/blog-add.jsp") })
	public String goAddBlog() {
		//查询所有标签
		List<Map<String, String>> labels = jdbcService.getBySql("select * from ocean_label");
		request.setAttribute("labels", labels);
		
		
		return SUCCESS;
	}
	@Action(value = "/app/mgr/blog/editpage", results = { @Result(name = SUCCESS, location = "/app/mgr/blog/blog-edit.jsp") })
	public String goEditBlog() {
		Blog blog = blogService.getBlog(entity);
		request.setAttribute("blog", blog);
		//查询所有标签
		List<Map<String, String>> labels = jdbcService.getBySql("select * from ocean_label");
		request.setAttribute("labels", labels);
		return SUCCESS;
	}
	
	@Action(value = "/app/mgr/blog/update", results = { @Result(name = SUCCESS, type = "json", params = {
			"root", "result" }) })
	public String updateBlog() {
		try {
			String content = request.getParameter("content");
			String title = entity.getTitle();
			String subTitle = entity.getSubTitle();
			String description = entity.getDescription();
			String labels = entity.getLabels();
			
			byte[] bytes = content.getBytes();
			Blog blog = blogService.getBlog(entity);
			
			System.out.println("查询到的信息："+blog);
			
			blog.setTitle(title);
			blog.setSubTitle(subTitle);
			blog.setContent(bytes);
			blog.setModifyDate(new Date());
			blog.setDescription(description);
			blog.setLabels(labels);
			
			blogService.saveOrUpdateBlog(blog);
			
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	@Action(value = "/app/mgr/blog/updatevisible", results = { @Result(name = SUCCESS, type = "json", params = {
			"root", "result" }) })
	public String updateVisible() {
		try {
			String id = request.getParameter("id");
			String visible = request.getParameter("visible");
			jdbcService.updateBlog(Long.valueOf(id),new String[] { "visible" }, new String[] { visible });
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	@Action(value = "/app/mgr/blog/updatelock", results = { @Result(name = SUCCESS, type = "json", params = {
			"root", "result" }) })
	public String updateLock() {
		try {
			String id = request.getParameter("id");
			String lock = request.getParameter("lock");
			jdbcService.updateBlog(Long.valueOf(id),new Object[] { "lockComment" }, new Object[] { lock });
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(value = "/app/mgr/blog/add", results = { @Result(name = SUCCESS, type = "json", params = {
			"root", "result" }) })
	public String addBlog() {
		try {
			String content = request.getParameter("content");
			entity.setCreateDate(new Date());
			entity.setVisible(0);
			entity.setLockComment(0);
			
			byte[] bcontent = content.getBytes();
			entity.setContent(bcontent);
			entity.setAuthor(request.getSession().getAttribute("LOGIN_USERNAME").toString());
			
			blogService.saveOrUpdateBlog(entity);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	@Action(value = "/app/mgr/blog/delete", results = { @Result(name = SUCCESS,type="json", params={"root","result"})})
	public String deleteBlog() {
		try {
			blogService.delete(entity);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	
	/**
	 * *********************************************************************
	 *  标签管理
	 * *********************************************************************
	 */
	
	@Action(value = "/app/mgr/blog/labelpage", results = { @Result(name = SUCCESS, location = "/app/mgr/blog/label-list.jsp") })
	public String labelList() {
		List<Map<String, String>> labels = jdbcService.getBySql("select * from ocean_label");
		request.setAttribute("labels", labels);
		return SUCCESS;
	}
	@Action(value = "/app/mgr/blog/labeladd", results = { @Result(name = SUCCESS,type="json", params={"root","result"})})
	public String addLabel() {
		try {
			String name = request.getParameter("labelName");
			jdbcService.addLabel(name  );
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	@Action(value = "/app/mgr/blog/labeldelete", results = { @Result(name = SUCCESS,type="json", params={"root","result"})})
	public String deleteLabel() {
		try {
			String id = request.getParameter("labelId");
			if(StringUtils.isEmpty(id)){
				return SUCCESS;
			}
			jdbcService.deleteLabel(Integer.valueOf(id));
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	

}
