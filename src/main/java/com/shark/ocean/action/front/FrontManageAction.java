package com.shark.ocean.action.front;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.lucene.LuceneHelper;
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
	
	@Action(value="/app/front/index",results={@Result(name=SUCCESS,location="/app/front/home/home.jsp")})
	public String index(){
		//首页文章列表为最新文章
		//List<Blog> all = blogService.getByField("visible", 0);
		List<Blog> all = blogService.getRecentBlogs(8);
		request.setAttribute("blogs", all);
		return SUCCESS;
	}
	
	/**
	 * 前台博客列表页面
	 * @return
	 */
	@Action(value="/app/front/list",results={@Result(name=SUCCESS,location="/app/front/home/blog_list.jsp")})
	public String list(){
		commonList();
		return SUCCESS;
	}
	
	/**
	 * 前台博客列表分页访问方法
	 * @return
	 */
	@Action(value="/app/front/listpage",results={@Result(name=SUCCESS,location="/app/front/home/blog_list_part.jsp")})
	public String listPage(){
		commonList();
		return SUCCESS;
	}

	private void commonList() {
		try {
			String labelName = request.getParameter("labelName");
			String author = request.getParameter("author");
			String sql = "select id , title,author,views,createdate,description from ocean_blog where visible=0 ";
			if(StringUtils.isNoneEmpty(labelName)){
				labelName = new String(labelName.getBytes("ISO-8859-1"),"utf-8");
				if(!"所有文章".equals(labelName)){
					sql += " and labels like '%"+labelName+"%' ";
				}
				request.setAttribute("labelName", labelName);
			}else{
				request.setAttribute("listdescription", "所有文章");
			}
			if(StringUtils.isNoneEmpty(author)){
				author = new String(author.getBytes("ISO-8859-1"),"utf-8");
				sql += " and author like '"+author+"' ";
				request.setAttribute("author", author);
			}
			
			sql += " order by createDate desc";
			
			List<Map<String,Object>> list = jdbcService.getBySql(sql);
			
			PageUtil page = new PageUtil(list, pageRequest.getPageSize(), pageRequest.getPage(), list.size());
			request.setAttribute("page", page);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	//-----------------------------------------------------
	
	@Action(value="/app/front/listbyauthor",results={@Result(name=SUCCESS,location="/app/front/home/blog_list.jsp")})
	public String listByAuthor(){
		try {
			String author = request.getParameter("author");
			author = new String(author.getBytes("ISO-8859-1"),"utf-8");
			List<Map<String,Object>> list = jdbcService.getBySql("select id , title,createdate,description from ocean_blog where author like '"+author+"' and visible=0 ");
			
			PageUtil page = new PageUtil(list, pageRequest.getPageSize(), pageRequest.getPage(), list.size());
			request.setAttribute("page", page);
			request.setAttribute("listdescription", author);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	@Action(value="/app/front/listall",results={@Result(name=SUCCESS,location="/app/front/home/blog_list.jsp")})
	public String listAll(){
		try {
			List<Map<String,Object>> list = jdbcService.getBySql("select id , title,createdate,description from ocean_blog where  visible=0 ");
			PageUtil page = new PageUtil(list, pageRequest.getPageSize(), pageRequest.getPage(), list.size());
			request.setAttribute("page", page);
			request.setAttribute("listdescription", "所有文章");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	//-----------------------------------------------------
	
	
	@Action(value="/app/front/blog",results={@Result(name=SUCCESS,location="/app/front/home/blog_detail.jsp")})
	public String blogDetail(){
		try {
			String id = request.getParameter("id");
			String labelName = request.getParameter("cls");
			if(StringUtils.isNoneEmpty(labelName)){
				labelName = new String(labelName.getBytes("ISO-8859-1"),"utf-8");
				request.setAttribute("labelName", labelName);
			}
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
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
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
			//String id = request.getSession().getId();
			String remoteHost = request.getRemoteHost();
			comment.setUsername(remoteHost);
			
			commentService.addComment(comment);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	@Action(value="/app/front/comments",results={@Result(name=SUCCESS,location="/app/front/common/comment.jsp")})
	public String comments(){
		String blogId = request.getParameter("blogId");
		List<Comment> all = commentService.getByField("blogId", blogId,new String[]{"createDate"},new boolean[]{true});
		PageUtil  page = new PageUtil(all, pageRequest.getPageSize(), pageRequest.getPage(), all.size());
		System.out.println(page);
		request.setAttribute("page", page);
		return SUCCESS;
	}
	
	
	
	/**
	 * 前台全局搜索
	 * @return
	 */
	@Action(value="/app/front/globalsearch",results={@Result(name=SUCCESS,location="/app/front/home/search_list.jsp")})
	public String globalSearch(){
		String term = request.getParameter("term");
		if(StringUtils.isNotEmpty(term)){
			LuceneHelper  helper = new LuceneHelper();
			List<Map<String, String>> searchResults = helper.searchIndex("description", "title:"+term+" content:"+term);
			request.setAttribute("searchResults", searchResults);
			request.setAttribute("term", term);
			request.setAttribute("size", searchResults.size());
		}
		
		return SUCCESS;
	}
	
}
