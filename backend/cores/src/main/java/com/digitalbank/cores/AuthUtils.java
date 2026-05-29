package com.digitalbank.cores;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;

public class AuthUtils {

    private static final CustomPasswordEncoder passwordEncoder = new CustomPasswordEncoder();

    public static void validateUserPassword(String userName, String password) throws AuthenticationException {
        if (userName == null || userName.isBlank()) {
            throw new BadCredentialsException("Username must not be null or empty");
        }
        if (password == null || password.isBlank()) {
            throw new BadCredentialsException("Password must not be null or empty");
        }
        // TODO: implement later when the DB available — check user exists and password matches
    }

    public static String getEncodePassword(String password) {
        return passwordEncoder.encode(password);
    }
}
