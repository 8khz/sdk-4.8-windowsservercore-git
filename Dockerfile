FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019  
MAINTAINER jslachta

ENV chocolateyUseWindowsCompression false

RUN $text = '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13 -bor [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls'; \
    $text | Set-Content 'C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1';

RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); \
    powershell -Command refreshenv;

RUN choco install git -y;

RUN powershell -Command refreshenv;
