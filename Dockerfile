FROM maven:3.9.16-eclipse-temurin-17 AS build
WORKDIR /workspace

# Copy everything and build the application
COPY . /workspace
RUN mvn -B -DskipTests package

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy fat jar from build stage
COPY --from=build /workspace/target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
