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
	 * @param orderBy  ������ֶ�
	 * @param descs  �Ƿ��ս���������orderBy�ֶ����Ӧ
	 * @return
	 */
	public List<Comment> getByField(String fieldName, Object fieldValue,String[] orderBy,boolean[] descs);

	public void delete(Comment entity);
}
