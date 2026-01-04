package com.spring.prcjsp.exception;

public class BoardIdNotFoundException extends RuntimeException {
    public BoardIdNotFoundException(String message) {
        super(message);
    }
}
