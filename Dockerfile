FROM eclipse-temurin:25-jdk-alpine AS builder

WORKDIR /build

COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle.kts settings.gradle.kts ./

RUN chmod +x gradlew
RUN ./gradlew dependencies --no-daemon || true

COPY src src
COPY frontend frontend
RUN ./gradlew build -x test --no-daemon

FROM eclipse-temurin:25-jre-alpine

WORKDIR /app

RUN addgroup -S app && adduser -S app -G app

COPY --from=builder /build/build/libs/*.jar app.jar

USER app

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
