package com.spring.prcjsp.mapper;

import com.spring.prcjsp.domain.Comment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommentMapper {
    List<Comment> getComments(Long id);

    void createComment(Comment comment);

    void updateComment(Comment comment);
}
