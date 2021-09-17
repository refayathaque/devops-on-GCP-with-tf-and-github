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
    return "Hello Docker World";
  }

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
}

// added RequestMapping and RestController code from https://spring.io/guides/gs/spring-boot-docker/
// to build and run this app with Maven and Apache Tomcat modify the command in the guide above with values found in pom.xml
// mvn package && java -jar target/${artifactId}-${version}.jar