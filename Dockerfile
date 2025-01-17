# Gradle 빌드 단계
FROM openjdk:17-jdk-slim AS build

WORKDIR /app

# 소스 복사 및 빌드 실행
COPY . .
RUN ./gradlew clean build --no-daemon

# 실행 이미지 단계
FROM openjdk:17-jdk-slim

WORKDIR /app

# 빌드된 JAR 복사
COPY --from=build /app/build/libs/KREAMIFY-0.0.1-SNAPSHOT.jar /app/KREAMIFY.jar

# 실행 명령어
CMD ["java", "-Duser.timezone=Asia/Seoul", "-jar", "-Dspring.profiles.active=dev", "/app/KREAMIFY.jar"]