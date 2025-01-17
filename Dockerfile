# Oracle OpenJDK 17.0.10 이미지 사용
FROM oraclelinux:8

# Oracle OpenJDK 설치
RUN yum update -y && \
    yum install -y java-17-openjdk && \
    yum clean all

# 작업 디렉토리 설정
WORKDIR /app

# JAR 파일 복사 (수정된 경로)
COPY ./KREAMIFY_BE/build/libs/KREAMIFY-0.0.1-SNAPSHOT.jar /app/KREAMIFY.jar

# 컨테이너 시작 시 실행할 명령어
CMD ["java", "-Duser.timezone=Asia/Seoul", "-jar", "-Dspring.profiles.active=dev", "KREAMIFY.jar"]