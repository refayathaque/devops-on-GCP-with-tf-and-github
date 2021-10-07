package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {

	@RequestMapping("/")
  public String home() {
    return "hello-world";
  }

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
}

// added RequestMapping and RestController code from https://spring.io/guides/gs/spring-boot-docker/