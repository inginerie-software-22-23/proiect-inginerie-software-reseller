package com.m15.Reseller.dto.exception;

public class ChatNotFoundException extends RuntimeException {
    public ChatNotFoundException(String exMessage, Exception exception) {
        super(exMessage, exception);
    }

    public ChatNotFoundException(String exMessage) {
        super(exMessage);
    }
}
