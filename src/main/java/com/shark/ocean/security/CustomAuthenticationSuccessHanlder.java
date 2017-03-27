package com.shark.ocean.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
/**
 * 自定义登录认证成功以后的处理器，处理跳转的url
 * 会覆盖default-target-ur的设定
 * @author admin
 *
 */
public class CustomAuthenticationSuccessHanlder implements AuthenticationSuccessHandler {

	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication auth)
			throws IOException, ServletException {
		System.out.println("自定义登录认证成功后的处理器。。。"+auth.getName());
		
		resp.sendRedirect(req.getContextPath());
	}

}
