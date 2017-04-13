package com.shark.ocean.dao.impl;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.shark.ocean.dao.IComment;
import com.shark.ocean.model.Comment;

@Repository("commentDao")
public class CommentDaoImpl extends BaseDaoImpl<Comment> implements IComment {

	public void addComment(Comment comment) {
		byte[] byteComment = comment.getByteComment();
		Blob blob = getSession().getLobHelper().createBlob(byteComment);
		comment.setBlobContent(blob);
		getSession().saveOrUpdate(comment);
	}

	
	@Override
	protected List<Comment> decorate(List list) {
		List<Comment>  comments = new ArrayList<Comment>();
		try {
			for (Object o : list) {
				Comment comment = (Comment)o;
				Blob blobContent = comment.getBlobContent();
				if(blobContent!=null){
					byte[] bytes = blobContent.getBytes(1, Long.valueOf(blobContent.length()).intValue());
					comment.setByteComment(bytes);
					comment.setStrContent(new String(bytes));
				}
				comments.add(comment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return comments;
	}

}
