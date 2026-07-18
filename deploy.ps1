<#
.SYNOPSIS
  PowerShell deployment helper for Windows environments.
#>
param()

$LogFile = "deploy.ps1.log"
Start-Transcript -Path $LogFile -Force

Write-Output "Automated Deployment (PowerShell)"

function Check-Command($cmd) {
  $null = Get-Command $cmd -ErrorAction SilentlyContinue
  if ($?) { return $true } else { return $false }
}

if (Test-Path "mvnw.cmd") {
  $mvncmd = "mvnw.cmd"
} elseif (Get-Command mvn -ErrorAction SilentlyContinue) {
  $mvncmd = "mvn"
} else {
  Write-Error "Maven not found and mvnw.cmd not present. Install Maven or ensure mvnw.cmd is executable."
  Stop-Transcript
  exit 1
}

if (-not (Check-Command java)) {
  Write-Error "Java not found. Install JDK and add to PATH or set JAVA_HOME."
  Stop-Transcript
  exit 1
}

Write-Output "Java version:"; java -version
Write-Output "Using build tool: $mvncmd"

& (Join-Path . $mvncmd) -DskipTests package

if (Get-Command docker -ErrorAction SilentlyContinue) {
  Write-Output "Docker available: $(docker --version)"
  if (Test-Path docker-compose.yml) {
    if (Get-Command docker-compose -ErrorAction SilentlyContinue) {
      docker-compose build
    } else {
      docker compose build
    }
  }
}

Write-Output "Deployment finished"
Stop-Transcript
