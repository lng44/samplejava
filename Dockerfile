FROM mcr.microsoft.com/windows/servercore:ltsc2019
RUN tzutil /s "Central Standard Time"
RUN MKDIR c:\\app
WORKDIR c:/app
COPY . .
RUN powershell -File "init.ps1"
RUN mvn clean package
EXPOSE 8080
COPY ./target/*.war c:/tomcat/webapps/ROOT.war

WORKDIR c:/tomcat/webapps
RUN MKDIR ROOT
WORKDIR c:/tomcat/webapps/ROOT
RUN jar -xvf ../ROOT.war
WORKDIR c:/app
RUN powershell -File "debug.ps1"
CMD ["catalina.bat","run"]