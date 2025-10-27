package com.vmn.ressite;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetingController {

    @GetMapping("/")
    public String getGreeting() {
        return "Greetings from Spring Boot!";
    }

}
