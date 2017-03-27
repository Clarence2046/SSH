package com.shark.ocean.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
/**
 * �Զ����¼��֤�ɹ��Ժ�Ĵ�������������ת��url
 * �Ḳ��default-target-ur���趨
 * @author admin
 *
 */
public class CustomAuthenticationSuccessHanlder implements AuthenticationSuccessHandler {

	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication auth)
			throws IOException, ServletException {
		System.out.println("�Զ����¼��֤�ɹ���Ĵ�����������"+auth.getName());
		
		resp.sendRedirect(req.getContextPath());
	}

}
