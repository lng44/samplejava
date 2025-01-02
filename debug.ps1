Get-ChildItem -Path C:\openjdk
Get-ChildItem -Path C:\maven
Get-ChildItem -Path C:\tomcat
Get-ChildItem -Path C:\tomcat\webapps
Expand-Archive -Path C:\tomcat\webapps\ROOT.zip -DestinationPath C:\tomcat\webapps\ROOT
Get-ChildItem -Path C:\tomcat\webapps\ROOT