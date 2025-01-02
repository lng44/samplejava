FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN tzutil /s "Central Standard Time"
RUN powershell -NoProfile -Command " \
    Invoke-WebRequest -Uri https://download.java.net/openjdk/jdk17/ri/openjdk-17+35_windows-x64_bin.zip -OutFile C:\openjdk.zip; \
    Expand-Archive -Path C:\openjdk.zip -DestinationPath C:\openjdk; \
    Remove-Item -Path C:\openjdk.zip; \
    "
RUN powershell -Command "[System.Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\openjdk', [System.EnvironmentVariableTarget]::Machine)"
RUN powershell -Command "[System.Environment]::SetEnvironmentVariable('PATH', 'C:\openjdk\bin;' + [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine), [System.EnvironmentVariableTarget]::Machine)"

RUN powershell -NoProfile -Command " \
    Invoke-WebRequest -Uri https://downloads.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.zip -OutFile C:\maven.zip; \
    Expand-Archive -Path C:\maven.zip -DestinationPath C:\; \
    Remove-Item -Path C:\maven.zip; \
    Rename-Item -Path C:\apache-maven-* C:\maven; \
    "
RUN powershell -Command "[System.Environment]::SetEnvironmentVariable('PATH', 'C:\maven\bin;' + [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine), [System.EnvironmentVariableTarget]::Machine)"

RUN powershell -NoProfile -Command " \
    Invoke-WebRequest -Uri https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.zip -OutFile C:\tomcat.zip; \
    Expand-Archive -Path C:\tomcat.zip -DestinationPath C:\; \
    Rename-Item -Path C:\apache-tomcat-* C:\tomcat; \
    Remove-Item -Path C:\tomcat.zip; \
    "

COPY . /app
WORKDIR /app
RUN mvn clean package
RUN copy /app/target/*.war C:\tomcat\webapps\ROOT.war
EXPOSE 8080
CMD ["cmd", "/c", "C:\\tomcat\\bin\\startup.bat && tail -f C:\\tomcat\\logs\\catalina.out"]