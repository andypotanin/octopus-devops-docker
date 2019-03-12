FROM mcr.microsoft.com/powershell:latest

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN pwsh -c "Install-Module -Name Az -Force"
RUN pwsh -c "Install-Module -Name AzureRM.ServiceBus  -Force"
RUN pwsh  -c "Install-Module -Name powershell-yaml -Force"
RUN /bin/bash -c 'apt-get update; apt-get install apt-transport-https lsb-release software-properties-common dirmngr -y'
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main" > /etc/apt/sources.list.d/azure-cli.list; 
RUN apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv --keyserver packages.microsoft.com --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF
RUN apt-get update; apt-get install azure-cli -y

VOLUME /octopus-devops-scripts
WORKDIR /octopus-devops-scripts
