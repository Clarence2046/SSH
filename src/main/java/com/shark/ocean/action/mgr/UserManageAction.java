package com.shark.ocean.action.mgr;

import java.nio.charset.Charset;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.model.SystemUser;
import com.shark.ocean.service.ISystemUserService;
import com.shark.ocean.util.PageUtil;

/**
 * 后台管理首页
 * 
 * @author admin
 *
 */
@ParentPackage("json-default")
public class UserManageAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7496445031013623195L;

	@Autowired
	private ISystemUserService systemUserService;

	private boolean result = false;

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	private SystemUser systemUser;

	public SystemUser getSystemUser() {
		return systemUser;
	}

	public void setSystemUser(SystemUser systemUser) {
		this.systemUser = systemUser;
	}

	@Action(value = "/user", results = { @Result(name = SUCCESS, location = "/app/mgr/user/user-list.jsp") })
	public String listUser() {
		System.out.println("list user..."+pageRequest);
		List<SystemUser> list = systemUserService.getAll();
		HttpServletRequest request = ServletActionContext.getRequest();
		PageUtil  page = new PageUtil(list,pageRequest.getPageSize(),pageRequest.getPage(),list.size());
		request.setAttribute("result", page);
		System.out.println(page);
		
		return SUCCESS;
	}

	@Action(value = "/user/toadd", results = { @Result(name = SUCCESS, location = "/app/mgr/user/user-add.jsp") })
	public String addUserForward() {
		System.out.println("to add user...");

		return SUCCESS;
	}

	@Action(value = "/user/add", results = { @Result(type = "json", params = { "root", "result" }) })
	public String addUser() {

		System.out.println(systemUser);
		try {
			// systemUser.setUsername(new String(
			// systemUser.getUsername().getBytes("gbk"),"utf-8"));
			System.out.println("系统默认编码:" + Charset.defaultCharset().displayName());
			Md5PasswordEncoder encoder = new Md5PasswordEncoder();
			encoder.setEncodeHashAsBase64(true);
			String encodePassword = encoder.encodePassword(systemUser.getPassword(), systemUser.getUsername());
			systemUser.setPassword(encodePassword);

			systemUserService.add(systemUser);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	@Action(value = "/user/delete", results = { @Result(type = "json", params = { "root", "result" }) })
	public String deleteUser() {

		System.out.println("删除用户：" + systemUser);
		try {
			systemUserService.deleteById(systemUser.getId());
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

}
