FROM mcr.microsoft.com/windows/servercore:ltsc2019
RUN tzutil /s "Central Standard Time"
RUN MKDIR c:\\app
WORKDIR c:\\app
COPY . .
RUN powershell -File "init.ps1"
RUN mvn clean package
RUN copy c:\\app\\target\\*.war C:\\tomcat\\webapps\\ROOT.war
RUN powershell -File "debug.ps1"
EXPOSE 8080
CMD ["catalina.bat","run"]

