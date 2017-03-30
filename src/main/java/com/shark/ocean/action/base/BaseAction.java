package com.shark.ocean.action.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.shark.ocean.util.PageUtil;

public class BaseAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4142636035476345884L;

	protected PageUtil pageRequest = new PageUtil(null, 10, 1, 1);

	protected HttpServletRequest request;
	protected HttpServletResponse response;

	public BaseAction() {
		request = ServletActionContext.getRequest();
		response = ServletActionContext.getResponse();
	}

	public HttpServletRequest getRequest() {
		if(request==null){
			request = ServletActionContext.getRequest();
		}
		
		return request;
	}
	
	public PageUtil getPageRequest() {
		return pageRequest;
	}

	public void setPageRequest(PageUtil pageRequest) {
		this.pageRequest = pageRequest;
	}
	
	
	
}
