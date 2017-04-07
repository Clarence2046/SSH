package com.shark.ocean.model;

import java.sql.Blob;
import java.util.Date;
import java.util.List;

public class Blog {
	private Long id;

	private String title;

	private String subTitle;

	private String author;

	private byte[] content;

	private Blob blobContent;

	private Date createDate;

	private Date publishDate;

	private Date modifyDate;

	private Integer visible;

	private Integer lockComment;

	private String labels;

	private String description;
	private Integer views;

	public Integer getViews() {
		return views;
	}

	public void setViews(Integer views) {
		this.views = views;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String[] getLabelsList() {
		if (labels == null) {
			return null;
		}
		return labels.split(",");
	}

	public String getLabels() {
		return labels;
	}

	public void setLabels(String labels) {
		this.labels = labels;
	}

	public Blob getBlobContent() {
		return blobContent;
	}

	public void setBlobContent(Blob blobContent) {
		this.blobContent = blobContent;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public byte[] getContent() {
		return content;
	}

	public void setContent(byte[] content) {
		this.content = content;
		this.contentHtml = new String(content);
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public Integer getVisible() {
		return visible;
	}

	public void setVisible(Integer visible) {
		this.visible = visible;
	}

	public Integer getLockComment() {
		return lockComment;
	}

	public void setLockComment(Integer lockComment) {
		this.lockComment = lockComment;
	}

	private String contentHtml;

	public String getContentHtml() {
		return contentHtml;
	}

	public void setContentHtml(String contentHtml) {
		this.contentHtml = contentHtml;
	}

	@Override
	public String toString() {
		return "Blog [id=" + id + ", title=" + title + ", subTitle=" + subTitle
				+ ", author=" + author + ", createDate=" + createDate
				+ ", publishDate=" + publishDate + ", modifyDate=" + modifyDate
				+ ", visible=" + visible + ", lockComment=" + lockComment + "]";
	}

}
