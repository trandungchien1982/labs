package com.digitalbank.cores;

import org.apache.commons.lang3.RandomStringUtils;

import java.util.Date;
import java.util.LinkedList;
import java.util.UUID;

public class TokenUtils {

    public static String generateCustomToken() {
        String uuid = UUID.randomUUID().toString();
        long nowMillis = System.currentTimeMillis();
        String random = RandomStringUtils.randomAlphanumeric(20);
        return uuid + "." + nowMillis + "." + random;
    }

    public static UUID getUUIDFromCustomToken(String token) {
        if (token == null) return null;
        String uuidPart = token.split("\\.")[0];
        return UUID.fromString(uuidPart);
    }

    public static Date getProcessedTimeFromCustomToken(String token) {
        if (token == null) return null;
        long millis = Long.parseLong(token.split("\\.")[1]);
        return new Date(millis);
    }

    public static LinkedList<String> getRandomToken(int numTokens) {
        if (numTokens <= 0) return new LinkedList<>();
        LinkedList<String> tokens = new LinkedList<>();
        for (int i = 0; i < numTokens; i++) {
            tokens.add(generateCustomToken());
        }
        return tokens;
    }
}
