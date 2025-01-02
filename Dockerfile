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
WORKDIR c:\\tomcat\\bin
# CMD ["startup.bat"]
# CMD ["catalina.bat","stop",";","catalina.bat","start"]
CMD ["cmd", "/S", "/C", "echo Starting Tomcat && catalina.bat start && echo Stopping Tomcat && catalina.bat stop && echo Restarting Tomcat && catalina.bat start"]

