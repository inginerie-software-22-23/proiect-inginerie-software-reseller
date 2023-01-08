package com.m15.Reseller.helper;

public interface EmailSender {

    String buildEmail(String name, String link);
    void send(String to, String email);
}
