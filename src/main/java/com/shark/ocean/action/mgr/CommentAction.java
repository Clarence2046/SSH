package com.shark.ocean.action.mgr;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.model.Comment;
import com.shark.ocean.service.ICommentService;
import com.shark.ocean.service.IJdbcService;
import com.shark.ocean.util.PageUtil;

public class CommentAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3067963867845380846L;

	@Autowired
	private ICommentService  commentService;
	@Autowired
	private IJdbcService jdbcService;
	
	private Comment entity;
	
	
	public Comment getEntity() {
		return entity;
	}


	public void setEntity(Comment entity) {
		this.entity = entity;
	}


	@Action(value="/app/mgr/comment/list",results={@Result(name=SUCCESS,location="/app/mgr/comment/comment-list.jsp")})
	public String listComments() throws Exception{
		StringBuffer  sb = new StringBuffer("select id from ocean_blog  where 1=1 ");
		String title = request.getParameter("title");
		List<Long>  idlist = new ArrayList<Long>();
		if(StringUtils.isNotEmpty(title)){
			String term = new String(title.getBytes("ISO-8859-1"),"UTF-8");
			sb.append(" and title like '%"+term+"%'");
			request.setAttribute("title", term);
			List<Map<String, Object>> ids = jdbcService.getBySql(sb.toString());
			for (Map<String, Object> map : ids) {
				idlist.add(Long.valueOf(map.get("id").toString()));
			}
		}
		
		List<Comment> all = commentService.getAll();
		List<Comment> temp = new ArrayList<Comment>();
		if(idlist.size()>0){
			for (Comment comment : all) {
				if(idlist.contains(comment.getBlogId())){
					temp.add(comment);
				}
			}
		}else{
			temp = all;
		}
		
		PageUtil  page = new PageUtil(temp, pageRequest.getPageSize(), pageRequest.getPage(), temp.size());
		request.setAttribute("result", page);
		return SUCCESS;
	}
	@Action(value = "/app/mgr/comment/delete", results = { @Result(name = SUCCESS, type = "json", params = {"root", "result" }) })
	public String deleteComment() throws Exception{
		try{
			commentService.delete(entity);
			result = true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return SUCCESS;
	}
	@Action(value = "/app/mgr/comment/deleteBatch", results = { @Result(name = SUCCESS, type = "json", params = {"root", "result" }) })
	public String deleteBatchComment() throws Exception{
		try{
			String ids = request.getParameter("ids");
			if(StringUtils.isNotEmpty(ids) && ids.matches("(\\d+,)*\\d+")){
				String[] idArr = ids.split(",");
				Comment  comment = null;
				for (String id : idArr) {
					if(StringUtils.isNotEmpty(id)){
						comment = new Comment();
						comment.setId(Long.valueOf(id));
						commentService.delete(comment);
					}
				}
				
				result = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return SUCCESS;
	}

}
