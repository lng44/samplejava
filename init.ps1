Invoke-WebRequest -Uri https://cdn.azul.com/zulu/bin/zulu8.82.0.21-ca-jdk8.0.432-win_x64.zip -OutFile C:\app\openjdk.zip;
Expand-Archive -Path C:\app\openjdk.zip -DestinationPath C:\app\
Remove-Item -Path C:\app\openjdk.zip
Get-ChildItem -Path C:\app\ -Name *jdk* | ForEach-Object {
    Rename-Item -Path C:\app\$_ -NewName C:\app\openjdk
}

[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\app\openjdk","Machine")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\app\openjdk\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")

Invoke-WebRequest -Uri https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.zip -OutFile C:\app\maven.zip
Expand-Archive -Path C:\app\maven.zip -DestinationPath C:\app\
Remove-Item -Path C:\app\maven.zip
Get-ChildItem -Path C:\app\ -Name apache-maven-* | ForEach-Object {
    Rename-Item -Path C:\app\$_ -NewName C:\app\maven
}
[System.Environment]::SetEnvironmentVariable("PATH", "C:\app\maven\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")

# https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26-windows-x64.zip
Invoke-WebRequest -Uri https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.53/bin/apache-tomcat-6.0.53-windows-x64.zip -OutFile C:\app\tomcat.zip
Expand-Archive -Path C:\app\tomcat.zip -DestinationPath C:\app\
Remove-Item -Path C:\app\tomcat.zip;
Get-ChildItem -Path C:\app\ -Name apache-tomcat-* | ForEach-Object {
    Rename-Item -Path C:\app\$_ -NewName C:\app\tomcat
}
# Remove-Item -Recurse -Force C:\app\tomcat\webapps\ROOT
# [System.Environment]::SetEnvironmentVariable("CATALINA_HOME", "C:\app\tomcat","Machine")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\app\tomcat\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")

try {
    $aclPath = $path + 'C:\app\tomcat'
    Get-Acl -Path $aclPath
    Write-Host "Changing permissions for: $aclPath"
    # $objUser = New-Object System.Security.Principal.NTAccount(".", "User Manager")
    # $strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
    # Write-Host "SID value is: " $strSID
    $strSID = "ContainerUser"
    $permissions = 'FullControl'
    $inheritance = 'ContainerInherit, ObjectInherit'
    $acl = Get-Acl -Path $aclPath
    $rule = new-object System.Security.AccessControl.FileSystemAccessRule ( $strSID, $permissions, $inheritance, 'None', 'Allow') 
    $acl.AddAccessRule($rule)
    Set-Acl -AclObject $acl -Path $aclPath
    Write-Host "Access control change successful" -fore green
}
catch {
    Write-Host "Error setting access control: $_" -fore red
}


# Get-ChildItem -Path C:\app\
# Get-ChildItem -Path C:\app\openjdk
# Get-ChildItem -Path C:\app\maven
# Get-ChildItem -Path C:\app\tomcat
# Get-ChildItem -Path C:\app\tomcat\webapps