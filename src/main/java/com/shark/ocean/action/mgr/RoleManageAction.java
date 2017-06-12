package com.shark.ocean.action.mgr;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.model.Role;
import com.shark.ocean.model.SystemRight;
import com.shark.ocean.service.IJdbcService;
import com.shark.ocean.service.IRoleService;
import com.shark.ocean.util.MenuUtil;
import com.shark.ocean.util.PageUtil;

/**
 * 后台权限管理
 * 
 * @author admin
 * 
 */
@ParentPackage("json-default")
public class RoleManageAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7496445031013623195L;

	@Autowired
	private IRoleService roleService;

	private boolean result = false;

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	private Role entity;

	public Role getEntity() {
		return entity;
	}

	public void setEntity(Role entity) {
		this.entity = entity;
	}

	@Action(value = "/app/mgr/role/list", results = { @Result(name = SUCCESS, location = "/app/mgr/role/role-list.jsp") })
	public String list() {
		System.out.println("list Role..." + pageRequest);
		List<Role> list = roleService.getAll();
		HttpServletRequest request = ServletActionContext.getRequest();
		PageUtil page = new PageUtil(list, pageRequest.getPageSize(),
				pageRequest.getPage(), list.size());
		request.setAttribute("result", page);
		System.out.println(page);

		return SUCCESS;
	}

	@Action(value = "/app/mgr/role/add", results = { @Result(type = "json", params = {
			"root", "result" }) })
	public String add() {
		try {
			// systemUser.setUsername(new String(
			// systemUser.getUsername().getBytes("gbk"),"utf-8"));

			roleService.add(entity);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	@Action(value = "/app/mgr/role/addpage", results = { @Result(name = SUCCESS, location = "/app/mgr/role/role-add.jsp") })
	public String editpage() {
		try {
			System.out.println("添加角色：");

			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	@Action(value = "/app/mgr/role/edit", results = { @Result(type = "json", params = {
			"root", "result" }) })
	public String edit() {
		try {
			// systemUser.setUsername(new String(
			// systemUser.getUsername().getBytes("gbk"),"utf-8"));

			roleService.update(entity);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	@Action(value = "/app/mgr/role/delete", results = { @Result(type = "json", params = {
			"root", "result" }) })
	public String delete() {

		System.out.println("删除用户：" + entity);
		try {
			roleService.delete(entity);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}
	
	@Autowired
	private IJdbcService jdbcService;
	@Action(value = "/app/mgr/role/role_right_page", results = { @Result(name = SUCCESS, location = "/app/mgr/role/role-right.jsp") })
	public String roleRightPage() {
		try {
			System.out.println(".....role..right.....");
			List<MenuUtil> allMenus = jdbcService.getAllMenus();
			getRequest().setAttribute("allRights", allMenus);
			getRequest().setAttribute("authId", getRequest().getParameter("authId"));
			
			List<Map<String, Object>>  resultlist = jdbcService.getBySql("select rightid from ocean_role_right where roleid='"+getRequest().getParameter("authId")+"'");
			System.out.println("用户的权限："+resultlist);
			List<Object> hasRights = new ArrayList<Object>();
			for (Map<String, Object> map : resultlist) {
				hasRights.add(map.get("rightid"));
			}
			
			getRequest().setAttribute("hasRights", hasRights);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}
	
	@Action(value = "/app/mgr/role/role_right", results = { @Result(type = "json", params = {"root", "result" }) })
	public String roleRight() {

		System.out.println("关联权限" );
		try {
			String roleId = request.getParameter("roleId");
			String rights = request.getParameter("rights");
			String[] rightIds = rights.split("right_");
			
			jdbcService.saveRoleRights(roleId, rightIds);
			
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

}
