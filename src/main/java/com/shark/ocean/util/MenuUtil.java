package com.shark.ocean.util;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class MenuUtil implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -9101479852413835095L;

	private String id;

	private String parentId;

	private String url;

	private String authUrl;

	private String title;

	private Integer level;

	private List<MenuUtil> childrenMenu = new ArrayList<MenuUtil>();

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}

	public List<MenuUtil> getChildrenMenu() {
		return childrenMenu;
	}

	public void setChildrenMenu(List<MenuUtil> childrenMenu) {
		this.childrenMenu = childrenMenu;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "MenuUtil [id=" + id + ", url=" + url + ", authUrl=" + authUrl
				+ ", title=" + title + ", childrenMenu=" + childrenMenu + "]";
	}

}
