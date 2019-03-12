FROM mcr.microsoft.com/powershell:latest

RUN pwsh -c "Install-Module -Name Az -Force"
