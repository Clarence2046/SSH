package com.shark.ocean.model;

import java.io.Serializable;

public class SystemUser implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2511117314547373874L;

	private Long id;

	private String username;

	private String password;

	private Integer type;

	private String description;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "SystemUser [id=" + id + ", username=" + username
				+ ", password=" + password + ", type=" + type + "]";
	}

}
