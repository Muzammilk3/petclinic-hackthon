#!/bin/sh
set -e

APP_JAR=/app/app.jar

if [ -f "$APP_JAR" ]; then
  echo "Found $APP_JAR — starting application"
  exec java -jar "$APP_JAR"
else
  echo "No application jar found at $APP_JAR"
  echo "Mount the built jar into the container at /app/app.jar or build the project locally first."
  echo "Keeping container alive for debugging..."
  tail -f /dev/null
fi
