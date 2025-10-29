# ----------------------------------------------------------------------
# STAGE 1: BUILD THE JAR ARTIFACT (JDK 21)
# ----------------------------------------------------------------------
# Uses a stable Maven image that includes the Java Development Kit (JDK) version 21.
FROM maven:3.9.6-eclipse-temurin-21 AS build

# Set the working directory inside the build container
WORKDIR /ressite

# Copy the dependency file and source code (in separate layers for caching)
COPY pom.xml .
COPY src ./src

# Build the application, creating the JAR file in /ressite/target/
RUN mvn clean package -DskipTests

# ----------------------------------------------------------------------
# STAGE 2: RUN THE APPLICATION (JRE 21)
# ----------------------------------------------------------------------
# Use a minimal Java Runtime Environment (JRE) based on Java 21 for a smaller, more secure final image.
FROM eclipse-temurin:21-jre-jammy

# Set the working directory for the final application
WORKDIR /ressite

# Copy the built JAR artifact from the 'build' stage.
COPY --from=build /ressite/target/ressite-render.jar .

# Define the port the application listens on
EXPOSE 8080

# Run the application using the non-shell array form
CMD ["java", "-jar", "ressite-render.jar"]
