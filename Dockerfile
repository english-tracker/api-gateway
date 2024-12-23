# Stage 1: Build Stage
FROM eclipse-temurin:21-jdk-alpine as builder

# Set the working directory inside the container
WORKDIR /app

# Copy project files to the container
COPY . .

# Build the Spring Boot application
RUN ./gradlew clean build -x test

# Stage 2: Runtime Stage
FROM eclipse-temurin:21-jre-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the application's port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
