package com.shark.ocean.security;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

public class CustomAuthenticationProvider implements AuthenticationProvider {

	public Authentication authenticate(Authentication auth) throws AuthenticationException {
		System.out.println("�Զ�����֤����");
		Object principal = auth.getPrincipal();
		//�����û�����ȡ��Ӧ����Ϣ������Ȩ���жϣ������Ƿ�ͨ��
		
		
		return auth;
	}

	public boolean supports(Class<?> arg0) {
		return true;
	}

}
