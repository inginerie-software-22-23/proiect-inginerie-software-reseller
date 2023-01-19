package com.m15.Reseller.dto.exception;

public class FollowNotFound extends RuntimeException {
    public FollowNotFound(String exMessage, Exception exception) {
        super(exMessage, exception);
    }

    public FollowNotFound(String exMessage) {
        super(exMessage);
    }
}
