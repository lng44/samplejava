FROM mcr.microsoft.com/windows/servercore:ltsc2019
RUN powershell -File "init.ps1"
RUN tzutil /s "Central Standard Time"
RUN MKDIR c:\\app
WORKDIR c:\\app
COPY . .
RUN mvn clean package
WORKDIR c:\\tomcat\\bin
RUN startup.bat
RUN copy c:\\app\\target\\*.war C:\\tomcat\\webapps\\ROOT.war
RUN shutdown.bat
EXPOSE 8080
CMD ["catalina.bat","run"]
