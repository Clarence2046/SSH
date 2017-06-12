package com.shark.ocean.model;

import java.sql.Blob;
import java.util.Date;

public class Comment {
	private Long id;

	private String username;

	private Long blogId;

	private Long replyId;

	private String strContent;

	private Blob blobContent;

	private byte[] byteComment;

	private Integer type;

	private Date createDate;

	private Integer replyCount;
	private String replyUsername;

	private Integer floor;
	private Integer replyFloor;

	private String blogName;

	public String getBlogName() {
		return blogName;
	}

	public void setBlogName(String blogName) {
		this.blogName = blogName;
	}

	public Integer getReplyFloor() {
		return replyFloor;
	}

	public void setReplyFloor(Integer replyFloor) {
		this.replyFloor = replyFloor;
	}

	public Integer getFloor() {
		return floor;
	}

	public void setFloor(Integer floor) {
		this.floor = floor;
	}

	public String getReplyUsername() {
		return replyUsername;
	}

	public void setReplyUsername(String replyUsername) {
		this.replyUsername = replyUsername;
	}

	public Integer getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(Integer replyCount) {
		this.replyCount = replyCount;
	}

	public Blob getBlobContent() {
		return blobContent;
	}

	public void setBlobContent(Blob blobContent) {
		this.blobContent = blobContent;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public String getCreateDateStr() {
		String desc = "";
		Date now = new Date();
		long time = now.getTime();
		long ctime = createDate.getTime();
		long period = (time - ctime) / 1000;
		if (period < 60) {
			desc = period + "秒前";
		} else if (period >= 60 && period < 3600) {
			desc = period / 60 + "分钟前";
		} else if (period >= 3600 && period < 3600 * 24) {
			desc = period / 3600 + "小时前";
		} else if (period >= 3600 * 24 && period < 3600 * 24 * 30) {
			desc = period / (3600 * 24) + "天前";
		} else if (period >= 3600 * 24 * 30 && period < 3600 * 24 * 30 * 12) {
			desc = period / (3600 * 24 * 30) + "月前";
		} else if (period >= 3600 * 24 * 30 * 12) {
			desc = period / (3600 * 24 * 30 * 12) + "年前";
		}
		return desc;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
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

	public Long getBlogId() {
		return blogId;
	}

	public void setBlogId(Long blogId) {
		this.blogId = blogId;
	}

	public Long getReplyId() {
		return replyId;
	}

	public void setReplyId(Long replyId) {
		this.replyId = replyId;
	}

	public String getStrContent() {
		return strContent;
	}

	public void setStrContent(String strContent) {
		this.strContent = strContent;
	}

	public byte[] getByteComment() {
		return byteComment;
	}

	public void setByteComment(byte[] byteComment) {
		this.byteComment = byteComment;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

}
