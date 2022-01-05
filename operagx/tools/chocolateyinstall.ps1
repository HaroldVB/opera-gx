$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = '82.0.4227.50'

$checksum   = "a794c04108e4a237570c267e1d00420dd39e7d16fd8658778a366a2f3128ced8"
$checksum64 = "c3acc3d9ffad25913cb2a6f1413c9c3b9a2c7223cc468981bf3e6cd7e70471d7"

Write-Output "Checksums for Version $version"
Write-Output "$checksum"
Write-Output "$checksum64"

$url        = 'https://get.geo.opera.com/pub/opera_gx/' + $version + '/win/Opera_GX_' + $version + '_Setup.exe'
$url64      = 'https://get.geo.opera.com/pub/opera_gx/' + $version + '/win/Opera_GX_' + $version + '_Setup_x64.exe'

$pp = Get-PackageParameters
 
$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters

  softwareName  = 'operagx*'

  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'

  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
