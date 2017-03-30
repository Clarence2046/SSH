package com.shark.ocean.action.mgr;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.model.Role;
import com.shark.ocean.model.SystemRight;
import com.shark.ocean.model.SystemUser;
import com.shark.ocean.service.IRoleService;
import com.shark.ocean.service.ISystemRightService;
import com.shark.ocean.service.ISystemUserService;

/**
 * 后台ajax校验
 * 
 * @author admin
 *
 */
@ParentPackage("json-default")
public class AjaxCheckAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7496445031013623195L;

	@Autowired
	private ISystemUserService systemUserService;
	@Autowired
	private ISystemRightService systemRightService;
	@Autowired
	private IRoleService roleService;

	private boolean result = false;

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}


	@Action(value = "/app/mgr/ajaxuser/checkField", results = { @Result(type = "json", params = { "root", "result" }) })
	public String checkFields() {
		String fieldId = request.getParameter("fieldId");
		String fieldValue = request.getParameter("fieldValue");
		System.out.println("校验字段："+fieldId+" ,校验值："+fieldValue);
		List<SystemUser> list = systemUserService.getByField(fieldId, fieldValue);
		if(list == null || list.size()==0){
			result = true;
		}
		return SUCCESS;
	}
	@Action(value = "/app/mgr/ajaxright/checkField", results = { @Result(type = "json", params = { "root", "result" }) })
	public String checkRightFields() {
		String fieldId = request.getParameter("fieldId");
		String fieldValue = request.getParameter("fieldValue");
		System.out.println("校验字段："+fieldId+" ,校验值："+fieldValue);
		List<SystemRight> list = systemRightService.getByField(fieldId, fieldValue);
		if(list == null || list.size()==0){
			result = true;
		}
		return SUCCESS;
	}
	@Action(value = "/app/mgr/ajaxrole/checkField", results = { @Result(type = "json", params = { "root", "result" }) })
	public String checkRoleFields() {
		String fieldId = request.getParameter("fieldId");
		String fieldValue = request.getParameter("fieldValue");
		System.out.println("校验字段："+fieldId+" ,校验值："+fieldValue);
		List<Role> list = roleService.getByField(fieldId, fieldValue);
		if(list == null || list.size()==0){
			result = true;
		}
		return SUCCESS;
	}

}
