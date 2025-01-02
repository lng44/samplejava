FROM mcr.microsoft.com/windows/servercore:ltsc2019

COPY . c:\\app
RUN powershell -File c:\app\init.ps1

WORKDIR c:\\app
RUN mvn clean package
RUN copy .\target\*.war C:\tomcat\webapps\ROOT.war
EXPOSE 8080
RUN tzutil /s "Central Standard Time"
CMD ["cmd", "/c", "C:\tomcat\bin\startup.bat && tail -f C:\tomcat\logs\catalina.out"]