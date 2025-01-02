FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN MKDIR c:\\app
WORKDIR c:\\app
COPY . .
RUN powershell -File "init.ps1"
RUN mvn clean package
RUN startup.bat
RUN copy c:\\app\\target\\*.war C:\\tomcat\\webapps\\ROOT.war
EXPOSE 8080
RUN tzutil /s "Central Standard Time"
# CMD ["cmd", "/c", "C:\tomcat\bin\startup.bat && tail -f C:\tomcat\logs\catalina.out"]
WORKDIR c:\\tomcat\\bin
CMD ["catalina.bat","run"]
