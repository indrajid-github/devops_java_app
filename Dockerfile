FROM  maven:3.9.0-eclipse-temurin-17 as build
WORKDIR /app
COPY src/ .
COPY pom.xml .
RUN mvn clean package

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/kubernetes-configmap-reload-0.0.1-SNAPSHOT.jar /app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"] 