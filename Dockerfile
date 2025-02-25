# Use a Maven image with OpenJDK 17
FROM maven:3.8.6-openjdk-17-slim AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and the source code into the container
COPY pom.xml /app/
COPY src /app/src

# Run the build command
RUN mvn clean install -DskipTests

# Use an official OpenJDK runtime image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/EmpManagementSystem-0.0.1-SNAPSHOT.jar /app/EmpManagementSystem.jar

# Expose port 8080 (default Spring Boot port)
EXPOSE 8080

# Command to run the Spring Boot application
CMD ["java", "-jar", "EmpManagementSystem.jar"]
