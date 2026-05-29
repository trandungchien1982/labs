package com.digitalbank.cores;

import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Service;

@Lazy
@Service
public class ApiKeyService {

    public void validateKey(String accessKeyId, String accessToken) throws AuthenticationException {
        if (accessKeyId == null || accessKeyId.isBlank()) {
            throw new BadCredentialsException("accessKeyId must not be null or empty");
        }
        if (accessToken == null || accessToken.isBlank()) {
            throw new BadCredentialsException("accessToken must not be null or empty");
        }
        // TODO: implement later when the DB is ready — verify accessKeyId + accessToken match
    }
}
