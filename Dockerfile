FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/jenkins-maven-demo-1.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
