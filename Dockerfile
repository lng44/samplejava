FROM mcr.microsoft.com/windows/servercore:ltsc2019
RUN tzutil /s "Central Standard Time"
RUN MKDIR c:\\app
WORKDIR c:\\app
COPY . .
RUN powershell -File "init.ps1"
RUN mvn clean package
WORKDIR c:\\tomcat\\bin
RUN copy c:\\app\\target\\*.war C:\\tomcat\\webapps\\ROOT.war
EXPOSE 8080
CMD ["catalina.bat","run"]
