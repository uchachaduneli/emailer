package com.mailer.spboot.repositories;

import com.mailer.spboot.model.Email;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmailRepository extends JpaRepository<Email, Integer> {
}
