#FROM  maven:3.9.0-eclipse-temurin-17 as build
#WORKDIR /app
#COPY . .
#RUN mvn clean package

#FROM eclipse-temurin:17.0.6_10-jdk
#WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
#EXPOSE 8080
#CMD ["java","-jar","app.jar"]

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY ./target/*.jar /app.jar
CMD ["java","-jar","app.jar"]