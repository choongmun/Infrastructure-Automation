$zipPath = [Environment]::GetFolderPath("Desktop") + '\release.zip'
$destinationFolder = [Environment]::GetFolderPath("Desktop") + '\df\'
Get-ChildItem $zipPath | Expand-Archive -Force -DestinationPath $destinationFolder

$setupFile = [Environment]::GetFolderPath("Desktop") + '\df\Release\Setup.exe'
Start-Process -FilePath $setupFile -ArgumentList /passive -NoNewWindow -PassThru -Wait

while (!(Test-Path "C:\windows\DataFusion")) { Start-Sleep -S 2 }
$confFile = [Environment]::GetFolderPath("Desktop") + '\sftpconf.zip'
Move-Item -Path $confFile -Force -Destination 'C:\Windows\DataFusion\sftpconf.zip'

. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter –Force

Enable-RemoteDesktop

choco install officeproplus2013 -y
cinst firefox -y
cinst ccleaner -y
cinst vlc -y
cinst winrar -y

Remove-Item $zipPath -Recurse
Remove-Item $destinationFolder -Recurse
