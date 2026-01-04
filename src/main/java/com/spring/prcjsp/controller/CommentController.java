package com.spring.prcjsp.controller;

import com.spring.prcjsp.response.ApiResponse;
import com.spring.prcjsp.service.CommentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor
@Log4j2
public class CommentController {
    private final CommentService commentService;

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<?>> getComments(@PathVariable(value = "id") Long id) {
        ApiResponse<?> response = commentService.getComments(id);
        return ResponseEntity.ok(response);
    }
}
