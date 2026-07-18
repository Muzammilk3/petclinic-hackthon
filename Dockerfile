FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Expect the application JAR to be present in target/ (build locally with Maven)
COPY target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
