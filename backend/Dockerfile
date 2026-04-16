# Stage 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Compile the code and package it into a .jar file
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre
WORKDIR /app
# Copy the built jar from the previous stage
COPY --from=build /app/target/*.jar app.jar
# Expose the default Spring Boot port
EXPOSE 8080
# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
