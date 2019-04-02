FROM mcr.microsoft.com/powershell:latest

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN pwsh -c "Install-Module -Name Az -Force"
RUN pwsh -c "Install-Module -Name AzureRM.ServiceBus  -Force"
RUN pwsh  -c "Install-Module -Name powershell-yaml -Force"
RUN /bin/bash -c 'apt-get update; apt-get install apt-transport-https lsb-release software-properties-common dirmngr -y'
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main" > /etc/apt/sources.list.d/azure-cli.list; 
RUN apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv --keyserver packages.microsoft.com --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF
RUN apt-get update; apt-get install azure-cli wget libunwind8 curl nano -y


RUN mkdir /root/octopus
RUN cd /root/octopus; wget https://download.octopusdeploy.com/octopus-tools/4.37.0/OctopusTools.4.37.0.ubuntu.16.04-x64.tar.gz; tar -xzf OctopusTools.4.37.0.ubuntu.16.04-x64.tar.gz
RUN ln -sf /root/octopus/Octo /usr/bin/octo

VOLUME /octopus-devops-scripts
WORKDIR /octopus-devops-scripts
