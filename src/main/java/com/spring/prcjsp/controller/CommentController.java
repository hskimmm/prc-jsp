package com.spring.prcjsp.controller;

import com.spring.prcjsp.dto.CreateCommentDTO;
import com.spring.prcjsp.dto.UpdateCommentDTO;
import com.spring.prcjsp.response.ApiResponse;
import com.spring.prcjsp.service.CommentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping
    public ResponseEntity<ApiResponse<?>> createComment(@Valid @RequestBody CreateCommentDTO createCommentDTO) {
        ApiResponse<?> response = commentService.createComment(createCommentDTO);
        return ResponseEntity.ok(response);
    }

    @PutMapping
    public ResponseEntity<ApiResponse<?>> updateComment(@Valid @RequestBody UpdateCommentDTO updateCommentDTO) {
        ApiResponse<?> response = commentService.updateComment(updateCommentDTO);
        return ResponseEntity.ok(response);
    }
}
