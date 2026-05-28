# ─── Build stage ──────────────────────────────────────────────────────────────
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /workspace

# Copy gradle wrapper and config first (better layer caching)
COPY gradlew gradlew.bat settings.gradle build.gradle gradle.properties ./
COPY gradle ./gradle
COPY cores/build.gradle ./cores/build.gradle

RUN chmod +x gradlew

# Pre-fetch dependencies
RUN ./gradlew :cores:dependencies --no-daemon --quiet || true

# Build the jar
COPY cores/src ./cores/src
RUN ./gradlew :cores:bootJar --no-daemon

# ─── Runtime stage ────────────────────────────────────────────────────────────
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

COPY --from=build /workspace/cores/build/libs/cores.jar app.jar

EXPOSE 8080

ENV CURRENT_PROFILE=default
ENV JAVA_OPTS=""

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]