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

/**
 * 获取用户认证信息的类
 * 	在这里获取对应登录用户名的用户信息
 * @author admin
 *
 */
public class CustomUserJdbcService extends JdbcDaoSupport implements UserDetailsService {

	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("认证。。。。。。");
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		SimpleGrantedAuthority  au = new SimpleGrantedAuthority("ROLE_USER");
		SimpleGrantedAuthority  au_admin = new SimpleGrantedAuthority("ROLE_ADMIN");
		UserDetails u = null;
		if("admin".equals(username)){
			authorities.add(au);
			authorities.add(au_admin);
			
			Md5PasswordEncoder  encoder = new Md5PasswordEncoder();
			encoder.setEncodeHashAsBase64(true);
			String encodePassword = encoder.encodePassword("admin","admin");
			u = new User(username, encodePassword, true, true, true, true,
					AuthorityUtils.NO_AUTHORITIES);
		}else{
			List<SystemUser> list = getJdbcTemplate().query("select * from ocean_user where username='"+username+"'", new RowMapper<SystemUser>() {
				public SystemUser mapRow(ResultSet rs, int rowNum) throws SQLException {
					SystemUser user = new SystemUser();
					
					user.setId(rs.getLong(1));
					user.setUsername(rs.getString(2));
					user.setPassword(rs.getString(3));
					user.setType(rs.getInt(4));
					
					return user;
				}
			});
			
			if(list!=null && list.size()>0){
				SystemUser systemUser = list.get(0);
				
				if(systemUser.getType()==1){
					authorities.add(au);
					authorities.add(au_admin);
				}else{
					authorities.add(au);
				}
				
				u = new User(username,systemUser.getPassword(), true, true, true, true,
						AuthorityUtils.NO_AUTHORITIES);
			}
			
		}
		
		
		return createUserDetails(username, u, authorities);
	}
	
	protected UserDetails createUserDetails(String username,
			UserDetails userFromUserQuery, List<GrantedAuthority> combinedAuthorities) {

		return new User(username, userFromUserQuery.getPassword(),
				userFromUserQuery.isEnabled(), true, true, true, combinedAuthorities);
	}

}
