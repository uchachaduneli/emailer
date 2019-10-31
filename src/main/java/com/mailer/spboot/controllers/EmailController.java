package com.mailer.spboot.controllers;

import com.mailer.spboot.model.Email;
import com.mailer.spboot.repositories.EmailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/emails")
public class EmailController {
    @Autowired
    private EmailRepository emailRepository;

    @GetMapping(path = "/all")
    public @ResponseBody
    Iterable<Email> getAllEmails() {
        return emailRepository.findAll();
    }

    public EmailRepository getEmailRepository() {
        return emailRepository;
    }

    public void setEmailRepository(EmailRepository emailRepository) {
        this.emailRepository = emailRepository;
    }
}
