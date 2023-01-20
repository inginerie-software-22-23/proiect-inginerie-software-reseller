package com.m15.Reseller.dto.exception;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

//@ControllerAdvice
//public class GlobalExceptionHandler implements HandlerExceptionResolver {
//
//    @ExceptionHandler(Exception.class)
//    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
//        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//        return new ModelAndView("error");
//    }
//}
