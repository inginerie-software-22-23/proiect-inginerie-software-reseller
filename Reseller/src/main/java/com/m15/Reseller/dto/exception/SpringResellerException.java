package com.m15.Reseller.dto.exception;

public class SpringResellerException extends RuntimeException {
    public SpringResellerException(String exMessage, Exception exception) {
        super(exMessage, exception);
    }

    public SpringResellerException(String exMessage) {
        super(exMessage);
    }
}
