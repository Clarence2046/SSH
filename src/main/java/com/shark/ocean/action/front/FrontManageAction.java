package com.shark.ocean.action.front;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.model.Blog;
import com.shark.ocean.model.Comment;
import com.shark.ocean.service.IBlogService;
import com.shark.ocean.service.ICommentService;
import com.shark.ocean.util.PageUtil;

@ParentPackage("json-default")
public class FrontManageAction extends BaseAction{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 776655375044516411L;

	@Autowired
	private IBlogService blogService;
	
	@Action(value="/app/front/index",results={@Result(name=SUCCESS,location="/app/front/index.jsp")})
	public String index(){
		List<Blog> all = blogService.getByField("visible", 0);
		request.setAttribute("blogs", all);
		return SUCCESS;
	}
	
	@Action(value="/app/front/list",results={@Result(name=SUCCESS,location="/app/front/list.jsp")})
	public String listByLabel(){
		try {
			String labelName = request.getParameter("labelName");
			labelName = new String(labelName.getBytes("ISO-8859-1"),"utf-8");
			List<Map<String,String>> list = jdbcService.getBySql("select id , title,createdate from ocean_blog where labels like '%"+labelName+"%' and visible=0 ");
			
			PageUtil page = new PageUtil(list, pageRequest.getPageSize(), pageRequest.getPage(), list.size());
			request.setAttribute("page", page);
			request.setAttribute("labelName", labelName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	@Action(value="/app/front/listbyauthor",results={@Result(name=SUCCESS,location="/app/front/list.jsp")})
	public String listByAuthor(){
		try {
			String author = request.getParameter("author");
			author = new String(author.getBytes("ISO-8859-1"),"utf-8");
			List<Map<String,String>> list = jdbcService.getBySql("select id , title,createdate from ocean_blog where author like '"+author+"' and visible=0 ");
			
			PageUtil page = new PageUtil(list, pageRequest.getPageSize(), pageRequest.getPage(), list.size());
			request.setAttribute("page", page);
			request.setAttribute("listdescription", author);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	@Action(value="/app/front/listall",results={@Result(name=SUCCESS,location="/app/front/list.jsp")})
	public String listAll(){
		try {
			List<Map<String,String>> list = jdbcService.getBySql("select id , title,createdate from ocean_blog where  visible=0 ");
			PageUtil page = new PageUtil(list, pageRequest.getPageSize(), pageRequest.getPage(), list.size());
			request.setAttribute("page", page);
			request.setAttribute("listdescription", "所有文章");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	@Action(value="/app/front/blog",results={@Result(name=SUCCESS,location="/app/front/detail.jsp")})
	public String blogDetail(){
		String id = request.getParameter("id");
		Blog blog = new Blog();
		blog.setId(Long.valueOf(id));
		blog = blogService.getBlog(blog);
		if(blog.getVisible()==1){
			blog = new Blog();
		}
		request.setAttribute("blog", blog);
		Integer views = blog.getViews();
		if(views==null){
			views = 0;
			blog.setViews(views);
		}
		views++;
		//更新查看次数
		jdbcService.updateBlog(Long.valueOf(id), new String[]{"views"}, new Object[]{views});
		
		return SUCCESS;
	}
	
	@Autowired
	private ICommentService commentService;
	
	private Comment comment;
	
	public Comment getComment() {
		return comment;
	}
	public void setComment(Comment comment) {
		this.comment = comment;
	}
	@Action(value="/app/front/comment",results={@Result(name=SUCCESS,type="json",params={"root","result"})})
	public String commentAdd(){
		try {
			String commentContent = request.getParameter("commentContent");
			comment.setByteComment(commentContent.getBytes());
			comment.setCreateDate(new Date());
			comment.setType(0);
			if(comment.getReplyId()!=null){
				comment.setType(1);
			}
			String id = request.getSession().getId();
			comment.setUsername(id.substring(id.length()-8));
			
			commentService.addComment(comment);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	@Action(value="/app/front/comments",results={@Result(name=SUCCESS,location="/app/front/comment.jsp")})
	public String comments(){
		String blogId = request.getParameter("blogId");
		List<Comment> all = commentService.getByField("blogId", blogId,new String[]{"createDate"},new boolean[]{true});
		PageUtil  page = new PageUtil(all, pageRequest.getPageSize(), pageRequest.getPage(), all.size());
		System.out.println(page);
		request.setAttribute("page", page);
		return SUCCESS;
	}
	
}
