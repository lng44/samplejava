FROM mcr.microsoft.com/windows/servercore:ltsc2019
RUN powershell -Command "Get-ChildItem -Path ."
RUN powershell -Command "Get-ChildItem -Path C:\Users"
RUN powershell -Command "Get-LocalUser"
RUN powershell -Command "Get-LocalGroup | ft Name, SID"


USER ContainerAdministrator
RUN tzutil /s "Central Standard Time"
# USER ContainerUser
RUN MKDIR c:\\app
WORKDIR c:/app
COPY . .
# USER ContainerUser
RUN powershell -File "init.ps1"
# USER ContainerAdministrator
RUN mvn clean package
# USER ContainerUser
EXPOSE 8080
RUN copy c:\\app\\target\\*.war c:\\app\\tomcat\\webapps\\ROOT.war
# RUN MKDIR c:\\tomcat\\webapps\\ROOT
# WORKDIR c:/tomcat/webapps/ROOT
# RUN jar -xvf ..\\ROOT.war
# WORKDIR c:/app
RUN powershell -File "debug.ps1"
CMD ["catalina.bat","run"]