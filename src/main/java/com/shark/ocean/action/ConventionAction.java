package com.shark.ocean.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.opensymphony.xwork2.ActionSupport;
/**
 * 使用convention时，每个action的value必须有值，“/”也不行，不然启动报错
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
	 * 访问： http://localhost:8080/ssh/different/url1 返回视图为： different/url1-mm.jsp
	 * 
	 * @return
	 */
	@Action("/different/url1")
	public String method1() {

		return "mm";
	}

	/**
	 * 访问： http://localhost:8080/ssh/different/url2 返回视图为： different/url2.jsp
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
			"contentType", "text/html","propert1","没有值。。"}) })
	public String method3() {
		propert2 = "属性2";
		return "dd";
	}

}
