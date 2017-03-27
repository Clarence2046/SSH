package com.shark.ocean.security;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

public class CustomAuthenticationProvider implements AuthenticationProvider {

	public Authentication authenticate(Authentication auth) throws AuthenticationException {
		System.out.println("自定义认证方法");
		Object principal = auth.getPrincipal();
		//根据用户名获取对应的信息，进行权限判断，决定是否通过
		
		
		return auth;
	}

	public boolean supports(Class<?> arg0) {
		return true;
	}

}
