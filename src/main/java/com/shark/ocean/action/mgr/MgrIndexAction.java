package com.shark.ocean.action.mgr;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 后台管理首页
 * 
 * @author admin
 *
 */
@ParentPackage("json-default")
public class MgrIndexAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7496445031013623195L;



	@Override
	@Action(value = "/app/mgr/index", results = { @Result(name = SUCCESS, location = "/app/mgr/index.jsp") })
	public String execute() throws Exception {
		System.out.println("进入后台管理-首页");

		return SUCCESS;
	}

}
