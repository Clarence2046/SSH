package com.shark.ocean.action.front;

import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.shark.ocean.action.base.BaseAction;
import com.shark.ocean.service.IJdbcService;

/**
 * 前台ajax获取类
 * @author admin
 *
 */
public class AjaxFrontAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6929467672595768714L;

	@Autowired
	private IJdbcService jbdcService;
	
	private List<Map<String, String>>  resultList;
	
	
	public List<Map<String, String>> getResultList() {
		return resultList;
	}


	public void setResultList(List<Map<String, String>> resultList) {
		this.resultList = resultList;
	}


	@Action(value="/app/front/ajax/labels",results={@Result(name=SUCCESS,type="json",params={"root","resultList"})})
	public String ajaxGetLabels(){
		List<Map<String, String>> labels = jbdcService.getBySql("select id,name from ocean_label");
		resultList = labels;
		return SUCCESS;
	}
	
}
