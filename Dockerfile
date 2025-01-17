# 빌드 스테이지
FROM oraclelinux:8 as builder
WORKDIR /build

# Oracle OpenJDK 17 설치
RUN yum install -y java-17-openjdk-devel

# Gradle 캐시를 위한 파일 복사
COPY build.gradle settings.gradle /build/
RUN gradle dependencies || true

# 소스 코드 복사 및 빌드
COPY . /build

# 실행 스테이지
FROM openjdk:17-jdk-slim
WORKDIR /app

# 빌드된 JAR 파일 복사
COPY --from=builder /build/build/libs/KREAMIFY-0.0.1-SNAPSHOT.jar /app/KREAMIFY.jar

EXPOSE 8080

# 컨테이너를 non-root 사용자로 실행
USER nobody:nogroup

# 애플리케이션 실행
ENTRYPOINT [ \
   "java", \
   "-jar", \
   "-Djava.security.egd=file:/dev/./urandom", \
   "-Dsun.net.inetaddr.ttl=0", \
   "KREAMIFY.jar" \
]