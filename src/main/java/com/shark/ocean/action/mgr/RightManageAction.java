package com.shark.ocean.action.mgr;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.model.SystemRight;
import com.shark.ocean.service.ISystemRightService;
import com.shark.ocean.util.PageUtil;

/**
 * 后台权限管理
 * 
 * @author admin
 * 
 */
@ParentPackage("json-default")
public class RightManageAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7496445031013623195L;

	@Autowired
	private ISystemRightService systemRightService;

	private boolean result = false;

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	private SystemRight systemRight;

	public SystemRight getSystemRight() {
		return systemRight;
	}

	public void setSystemRight(SystemRight systemRight) {
		this.systemRight = systemRight;
	}

	@Action(value = "/app/mgr/right/list", results = { @Result(name = SUCCESS, location = "/app/mgr/right/right-list.jsp") })
	public String list() {
		System.out.println("list systemRight..." + pageRequest);
		List<SystemRight> list = systemRightService.getAll();
		HttpServletRequest request = ServletActionContext.getRequest();
		PageUtil page = new PageUtil(list, pageRequest.getPageSize(),
				pageRequest.getPage(), list.size());
		request.setAttribute("result", page);
		System.out.println(page);

		return SUCCESS;
	}

	@Action(value = "/app/mgr/right/add", results = { @Result(type = "json", params = {
			"root", "result" }) })
	public String add() {
		try {
			// systemUser.setUsername(new String(
			// systemUser.getUsername().getBytes("gbk"),"utf-8"));

			systemRightService.add(systemRight);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}
	@Action(value = "/app/mgr/right/editpage", results = { @Result(name=SUCCESS,location="/app/mgr/right/right-edit.jsp" )})
	public String editpage() {
		try {
			System.out.println("编辑权限："+systemRight.getAuthId());
			
			List<SystemRight> list = systemRightService.getByField("authId", systemRight.getAuthId());
			if(list!=null && list.size()>0){
				systemRight = list.get(0);
			}else{
				System.out.println("为查询到指定编号的权限信息");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	@Action(value = "/app/mgr/right/edit", results = { @Result(type = "json", params = {
			"root", "result" }) })
	public String edit() {
		try {
			// systemUser.setUsername(new String(
			// systemUser.getUsername().getBytes("gbk"),"utf-8"));
			
			systemRightService.update(systemRight);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}

	@Action(value = "/app/mgr/right/delete", results = { @Result(type = "json", params = {
			"root", "result" }) })
	public String delete() {

		System.out.println("删除用户：" + systemRight);
		try {
			systemRightService.delete(systemRight);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

}
