FROM mcr.microsoft.com/windows/servercore:ltsc2016

RUN tzutil /s "Central Standard Time"
RUN powershell -NoProfile -Command " \
    Invoke-WebRequest -Uri https://download.java.net/openjdk/jdk17/ri/openjdk-17+35_windows-x64_bin.zip -OutFile C:\openjdk.zip; \
    Expand-Archive -Path C:\openjdk.zip -DestinationPath C:\openjdk; \
    Remove-Item -Path C:\openjdk.zip \
    "

ENV JAVA_HOME C:\openjdk
ENV PATH %JAVA_HOME%\bin;%PATH%

RUN powershell -NoProfile -Command " \
    Invoke-WebRequest -Uri https://downloads.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.zip -OutFile C:\maven.zip; \
    Expand-Archive -Path C:\maven.zip -DestinationPath C:\; \
    Rename-Item -Path C:\apache-maven-* C:\maven; \
    Remove-Item -Path C:\maven.zip \
    "
ENV PATH C:\maven\bin;%PATH%

RUN powershell -NoProfile -Command " \
    Invoke-WebRequest -Uri https://downloads.apache.org/tomcat/tomcat-6/v6.0.53/bin/apache-tomcat-6.0.53.zip -OutFile C:\tomcat.zip; \
    Expand-Archive -Path C:\tomcat.zip -DestinationPath C:\; \
    Rename-Item -Path C:\apache-tomcat-* C:\tomcat; \
    Remove-Item -Path C:\tomcat.zip \
    "
COPY . /app
WORKDIR /app
RUN mvn clean package
RUN copy /app/target/*.war C:\tomcat\webapps\ROOT.war
EXPOSE 8080
CMD ["cmd", "/c", "C:\\tomcat\\bin\\startup.bat && tail -f C:\\tomcat\\logs\\catalina.out"]