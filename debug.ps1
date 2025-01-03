
Get-LocalGroup | ForEach-Object {
    $groupName = $_.Name
    Write-Output "Group: $groupName"
    Get-LocalGroupMember -Group $groupName | ForEach-Object {
        Write-Output "    Member: $_"
    }
    Write-Output ""
}

$UserGroups = [System.Security.Principal.WindowsIdentity]::GetCurrent().Groups |
    ForEach-Object {
        $_.Translate([System.Security.Principal.NTAccount]).Value
    }
$UserGroups


# Get-ChildItem -Path C:\app\openjdk
# Get-ChildItem -Path C:\app\maven
# Get-ChildItem -Path C:\app\tomcat
# Get-ChildItem -Path C:\app\tomcat\webapps
# Get-ChildItem -Path C:\app\tomcat\webapps\ROOT