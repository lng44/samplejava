Invoke-WebRequest -Uri https://cdn.azul.com/zulu/bin/zulu8.82.0.21-ca-jdk8.0.432-win_x64.zip -OutFile C:\app\openjdk.zip;
Expand-Archive -Path C:\app\openjdk.zip -DestinationPath C:\app\
Remove-Item -Path C:\app\openjdk.zip
Get-ChildItem -Path C:\app\ -Name *jdk* | ForEach-Object {
    Rename-Item -Path C:\app\$_ -NewName C:\app\openjdk
}

Invoke-WebRequest -Uri https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.zip -OutFile C:\app\maven.zip
Expand-Archive -Path C:\app\maven.zip -DestinationPath C:\app\
Remove-Item -Path C:\app\maven.zip
Get-ChildItem -Path C:\app\ -Name apache-maven-* | ForEach-Object {
    Rename-Item -Path C:\app\$_ -NewName C:\app\maven
}

# https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26-windows-x64.zip
Invoke-WebRequest -Uri https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.53/bin/apache-tomcat-6.0.53-windows-x64.zip -OutFile C:\app\tomcat.zip
Expand-Archive -Path C:\app\tomcat.zip -DestinationPath C:\app\
Remove-Item -Path C:\app\tomcat.zip;
Get-ChildItem -Path C:\app\ -Name apache-tomcat-* | ForEach-Object {
    Rename-Item -Path C:\app\$_ -NewName C:\app\tomcat
}

