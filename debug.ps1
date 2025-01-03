Invoke-WebRequest -Uri https://cdn.azul.com/zulu/bin/zulu8.82.0.21-ca-jdk8.0.432-win_x64.zip -OutFile C:\Users\ContainerUser\app\openjdk.zip;
Expand-Archive -Path C:\Users\ContainerUser\app\openjdk.zip -DestinationPath C:\Users\ContainerUser\app\
Remove-Item -Path C:\Users\ContainerUser\app\openjdk.zip
Get-ChildItem -Path C:\Users\ContainerUser\app\ -Name *jdk* | ForEach-Object {
    Rename-Item -Path C:\Users\ContainerUser\app\$_ -NewName C:\Users\ContainerUser\app\openjdk
}

Invoke-WebRequest -Uri https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.zip -OutFile C:\Users\ContainerUser\app\maven.zip
Expand-Archive -Path C:\Users\ContainerUser\app\maven.zip -DestinationPath C:\Users\ContainerUser\app\
Remove-Item -Path C:\Users\ContainerUser\app\maven.zip
Get-ChildItem -Path C:\Users\ContainerUser\app\ -Name apache-maven-* | ForEach-Object {
    Rename-Item -Path C:\Users\ContainerUser\app\$_ -NewName C:\Users\ContainerUser\app\maven
}

# https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26-windows-x64.zip
Invoke-WebRequest -Uri https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.53/bin/apache-tomcat-6.0.53-windows-x64.zip -OutFile C:\Users\ContainerUser\app\tomcat.zip
Expand-Archive -Path C:\Users\ContainerUser\app\tomcat.zip -DestinationPath C:\Users\ContainerUser\app\
Remove-Item -Path C:\Users\ContainerUser\app\tomcat.zip;
Get-ChildItem -Path C:\Users\ContainerUser\app\ -Name apache-tomcat-* | ForEach-Object {
    Rename-Item -Path C:\Users\ContainerUser\app\$_ -NewName C:\Users\ContainerUser\app\tomcat
}
Remove-Item -Recurse -Force C:\Users\ContainerUser\app\tomcat\webapps\ROOT
# Get-LocalGroup | ForEach-Object {
#     $groupName = $_.Name
#     Write-Output "Group: $groupName"
#     Get-LocalGroupMember -Group $groupName | ForEach-Object {
#         Write-Output "    Member: $_"
#     }
#     Write-Output ""
# }

# $UserGroups = [System.Security.Principal.WindowsIdentity]::GetCurrent().Groups |
#     ForEach-Object {
#         $_.Translate([System.Security.Principal.NTAccount]).Value
#     }
# $UserGroups


