package com.spring.prcjsp.exception;

public class CommentIdNotFoundException extends RuntimeException {
    public CommentIdNotFoundException(String message) {
        super(message);
    }
}
