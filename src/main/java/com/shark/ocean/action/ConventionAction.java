package com.shark.ocean.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.opensymphony.xwork2.ActionSupport;
/**
 * ʹ��conventionʱ��ÿ��action��value������ֵ����/��Ҳ���У���Ȼ��������
 * @author admin
 *
 */
public class ConventionAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2870242881646451418L;

	@Action("/different/url")
	public String execute() {

		return SUCCESS;
	}

	/**
	 * ���ʣ� http://localhost:8080/ssh/different/url1 ������ͼΪ�� different/url1-mm.jsp
	 * 
	 * @return
	 */
	@Action("/different/url1")
	public String method1() {

		return "mm";
	}

	/**
	 * ���ʣ� http://localhost:8080/ssh/different/url2 ������ͼΪ�� different/url2.jsp
	 * 
	 * @return
	 */
	@Action("/different/url2")
	public String method2() {
		return SUCCESS;
	}

	private String propert1;
	private String propert2;

	public String getPropert2() {
		return propert2;
	}

	public void setPropert2(String propert2) {
		this.propert2 = propert2;
	}

	public String getPropert1() {
		return propert1;
	}

	public void setPropert1(String propert1) {
		this.propert1 = propert1;
	}

	@Action(value = "/different/url3", results = { @Result(name = "dd", location = "/different/url3.jsp", params = {
			"contentType", "text/html","propert1","û��ֵ����"}) })
	public String method3() {
		propert2 = "����2";
		return "dd";
	}

}
