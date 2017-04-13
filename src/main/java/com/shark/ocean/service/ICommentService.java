package com.shark.ocean.service;

import java.util.List;

import com.shark.ocean.model.Comment;

public interface ICommentService {
	public void addComment(Comment comment);

	public void add(Comment entity);

	public void update(Comment entity);

	public List<Comment> getAll();

	public List<Comment> getByField(String fieldName, Object fieldValue);
	
	/**
	 * 
	 * @param fieldName
	 * @param fieldValue
	 * @param orderBy  排序的字段
	 * @param descs  是否按照降序排序，与orderBy字段相对应
	 * @return
	 */
	public List<Comment> getByField(String fieldName, Object fieldValue,String[] orderBy,boolean[] descs);

	public void delete(Comment entity);
}
