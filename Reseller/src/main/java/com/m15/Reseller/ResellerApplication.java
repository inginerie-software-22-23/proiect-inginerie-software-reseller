package com.m15.Reseller;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@ComponentScan
@EnableAsync
public class ResellerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ResellerApplication.class, args);
	}

}
