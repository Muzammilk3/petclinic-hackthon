# Deployment helper

Run the appropriate script for your platform:

- Git Bash / WSL / macOS / Linux:

```bash
./deploy.sh
```

- Windows PowerShell:

```powershell
.\deploy.ps1
```

Notes:
- Both scripts prefer the bundled Maven wrapper (`mvnw` / `mvnw.cmd`) if present.
- You need a JDK installed and `java` available on your PATH.
- Docker is optional; if present the scripts will attempt to build images.

Installation notes (quick):

- Windows (Git Bash / PowerShell):
	- Install JDK 17+ from Temurin/AdoptOpenJDK or Oracle and add `java` to PATH or set `JAVA_HOME`.
	- Install Maven or use the bundled `mvnw.cmd` wrapper. To install Maven on Windows (Chocolatey):

	```powershell
	choco install maven -y
	```

	- Install Docker Desktop if you need container builds.

- WSL (Ubuntu example):

	```bash
	sudo apt update
	sudo apt install openjdk-17-jdk maven -y
	sudo apt install docker.io -y    # optional
	```

- macOS (Homebrew):

	```bash
	brew install openjdk@17 maven
	brew install --cask docker   # optional
	```

- Linux (Debian/Ubuntu example):

	```bash
	sudo apt update
	sudo apt install openjdk-17-jdk maven -y
	```

If you need help installing Java/Maven on your system, tell me your OS and I will provide exact commands.
