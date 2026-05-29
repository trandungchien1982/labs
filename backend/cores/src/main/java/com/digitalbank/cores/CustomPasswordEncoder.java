package com.digitalbank.cores;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomPasswordEncoder implements PasswordEncoder {

    @Override
    public String encode(CharSequence rawPassword) {
        return encode(rawPassword != null ? rawPassword.toString() : null, "custom");
    }

    public String encode(String password, String encoderType) {
        return switch (encoderType) {
            case "bcrypt" -> new BCryptPasswordEncoder().encode(password);
            case "custom" -> password;
            default -> throw new IllegalArgumentException("Not support encoderType: " + encoderType);
        };
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        return isMatching(rawPassword != null ? rawPassword.toString() : null, encodedPassword);
    }

    public boolean isMatching(String password, String encodedPassword) {
        return encode(password, "custom").equals(encodedPassword);
    }
}
