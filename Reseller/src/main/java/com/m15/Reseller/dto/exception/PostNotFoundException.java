package com.m15.Reseller.dto.exception;

public class PostNotFoundException extends RuntimeException {
    public PostNotFoundException(String exMessage, Exception exception) {
        super(exMessage, exception);
    }

    public PostNotFoundException(String exMessage) {
        super(exMessage);
    }
}
