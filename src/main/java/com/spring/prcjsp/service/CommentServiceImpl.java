package com.spring.prcjsp.service;

import com.spring.prcjsp.domain.Comment;
import com.spring.prcjsp.dto.CreateCommentDTO;
import com.spring.prcjsp.exception.BoardIdNotFoundException;
import com.spring.prcjsp.mapper.CommentMapper;
import com.spring.prcjsp.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j2
public class CommentServiceImpl implements CommentService{
    private final CommentMapper commentMapper;

    @Transactional(readOnly = true)
    @Override
    public ApiResponse<?> getComments(Long id) {
        if (id == null) {
            throw new BoardIdNotFoundException("게시글이 존재하지 않습니다");
        }

        try {
            List<Comment> commentList = commentMapper.getComments(id);
            return new ApiResponse<>(true, "댓글 조회 성공", commentList);
        } catch (DataAccessException e) {
            log.error("댓글 조회(데이터베이스 오류) = {}", e.getMessage());
            throw new RuntimeException("댓글 조회 중 데이터베이스 오류가 발생하였습니다");
        } catch (Exception e) {
            log.error("댓글 조회(기타 오류) = {}", e.getMessage());
            throw new RuntimeException("댓글 조회 중 오류가 발생하였습니다");
        }
    }

    @Transactional
    @Override
    public ApiResponse<?> createComment(CreateCommentDTO createCommentDTO) {
        if (createCommentDTO.getBoardId() == null) {
            throw new BoardIdNotFoundException("게시글이 존재하지 않습니다");
        }

        try {
            Comment comment = Comment.builder()
                    .boardId(createCommentDTO.getBoardId())
                    .content(createCommentDTO.getContent())
                    .regUserName(createCommentDTO.getRegUserName())
                    .build();
            commentMapper.createComment(comment);

            return new ApiResponse<>(true, "댓글을 등록하였습니다");
        } catch (DataAccessException e) {
            log.error("댓글 등록(데이터베이스 오류) = {}", e.getMessage());
            throw new RuntimeException("댓글 등록 중 데이터베이스 오류가 발생하였습니다");
        } catch (Exception e) {
            log.error("댓글 등록(기타 오류) = {}", e.getMessage());
            throw new RuntimeException("댓글 등록 중 오류가 발생하였습니다");
        }
    }
}
