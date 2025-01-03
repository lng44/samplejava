FROM mcr.microsoft.com/windows/nanoserver:ltsc2019
RUN powershell -Command "Get-ChildItem -Path ."
RUN powershell -Command "Get-LocalUser"
USER ContainerUser
RUN tzutil /s "Central Standard Time"
RUN MKDIR c:\\app
WORKDIR c:/app
COPY . .
RUN powershell -File "init.ps1"
RUN mvn clean package
EXPOSE 8080
COPY ./target/*.war c:/tomcat/webapps/ROOT.war
# RUN MKDIR c:\\tomcat\\webapps\\ROOT
# WORKDIR c:/tomcat/webapps/ROOT
# RUN jar -xvf ..\\ROOT.war
# WORKDIR c:/app
# RUN powershell -File "debug.ps1"
CMD ["catalina.bat","run"]