package com.m15.Reseller.dto.exception;

public class CommentNotFoundException extends RuntimeException {
    public CommentNotFoundException(String exMessage, Exception exception) {
        super(exMessage, exception);
    }

    public CommentNotFoundException(String exMessage) {
        super(exMessage);
    }
}
