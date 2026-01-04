package com.spring.prcjsp.service;

import com.spring.prcjsp.response.ApiResponse;

public interface CommentService {
    ApiResponse<?> getComments(Long id);
}
