# --- Build Stage ---
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build application
RUN mvn -q -DskipTests clean package

# --- Run Stage ---
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy built JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Render will use PORT env variable, so expose 10000
EXPOSE 10000

# Run Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
