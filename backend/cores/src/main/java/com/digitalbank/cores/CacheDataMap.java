package com.digitalbank.cores;

import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;

public class CacheDataMap<K, V> {

    private final int expiredInMillis;
    private final ConcurrentHashMap<K, CacheEntry<V>> store = new ConcurrentHashMap<>();

    public CacheDataMap(int expiredInMillis) {
        this.expiredInMillis = expiredInMillis;
    }

    public V getOrCreate(K key, Function<K, V> creator) {
        // compute() holds the bucket lock atomically — no check-then-act race
        CacheEntry<V> entry = store.compute(key, (k, existing) -> {
            if (existing == null || existing.isExpired(expiredInMillis)) {
                return new CacheEntry<>(creator.apply(k));
            }
            return existing;
        });
        return entry.value;
    }

    private static class CacheEntry<V> {
        final V value;
        final long createdAt = System.currentTimeMillis();

        CacheEntry(V value) {
            this.value = value;
        }

        boolean isExpired(int expiredInMillis) {
            return System.currentTimeMillis() - createdAt > expiredInMillis;
        }
    }
}
