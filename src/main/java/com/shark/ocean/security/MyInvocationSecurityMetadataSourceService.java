package com.shark.ocean.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.matcher.RequestMatcher;

import com.shark.ocean.model.SystemRight;
import com.shark.ocean.service.ISystemRightService;

public class MyInvocationSecurityMetadataSourceService implements
		FilterInvocationSecurityMetadataSource {

	private ISystemRightService systemRightService;
	private static Map<String, Collection<ConfigAttribute>> resourceMap = null;

	public MyInvocationSecurityMetadataSourceService(ISystemRightService systemRightService) {
		this.systemRightService = systemRightService;
		loadResourceDefine();
	}

	private void loadResourceDefine() {
		List<SystemRight> all = systemRightService.getAll();

		/**//*
			 * Ӧ������ԴΪkey�� Ȩ��Ϊvalue�� ��Դͨ��Ϊurl�� Ȩ�޾�����Щ��ROLE_Ϊǰ׺�Ľ�ɫ��
			 * һ����Դ�����ɶ��Ȩ�������ʡ� sparta
			 */
		resourceMap = new HashMap<String, Collection<ConfigAttribute>>();

		for (SystemRight auth : all) {
			ConfigAttribute ca = new SecurityConfig("ROLE_" + auth.getAuthId());
			String url = auth.getAuthUrl();
			url = "/"+url;
			url=url.replace("//", "/");
			/**//*
				 * �ж���Դ�ļ���Ȩ�޵Ķ�Ӧ��ϵ������Ѿ�������ص���Դurl����Ҫͨ����urlΪkey��ȡ��Ȩ�޼��ϣ���Ȩ�����ӵ�Ȩ�޼�����
				 * �� sparta
				 */
			if (resourceMap.containsKey(url)) {

				Collection<ConfigAttribute> value = resourceMap.get(url);
				value.add(ca);
				resourceMap.put(url, value);
			} else {
				Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
				atts.add(ca);
				resourceMap.put(url, atts);
			}

		}
		System.out.println("resourceMap:"+resourceMap);

	}

	/*public Collection<ConfigAttribute> getAllConfigAttributes() {

		return null;
	}*/

	// ����URL���ҵ���ص�Ȩ�����á�
	public Collection<ConfigAttribute> getAttributes(Object object)
			throws IllegalArgumentException {

		// object ��һ��URL�����û������url��
		String url = ((FilterInvocation) object).getRequestUrl();
		System.out.println("��鵱ǰ����URLȨ�ޣ� "+url);
		int firstQuestionMarkIndex = url.indexOf("?");

		if (firstQuestionMarkIndex != -1) {
			url = url.substring(0, firstQuestionMarkIndex);
		}

		Iterator<String> ite = resourceMap.keySet().iterator();

		while (ite.hasNext()) {
			String resURL = ite.next();

			if (resURL.equals(url)) {
				System.out.println("��ȡ����ӦȨ��URL-0��"+resURL);
				return resourceMap.get(resURL);
			}else if(resURL.endsWith("*")){
				String temp = resURL.substring(0, resURL.length()-1);
				if(url.startsWith(temp)){
					System.out.println("��ȡ����ӦȨ��URL-1��"+resURL);
					return resourceMap.get(resURL);
				}
			}
		}
		System.out.println("��ǰ����·����"+url+"������Ȩ�޿��Ʒ�Χ֮��");
		/*Collection<ConfigAttribute> n = new ArrayList<ConfigAttribute>();
		nn.add(new SecurityConfig("����ӦȨ��"));*/
		return null;
	}

	public boolean supports(Class<?> arg0) {

		return true;
	}

	public Collection<ConfigAttribute> getAllConfigAttributes() {
		Set<ConfigAttribute> allAttributes = new HashSet<ConfigAttribute>();
		for (ConfigAttribute configAttribute : allAttributes) {
			allAttributes.add(configAttribute);
		}
		
		return allAttributes;
	}

}
