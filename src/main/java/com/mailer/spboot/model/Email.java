package com.mailer.spboot.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.sql.Timestamp;

@Entity
public class Email {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer Id;
    private String subject;
    private String fromSource;
    private String toSource;
    private String body;
    private String containingFolder;
    private Timestamp createDate;

    public Integer getId() {
        return Id;
    }

    public void setId(Integer id) {
        Id = id;
    }
}