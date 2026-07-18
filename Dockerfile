FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Mount-based runtime: prefer a host-mounted JAR at /app/app.jar
# The entrypoint script will run the jar if present, otherwise keep container alive
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/app/docker-entrypoint.sh"]
