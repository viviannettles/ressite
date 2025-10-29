# Use a Maven image to build the JAR
FROM maven:3.9.2-eclipse-temurin-20 AS build
WORKDIR /ressite
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use a JDK runtime to run the app
FROM eclipse-temurin:25-jdk
WORKDIR /ressite
COPY ./target/ressite-aws.jar /ressite
EXPOSE 8080
CMD ["java", "-jar", "ressite-aws.jar"]