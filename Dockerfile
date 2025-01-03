FROM mcr.microsoft.com/windows/servercore:ltsc2019
# RUN powershell -Command "Get-ChildItem -Path ."
# RUN powershell -Command "Get-ChildItem -Path C:\Users"
# RUN powershell -Command "Get-LocalUser"
# RUN powershell -Command "Get-LocalGroup | ft Name, SID"
# RUN powershell -Command "Set-ExecutionPolicy RemoteSigned"
# USER ContainerAdministrator
# RUN tzutil /s "Central Standard Time"
USER ContainerUser
RUN MKDIR c:\\app
WORKDIR c:/app
COPY . .
RUN powershell -File "debug.ps1"
RUN powershell -File "init.ps1"
RUN mvn clean package
RUN copy c:\\app\\target\\*.war c:\\app\\tomcat\\webapps
# RUN MKDIR c:\\tomcat\\webapps\\ROOT
# WORKDIR c:/tomcat/webapps/ROOT
# RUN jar -xvf ..\\ROOT.war
# WORKDIR c:/app
# RUN powershell -File "debug.ps1"
EXPOSE 8080
CMD ["catalina.bat","run"]