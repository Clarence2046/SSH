package com.shark.ocean.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.shark.ocean.util.MenuUtil;

public class CustomUser extends User {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9010878400990735100L;
	/**
	 * 用户拥有的菜单权限集合
	 */
	private List<MenuUtil> menus = new ArrayList<MenuUtil>();

	public CustomUser(String username, String password,
			Collection<? extends GrantedAuthority> authorities,
			List<MenuUtil> menus) {
		super(username, password, authorities);
		this.menus = menus;
	}

	public CustomUser(String username, String password, boolean enabled,
			boolean accountNonExpired, boolean credentialsNonExpired,
			boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities,
			List<MenuUtil> menus) {
		super(username, password, enabled, accountNonExpired,
				credentialsNonExpired, accountNonLocked, authorities);
		this.menus = menus;
	}

	public List<MenuUtil> getMenus() {
		return menus;
	}

	public void setMenus(List<MenuUtil> menus) {
		this.menus = menus;
	}

}
