package com.mailer.spboot.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
public class IndexController {

    @RequestMapping("/")
    public String home(Map<String, Object> model) {
        return "login";
    }

    @RequestMapping("/users")
    public String next(Map<String, Object> model) {
        return "users";
    }

}