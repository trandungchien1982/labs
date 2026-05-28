package com.digitalbank.cores;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.amqp.RabbitAutoConfiguration;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.autoconfigure.thymeleaf.ThymeleafAutoConfiguration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.atomic.AtomicLong;

@SpringBootApplication(exclude = {
        DataSourceAutoConfiguration.class,
        HibernateJpaAutoConfiguration.class,
        RedisAutoConfiguration.class,
        RabbitAutoConfiguration.class,
        ThymeleafAutoConfiguration.class,
        SecurityAutoConfiguration.class
})
@EnableScheduling
// This MainApp is used for testing only
public class CoresApplication {

    private static final Logger log = LoggerFactory.getLogger(CoresApplication.class);
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MMM/yyyy HH:mm:ss");
    private final AtomicLong index = new AtomicLong(0);

    public static void main(String[] args) {
        SpringApplication.run(CoresApplication.class, args);
    }

    @Scheduled(fixedRate = 3000)
    public void printScheduledMessage() {
        log.info("This is the message at position : {}, time now {}", index.incrementAndGet(), LocalDateTime.now().format(FORMATTER));
    }
}