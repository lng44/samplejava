Invoke-WebRequest -Uri https://cdn.azul.com/zulu/bin/zulu8.82.0.21-ca-jdk8.0.432-win_x64.zip -OutFile C:\openjdk.zip;
Expand-Archive -Path C:\openjdk.zip -DestinationPath C:\
Remove-Item -Path C:\openjdk.zip
Get-ChildItem -Path C:\ -Name *jdk* | ForEach-Object {
    Rename-Item -Path C:\$_ -NewName C:\openjdk
}

[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\openjdk","Machine")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\openjdk\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")

Invoke-WebRequest -Uri https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.zip -OutFile C:\maven.zip
Expand-Archive -Path C:\maven.zip -DestinationPath C:\
Remove-Item -Path C:\maven.zip
Get-ChildItem -Path C:\ -Name apache-maven-* | ForEach-Object {
    Rename-Item -Path C:\$_ -NewName C:\maven
}
[System.Environment]::SetEnvironmentVariable("PATH", "C:\maven\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")

# https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26-windows-x64.zip
Invoke-WebRequest -Uri https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.53/bin/apache-tomcat-6.0.53-windows-x64.zip -OutFile C:\tomcat.zip
Expand-Archive -Path C:\tomcat.zip -DestinationPath C:\
Remove-Item -Path C:\tomcat.zip;
Get-ChildItem -Path C:\ -Name apache-tomcat-* | ForEach-Object {
    Rename-Item -Path C:\$_ -NewName C:\tomcat
}
# Remove-Item -Recurse -Force C:\tomcat\webapps\ROOT
# [System.Environment]::SetEnvironmentVariable("CATALINA_HOME", "C:\tomcat","Machine")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\tomcat\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")

Get-ChildItem -Path C:\
Get-ChildItem -Path C:\Users
Get-ChildItem -Path C:\openjdk
Get-ChildItem -Path C:\maven
Get-ChildItem -Path C:\tomcat
Get-ChildItem -Path C:\tomcat\webapps