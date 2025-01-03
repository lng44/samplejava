
# try {
#     $aclPath = $path + 'C:\app\tomcat'
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
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\app\openjdk","Machine")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\app\openjdk\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\app\maven\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")
[System.Environment]::SetEnvironmentVariable("CATALINA_HOME", "C:\app\tomcat","Machine")
[System.Environment]::SetEnvironmentVariable("PATH", "C:\app\tomcat\bin;"+[System.Environment]::GetEnvironmentVariable("PATH","Machine"),"Machine")


