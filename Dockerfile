FROM eclipse-temurin:25-jdk
WORKDIR /ressite
COPY ./target/ressite-aws.jar /ressite
EXPOSE 8080
CMD ["java", "-jar", "ressite-aws.jar"]