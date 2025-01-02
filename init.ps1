Invoke-WebRequest -Uri https://download.java.net/openjdk/jdk17/ri/openjdk-17+35_windows-x64_bin.zip -OutFile C:\openjdk.zip;
Expand-Archive -Path C:\openjdk.zip -DestinationPath C:\openjdk
Remove-Item -Path C:\openjdk.zip

[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\openjdk",[System.EnvironmentVariableTarget]::Machine)
Write-Output [System.Environment]::GetEnvironmentVariable("JAVA_HOME", [System.EnvironmentVariableTarget]::Machine)

Write-Output ${env:PATH}
[System.Environment]::SetEnvironmentVariable("PATH", "C:\openjdk\bin;${env:PATH}",[System.EnvironmentVariableTarget]::Machine)
Write-Output [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)

Invoke-WebRequest -Uri https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.zip -OutFile C:\maven.zip
Expand-Archive -Path C:\maven.zip -DestinationPath C:\
Remove-Item -Path C:\maven.zip
Get-ChildItem -Path C:\ -Name apache-maven-* | ForEach-Object {
    Rename-Item -Path C:\$_ -NewName C:\maven
}

Write-Output [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH", "C:\maven\bin;${env:PATH}",[System.EnvironmentVariableTarget]::Machine)
Write-Output [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)

Invoke-WebRequest -Uri https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.zip -OutFile C:\tomcat.zip
Expand-Archive -Path C:\tomcat.zip -DestinationPath C:\
Remove-Item -Path C:\tomcat.zip;

Get-ChildItem -Path C:\ -Name apache-tomcat-* | ForEach-Object {
    Rename-Item -Path C:\$_ -NewName C:\tomcat
}