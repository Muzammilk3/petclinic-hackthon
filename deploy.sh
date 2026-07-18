#!/usr/bin/env bash
set -euo pipefail
LOGFILE=deploy.log

exec > >(tee -a "$LOGFILE")
exec 2>&1

echo "Automated Deployment Script"

check_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: required command '$1' not found in PATH" >&2
    return 1
  fi
}

echo "Checking prerequisites..."

# Prefer bundled Maven wrapper if present. Support Windows Git Bash (mvnw.cmd) too.
if [ -x ./mvnw ]; then
  MVNCMD="./mvnw"
elif [ -f ./mvnw.cmd ]; then
  MVNCMD="cmd.exe /c mvnw.cmd"
elif command -v mvn >/dev/null 2>&1; then
  MVNCMD="mvn"
else
  echo "ERROR: Maven not found and no maven wrapper present. Install Maven or add ./mvnw (or mvnw.cmd) to the repo." >&2
  exit 1
fi

if ! check_cmd java; then
  echo "Please install a JDK and ensure 'java' is on PATH. On Windows use 'mvnw.cmd' or set JAVA_HOME." >&2
  exit 1
fi

echo "Java and Maven available. Java version:"
java -version || true
echo "Using build tool: $MVNCMD"

echo "Building project (skip tests)..."
# When MVNCMD contains spaces (e.g. "cmd.exe /c mvnw.cmd") use eval
if [[ "$MVNCMD" =~ \  ]]; then
  eval "$MVNCMD -DskipTests package"
else
  "$MVNCMD" -DskipTests package
fi

echo "Build completed. Checking Docker (optional)..."
if command -v docker >/dev/null 2>&1; then
  echo "Docker found: $(docker --version)"
  if [ -f docker-compose.yml ] || [ -f docker-compose.yaml ]; then
    if command -v docker-compose >/dev/null 2>&1; then
      echo "Building docker images via docker-compose"
      docker-compose build
    else
      echo "Using 'docker compose' to build images"
      docker compose build
    fi
  else
    echo "No docker-compose file found; skipping container build"
  fi
else
  echo "Docker not found; skipping container build"
fi

echo "Deployment script finished successfully"
