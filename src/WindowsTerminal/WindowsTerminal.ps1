function Install-OhMyPosh {
  scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
  Import-Module -Name "posh-git" -Repository "PSGallery";
  Import-Module "Terminal-Icons";
  Import-Module "PSReadLine";
  Install-Module -Name "Terminal-Icons" -Repository "PSGallery";
  Install-Module -Name "PSWebSearch" -Repository "PSGallery";
  Install-Module -Name "PSReadLine" -Repository "PSGallery" -RequiredVersion 2.1.0;
}

function Set-OhMyPosh-Theme {
  $DotfilesOhMyPoshThemePath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WindowsTerminal" | Join-Path -ChildPath ".omp.json";
  Write-Host "Coping Oh My Posh custom theme:" -ForegroundColor "Green";
  Copy-Item $DotfilesOhMyPoshThemePath -Destination $env:UserProfile;
  Write-Host "Oh My Posh theme was successfully created." -ForegroundColor "Green";
}

function Set-PowerShell-Profile {
  $DotfilesWindowsTerminalProfilePath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WindowsTerminal" | Join-Path -ChildPath "Microsoft.PowerShell_profile.ps1";
  if (-not (Test-Path -Path $Profile)) {
    Write-Host "Creating empty PowerShell profile:" -ForegroundColor "Green";
    New-Item -Path $Profile -ItemType "file" -Force;
  }
  Write-Host "Coping PowerShell profile:" -ForegroundColor "Green";
  Copy-Item $DotfilesWindowsTerminalProfilePath -Destination $Profile;
  Write-Host "Activating PowerShell profile:" -ForegroundColor "Green";
  . $Profile;
  Write-Host "PowerShell profile was successfully created." -ForegroundColor "Green";
}