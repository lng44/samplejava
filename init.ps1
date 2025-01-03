
# try {
#     $aclPath = $path + 'C:\Users\ContainerUser\app\tomcat'
#     Get-Acl -Path $aclPath
#     Write-Host "Changing permissions for: $aclPath"
#     $objUser = New-Object System.Security.Principal.NTAccount(".", "Users")
#     $strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
#     Write-Host "SID value is: " $strSID
#     $permissions = 'FullControl'
#     $inheritance = 'ContainerInherit, ObjectInherit'
#     $acl = Get-Acl -Path $aclPath
#     $rule = new-object System.Security.AccessControl.FileSystemAccessRule($strSID, $permissions, $inheritance, 'InheritOnly', 'Allow')
#     $acl.AddAccessRule($rule)
#     Set-Acl -AclObject $acl -Path $aclPath
#     Write-Host "Access control change successful" -fore green
# }
# catch {
#     Write-Host "Error setting access control: $_" -fore red
# }
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Users\ContainerUser\app\openjdk","User")
[System.Environment]::SetEnvironmentVariable("CATALINA_HOME", "C:\Users\ContainerUser\app\tomcat","User")

[System.Environment]::SetEnvironmentVariable("PATH", "C:\Users\ContainerUser\app\openjdk\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","User"),"User")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\Users\ContainerUser\app\maven\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","User"),"User")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\Users\ContainerUser\app\tomcat\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","User"),"User")

# Get-ChildItem -Path C:\Users\ContainerUser\app\openjdk
# Get-ChildItem -Path C:\Users\ContainerUser\app\maven
# Get-ChildItem -Path C:\Users\ContainerUser\app\tomcat
# Get-ChildItem -Path C:\Users\ContainerUser\app\tomcat\webapps
# Get-ChildItem -Path C:\Users\ContainerUser\app\tomcat\webapps\ROOT


