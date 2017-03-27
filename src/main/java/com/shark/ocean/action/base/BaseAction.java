package com.shark.ocean.action.base;

import com.opensymphony.xwork2.ActionSupport;
import com.shark.ocean.util.PageUtil;

public class BaseAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4142636035476345884L;

	
	protected PageUtil  pageRequest = new PageUtil(null, 10, 1, 1);


	public PageUtil getPageRequest() {
		return pageRequest;
	}


	public void setPageRequest(PageUtil pageRequest) {
		this.pageRequest = pageRequest;
	}
	
	
}
