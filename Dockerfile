FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN MKDIR c:\\app
WORKDIR c:\\app
COPY . .
RUN powershell -Command '[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\openjdk",[System.EnvironmentVariableTarget]::Machine)'
RUN powershell -Command 'Write-Output ${env:JAVA_HOME}'
RUN powershell -File "init.ps1"
RUN mvn clean package
RUN copy c:\\app\\target\\*.war C:\\tomcat\\webapps\\ROOT.war
EXPOSE 8080
RUN tzutil /s "Central Standard Time"
CMD ["cmd", "/c", "C:\tomcat\bin\startup.bat && tail -f C:\tomcat\logs\catalina.out"]
# CMD ["powershell", "-Command", "Start-Process -NoNewWindow -FilePath 'C:\\tomcat\\bin\\startup.bat'; Wait-Process -Name 'java'"]
