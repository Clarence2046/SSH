package com.shark.ocean.action.mgr;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import com.opensymphony.xwork2.ActionSupport;
import com.shark.ocean.security.CustomUser;
import com.shark.ocean.util.MenuUtil;

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

	private  List<MenuUtil> menus = new ArrayList<MenuUtil>();

	public  List<MenuUtil> getMenus() {
		return menus;
	}

	/**
	 * 如果只配置一级路径，那么只要满足最后部分就可以访问 如： 配置/user 那么/ss/ss/user也可以访问
	 */
	@Override
	@Action(value = "/app/mgr/index", results = { @Result(name = SUCCESS, location = "/app/mgr/index.jsp"),
												  @Result(name="login",type="redirect",location="/login.jsp") })
	public String execute() throws Exception {
		System.out.println("进入后台管理-首页");
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal instanceof CustomUser){
			CustomUser userDetails = (CustomUser) principal;
			// 获取用户权限信息
			Collection<? extends GrantedAuthority> authorities = userDetails
					.getAuthorities();
			List<String> s = new ArrayList<String>();
			for (GrantedAuthority grantedAuthority : authorities) {
				String authority = grantedAuthority.getAuthority();
				s.add(authority);
			}
			System.out.println("当前用户的权限信息：" + s);
			if (menus.size() == 0) {
				menus.addAll(userDetails.getMenus());
			}
			ServletActionContext.getContext().getSession().put("LOGIN_USERNAME", userDetails.getUsername());
			System.out.println("当前用户的菜单信息：" + menus);
		}else{
			return "login";
		}

		return SUCCESS;
	}

}
