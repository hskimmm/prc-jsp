package com.spring.prcjsp.service;

import com.spring.prcjsp.dto.CreateCommentDTO;
import com.spring.prcjsp.dto.UpdateCommentDTO;
import com.spring.prcjsp.response.ApiResponse;
import jakarta.validation.Valid;

public interface CommentService {
    ApiResponse<?> getComments(Long id);

    ApiResponse<?> createComment(@Valid CreateCommentDTO createCommentDTO);

    ApiResponse<?> updateComment(@Valid UpdateCommentDTO updateCommentDTO);
}
