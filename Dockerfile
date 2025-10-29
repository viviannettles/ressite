# ----------------------------------------------------------------------
# STAGE 1: BUILD THE JAR ARTIFACT
# ----------------------------------------------------------------------
FROM maven:3.9.2-eclipse-temurin-20 AS build
# Set the working directory inside the build container
WORKDIR /ressite
# Copy the dependency file and source code
COPY pom.xml .
COPY src ./src
# Build the application, creating the JAR file in /app/target/
RUN mvn clean package -DskipTests

# ----------------------------------------------------------------------
# STAGE 2: RUN THE APPLICATION
# ----------------------------------------------------------------------
FROM eclipse-temurin:25-jdk
# Set the working directory for the final application (where the JAR will live)
WORKDIR /ressite

# We explicitly copy the artifact from the 'build' stage.
# The JAR is located at /app/target/ressite-aws.jar (because WORKDIR was /app)
# We copy it to the current working directory (which is also /app)
COPY --from=build /ressite/target/ressite-render.jar .

EXPOSE 8080
# Run the application
CMD ["java", "-jar", "ressite-render.jar"]
