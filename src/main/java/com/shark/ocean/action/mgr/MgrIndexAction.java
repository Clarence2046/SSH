package com.shark.ocean.action.mgr;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import com.opensymphony.xwork2.ActionSupport;
import com.shark.ocean.security.CustomUser;
import com.shark.ocean.util.MenuUtil;

/**
 * ��̨������ҳ
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
	 * ���ֻ����һ��·������ôֻҪ������󲿷־Ϳ��Է��� �磺 ����/user ��ô/ss/ss/userҲ���Է���
	 */
	@Override
	@Action(value = "/app/mgr/index", results = { @Result(name = SUCCESS, location = "/app/mgr/index.jsp") })
	public String execute() throws Exception {
		System.out.println("�����̨����-��ҳ");
		CustomUser userDetails = (CustomUser) SecurityContextHolder
				.getContext().getAuthentication().getPrincipal();
		// ��ȡ�û�Ȩ����Ϣ
		Collection<? extends GrantedAuthority> authorities = userDetails
				.getAuthorities();
		List<String> s = new ArrayList<String>();
		for (GrantedAuthority grantedAuthority : authorities) {
			String authority = grantedAuthority.getAuthority();
			s.add(authority);
		}
		System.out.println("��ǰ�û���Ȩ����Ϣ��" + s);
		if (menus.size() == 0) {
			menus.addAll(userDetails.getMenus());
		}

		System.out.println("��ǰ�û��Ĳ˵���Ϣ��" + menus);

		return SUCCESS;
	}

}
