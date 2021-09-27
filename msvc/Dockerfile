FROM mcr.microsoft.com/powershell:latest

RUN pwsh -c 'Install-Module Pode -force'

COPY . /usr/src/app/

EXPOSE 8080

CMD [ "pwsh", "-c", "cd /usr/src/app; ./StartPodeServer.ps1" ]
