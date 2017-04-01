package com.shark.ocean.action.front;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.model.Blog;
import com.shark.ocean.service.IBlogService;

public class FrontManageAction extends BaseAction{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 776655375044516411L;

	@Autowired
	private IBlogService blogService;
	
	@Action(value="/app/front/index",results={@Result(name=SUCCESS,location="/app/front/index.jsp")})
	public String index(){
		List<Blog> all = blogService.getAll();
		request.setAttribute("blogs", all);
		return SUCCESS;
	}
	
}
