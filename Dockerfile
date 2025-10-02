# ===============================
# Stage 1: Build the application
# ===============================
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy everything to container
COPY . .

# Build Spring Boot application (skip tests to save time)
RUN mvn clean package -DskipTests

# ===============================
# Stage 2: Run the application
# ===============================
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy only the built JAR from previous stage
COPY --from=build /app/target/bookStore-0.0.1-SNAPSHOT.jar app.jar

# Run the Spring Boot JAR
ENTRYPOINT ["java","-jar","app.jar"]