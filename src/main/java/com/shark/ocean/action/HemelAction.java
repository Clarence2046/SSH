package com.shark.ocean.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.shark.ocean.model.Hemel;
import com.shark.ocean.service.IHemel;

@Controller
public class HemelAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7186621072329495236L;

	@Autowired
	private IHemel hemelService;
	
	
	@Override
	public String execute() throws Exception {
		return SUCCESS;
	}
	
	public String test(){
		HttpServletRequest request = ServletActionContext.getRequest();
		
		System.out.println("test..");
		System.out.println("service: "+hemelService);
		List<Hemel> all = hemelService.getAll();
		//System.out.println(all);
		
		Hemel hemel = hemelService.get("2c9282f25ac6dbf6015ac6dbf8440000");
		//System.out.println(hemel);
		Object req = request.getParameter("req");
		System.out.println("qingqiushuju: "+req);
		
		request.setAttribute("list", all);
		
		//获取请求数据
		HttpServletRequest request2 = ServletActionContext.getRequest();
		ActionContext context = ActionContext.getContext();
		Map<String, Object> parameters = context.getParameters();
		System.out.println(parameters);
		Object object = context.get("req");
		
		Map<String, Object> contextMap = context.getContextMap();
		System.out.println(contextMap);
		
		return "go";
	}
	

}
