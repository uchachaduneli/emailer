package com.mailer.spboot.controllers;

import com.mailer.spboot.misc.Response;
import com.mailer.spboot.model.User;
import com.mailer.spboot.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/user")
public class UserController {
    @Autowired
    private UserRepository userRepository;

    @PostMapping(path = "/add")
    @ResponseBody
    public Response addNewUser(@RequestParam String name, @RequestParam String email) {
        User n = new User();
        n.setUserDesc(name);
        n.setEmail(email);
        userRepository.save(n);
        return Response.ok();
    }

    @PostMapping(path = "/add-json")
    @ResponseBody
    public String addNewUser(@RequestBody User user) {
//        User n = new User();
//        n.setName(name);
//        n.setEmail(email);
        userRepository.save(user);
        return "Data Saved";
    }

    @GetMapping(path = "/all")
    public @ResponseBody
    Iterable<User> getAllUsers() {
        return userRepository.findAll();
    }


    public UserRepository getUserRepository() {
        return userRepository;
    }

    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}
