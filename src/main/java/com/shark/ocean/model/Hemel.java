package com.shark.ocean.model;

import java.util.Date;

public class Hemel {
	private String aid;

	private String name;

	private Date date1;

	private String content;

	public Hemel() {
	}

	public Hemel(String name, Date date1, String content) {
		this.name = name;
		this.date1 = date1;
		this.content = content;
	}

	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getDate1() {
		return date1;
	}

	public void setDate1(Date date1) {
		this.date1 = date1;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Hemel [aid=" + aid + ", name=" + name + ", date1=" + date1 + ", content=" + content + "]";
	}

}
