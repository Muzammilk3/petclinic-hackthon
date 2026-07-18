#! /bin/bash
LOGFILE=deployment.log

exec > >(tee -a $LOGFILE)
exec 2>&1

echo "Deployment Started"

# Check Java
java -version || exit 1

# Check Maven
mvn -version || exit 1

# Check Docker
docker --version || exit 1

# Build application
mvn clean package || exit 1

echo "Build Successful"

echo "Deployment Finished"