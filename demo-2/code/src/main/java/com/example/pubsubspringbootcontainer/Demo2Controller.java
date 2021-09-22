package com.example.demo2;

import java.util.Base64;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

// Demo2Controller consumes a Pub/Sub message.
@RestController
  public class Demo2Controller {
  @RequestMapping(value = "/", method = RequestMethod.POST)
  public ResponseEntity receiveMessage(@RequestBody Body body) {
    // Get PubSub message from request body.
    Body.Message message = body.getMessage();
    if (message == null) {
      String msg = "Bad Request: invalid Pub/Sub message format";
      System.out.println(msg);
      return new ResponseEntity(msg, HttpStatus.BAD_REQUEST);
    }

    String data = message.getData();
    String target =
        !StringUtils.isEmpty(data) ? new String(Base64.getDecoder().decode(data)) : "World";
    String msg = "Hello " + target + "!";

    System.out.println(msg);
    return new ResponseEntity(msg, HttpStatus.OK);
  }
}