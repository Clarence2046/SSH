package com.shark.ocean.security;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.shark.ocean.model.SystemUser;
import com.shark.ocean.util.MenuUtil;

/**
 * 获取用户认证信息的类 在这里获取对应登录用户名的用户信息
 * 
 * @author admin
 * 
 */
public class CustomUserJdbcService extends JdbcDaoSupport implements
		UserDetailsService {

	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		System.out.println("认证。。。。。。");
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		SimpleGrantedAuthority au = new SimpleGrantedAuthority("ROLE_USER");
		SimpleGrantedAuthority au_admin = new SimpleGrantedAuthority(
				"ROLE_ADMIN");
		UserDetails u = null;
		// 超级管理员拥有所有的权限
		// 所有权限
		String allRightsSql = "select authid,authurl,authlevel,authname,visiturl,parentauthid from ocean_right where authstatus=0 ";
		List<MenuUtil> allRights = getRightsBySql(allRightsSql);
		// 一级菜单
		String firstMenuSql = "select authid,authurl,authlevel,authname,visiturl,parentauthid from ocean_right where authstatus=0 and authlevel=1";
		// 二级菜单
		String secondMenuSql = "select authid,authurl,authlevel,authname,visiturl,parentauthid from ocean_right where authstatus=0 and authlevel=2";
		List<MenuUtil> SystemRights = getRightsBySql(firstMenuSql);

		List<MenuUtil> menus = new ArrayList<MenuUtil>();

		if ("admin".equals(username)) {
			authorities.add(au);
			authorities.add(au_admin);

			SimpleGrantedAuthority auths;
			for (MenuUtil menuUtil : allRights) {
				auths = new SimpleGrantedAuthority("ROLE_" + menuUtil.getId());
				authorities.add(auths);
			}
			for (MenuUtil menuUtil : SystemRights) {
				// 统计当前用户的菜单权限有哪些
				secondMenuSql = "select authid,authurl,authlevel,authname,visiturl,parentauthid "
						+ " from ocean_right where authstatus=0 and authlevel=2 and parentauthid='"
						+ menuUtil.getId() + "'";

				List<MenuUtil> secdRights = getRightsBySql(secondMenuSql);
				menuUtil.setChildrenMenu(secdRights);
				menus.add(menuUtil);
			}

			Md5PasswordEncoder encoder = new Md5PasswordEncoder();
			encoder.setEncodeHashAsBase64(true);
			String encodePassword = encoder.encodePassword("admin", "admin");
			u = new User(username, encodePassword, true, true, true, true,
					AuthorityUtils.NO_AUTHORITIES);
		} else {
			List<SystemUser> list = getJdbcTemplate().query(
					"select * from ocean_user where username='" + username
							+ "'", new RowMapper<SystemUser>() {
						public SystemUser mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							SystemUser user = new SystemUser();

							user.setId(rs.getLong(1));
							user.setUsername(rs.getString(2));
							user.setPassword(rs.getString(3));
							user.setType(rs.getInt(4));

							return user;
						}
					});

			if (list != null && list.size() > 0) {
				SystemUser systemUser = list.get(0);

				if (systemUser.getType() == 1) {
					authorities.add(au);
					authorities.add(au_admin);
					SimpleGrantedAuthority auths;
					for (MenuUtil menuUtil : allRights) {
						auths = new SimpleGrantedAuthority("ROLE_"
								+ menuUtil.getId());
						authorities.add(auths);
					}
					for (MenuUtil menuUtil : SystemRights) {
						// 统计当前用户的二级菜单
						secondMenuSql = "select authid,authurl,authlevel,authname,visiturl,parentauthid "
								+ " from ocean_right where authstatus=0 and authlevel=2 and parentauthid='"
								+ menuUtil.getId() + "'";

						List<MenuUtil> secdRights = getRightsBySql(secondMenuSql);
						menuUtil.setChildrenMenu(secdRights);
						menus.add(menuUtil);
					}
				} else {
					authorities.add(au);
					String sql = "select r.authid,r.authurl,r.authname,r.visiturl,r.parentauthid,r.authlevel from ocean_user u, ocean_user_role ur,ocean_role_right rr,ocean_right r "
								 +" where u.id=ur.userid and ur.roleid=rr.roleid and rr.rightid=r.authid and u.id='"+systemUser.getId()+"'";
					//查询当前用户的角色和权限
					List<MenuUtil> rightsBySql = getRightsBySql(sql );
					SimpleGrantedAuthority auths;
					for (MenuUtil menuUtil : rightsBySql) {
						auths = new SimpleGrantedAuthority("ROLE_" + menuUtil.getId());
						authorities.add(auths);
						
						//一级菜单
						if("0".equals(menuUtil.getParentId())){
							menus.add(menuUtil);
						}
					}
					
					rightsBySql.removeAll(menus);
					//还需要对获取到的所有权限进行分类，因为获取到的是总的权限，没有父子关系
					for (MenuUtil menuUtil : menus) {
						String id = menuUtil.getId();
						for (MenuUtil submenu : rightsBySql) {
							if(id.equals(submenu.getParentId()) && submenu.getLevel()==2){
								menuUtil.getChildrenMenu().add(submenu);
							}
						}
						rightsBySql.removeAll(menuUtil.getChildrenMenu());
					}
				}

				u = new User(username, systemUser.getPassword(), true, true,
						true, true, AuthorityUtils.NO_AUTHORITIES);
			}

		}

		return createUserDetails(username, u, authorities, menus);
	}

	protected UserDetails createUserDetails(String username,
			UserDetails userFromUserQuery,
			List<GrantedAuthority> combinedAuthorities) {

		return new User(username, userFromUserQuery.getPassword(),
				userFromUserQuery.isEnabled(), true, true, true,
				combinedAuthorities);
	}

	protected UserDetails createUserDetails(String username,
			UserDetails userFromUserQuery,
			List<GrantedAuthority> combinedAuthorities, List<MenuUtil> menus) {

		return new CustomUser(username, userFromUserQuery.getPassword(),
				userFromUserQuery.isEnabled(), true, true, true,
				combinedAuthorities, menus);
	}

	/**
	 * 查询权限
	 * 
	 * @param sql
	 * @return
	 */
	protected List<MenuUtil> getRightsBySql(String sql) {
		List<MenuUtil> SystemRights = getJdbcTemplate().query(sql,
				new RowMapper<MenuUtil>() {
					public MenuUtil mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						MenuUtil right = new MenuUtil();

						right.setId(String.valueOf(rs.getLong("AUTHID")));
						right.setAuthUrl(rs.getString("AUTHURL"));
						right.setTitle(rs.getString("AUTHNAME"));
						right.setUrl(rs.getString("VISITURL"));
						right.setParentId(String.valueOf(rs.getLong("PARENTAUTHID")));
						right.setLevel(rs.getInt("AUTHLEVEL"));
						return right;
					}
				});
		return SystemRights;
	}

}
