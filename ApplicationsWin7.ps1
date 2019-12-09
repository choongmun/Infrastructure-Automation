iex ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); Get-Boxstarter -Force

Enable-RemoteDesktop

#To install .net framework 4.8 (https://chocolatey.org/packages/dotnetfx)
choco install dotnetfx -y
choco install officeproplus2013 -y

$zipPath = [Environment]::GetFolderPath("Desktop") + '\release.zip'
$destinationFolder = [Environment]::GetFolderPath("Desktop") + '\df\'

New-Item -Path $destinationFolder -ItemType Directory

$zipFile = (New-Object -com shell.application).NameSpace($zipPath)
$destination = (New-Object -com shell.application).NameSpace($destinationFolder)
$destination.CopyHere($zipFile.Items())

$setupFile = [Environment]::GetFolderPath("Desktop") + '\df\Release\Setup.exe'
Start-Process -FilePath $setupFile -ArgumentList /passive -NoNewWindow -PassThru -Wait

while (!(Test-Path "C:\windows\DataFusion")) { Start-Sleep -S 2 }
$confFile = [Environment]::GetFolderPath("Desktop") + '\sftpconf.zip'
Move-Item -Path $confFile -Force -Destination 'C:\Windows\DataFusion\sftpconf.zip'

cinst firefox -y
cinst ccleaner -y
cinst vlc -y
cinst winrar -y

Remove-Item $zipPath -Recurse
Remove-Item $destinationFolder -Recurse
