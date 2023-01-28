package com.m15.Reseller.helper;

import com.m15.Reseller.model.User;

public interface EmailSender {

    String buildAuthEmail(String name, String link);
    String buildForgotPassword(String name, String password);
    String buildCommentNotificationEmail(User user, String text);
    void send(String to, String email, String title);
}
