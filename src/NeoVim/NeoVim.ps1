function Install-VimPlug {
  $VimPlugFilePath = "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim/autoload/plug.vim";
  if (-not (Test-Path -Path $VimPlugFilePath)) {
    Write-Host "Installing Vim-Plug:" -ForegroundColor "Green";
    Invoke-WebRequest -useb "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" | New-Item $VimPlugFilePath -Force;
  }
  else {
    Write-Host "Vim-Plug is already installed." -ForegroundColor "Green";
  }
}

function Set-Vim-Configuration {
  New-Item -path "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])\nvim" -name "init.vim" -type "file" -Force;
  $DotfilesInitVimPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "NeoVim" | Join-Path -ChildPath "init.vim";
  $InitVimPath = "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])\nvim\init.vim";

  if (-not (Test-Path -Path $InitVimPath)) {
    Write-Host "Copying initial NeoVim configuration file: " -ForegroundColor "Green";
    Copy-Item $DotfilesInitVimPath -Destination $InitVimPath;
  }

  Write-Host "Installing NeoVim plugins:" -ForegroundColor "Green";
  nvim --headless +PlugInstall +qall;
  Write-Host "NeoVim was successfully configured." -ForegroundColor "Green";
}

choco install -y "neovim" --params "/InstallDir:${env:ProgramFiles}";
refreshenv;
Install-VimPlug;
Set-Vim-Configuration;