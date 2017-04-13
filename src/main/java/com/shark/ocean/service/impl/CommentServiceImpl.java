package com.shark.ocean.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shark.ocean.dao.IComment;
import com.shark.ocean.model.Comment;
import com.shark.ocean.service.ICommentService;

@Service("commentService")
public class CommentServiceImpl implements ICommentService {

	@Autowired
	private IComment commentDao;

	public void addComment(Comment comment) {
		commentDao.addComment(comment);
	}

	public void add(Comment entity) {
		commentDao.add(entity);
	}

	public void update(Comment entity) {
		commentDao.update(entity);
	}

	public List<Comment> getAll() {

		return commentDao.getAll();
	}

	public List<Comment> getByField(String fieldName, Object fieldValue) {

		return commentDao.getByField(fieldName, fieldValue);
	}

	public void delete(Comment entity) {
		commentDao.delete(entity);
	}

	public List<Comment> getByField(String fieldName, Object fieldValue,
			String[] orderBy, boolean[] descs) {
		return commentDao.getByField(fieldName, fieldValue, orderBy, descs);
	}

}
