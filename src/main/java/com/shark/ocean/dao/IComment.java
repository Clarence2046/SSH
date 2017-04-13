package com.shark.ocean.dao;

import com.shark.ocean.model.Comment;

public interface IComment extends IBaseDao<Comment>{
	public void addComment(Comment comment);

}
